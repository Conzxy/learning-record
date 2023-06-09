# Lua GC
在了解Lua GC之前，需要先了解`弱表`（weak table）和`终止器`（finalizer）。
# 弱表
（强弱引用可以参考`std::shared_ptr`和`std::weak_ptr`）<br>
弱表中的对象都是弱引用，如果指向一个对象的引用都是弱的，那么GC会回收该对象并删除所有弱引用（从`std::weak_ptr`角度来看，要实现该效果需要遍历所有对象，除非有映射）。<br>
表的默认属性是键和值都是强引用，也就是说除非你将表的强引用抹掉（赋值为nil），表中元素是不可能被回收的。<br>
可以通过元表的`__mode`字段修改键和值的强弱性：
```lua
a = {}
mt = { __mode = "k" } // key is weak
// kv --> key and value is weak
// v --> value is weak
setmetatable(a, mt)
key = {}
a[key] = 1
key = {}
a[key] = 2
collectgarbage()
for _, v in pairs(a) do print(v) end --> 2
```

注意，只有对象才会从虚表中移除，比如数字和布尔值并不算作对象，也不会涉及动态分配，不会被回收（自然，也说明没有回收的必要）。<br>
对象包括字符串，表，函数，线程，用户数据，内部数据结构等。

## 用途
* 实现对象池（共享缓冲池）：值是弱引用（或键值都为弱应用，效果一样，尽管没必要）（注意不管哪种做法，）
* 存储对象元信息的表：键是弱引用，值必须是强引用（如果键被回收了，可以通过设置__gc删除该kv对）
* 替换表的默认值为非nil：键是表，弱引用，值是默认值，强引用。
* 暂时表（ephemeron table）实现缓存工厂函数（集合）：<br>
  暂时表指弱键强值且值指向键的表，其实就是我们熟悉的哈希集合（`std::unordered_set`）。

# 终止器
（可类比析构函数）。<br>
当对象被回收时，调用的函数就是`终止器`。<br>
```lua
o = { x = "hi" }
setmetatable(o, { __gc =  function (o) print (o.x) end })
o = nil
collectgarbage() --> hi
```
注意，如果`setmetatable()`中没有__gc注册，那么就算之后改动了注册的元表也没有作用，相对地，即使作为实参的元表的__gc是任意非nil值，之后改动也会起作用：
```lua
o = { x = "hi" }
-- mt = {} -- (1)
mt = { __gc = true } -- (2)
setmetatable(o, mt)
mt.__gc = function (o) print(o.x) end
o = nil
collectgarbage()
-- To (1), print nothing
-- To (2), print "hi"
```

## 复活（resurrection）
复活分为`短暂复活`（transient resurrection）和`永久复活`（permanent resurrection）。<br>
当终止器被调用的时候，对象作为实参传入，因此它是存活的（至少对于终止阶段来说）。

复活必须具有`传递性`：
```lua A = { x = "this is A" }
B = { f = A }
setmetatabel(B, { __gc = function (o) print (o.f.x) end })
A, B = nil
collectgarbage() --> this is A
```
在终止阶段，将A和B一起复活（调用终止器之前）。

由于复活特性，GC将它分为两个步骤来进行回收：
* 第一次，GC检测到一个不可访问对象有一个终止器，GC复活该对象并将它放入终止队列，以在终止阶段调用终止器。一旦终止器运行，Lua将对象标记为`被终止`（finalized）。
* 下一次，GC检测到该不可访问对象，它会删除它。

为了保证所有垃圾都被完全释放，用户可以调用两次`collectgarbage()`来保证。

如果一个对象的终止器直到程序结束都没有被调用，那么会在Lua虚拟机关闭时统一调用（`atexit()`）。
e.g. 全局变量

### 在每次GC流程中都会被调用的函数
在终止器中反复注册同样的终止器（因为终止器只会被调用一次且分两个步骤回收），即永久复活。
```lua
do
  local mt = { __gc = function (o)
    print("New cycle")
    setmetatable({}, getmetatable(o))
  end}

  setmetatable({}, mt)
end

collectgarbage()
collectgarbage()
collectgarbage()
```

### 弱表对此的特殊处理
> [Lua 5.4 Manual 2.5.4](https://www.lua.org/manual/5.4/manual.html#2.5.4)

对于弱表中的复活对象，并不会移除弱键（作为弱键），只会移除弱值，在下一轮GC中回收它，这样可以使复活对象在终止器中通过该弱表获取它关联的值。

# GC
在5.0前，GC的实现大致没变动（据书上来说，我没确认过）。后面每个小版本，都有一些变动。

## 思路
在5.0前，Lua使用一个简单的`标记-清扫`（mark-and-sweep）GC（又称`Stop-the-world`GC），这个名字表示这种GC是会停止执行主程序而转去执行GC流程，然后再回来执行原来的执行流。
该GC分为4个阶段来完成一个流程（cycle）：
* `标记`（mark）：
  标记所有可直接访问的对象为 **存活（alive）** ，所有存储在存活对象中的对象也标记为存活。
* `清洁`（cleaning）：
  处理终止器和弱表。
  遍历所有被标记为终止的对象，寻找未被标记的对象（dead），将这些对象标记为存活的（复活的），并放在一个分离列表中以在终止阶段使用。
  遍历弱表，并将所有未被标记的对象（包括key和value）删除。
* `清扫`（sweep）：
  遍历所有Lua对象（Lua将所有对象存储在一个链表上）。回收未被标记为存活的对象，存活对象的标记被清除。
* `终止`（finalizatio）：
  调用在分离列表（清洁阶段）的对象的终止器。

Lua Manual将这个称为`世代模式`（generational mode）。

Lua 5.1，Lua实现了`递进式GC`（incremental collector），相较于原来的版本，它并不会停止当前的执行流，而是交错于执行流中，分步骤执行。每当解释器分配了一些内存时，收集器就执行一个小步骤。<br>
Lua Manual将这个称为`递进式模式`（incremental mode）。

Lua 5.2，引进了`紧急回收`（emergency collection）。当内存分配失败时，Lua强制执行一个完整的回收流程并再尝试分配。紧急回收可以在Lua分配内存的任何时候触发，包括Lua在不处于一致性状态下运行代码，因此该回收不能运行终止器。

Lua的GC行为不跨平台也不跨发行版本，因此一个平台有的优化策略，其他平台可能没有。

## 触发扳机
> 参考[Lua 5.4 Manual](https://www.lua.org/manual/5.4/manual.html#2.5.2)

### 递进模式
在递进模式下，Lua用三个参数来控制：
* GC pause（暂停）：
  在开始新一轮GC之前，需要等待多久。这个并不是指代时间，而是内存占用率。表示达到上次GC后内存占有的%n才触发新一轮GC。如果小于等于100，表示不会再次触发GC（因为不可能再回收了，内存占用减不下来）。默认值是200，最大值是1000。也就是说默认2倍内存占用才会触发新一轮GC。
* GC step-multiplier（步骤倍数）：
  相对于内存分配，收集器的速度，即每1K字节的内存分配，有多少对象被标记或清扫。如果小于100，那么GC会很慢并且会导致GC永远完成不了一轮回收。默认是100，最大是1000。
* GC step-size（步骤规模）：
  分配多少字节内存执行一个步骤（step）。指定的参数是2的指数，即指定为n，表示的是2^n字节。默认值是13，即8K字节。

正如之前所说，在递进模式下，当执行内存分配时，可能执行一个步骤来回收一些对象，每个步骤由步骤倍数控制标记和清扫的对象个数，从而避免遍历所有对象。注意，当内存分配过多且仍然有很多死对象没被标记时，通过步骤回收是有限的。
因此第一个参数pause来控制一个回收轮的执行频率来避免这种情况。

### 世代模式
在世代模式下，GC执行频繁的 *小回收（minor collection）* ，只遍历最近创建的对象，如果小回收之后还是在限制以上，那么执行 *大回收（major collection）* ，也就是`stop-the-world`，遍历所有对象。<br>
通过两个参数控制执行回收的频率：
* 小倍数（minor multiplier）：当内存增长了上次大回收完成时内存占用的%n时，开始新一轮小回收。默认是20，最大是200。
* 大倍数（major multiplier）：类似小因此，不过是开始新一轮大回收。默认是100，最大是1000.

## collectgarbage
> 参考的是[Lua 5.4 manual](https://www.lua.org/manual/5.4/manual.html#6.1)，与书上的有区别

```lua
collectgarbage([opt[, arg]])
```
第一个参数是可选参数，表示执行什么操作，实参类型是字符串。
* "collect"：开始一轮完整的GC（默认选项）
* "stop"：禁止自动调用GC，除非restart，否则你必须显式调用GC
* "restart"：
* "count"：返回Lua正在使用的内存占用。单位是KB，因此结果是浮点数。
* "step"：
* "isrunning"：是否正在运行
* "incremental"：切换为递进模式，arg为pause，step-multiplier，step-size，为0表示不改变
* "generational"：切换为世代模式，arg为minor-multiplier，major-multiplier，为0表示不改变

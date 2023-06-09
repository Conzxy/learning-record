# Data Structures

# 数组
用整型做下标的表当数组用（底层是连续的，不需要担心是用哈希表）。
```lua
local a = {}
for i = 1, 100 do
  a[i] = 0
end

print(#a)
```

当然也可以用负数开头，但是Lua的库设施基本都是遵循从1开始的惯用法，因此不从1开始，那么会不无法使用这些设施。

## 构造
```lua
-- 大括号初始化
squares = { 1, 4, 9, ... }
```

## 矩阵和多维数组
数组的数组（jagged array，锯齿数组，表示不连续）。
```lua
local mt = {}
for i = 1, N do
  local row = {}
  m[i] = row
  for j = 1, M do
    row[j] = 0
  end
end
```

一维数组实现
```lua
local mt = {}
for i = 1, N do
  cur = (i-1) * M 
  for j = 1, M do
    mt[cur+j] = 0
  end
end
```

Lua不需要刻意实现稀疏矩阵/数组，因为Lua是天然稀疏的（因为底层实现有哈希表）
简单来说，对于你认为的无意义值对应的下标不进行赋值就可以了。
但是注意，不应该采用整数进行遍历，而是采用`pair`遍历所有有意义值（不然你会无意义地访问不存在元素，尽管它为nil）（其实就相当于遍历哈希表）。

这里用矩阵乘法举例子，用点乘的描述方式进行计算：
```lua

```

# 链表
```lua
list = nil
-- insertion before head
list = { next = list, value = v }

-- traverse
local l = list
while l do
  io.write(l.value, " ")
  l = l.next
end
```

一般Lua不会用链表，因为它自己就是动态类型（你可以认为是std::vector<Any>）。

# 队列和双端队列
尽管可以使用`table.insert()/remove()`实现队列的操作，但是注意它们是针对序列操作，也就是说对头进行插入或删除，时间复杂度是O(n)。
通过维护两个索引和利用表的哈希特性可以实现O(1)的头插入和删除（底层实现也是O(1)）。

```lua
```

# 反转表
利用表可以存取任何合法Lua类型的特性，可以轻松反转表：
```lua
tb = {}
for k, v in pairs(tb) do
  tb[v] = k
end
```

# 集合（Sets）和包（Bags）
集合没啥好说的，table是天然的集合。
包又叫multiset，类似C++的设施，允许多个相同的key出现在表中。Lua并没有原生的包，通过给key加上一个

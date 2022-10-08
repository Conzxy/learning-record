# Lua Closure

记住一点，在Lua这种动态语言中，值是第一公民，函数在Lua中也是值，因此可以作为实参等传递，也可以像其他值一样使用。

# 语法
```lua
function foo (x) return 2 * x end
-- passed to a variabel
foo = function (x) return 2 * x end
```
语法格式是`function (params...) body end`。

# 递归
递归需要注意，正在定义的函数不能被闭包递归调用，因为它会认为不存在该函数，而去搜索其他可能的函数代替（比如局部变量的话，会搜索全局函数）。
```lua
local fact = function (n)
  if n == 0 then return 1
  else return n * fact(n-1) -- buggy
  end
end
```
只需要将fact前向声明就行了：
```lua
local fact
fact = ...
```
当然，也可以通过`局部闭包`的语法糖来实现相同的效果：
```lua
local function fact2(n) 
  if (n == 0) then return 1
  else return n * fact(n-1)
  end
end
--[[ 
 等效于
 local fact2;
 fact2 = ...
--]]
```
# 词法作用域（Lexical Scoping）
相当于C++的捕获列表
```lua
names = { ... }
grades = { ... }

function sortbygrade (names, grades)
  table.sort(names, function (n1, n2)
    return grades[n1] > grades[n2] -- 捕获变量grades
  end)
end

sortbygrade(names, grades)
```
捕获的变量在匿名函数中既不是局部变量也不是全局变量，而称作`非局部变量（non-local）`（也叫`上值（upvalues）`）。

## 用途
捕获变量到匿名函数中，使原变量逃逸原来的作用域：
```lua
function newCounter()
  local count = 0
  return function()
           count = count + 1
           retunr count
         end
end

c1 = newCounter()
print(c1())
print(c2())
```

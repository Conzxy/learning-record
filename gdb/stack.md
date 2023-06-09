# GDB调试栈（Examining the stack）
每次函数调用，都会有`栈帧（Stack frame）`存储在运行时栈中，包括局部变量，一些函数实参（x86和x86_64有区别），PC等。<br>
当程序停止时，GDB自动选择的是当前函数的栈帧。<br>
由于栈帧由%ebp/rbp指定，一般编译器会设置它以便可以进行backtrace，但栈帧本身是可选的，可以指定`-fomit-frame-pointer`禁止，不设置帧寄存器。<br>

# Backtrace
## Format
```shell
backtrace/bt [OPTION] ... [QUALIFIER] ... [COUNT]
```

## OPTIONS
`COUNT`用于指定展开的栈帧数：
```
bt N # 由内向外展开N个栈帧
bt -N # 由外到内...
# 注意，由外到内并不是说会将frame数字由大到小打印，而是将倒数的帧打印出来
```
* `-full`：打印所有局部变量
* `-no-filters`
* `-hide`：

## 等价命令：
`where`和`info stack/s`与回溯是等价命令，包括其命令参数格式

## 多线程环境
默认打印当前线程的栈，如需要打印其他线程的栈，可以通过以下命令：
```
thread apply [THREAD-ID-LIST | all] backtrace
```
e.g.
```
info threads
# 查看线程1 2的bt
thread apply 1 2 bt
```

# 选择栈帧
```
frame/f [selection-spec]
# 以下命令不打印栈帧信息，只是选择
select-frame [selection-spec]
```
`selection-sepc`可以是：
* num：打印num指定的帧（0表示最内层的帧）
* level num：与num等价
* `address` stack-address：指定栈地址，`info frame`可以查看
* `function` function-name：如果有多个栈帧都属于该函数，那么会展开最内层的

如果没有指定`selection-spec`，那么打印当前的栈帧信息
# 移动栈帧
```
up n # 向更外层前进，即frame数字变大
down n # 向更内层前进
# n默认为1

# 以下命令不打印到达的栈帧信息
up-silently n
down-silently n
```

# 栈帧信息
```
info frame/f
info frame/f [selection-spec]
```
包含信息如下：
* 当前栈帧的地址
* 下一个栈帧的地址（callee的）
* 上一个栈帧的地址（caller的）
* 对应源代码的语言
* 实参的地址
* 局部变量的地址
* 保存的PC（caller的）
* 保存的寄存器

## 查看实参信息
```
info args [-q]
```
打印当前栈帧的实参信息。<br>
`-q`表示quiet，禁止打印解释为什么没有实参被打印的头信息和消息。

```
info args [-q] [-t type_regexp] [regexp]
```
可以指定正则表达式进行过滤，其中可以分别指定类型匹配和变量名匹配。<br>
类型要么实现知道，要么可以通过`whatis`查看。<br>

## 查看局部变量
```
info locals [-q]
info locals [-q] [-t type_regexp] [regexp]
```
该命令常和`frame apply`和`thread apply`组合在一起使用。<br>
比如下面的指令可以检测所有已获得的锁：
```
thread apply all -s frame apply all -s info locals -q -t MutexLock
tfass i lo -q -t MutexLock
```

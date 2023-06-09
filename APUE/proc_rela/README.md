# 进程关系（process relationship）
## 进程组（process groups）
进程组是 **多个进程的集合**，通常关联一个作业（job）。类似进程，每个进程组都有一个独特的ID（process group id，PGID）。<br>
如果向进程组发送信号，那么进程组中的所有进程都会接收到信号，即进程组作为一个信号接收单位。<br>
每个进程都会属于某个进程组，获取进程组ID：
```c
#include <unistd.h>
pid_t getpgrp(void);
/* process group ID of calling process */
```
为了兼容老式BSD派生的（BSD-drived）系统的`getpgrp()`，Single UNIX规范定义了如下函数：
```c
#include <unistd.h>
pid_t getpgid(pid_t pid);
/* process group ID if OK, -1 on error */

/* 如果pid = 0，等效于getpgrp()，即获取当前进程的进程组ID */
```
每个进程组 **可以** 拥有一个组长（leader），其PID与PGID相等。<br>
由于进程组允许没有组长，因此组长可以创建进程组之后立即终止。但是注意，只要进程组中至少有一个进程是它的成员，那么该进程组仍然存在。<br>
换言之，进程组的生命周期会在最后一个进程移动或终止后结束。

进程可以加入或是创建新进程组：
```c
#include <unistd.h>
int setpgid(pid_t pid, pid_t pgid);
/* 0 if OK, -1 on error */
/* If pid = 0, pid = caller pid.
   If pgid = 0, pgid = pid argument 
   显然，pid = pgid，该进程成为进程组的组长 */
```

一个进程可以设置它自身和其子进程的进程组ID，但是调用了`exec()`的子进程的进程组ID不可以修改（尽管它的PID未变）。
* 加入：pgid已存在
* 创建：pgid不存在（还有一个典型例子就是*setsid()*)

## 会话（Session）
会话是多个进程组的集合。<br>
进程组中的进程通常被shell的管道（e.g proc | proc2）放置进去。<br>
建立新会话：
```c
#include <unistd.h>
pid_t setsid();
/* process group ID if ok, -1 on error */
```
注意，只有调用进程不是进程组组长时，该函数才会起作用，不然返回-1表示错误。<br>
换言之，创建新会话的前提条件是：`调用进程不能是进程组组长`。<br>
具体来说，它会进行如下行为：
* 成为新会话的leader（创建新会话的进程就是leader）。
* 成为新的进程组的组长（显然，PGID=PID of caller）
* 进程没有控制终端（如果原来有，那么破坏该关联）。

为满足前提条件，一个常用的手段就是先fork一个子进程，然后父进程终止。

会话ID（Session ID）是会话leader的PID。获取会话ID：
```c
#include <unistd.h>
pid_t getsid(pid_t pid);
/* session leader's process group ID if OK, -1 on error */
/* pid = 0，用调用进程的PID代替 */
```
需要注意的是这里返回的是会话leader的PGID，不过会话leader的PGID和PID往往是相等的。

## 控制终端（controlling terminal）
* 会话可以拥有一个控制终端。它是一个终端设备或伪终端设备，用于登陆。
* 会话leader建立连接到控制终端（`控制进程`）
* 在会话中的进程组可以被划分为一个`前台进程组`（foreground process group）和一个或多个`后台进程组`（background process group）。
* 会话拥有控制终端，将会有一个前台进程组，其余的进程组均属于后台进程组。
* 在控制终端中按下中断键（interrupt key）可以向前台进程组的所有进程发送中断信号（e.g. Ctrl+C）。
* 按下退出键（Ctrl+\），发送`SIGQUIT`信号到前台进程组。
* 控制终端关闭，发送`SIGHUP`到控制进程（即会话leader）。

## 作业控制（job control）
> 作业控制于1980加入到BSD

作业是进程的一个集合。
```shell
vi main.c # 在前台启动一个作业
# 在后台启动两个作业
pr *.c | lpr &
make all &
```

支持作业控制有三个前提条件：
* shell支持
* 内核的终端驱动支持
* 内核支持作业控制的信号


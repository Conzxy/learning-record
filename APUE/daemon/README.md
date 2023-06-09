# Daemon进程:
> Daemon本意指古希腊神话中半人半神的存在，实际由来是Maxwell's Demon[1]，这里不作翻译。<br>
> 在CS中，指代在后台不知疲倦地处理系统杂物的后台进程。<br>
> [1] http://catb.org/~esr/jargon/html/D/daemon.html

## 概念
Daemon是指在 **后台长时间运行的进程**。通常，它们会随着系统启动而启动，随着系统关闭而停止。

## Daemonize
为了 *阻止发生不必要的交互*，通常要遵循一定的规则将进程Daemon化：
### Old style(System V)
> 结合APUE和daemon(7)

* 关闭除`stdin(1)`，`stdout(2)`，`stderr(3)`以外的其他已打开的文件描述符。
  * 通过遍历`/proc/self/fd`或者`[3,getrlimit(RLIMIT_NOFILE)]`实现。
* 重置所有的信号处理器为default。
  * 遍历可用的信号到`_NSIG`。
* 重置信号掩码（`sigprocmask()`）。
* 调用`fork()`，创建后台进程。
* 在子进程调用`setsid()`创建新会话，以脱离控制终端。
* 再次调用`fork()`，以保证永远不能再获取终端，退出第一个子进程。
  * 之后，将由init作为父进程接管。
* `stdin`,`stdout`,`stderr`全部重定向为`/dev/null`。
* 设置`umask`为0，使daemon可以根据自己的需要或第三库的API的需要来创建合适的文件，而不受调用环境（caller）的影响。
* 设置当前的工作目录为根目录（`/`），以防止阻塞挂载点被卸载。
* 写入daemon的PID到`/run/*.pid`，以防止daemon多次启动。
* 通知最初的进程：daemon的初始化已完成。
* 退出最初的进程。

> 不要调用BSD的daemon()（即`daemon(3)`），它只完成这里的一些步骤

## New style(Modern Service for Linux)

1. SIGTERM --> 关闭Daemon
2. SIGHUP --> 重加载配置文件
3. 提供正确的退出码，以便systemd可以检测服务错误和问题。
4. 编写`*.service`单元文件
5. `open()`最好指定`O_NOCTTY`选项避免获取终端文件。
6. 不是通过`syslog()`来写入系统日志，stdout和stderr都与`systemd-journald.service(8)`建立了连接，因此通过`fprintf()`就可以提供日志服务。

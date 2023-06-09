# Service unit file
> 参考`systemd.service(5)`

## 什么是Service文件？
`*.service`是一种单元配置文件，主要用于记录被`systemd`控制和监督的进程信息。

单元配置文件中的配置项称为`Option`。

## Options
### Type=
* simple<br>
  （设置了ExecStart=但没有设置Type=和BusName时的默认值）<br>
  ExecStart是该服务的主进程（main process）。在主服务进程被fork成功之后，服务管理器认为该服务启动完成。<br>
  在创建主服务进程之后，执行主服务进程之前，立即就可以启动后面的单元文件，从而加快后继单元的启动速度。<br>
  注意，即使主服务进程并没有成功执行， *systemctl start* 仍然会视为成功（比如User=没有设置）
* exec<br>
  类似simple，但是只有在主服务进程被成功执行后才会视为服务启动完成。<br>
  如果主服务进程没有成功执行，那么 *systemctl start* 失败。

用更简单的话来描述，simple关注的是`fork()`，而exec在此之上还关注了`exec()`是否成功。

* forking<br>
  期望ExecStart=指定的进程会调用fork()作为启动的一部分。<br>
  父进程应当在启动完成和所有通信频道建立完成后推出，这是传统UNIX daemon的做法（参考Old style daemon）。<br>
  在父进程退出后，服务管理器认为服务启动完成。<br>
  建议设置PIDFile=来指定pid文件存储位置，以避免多次启动（参考Old style daemon）
* oneshot<br>
  （Type=和ExecStart=均为设置时的默认值）<br>
  类似simple，但在该服务的主服务进程退出后才被认为服务启动完成。<br>
  对于该类型服务，建议设置`RemainAfterExit=`。
* dbus<br>
  待补充。
* notify<br>
  类似exec。不过服务主进程需要通过`sd_notify(3)`来通知服务启动完成。<br>
* idle<br>
  类似simple，在所有活动作业都被派遣（dispatch，翻译成完成或许也不算错）后才执行该服务程序。<br>

### RemainAfterExit=
当该服务的所有进程退出后，是否视为活动。默认是no。

### PIDFile=
如果是相对路径，前缀为`/run`。

### ExecStart=

### ExecStartPre=, ExecStartPost=

### ExecCondition=
在ExecStartPre=之前执行的命令。

### ExecReload=

### ExecStop=

### ExecStopPost=

### RestartSec=
重启服务前的睡眠时间

### TimeoutStartSec=

### TimeoutStopSec=

### TimeoutAbortSec=

### TimeoutSec=
设置`TimeoutStartSec=`和`TimeoutStopSec=`的快捷方式。

### Restart=

### NotifyAccess=
设置服务状态通知socket的权限。
* none：不更新，所有状态更新信息都被忽视
* main：仅主服务进程的信息可接受
* exec：主服务进程+Exec\*=的进程均可接受
* all: 该服务的控制组（control group）的进程均可接受
当Type=notify或WatchdogSec=被设置时，如果NotifyAccess=没被设置，默认值为 **main**。

# 作用
> I/O completion ports provide an efficient threading model for processing multiple asynchronous I/O requests on a multiprocessor system. When a process creates an I/O completion port, the system creates an associated queue object for threads whose sole purpose is to service these requests. Processes that handle many concurrent asynchronous I/O requests can do so more quickly and efficiently by using I/O completion ports in conjunction with a pre-allocated thread pool than by creating threads at the time they receive an I/O request.

IOCP是Windows针对IO多路复用给出的一个究极解决方案. 其思路与`epoll()/poll()`这类同步API不同, 它是完全异步的API.

首先它允许用户指定一个`线程数目`, 与之对应有一个`完成队列(Completion Queue)`, 这些线程会处理IO事件, 并不会阻塞调用线程(或主线程).
> [!warning]
> 处理IO事件的线程需要用户自己创建并管理, 通常是在内部实现事件循环.
> IOCP是要搭配`线程池`使用的.

# 基本应用
> The [**CreateIoCompletionPort**](https://learn.microsoft.com/en-us/windows/win32/fileio/createiocompletionport) function creates an I/O completion port and associates one or more file handles with that port. When an asynchronous I/O operation on one of these file handles completes, an I/O completion packet is queued in first-in-first-out (FIFO) order to the associated I/O completion port. One powerful use for this mechanism is to combine the synchronization point for multiple file handles into a single object, although there are also other useful applications. Please note that while the packets are queued in FIFO order they may be dequeued in a different order.

可以通过调用`CreateCompletionPort()`来创建新的完成端口, 或是绑定fd到一个完成端口上, 这些fd就可以推送IO事件给完成端口了. 当事件完成时, 会根据`FIFO`的顺序向完成队列中放置`IO完成包(IO Completion packet)`, 或者说`IO上下文(IO Context)`. 但是需要注意, 取出没必要遵循FIFO的顺序, 不然会影响性能.

> When a file handle is associated with a completion port, the status block passed in will not be updated until the packet is removed from the completion port. The only exception is if the original operation returns synchronously with an error. 
> A thread (either one created by the main thread or the main thread itself) uses the [**GetQueuedCompletionStatus**](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatus) function to wait for a completion packet to be queued to the I/O completion port, rather than waiting directly for the asynchronous I/O to complete. Threads that block their execution on an I/O completion port are released in last-in-first-out (LIFO) order, and the next completion packet is pulled from the I/O completion port's FIFO queue for that thread. This means that, when a completion packet is released to a thread, the system releases the last (most recent) thread associated with that port, passing it the completion information for the oldest I/O completion.

`GetQueuedCompletionStatus()`是等候Completion packet入队, 而不是等候异步IO事件完成.

根据该API, 可以实现类似`epoll()/poll()`等同步非阻塞API的效果.
> [!note]
> `GetQueuedCompletionStatusEx()`可以一次性取出多个Completion Packet, 因此释放该线程的条件应该是等于要求数目或者队列空.

> Although any number of threads can call [**GetQueuedCompletionStatus**](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatus) for a specified I/O completion port, when a specified thread calls **GetQueuedCompletionStatus** the first time, it becomes associated with the specified I/O completion port until one of three things occurs: The thread exits, specifies a different I/O completion port, or closes the I/O completion port. 
> In other words, a single thread can be associated with, at most, one I/O completion port.

线程与完成端口绑定的时机: 第一次调用`GetQueuedCompletionStatus()`.

一个线程在线程或完成端口的生命周期中至多绑定一个完成端口.

> Threads can use the [**PostQueuedCompletionStatus**](https://learn.microsoft.com/en-us/windows/win32/fileio/postqueuedcompletionstatus) function to place completion packets in an I/O completion port's queue. By doing so, the completion port can be used to receive communications from other threads of the process, in addition to receiving I/O completion packets from the I/O system. The **PostQueuedCompletionStatus** function allows an application to queue its own special-purpose completion packets to the I/O completion port without starting an asynchronous I/O operation. This is useful for notifying worker threads of external events, for example.

`PostQueuedCompletionStatus()`可以给不同线程提供通信能力. 可以用于实现其他线程对IO线程的唤醒.

> The I/O completion port handle and every file handle associated with that particular I/O completion port are known as _references to the I/O completion port_. The I/O completion port is released when there are no more references to it. Therefore, all of these handles must be properly closed to release the I/O completion port and its associated system resources. After these conditions are satisfied, an application should close the I/O completion port handle by calling the [**CloseHandle**](https://learn.microsoft.com/en-us/windows/desktop/api/handleapi/nf-handleapi-closehandle) function.

完成端口的生命周期是由计数控制, `CloseHandle()`的调用需要注意

# 并发线程设置
> The most important property of an I/O completion port to consider carefully is the concurrency value. The concurrency value of a completion port is specified when it is created with [**CreateIoCompletionPort**](https://learn.microsoft.com/en-us/windows/win32/fileio/createiocompletionport) via the _NumberOfConcurrentThreads_ parameter. This value limits the number of runnable threads associated with the completion port. When the total number of runnable threads associated with the completion port reaches the concurrency value, the system blocks the execution of any subsequent threads associated with that completion port until the number of runnable threads drops below the concurrency value.

 `CreateIoCompletionPort()`可以限制完成端口绑定线程的上限数量.
> [!warning]
> 这个线程数目只限制可运行线程


> The most efficient scenario occurs when there are completion packets waiting in the queue, but no waits can be satisfied because the port has reached its concurrency limit. Consider what happens with a concurrency value of one and multiple threads waiting in the [**GetQueuedCompletionStatus**](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatus) function call. In this case, if the queue always has completion packets waiting, when the running thread calls **GetQueuedCompletionStatus**, it will not block execution because, as mentioned earlier, the thread queue is LIFO. Instead, this thread will immediately pick up the next queued completion packet. No thread context switches will occur, because the running thread is continually picking up completion packets and the other threads are unable to run.

一种较为理想的运行情况是: 绑定线程数达到上限并且所有线程都不会被阻塞因为队列提供的packet一直有人消费

## 选择合适的线程上限
> The best overall maximum value to pick for the concurrency value is the number of CPUs on the computer. If your transaction required a lengthy computation, a larger concurrency value will allow more threads to run. Each completion packet may take longer to finish, but more completion packets will be processed at the same time. You can experiment with the concurrency value in conjunction with profiling tools to achieve the best effect for your application.                                                                                                                                           
> 
> The system also allows a thread waiting in [**GetQueuedCompletionStatus**](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatus) to process a completion packet if another running thread associated with the same I/O completion port enters a wait state for other reasons, for example the [**SuspendThread**](https://learn.microsoft.com/en-us/windows/desktop/api/processthreadsapi/nf-processthreadsapi-suspendthread) function. When the thread in the wait state begins running again, there may be a brief period when the number of active threads exceeds the concurrency value. However, the system quickly reduces this number by not allowing any new active threads until the number of active threads falls below the concurrency value. This is one reason to have your application create more threads in its thread pool than the concurrency value. Thread pool management is beyond the scope of this topic, but a good rule of thumb is to have a minimum of twice as many threads in the thread pool as there are processors on the system. For additional information about thread pooling, see [Thread Pools](https://learn.microsoft.com/en-us/windows/desktop/ProcThread/thread-pools).

假设CPU数目为n, 指定的参数为m.

一般视角来看, 选择少于n的线程数来处理IO事件, 会浪费多余的IO事件, 反之选择多于n的线程数会导致多余的线程处于阻塞状态.

所以选择`m=n`或者`m=n+c(c<n)`会是一个折中的方案.

考虑你的业务处理比较耗时, 队列会出现大量packet没人取, 所以把线程数调多些是更合理的. 但是这样做, 会导致如果业务空闲下来的时候, packet并不会堆积, 导致阻塞其他线程, 形成浪费.

线程池有一个经验理论值是`2n`, 当有的线程调用了`Sleep()`, `Lock()`等函数导致线程阻塞了, 此时IOCP会将其他线程从暂停线程队列中拖到释放线程队列, 并处理队列中剩余的packet.

IOCP的最终目标在于尽可能保证释放线程队列不会空闲, 处于随时可以进入等待线程队列的状态, CPU占用不被浪费.

这点, 我认为是要比其他同步非阻塞API更智能的.

# 底层实现原理
可以分为四个队列
![[Pasted image 20240403140840.png|IOCP Implementation]]

> [!question] `Paused Thread List`与`Waiting Thread Queue`的区别
> * `Waiting Thread Queue`是被动放弃，进入等待的线程，可从`Released List`或者第一次调用`GetQueuedCompletionStatus()`添加。
> *  `Paused Thread List`是主动放弃，从`Released List`添加的线程。
> 
> 另外`Waiting Thread Queue`满足`LIFO`的特征, IOCP是根据这个顺序来扫描等候线程, 根据IO事件的完成决定哪些线程放入到`Released Thread List`的, Paused Thread List应该在该过程完成后进行检测, 并且不需要按照LIFO的顺序检测, 条件满足有谁用谁.
> 所以将`Paused List`和`Waiting Thread Queue`合并不太合理, 因为我们不知道这个被阻塞的线程什么时候是可用的, 扫描它们是浪费的.
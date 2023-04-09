* [x] KanonTeardown()
* [x] 触发数为1时，调用GetQueuedStatus()
有个很奇怪的bug（或者行为异常），见iocp_poller.cc
* [x] CXX_STANDARD是否冲突
避免冲突，用#ifndef判断
* [x] TcpConnection构造函数有必要private吗
没有必要，加上NO_API限定符禁止外界调用。
不过说实话，TcpConnection的构造必然是kanon_net负责的，所以各方面来说没必要。
* Timer counter 是否声明为API？
* [x] sock_api.h确认哪些可以划为NO_API
均可用NO_API修饰
* Windows 正常Disconnect
* [x] 确认回调访问DLL变量是否不需要dllexport或是别的原因？
以TcpClient的回调举例，回调最终会移动到TcpClient成为它的成员，而这个callback有权限访问Connection的buffer
严格意义来说，只要kanon_net中没有NO_API的Buffer变量，我们都没有必要让Buffer的内联函数加上API限定符
* [x] EventLoop有些不是API
* [ ] 事件优先级调度
* [ ] （Win）TimerQueue AddTimer() 计算两次（第二次需要-now）
* [ ] 短函数KANON_INLINE覆盖
* [ ] 检查所有移动构造函数和移动赋值重载是否调用swap()来保证资源的正确释放
* [ ] 检查所有依赖std::allocator的deallocate()调用是否判断指针为空
* [ ] terminal_color宏重命名
* [ ] Windows file getsize()  直接使用OS API
* [ ] ProtobufCodec是否和MmbpCodec存在一样的问题？
检查size_header与MIN_SIZE/MAX_SIZE
* [ ] 检查kanon中关于String转换类型的所有函数的安全性检查
* [x] 检查chunklist（即ForwardList）是否内存泄露
FIX：reverse()用错了变量导致内存泄露
* [ ] AsyncLog 移动语义优化
* [x] ForwardList header 优化
测试全部通过
* [ ] 修改和BUG同步到Blog
* [x] 去除所有Conversion警告
* [ ] TcpConnection考虑是否采用侵入式引用计数
* [ ] platform.cmake KANON_ON_UNIX打错字了
* [ ] Log 二进制数据
* [ ] 性能测试：echo，与muduo
* [ ] connector（win），channel移动
* [ ] inetaddr * parse
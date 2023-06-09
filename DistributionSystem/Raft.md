# 为什么Raft渐渐流行
对于**复制日志（replicated log）** 的一致性协议（或共识算法），之前一直流行paxos，但是由于其设计上并没有那么好理解，因此Raft对该问题进行了解耦并简化了状态空间。Raft共分为三个部分：

- leader election
- replicated log
- safety
# 安全性（Safety)

- 选举安全性（election safety）：在一个给定的term中有且只有一个leader被选出
- 领队仅追加（leader append-only）：leader没有删除和覆盖原有log的权限，只可以在原有log上追加新的内容
- 日志匹配（log matching）：如果两个日志拥有相同的index和term那么在这个记录之前的所有记录应该都相同
- 领队完整（leader completeness）：
- \***状态机安全性（state machine safety）**：当有一个server将日志记录在一个给定的index处添加到自己的状态机中，此时其他server不能在该index处拥有不一样的记录

由于Raft最终目的是为了保证所有server的复制日志都是相同的，所以状态机安全性是Raft的关键。
# Leader election
## Role
集群中的每个服务器都担任了一个角色：

- leader：处理所有client的请求（如果请求被发到了follower，重定向给leader）
- follower：被动接受candidate和leader的请求，并不会主动发送任何请求
- candidate：用于选举的一种角色，鉴于leader和follower的中间态。

正常情况下，一个集群只有一个leader和多个follower。
## Term
Raft将时间分为多个term（任职期），每个term开始会进行一次选举，胜出的candidate会成为该term剩余时间内的leader。
> 对于均分票数的情况如何处理？

该term没有leader，并开启新term，该term更短，保证均分的可能降低。
> 不同的server在不同时间观测到term的迁移，会导致一些server可能没发觉自己处于哪个term，是否处于选举等，Raft是如何处理的？

term在Raft的真正作用就是作为**逻辑时针（logical clock）**， 并且每个server都存储一个current term，这样可以识别过时信息，比如旧的leader。

- 当candidate或leader发现接受到的term大于它们的current term，那么就转变为follower
- 当server发现有请求携带的term小于它们的current term，拒绝该请求（不是无视，而是返回term和failure让它更新自己，好加入到集群中）
## RPC
Raft也和大多数分布式系统一样采用主流的RPC方式来进行通信（至于底层消息是用json还是protobuf不是重点）。  
leader election涉及到的RPC有两个

- RequestVote：由candidate向其他server发送
- AppendEntries：由leader向其他server发送，并且可以作为心跳包发送

对于一定时间内没有响应的RPC，进行重发（最好是异步）。
## 操作流程


  

 

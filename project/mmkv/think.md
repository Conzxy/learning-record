## Pending Completion
发送Completion request后，如果Controller发送CONF_CHANGE，是否立即完成。

## Leaving
新节点加入看不到包含leaving node的配置，因此不可能向其发送Pull请求。
老节点离开会向其Push，但是此时它是不可能发送Complete request的。

对于leaving node，是OK的。

## Joining
新节点加入可以看到包含Joining节点的配置，该Joining节点必然已经完成所有Pull请求。因此是OK的。
老节点离开会Push给它，并不影响。是OK的。

## 如何应用Raft协议
除了Mmkvd，后台还运行有Sharder，ShardControllerClient，SharderClient，支持多重协议：
* MmbpMessage：MmbpRequest/MmbpResponse
* SharderMesage
* ControllerRequest/ControllerResponse
但是要注意，其实后两种协议实质上都是为了数据，即第一个协议的格式。
所以如果把它们转化为一个统一的状态塞进Raft状态机是设计的关键。

我们称Raft形成的集群为一个组，而每个Mmkvd实例为一个节点。
那么组内的所有节点都需要与Controller建立连接，为了支持Recover和log，需要制定新的机制或操作。
当Mmkv client发出Join请求后，Leader接受请求并处理，向Controller发出Join请求，并得到需要Pull的所有Shard。此时，向日志添加所有的ControllerResponse，在一个Shard处理完后，向日志添加表示“Shard=？ ？操作 处理完成”的条目。
当Recover时，就分析这些条目来决定是否继续进行Pull操作。其中日志中混有MmbpMessage并不会影响这些条目的解析和处理。

## Recover
由于Recover需要考虑Rejoin，此时数据库很可能已经存储数据，因此需要对Join请求得到的Pull shard进行分析：
* 对于自己有的Shard，和Pull Shard一致的情况，Push Shard给要Pull的节点
* 对于不一致的情况，Pull Shard给自己

除了Recover，也要考虑已存储数据的节点加入集群，因此这里一起考虑。
首先针对所有shard，此时肯定是空集合，因此先将key分布到对应的shard去，没有key也没关系。
然后分析shard和pull shard就行了。

将JOIN PUSHING作为一个状态并视为原子的，即影响pending conf的更新

### 
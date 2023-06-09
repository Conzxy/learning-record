- [ ] vset no weight version
* [x] linenoise -> linenoise-ng
linenoise-ng的API不完整，换成replxx改写成功。
replxx可以跨win/mac/linux
* [x] Configuration继承MmbpMessage
* [ ] Client shortcut key（or single handler？）
* [x] 增加选项表示log
* [ ] CLI支持'str'表示整体
* [ ] ReservedArray 是否进行默认初始化
* [x] 版本号（binary）
* [ ] server shrink buffer
* [ ] server pipeline
* [x] multithread -> config
* [x] `GetCliCommand()` 等加断言
- [ ] 异常处理（InetAddr etc）
- [ ] controller实现pending sessions <= pending conf实现
- [ ] 考虑request包含shard_id避免server再次计算
- [x] DatabaseManager在分布式条件下计算index采用shard_id而不是key hash
更换为GetShardDatabaseInstance()
- [ ] ShardAddkeys
* [ ] Mmkv cache shard_id
* [ ] TryReplaceKey logic check
* [ ] shard client断点再发送
* [ ] mmkvc 断点发送
* [ ] expiration routine check again check

- [ ] Cmake分成debug/release两个目录避免重复全量编译

- [ ] Controller recover 时集群不可用，controller不接受任何join/leave请求
- [ ] 将sharder/controller用到的Hashset等采用Norecord allocator
- [ ] 检查Blist等数据结构的coun%t操作，如果是CreateNode/FreeNode时递增或递减，将其分散到具体的操作中去。
- [ ] command与expiration不采用varint编码
- [ ] mmkv采用自己的protobuf链接kanon_protobuf与kraft

## 版本控制
- [ ] 采用vcpkg进行包管理
目前主要是采用submodule进行依赖管理，但是由于submodule可以套娃：
* kraft、kanon、mmkv均依赖protobuf、protoc，版本难以统一（CMake管理也累）
* kanon、mmkv均依赖kvarint，但由于是单文件，所以可以不管，尽管版本统一也很麻烦
* kraft（test）、mmkv均依赖kanon，版本同步麻烦（尽管不是很有必要）
* 待补充

- [ ] 全部采用系统的protobuf
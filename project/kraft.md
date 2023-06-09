* [ ] HB request update commit index
* [ ] leader 考虑写入conf entry
* [ ] no-op entry becomeleader
* [ ] voting state change
* [ ] addselfnode addpeernode conf entry apply
* [ ] redirect leader id -> try_apply()
* [ ] 有文件缺失，拒绝恢复
* [ ] fetchent buffer
- [ ] 锁定存储目录权限，设置用户或用户组，防止非法写入（因为没有catalog）


| Operation | Performance Comparison |
| -- | -- |
| Insert | HashSet > std::unorderd_set > AvlTreeHashTable(2倍) |
| Delete | HashSet > AvlTreeHashTable(接近) > std::unordered_set |
| Find | AvlTreeHashTable >> HashSet(5倍) > std::unordered_set |

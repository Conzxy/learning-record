## 清除coredump文件
```shell
systemd-tmpfiles --clean # 没有作用
sudo rm /var/lib/systemd/coredump # 主动清理
```
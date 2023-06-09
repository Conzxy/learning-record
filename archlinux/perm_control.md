# 权限管理

# 用户管理
## 查看当前登陆用户
```shell
$ who
```
显示格式：
```
username   login-time
```

## 查看系统所有用户
```shell
# passwd -Sa
# cat /etc/passwd
```

## 添加用户
```shell
# useradd -m -G "groups" -s "shell path" "username"
```
* `-m/--create-home`：创建`/home/[username]`家目录
* `-G/--groups`：加入到附加组去，用逗号隔开（没有空格），否则只加入初始组（大概是指与用户名同名的组）。
* `-s/--shell`：指定登陆shell（默认是bash）

有些用户需要登陆服务，比如提供系统服务的用户，将shell设为`/usr/bin/nologin`。<br>
系统可用shell可以查看`/etc/shells`。

新用户需要用`passwd`设置密码。

## 修改用户主目录
```shell
# usermod -d [path] -m [username]
```
`-m` 会自动创建新目录并移动旧内容。

## 修改用户的组
```shell
# usermod -aG [groups] [username]
```
> 注意，这里必须是`-aG`，表示追加，不然会离开不属于groups的组。

## 删除用户
```shell
# userdel -r [username]
```
* `-r`：删除用户主目录和邮件

## 用户数据库
用户信息存储在`/etc/passwd`中，用`:`隔开每个字段：
```
conzxy:x:1000:998:****:/home/conzxy:/bin/zsh
# 解释
# acount:password:UID:GID:GECOS:directory:shell
```

* `password`：`x`只是占位符，密码存储在`/etc/shadow`（加密并放了盐）。
* `UID`：对于root之后的第一个登陆用户，UID从1000开始，后面的用户UID均大于1000。对于服务用户，UID通常小于1000。
* `GID`：首要组的ID，在`/etc/groups`中可以查看所有组的GID。
* `GECOS`（可选）：表示信息用的字段，比如用户全称等。一般会留白。
* `directory`：用户主目录。
* `shell`：登陆默认shell。

## 检查数据库文件完整性
```shell
# pwck -s
```
* `-s`(sort)：将/etc/passwd和/etc/shadow中项按UID排序

# 组管理（group management）
`/etc/group`存储所有组信息。

## 查看用户的所属组
```shell
$ groups [username]
; 忽略username，则显示当前用户的信息（即视username为当前用户）。
```
除此之外，还可以用`id`查看：
```shell
$ id [username]
```
相较于groups，显示的信息更详细（包括uid，gid）。

## 创建组
```shell
# groupadd group
```

## 用户加入组
```shell
# gpasswd -a [user] [group]
# usermod -aG [additional_groups] [user]
```
对于`gpasswd`，a表示add。

## 用户移出组
```shell
# gpasswd -d [user] [group]
```

## 组改名
```shell
# groupmod -n [new_group] [old_group]
```
改名之后，属于该组的所有用户均会迁移到新组。<br>
注意，改名并不会导致GID变动，因此之前属于旧组的文件，新组依然可以访问（符合直觉）。

## 删除组
```shell
# groupdel [group]
```

## 组数据库
类似用户数据库，组数据库文件包括：
* `/etc/group`
* `/etc/gshadow`

`etc/group`的项格式：
```
wheel:x:998:conzxy,...
# group:password:GID:users,...
```
组也可以设置密码，不过暂时没想到应用场景。

## 检查数据库文件完整性
```shell
# grpck
```

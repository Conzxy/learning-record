# FAQ
关于Arch Linux的一些折腾记录（备忘录）

## `*.desktop`放在哪里
`/usr/share/applications/*.desktop`
一般查看用途：
* 想知道下载的应用执行路径
* 学习语法，给没有desktop的程序写.desktop以便程序启动器可以找到（比如`rofi`）

#  使指定窗口透明
```shell
$ sudo pacman -S devilspie
$ yay -S transset-df
$ make ~/.devilspie
$ vi ~/.devilspie/opacity.ds # 命名无所谓
```
编辑`~/.devilspie/opacity.ds`：
```
( if
( contains ( window_class ) "Code" ) # Vscode，可以换成别的
( begin
( spawn_async (str "transset-df -i " (window_xid) " 0.80" ))
)
)
```
然后启动`devilspie`
```
devilspie -a &
```

# 关闭Swap分区
由于交换分区可能会导致多个应用争用，同时由于移动硬盘不给力，导致系统整体阻塞影响使用体验，因此我决定禁用它（最麻的是内存占用不多的时候也给我用交换分区）（其实一般都会推荐关闭它的）。

## 临时命令
如果系统已经运行了，那么通过
```
$ swapoff -a
```
就能禁用交换分区。但这只是临时的，开机还会启动。

## 永久禁用
由于交换分区归`systemd`管理，所以可以找到`.swap`单元文件，并标记它（mask）。
```
# systemctl -type swap -all
# sudo systemctl -mask <unit-filename>
```

# 硬盘挂载
不推荐开机挂载不常用的硬盘，不如手动挂载（用脚本）。

## 开机自动挂载
```
; 获取文件系统类型和UUID
$ lsblks -f 
# vi /etc/fstab
```
各字段的意义参考文件内注释和[wiki](https://wiki.archlinux.org/title/Fstab_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)。
举个例子，套模板够用了：
```
UUID=... none /winC ntfs rw,retime 0 2
```

## 手动挂载
```
$ mount /dev/x1 /winC
$ mount /dev/x2 /winD
; 取消挂载
$ unmount /dev/x1 # Or /winC
```

# 声音控制
## 调整声音大小或禁用
可以用`alsamixer`来进行控制
其中`m`键是启动toggle，如果有音量没声音，那肯定是被禁用了。

# 更换启动默认shell
```shell
; 更换默认shell为zsh
$ chsh -s /bin/zsh
```

# 分辨率问题
可以尝试以下命令：
```shell
$ xrandr --output [] --mode 1920x1080
```
比如wine打开一些游戏异常退出，可能会导致整体UI变大。

# WPS打开异常
比如白屏。
原因可能是DPI出了问题，事先调整过DPI
```shell
$ xrandr --output [] --dpi 96
```


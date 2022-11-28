# 配置

## Location
配置文件所在: ~/.config/i3/config

## 浮点窗口(floating window)
在i3wm中，对话框是浮动的，好像是通过XWindow的属性检测的（暂时没了解）。<br>

我的需求是想要使终端打开默认浮动而不是打开之后通过键映射使窗口浮动。

```txt
# toggle tiling / floating
bindsym $mod+Shift+space floating toggle
```

由于终端模拟器一般支持指定窗口名称，因此可以通过该选项来识别它：
```shell
$ alacritty -t (window-title)
```

```txt
for_window [title="alacritty$"] floating enable;

set $fontSize 15
bindsym $mod+Return exec alacritty -o font.size=$fontSize -t "alacritty"
bindsym $mod+Shift+Return exec alacritty -o font.size=$fontSize -t "tilling"
```

## ...

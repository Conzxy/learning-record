# Polybar Configuration
有点嫌弃`i3bar`太简陋了（尽管功能性足够了），记得之前在wiki上看到有其他替代品，于是试用了下`polybar`，初始配置其实就不错了，只要再调两下。
更复杂的配置得参考github上的wiki。

## 显示托盘图标
```ini
[bar/mybar]
wm-restack = i3
tray-position = right
```

## 移到屏幕下边
默认是在屏幕上面出现，通过设置`bottom`调整：
```ini
[bar/mybar]
bottom = true
```

## 多显示器显示polybar
可以参考[github issue](https://github.com/polybar/polybar/issues/763#issuecomment-331604987)。
```shell
# 在~/.config/polybar/mylaunch.sh中加入
if type 'xrandr'; then
  for m in $(xrandr --query | grep ' connected' | cut -d" " -f1); do
    POLYBAR_MONITOR=$m polybar --reload example 1>/dev/null 2>&1 | tee -a /tmp/polybar2.log & disown
  done
else
  polybar -c ~/.config/polybar/config.ini example 1>/dev/null 2>&1 | tee -a /tmp/polybar2.log & disown
fi

# 在~/.cofig/polybar/config.ini
[bar/example]
monitor = ${env:POLYBAR_MONITOR:}
...
```

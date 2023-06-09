# htop

# 修改显示信息
F2 -> Meters -> Column [count]

可以从`avaliable meters`中添加新的显示信息。<br>
在具体的meter上按
* 空格：更换样式，比如LED，text
* 回车：移动

# 过滤功能
`F4`/`\` 触发过滤功能<br>
如果一开始就决定监视哪个进程，可以在命令行参数中指定过滤字符串（朴素匹配）。

```shell
htop -F [program name]
```

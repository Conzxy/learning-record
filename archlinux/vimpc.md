# vimpc
mpd的一个好用的终端客户端。<br>
最大的特点就是key binding很多习惯都是迁移或借鉴的vim，对于vim用户很友好也很舒适。

## 音量控制
```
[count] + 增加音量
[count] - 减小音量
```

## 控制播放模式
```
C
T
R 随机播放
E 循环
S
```

## 控制播放状态
```
space 暂停/播放

```

## Playlist
playlist可以将用户喜欢的歌按照自己的标准进行分类。
```
[count] a 添加歌曲
[count] d, del 删除歌曲
x 删除列表本身
e 浏览列表的歌曲
```

### Command
```
save <name>
toplaylist <name>
load <name>
```

## Library
library按照"artist/album/song"的层次展示。

一开始展示的是artist，用左右键折叠和展开列表。
```
[count] a
[count] d, del
h, left, zc 折叠列表
l, right, zo 展开列表
e 打开一个新tab浏览artist/album的歌曲
```

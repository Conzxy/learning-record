# wine FAQ

# 游戏打开黑屏
光鸟鸟打开黑屏，尽管有声音和接受鼠标点击（然而色鸟鸟完全可以运行）<br>
中间怀疑是不是DirectX3D支持出了问题，于是通过winetricks下载d3d9相关插件，结果没用。<br>
中途甚至还换用N卡独显模式（默认是intel核显）。结果自然也是没用。<br>
最终通过安装`gstreamer`解决。

# 有视频的游戏播放不了视频
运行椿恋歌，序章过后有一个OPENING视频，结果播放不了，也跳过不了，我又没存档，于是卡在那过不去了，贼难受。只能考虑如何正常播放视频。<br>
首先，浏览了wine的终端日志，显示gstreamer缺少MPEG-1的解码器，于是装了各种插件（good，ugly，bad，libav等），然而均没有用。<br>
参考了一个[涉及这方面的博客](https://piglalala.github.io/2021/04/07/%E5%A6%82%E4%BD%95%E5%9C%A8linux%E7%8E%AF%E5%A2%83%E4%B8%8B%E6%84%89%E5%BF%AB%E7%9A%84%E6%8E%A8galgame01-%E4%BB%8E%E5%9F%BA%E7%A1%80%E9%85%8D%E7%BD%AE%E8%BF%90%E8%A1%8C%E5%88%B0/)，于是装了[LAVFilter](https://github.com/Nevcairiel/LAVFilters/releases)，这个更神奇了，32位(~/.wine32)没问题，64位(~/.wine)最后一步有问题，而wine对于32位和64位是分别要求依赖的，也就是说64位应当依赖64位的gstreamer插件，而32位一些插件(lib-gst-plugin-\*)由于循环依赖的问题，我下不了，硬着头皮忽略最后一步的错误，然后64位和32位尝试运行，显示”缺少WMA格式的解码器，要安装合适插件“。到这里我都没啥解决方法了。<br>
根据WMA的提示，搜到了[某个帖子](https://forum.artixlinux.org/index.php/topic,4411.0.html)。<br>
根据该帖子，需要移除`gstreamer-0.1`系列插件，然后rebuild wine和创建新的prefix目录。rebuild我是下载的代码压缩包，然后编译，时间贼长不说，最终还是老问题，这时我复用的原来的prefix，于是用原来的wine创建了新的64位prefx(~/.wine64)，再次运行仍然不行（这是我用的是rebuild的wine），我嫌弃这个wine太难用了（很多东西不太一样），还是换回了原来的wine，然后对`~/.wine64`安装LAVFilter（用`~/.wine`会直接报错，连引导界面都进不了，迷惑），这次成功了，然后我拿去再跑了一下，居然可以了！算是意外之喜。<br>

到头来，rebuild这步并不是关键（甚至没啥用），关键是创建个新的prefix，居然解决了一切！<br>
我猜创建prefix才会根据现在的环境建立一些索引啥的，从而新插件和没有的插件都被更新了，因此新prefix能够正常工作。当然，或许也和winetricks安装的那些东西有关也说不定（因为新prefix是纯净的），这方面就没太关注了。

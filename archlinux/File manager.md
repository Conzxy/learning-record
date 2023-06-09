# File Manager
## TUI
* vifm
* ranger

虽然初始可能乍看 ranger 要比 vifm 更好用些，其实不然。
vim的keybinding两边都做的可以，因此应当关注可扩展/可配置的部分。

不过，vifm可以有两个pane，便于cp/mv。从这点我更喜欢vifm。

### colorscheme
个人认为 vifm 要做得更好，我只是大致搜了一下：
* ranger
	* http://dotshare.it/category/fms/ranger/
	* https://github.com/alfunx/ranger-colorschemes
* vifm
	* https://vifm.info/colorschemes.shtml

### 扩展
两者都支持文本预览、目录树预览等。
但是都不默认支持Image/Vedio/Song预览。

#### 预览
##### vifm
> 参考：https://github.com/thimc/vifmimg

需要的依赖：
* ueberzug
* ffmpegthumbnailer
* ImageMagick
* ddjvu
由于我只需要Image/Vedio能够预览就足够了，所以只需要这些依赖。

> 对于我来说，只有ueberzug是需要额外安装的。

将两个脚本放在PATH包含的目录中，然后用其中的 `vifmrun` 脚本运行vifm，否则不能正常显示。
之后通过 `:view` 命令进入预览模式（再次敲击该命令退出）

## GUI
GUI的FM保留一两个就行了，没必要弄太多，因为大同小异。

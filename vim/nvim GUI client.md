## gnvim
基于Rust+gtk4编写的GUI client。
功能孱弱，没有啥文档。
艹蛋的是AUR的包也没人积极维护，有些bug fix之后还得自己拉新的源码编译。

除此之外，由于这个GUI将Command line放在最顶上，导致barbar.nvim无法工作。
弃用。

## fvim
笑死，根本启动不了。
是基于F#写的，好像是要在微软.Net环境跑，直接弃用不解释。

## neovide
在wayland下原生运行会出问题。
还是得用xwayland。
```shell
WINIT_UNIX_BACKEND=x11 neovide
```

`<m-<>`和`<m->>`的keymap无法作用。
## goneovim
这个是用qt-binding+Go编写的。
可以原生在wayland下运行（因为Qt），并且keymap正常作用。

## neovim-qt
同goneovim。

## neoray
这个连编码都没整明白。
`<m-<>`和`<m->>`的keymap也无法作用。

## nvui
keymap有问题。
内存占用大（不开任何buffer 185M）。

## 最终选用
最终选用goneovim，因为相比neovim-qt更美观，我喜欢。
而至于neovide，有多个原因：
* keymap
* 不能原生运行
* 内存占用大

goneovide开两个buffer占用100M不到，neovide不开buffer居然要183M。
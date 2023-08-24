# Nvim Workspace 解决方案
## 前言
我一直都在思考 **neovim/vim** 相比 **vscode** 还有什么不足，因为我仍然觉得vscode有一些feature比较吸引我，其中有一个就是workspace的记录。
可以恢复之前打开的文件，这是很有必要的功能。

## Nvim Session
**Nvim Session** 就是neovim的解决方案，可以记录这个working directory下的所有打开buffer。

由于原生的可能比较难用，所以我还是安装了一个插件来简化Session的管理。
```vim
Plug 'Shatur/neovim-session-manager'
```
由于这些插件一般都有自动保存功能，保证working directory不变，不然会保存很多你不想保存的Session。

```vim
" 记得注释这行
set autochdir
```

一般来说，切换Session的同时也会把workding directory切换，所以不用手动切换。
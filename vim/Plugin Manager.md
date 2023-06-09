在安装具体的插件之前，我们需要先安装一个插件管理器。
这里推荐更为`vim-plug`，至于`bundle`等之类的旧时代产物已经没有必要使用了。
参考[官方README](https://github.com/junegunn/vim-plug)。

## Windows(Powershell)
```powershell
iwr -useb [https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

## Unix/Linux(zsh/bash/...)
```shell
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       [https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
```

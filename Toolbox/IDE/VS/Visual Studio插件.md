## VsVim
可以读取vimrc文件，读取路径默认为：
```
~; ~/vimfiles
```
配置一般就是一个editor的设置（比如`set number`）以及keymap。
```cmake
set foldenable
set backspace=indent,eol,start
" set background=dark
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set autochdir

set number
set relativenumber
"set autoindent
set smartindent
set cursorline
set ruler
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

:command AddMudoleComment :normal i
      \/*--------------------------------------------------*/<CR>
      \/*                                                  */<CR>
      \/*--------------------------------------------------*/<CR>
      \<ESC>

:command IncToday :r! date "+\%Y-\%m-\%d"

set mapleader = " "
nnoremap <cr> o<ESC>
" inoremap {<cr> {<cr>}<ESC>O

nnoremap <m-s> i<space><esc>

" noremap : no recursion
" normal no recursion remap
nnoremap <silent> <C-l> :<C-u>nohlsearch<cr><C-l>
nnoremap k gkzz
nnoremap gk kzz
nnoremap j gjzz
nnoremap gj jzz

" only use hjkl
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" buffer
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> ]B :blast<cr>

"hi comment ctermfg = 2

" set background(or frontground)
" @see :h cterma
" also /usr/share/vim/vim81/colors/*.vim, there are some colorscheme
" https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
" hi Normal ctermfg = 252 ctermbg = none
" 252 gray(other gray also exist)
" hi Normal			ctermfg=252 ctermbg=black
"hi IncSearch		ctermfg=gray ctermbg=lightblue
" argdo no <more> hint
set nomore

set smartcase

" prime
noremap <Leader>Y "*y
noremap <Leader>P "*p
" clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
```

### 将状态栏信息显示到VS状态栏而不是新建立个编辑区状态栏
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676425112170-d5115dea-42d1-4e2b-9f51-03d019d1708c.png#averageHue=%23efeeec&clientId=ucf0522e7-d968-4&from=paste&height=493&id=u2ced62be&name=image.png&originHeight=493&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50271&status=done&style=none&taskId=ua6a3aff7-6a76-448a-b152-b12f4d6bfe9&title=&width=746)
### 如何设置`Ctrl+[`为ESC
解除所有与`Ctrl+[`关联的key binding。
中文版的检索有限，需要下载英文包，将中文这边无法搜索到的按键解绑：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676009370395-c9cec899-762b-4676-a940-c1e43bcd9dc9.png#averageHue=%23d9ba7d&clientId=ua2760be1-1647-4&from=paste&height=173&id=ub63c2030&name=image.png&originHeight=173&originWidth=475&originalType=binary&ratio=1&rotation=0&showTitle=false&size=11219&status=done&style=none&taskId=ua0f66db3-5ac9-41e0-be04-59a99ca0b44&title=&width=475)
如果要改回来的话，不再是“区域设置”：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676009502318-6c435de1-a151-4fd0-95a4-4ceff68467a5.png#averageHue=%23efefee&clientId=ua2760be1-1647-4&from=paste&height=483&id=u531f0192&name=image.png&originHeight=483&originWidth=741&originalType=binary&ratio=1&rotation=0&showTitle=false&size=21833&status=done&style=none&taskId=u1c3e39ba-6141-4046-8dfc-8114341dfa6&title=&width=741)

## Visual Assist
### Smart selection
有两种模式：块选择和通常选择。
主要是便于一段代码块的选择（如果是依赖keyboard，用vim的文本对象亦可）

由于缩放字体一般是不用的，这里覆盖映射。
`Ctrl(+Shift)+Mouse wheel`就可以进行智能选择。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676174559661-ce00aeb0-f684-4264-ad33-dfb4a7ecb21e.png#averageHue=%23eeeceb&clientId=u9f606933-28ce-4&from=paste&height=596&id=u15048665&name=image.png&originHeight=894&originWidth=1134&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=67584&status=done&style=none&taskId=ue251f6aa-a6a5-40a5-9c53-f1ba8779d04&title=&width=756)

## Output Enhancer

## GitHub Extension for Visual Studio

## Markdown Editor

## Clang-format
clang-format在VS2019/2022是内置的，只需要设置好就可以使用。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676268527572-bf7ba30c-dc13-4b28-98fa-e853179e0967.png#averageHue=%23f3f2f2&clientId=u5636d59d-35e1-4&from=paste&height=483&id=uf6104ced&name=image.png&originHeight=483&originWidth=747&originalType=binary&ratio=1&rotation=0&showTitle=false&size=41225&status=done&style=none&taskId=u61d35691-64bf-4f22-a64f-827b7e03af0&title=&width=747)

## Color Theme
### Gruvbox
在其他editor也很喜欢的一款暖色调colorscheme

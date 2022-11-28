# 插件
## gutentags_plus
韦易笑推荐的一个插件（也是他自己整合的）。
```vim
Plug 'skywind3000/gutentags_plus'
Plug 'ludovicchabant/vim-gutentags' " 必须一起装上，本质上来说服务是由它提供的
```
除此之外，我的`.vimrc`应该用的是`gtags`，gtags比`ctags`更好用，因此采用它是没大问题的。
可以去[gtags 官网](https://www.gnu.org/software/global/)下载

同时，这个也是和`vim-preview`搭配必需的一个插件。

> 以下复制于 https://github.com/skywind3000/gutentags_plus/blob/master/README.md
### Command

```VimL
:GscopeFind {querytype} {name}
```

Perform a cscope search and take care of database switching before searching. 

`{querytype}` corresponds to the actual cscope line interface numbers as well as default nvi commands:

```text
0 or s: Find this symbol
1 or g: Find this definition
2 or d: Find functions called by this function
3 or c: Find functions calling this function
4 or t: Find this text string
6 or e: Find this egrep pattern
7 or f: Find this file
8 or i: Find files #including this file
9 or a: Find places where this symbol is assigned a value
```

### Keymaps

| keymap | desc |
|--------|------|
| `<leader>cs` | Find symbol (reference) under cursor |
| `<leader>cg` | Find symbol definition under cursor |
| `<leader>cd` | Functions called by this function |
| `<leader>cc` | Functions calling this function |
| `<leader>ct` | Find text string under cursor |
| `<leader>ce` | Find egrep pattern under cursor |
| `<leader>cf` | Find file name under cursor |
| `<leader>ci` | Find files #including the file name under cursor |
| `<leader>ca` | Find places where current symbol is assigned |
| `<leader>cz` | Find current word in ctags database |

You can disable the default keymaps by:

```VimL
let g:gutentags_plus_nomap = 1
```

and define your new maps like:

```VimL
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>
```

### Troubleshooting

#### ERROR: gutentags: gtags-cscope job failed, returned: 1

step1: add the line below to your `.vimrc`:

    let g:gutentags_define_advanced_commands = 1

step2: restart vim and execute command:

    :GutentagsToggleTrace

step3: open some files and generate gtags again with current project:

    :GutentagsUpdate

step4: you may see a lot of gutentags logs, after that:

    :messages

To see the gtags log.

## nvim-tree
```vim
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
```
> NerdTree的替代物。

注意，README只说明要在`init.lua`下添加setup配置，但是我是采用`init.vim`加载配置，所以在vim脚本中按照如下语法添加Lua脚本：
```vim
lua << EOF
...
Lua scripts code
...
EOF
```

将如下配置放在`~/.vim/plugin/nvim_tree_lua.vim`下。
```vim
lua << EOF
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  open_on_setup_file = false,
  sort_by = "name",
  view = {
    adaptive_size = false,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF
```

## barbar
```vim
Plug 'romgrk/barbar.nvim'
```
管理Buffer的工具，每个Buffer会有一个可视化tab(不是tabpage)显示。

```vim
" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight
" Magic buffer-picking mode
" ie. Jump-to-buffer mode
nnoremap <silent> <C-j>    <Cmd>BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used
```

## vista
```vim
Plug 'liuchengxu/vista.vim'
```
> tagbar的替代物
遵循LSP的Symbol显示工具，包括class，functions，type alias等。


## indentLine
```vim
Plug 'Yggdroot/indentLine'
```
其实对于我来说不是很必要...

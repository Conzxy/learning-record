# 插件FAQ
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


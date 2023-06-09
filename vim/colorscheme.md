# ColorScheme
## Gruvbox
编辑`~/.vim/plugged/gruvbox/colors/gruvbox.vim`
```vim
""" Cursor Line无背景色(ie. 透明) """
" Screen line that the cursor is
" call s:HL('CursorLine',   s:none, s:bg1)
call s:HL('CursorLine',   s:none, s:none)

...

""" 行号前面一行的颜色设为透明 """
" let s:sign_column = s:bg1
let s:sign_column = s:none
```

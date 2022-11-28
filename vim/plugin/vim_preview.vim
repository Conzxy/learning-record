" vim-preview config
noremap <m-;> :PreviewTag<cr>
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
" <c-\><c-o> leave insert mode but also allow press command
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

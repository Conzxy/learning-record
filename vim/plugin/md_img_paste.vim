" md-img-paste.vim
" function! g:MyMarkdownPasteImage(relpath)
"     execute "normal! a<div align=\"center\"><img src=\"" . a:relpath . "\" alt=\"Image\" style=\"zoom:%;\" /><\/div>"
" endfunction

" autocmd FileType markdown let g:PasteImageFunction='g:MyMarkdownPasteImage'

let g:mdip_imgdir='pic' 
let g:mdip_imgname='image'
autocmd FileType markdown nnoremap <silent> <C-p> :call mdip#MarkdownClipboardImage()F%i<CR>


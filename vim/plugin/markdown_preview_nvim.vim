" markdown-preview-nvim config
" let g:mkdp_path_to_chrome="~/Downloads/firefox/firefox"
" let g:mkdp_path_to_chrome="/usr/bin/microsoft-edge-stable --inprivate"
" let g:mkdp_path_to_chrome="konqueror"
let g:mkdp_browser="/usr/bin/google-chrome-stable"
let g:mkdp_theme="light"

nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

let g:mkdp_markdown_css='Github'
nnoremap <m-p> :MarkdownPreview<CR>

" todo.txt-vim config
au filetype todo setlocal omnifunc=todo#Complete
au filetype todo imap <buffer> + +<C-X><C-O>
au filetype todo imap <buffer> @ @<C-X><C-O>

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

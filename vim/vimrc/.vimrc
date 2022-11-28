if has("syntax")
  syntax on
endif

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

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

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

let mapleader = " "

call plug#begin('~/.vim/plugged')
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'skywind3000/vim-terminal-help'
Plug 'navarasu/onedark.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'ferrine/md-img-paste.vim'
Plug 'liuchengxu/vista.vim'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-endwise'
Plug 'rhysd/vim-clang-format'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'rakr/vim-one'
Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/indentLine'
Plug 'skywind3000/vim-preview'
Plug 'tpope/vim-fugitive'
Plug 'kien/rainbow_parentheses.vim'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-easy-align'
Plug 'skywind3000/gutentags_plus'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
" Plug 'majutsushi/tagbar'
Plug 'Mofiqul/vscode.nvim'
call plug#end()

set nocompatible
filetype off
filetype plugin indent on
" filetype plugin on

" set cscopetag
set cscopeprg=/usr/local/bin/gtags-cscope

" make alt as meta key
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)

if (empty($TMUX))
  if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 <
      "https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
      endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 <
"https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
">
"  "Based on Vim patch 7.4.1770 (`guicolors` option) <
"  https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
"  >
"    " <
"    https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
"    >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" edit indent/number/...
"


" vim-markdown config
" let g:markdown_fenced_languages = ['cpp', 'python', 'bash=sh']

" gutentags config(including gutentags_plus)
" see https://github.com/skywind3000/gutentags_plus
set tags=./.tags;,.tags

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

let g:gutentags_ctags_tagfile = 'tags'

let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif

if executable('gtags') && executable('gtags-cscope')
  let g:gutentags_modules += ['gtags_cscope']
endif

let g:gutentags_auto_add_gtags_cscope = 0

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
  "silent! call mkdir(s:vim_tags, 'p')
endif

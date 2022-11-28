let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-b>'
noremap <leader>fr :Leaderf file --regex<cr>
noremap <leader>fn :Leaderf file --nameOnly<cr>
noremap <m-m> :Leaderf mru<cr>
noremap <m-l> :Leaderf loclist<cr>
noremap <m-s> :Leaderf searchHistory<cr>
noremap <m-c> :Leaderf command<cr>
noremap <m-f> :Leaderf function<cr>
noremap <m-t> :Leaderf tag<cr>
noremap <leader>ch :Leaderf cmdHistory<cr>
noremap <leader>bt :Leaderf bufTag<cr>
noremap <leader>rc :Leaderf rg --current-buffer<cr>
noremap <leader>ra :Leaderf rg --all-buffer<cr>

let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}


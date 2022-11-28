" AsyncTask config
" AsyncRun config
let g:asyncrun_open = 10
"let g:asyncrun_bell = 1
noremap <F10> :call asyncrun#quickfix_toggle(10)<cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', 'build.xml']
let g:asynctasks_term_pos = 'bottom'
"nnoremap <silent><F9> :AsyncRun g++ "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -Wall -g<cr>
"noremap <silent><F5> :AsyncRun -mode=term -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<cr>
noremap <silent><F7> :AsyncTask file-build<cr>
noremap <silent><F5> :AsyncTask file-run<cr>
"noremap <silent><F6> :AsyncRun! -mode=term -cwd=<root>/build/ <root>/build/$(VIM_FILENOEXT)<cr>
"noremap <silent><F8> :AsyncRun -cwd=<root>/build cmake .. && make<cr>
" noremap <silent><F8> :AsyncTask project-cmake<cr>
"noremap <silent><F9> :AsyncTask project-build<cr>
" noremap <silent><F6> :AsyncTask project-run<cr>
" noremap <silent><F9> :AsyncTask target-build<cr>
noremap <m-a> :Leaderf --nowrap task<cr>

" make LeaderF be interativc with AsyncTask
function! s:lf_task_source(...)
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	return source
endfunction

function! s:lf_task_accept(line, arg)
	let pos = stridx(a:line, '<')
	if pos < 0
		return
	endif
	let name = strpart(a:line, 0, pos)
	let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
	if name != ''
		exec "AsyncTask " . name
	endif
endfunction

function! s:lf_task_digest(line, mode)
	let pos = stridx(a:line, '<')
	if pos < 0
		return [a:line, 0]
	endif
	let name = strpart(a:line, 0, pos)
	return [name, 0]
endfunction

function! s:lf_win_init(...)
	setlocal nonumber
	setlocal nowrap
endfunction


let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
let g:Lf_Extensions.task = {
			\ 'source': string(function('s:lf_task_source'))[10:-3],
			\ 'accept': string(function('s:lf_task_accept'))[10:-3],
			\ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
			\ 'highlights_def': {
			\     'Lf_hl_funcScope': '^\S\+',
			\     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
			\ },
			\ 'help' : 'navigate available tasks from asynctasks.vim',
		\ }

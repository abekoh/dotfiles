set tabstop=4
set noexpandtab
set shiftwidth=4
" set listchars=tab:\ \ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" nmap <Leader>r <Plug>(go-run)
" nmap <Leader>tt <Plug>(go-test)
" nmap <Leader>tf <Plug>(go-test-func)
" nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>
" nmap <Leader>c <Plug>(go-coverage-toggle)
" nmap <Leader>a <Plug>(go-alternate-edit)
" nmap <Leader>A <Plug>(go-alternate-vertical)
" nmap <Leader>dd <Plug>(go-def)
" nmap <Leader>dp <Plug>(go-def-pop)
" nmap <Leader>n <Plug>(go-rename)
"   
" " run :GoBuild or :GoTestCompile based on the go file
" function! s:build_go_files()
"   let l:file = expand('%')
"   if l:file =~# '^\f\+_test\.go$'
"     call go#test#Test(0, 1)
"   elseif l:file =~# '^\f\+\.go$'
"     call go#cmd#Build(0)
"   endif
" endfunction

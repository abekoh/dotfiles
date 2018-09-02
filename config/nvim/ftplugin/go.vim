set tabstop=4
set noexpandtab
set shiftwidth=4
nmap <Leader>r <Plug>(go-run)
nmap <Leader>t <Plug>(go-test)
nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>
nmap <Leader>c <Plug>(go-coverage-toggle)
nmap <Leader>c <Plug>(go-coverage-toggle)
nmap <Leader>a <Plug>(go-alternate-edit)
nmap <Leader>A <Plug>(go-alternate-vertical)
nmap <Leader>d <Plug>(go-def)
  
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

if exists(':T') == 2
  nnoremap <silent> <Leader>r :call<Space>QuickRun('go run')<CR>
  nnoremap <silent> <Leader>R :call<Space>QuickRunWithArgs('go run')<CR>
endif

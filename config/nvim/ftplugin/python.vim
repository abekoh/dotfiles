set tabstop=4
set softtabstop=0
set shiftwidth=4
if exists(':T') == 2
  nnoremap <silent> <Leader>r :call<Space>QuickRun('python')<CR>
  nnoremap <silent> <Leader>R :call<Space>QuickRunWithArgs('python')<CR>
endif

set tabstop=4
set softtabstop=0
set shiftwidth=4
nnoremap <Leader>r :T<Space>python<Space>%<CR><C-w>j:call MoveToNewTeminal()<CR>
nnoremap <Leader>R :call<Space>RunWithArgs()<CR>

function! RunWithArgs()
  let l:args = input("$ python ")
  execute "T python % " . l:args
  normal <C-w>j
  call MoveToNewTeminal()
endfunction

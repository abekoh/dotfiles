"command! -nargs=+ Help :execute "tab help <args>"
"autocmd MyAutoCmd help nnoremap <buffer> q <C-w>c
"autocmd MyAutoCmd help nnoremap <buffer> t :call<Space>MoveToNewTab<CR>
function! MoveToNewTab()
  tab split
  tabprevious
  if winnr('$') > 1
    close
  elseif bufnr('$') > 1
    buffer #
  endif
  tabnext
endfunction

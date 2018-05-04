function! MoveToNewTab()
  if winnr('$') > 1
    tab split
    tabprevious
    close
    tabnext
  endif
endfunction

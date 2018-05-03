function! MoveToNewTab()
  if winnr('$') > 1
    tab split
    tabprevious
    close
    tabnext
  endif
endfunction

function! MoveToNewTeminal()
  if exists("s:neoterm_buffer_id") && bufexists(s:neoterm_buffer_id)
    tab split
    execute "buffer " . s:neoterm_buffer_id
  elseif winnr('$') > 1
    execute "normal \<C-w>j"
    call MoveToNewTab()
    let s:neoterm_buffer_id = bufnr('$')
  endif
endfunction

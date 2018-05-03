function! MoveToNewTab()
  if winnr('$') > 1
    tab split
    tabprevious
    close
    tabnext
  endif
endfunction

function! MoveToNewTeminal()
  if exists("s:neoterm_buffer_id") && bufloaded(s:neoterm_buffer_id)
    let s:neoterm_win_ids = win_findbuf(s:neoterm_buffer_id)
    if empty(s:neoterm_win_ids)
      tab split
      execute "buffer " . s:neoterm_buffer_id
    else
      call win_gotoid(s:neoterm_win_ids[0])
    endif
  elseif winnr('$') > 1
    execute "normal \<C-w>j"
    call MoveToNewTab()
    let s:neoterm_buffer_id = bufnr('$')
  endif
endfunction

function! QuickRun(cmd)
  execute "T " . a:cmd . " %"
  normal <C-w>j
  call MoveToNewTeminal()
endfunction

function! QuickRunWithArgs(cmd)
  let l:args = input("$ " . a:cmd . " ")
  execute "T " . a:cmd . " % " . l:args
  normal <C-w>j
  call MoveToNewTeminal()
endfunction

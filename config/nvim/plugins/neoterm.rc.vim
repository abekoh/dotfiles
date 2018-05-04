let g:neoterm_default_mod = 'tab'

function! MoveToNeoTerm()
  if exists("s:neoterm_buffer_id") && bufloaded(s:neoterm_buffer_id)
    let s:neoterm_win_ids = win_findbuf(s:neoterm_buffer_id)
    if empty(s:neoterm_win_ids)
      tabedit
      execute "buffer " . s:neoterm_buffer_id
      echo "hey"
    else
      call win_gotoid(s:neoterm_win_ids[0])
    endif
  else
    tabnext
    let s:neoterm_buffer_id = bufnr('$')
  endif
endfunction

function! QuickRun(cmd)
  execute "tab T " . a:cmd . " %"
  call MoveToNeoTerm()
endfunction

function! QuickRunWithArgs(cmd)
  let l:args = input("$ " . a:cmd . " ")
  execute "tab T " . a:cmd . " % " . l:args
  call MoveToNeoTerm()
endfunction

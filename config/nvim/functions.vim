function! MoveToNewTab()
  if winnr('$') > 1
    tab split
    tabprevious
    close
    tabnext
  endif
endfunction

if has('vim_starting')
  function ReloadSettings() abort
    execute printf('source %s', $MYVIMRC)
    redraw
    echo printf('init.vim has reloaded (%s).', strftime('%c'))
  endfunction
endif

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

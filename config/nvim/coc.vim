let g:coc_global_extensions = [
  \'coc-lists',
  \'coc-pyright',
  \'coc-go',
  \'coc-rls',
  \'coc-solargraph',
  \'coc-tsserver',
  \'coc-sh',
  \'coc-sql',
  \'coc-eslint',
  \'coc-prettier',
  \'coc-vimlsp',
  \'coc-snippets',
  \'coc-html',
  \'coc-yaml',
  \'coc-toml',
  \'coc-xml',
  \'coc-css',
  \'coc-json',
  \'coc-word',
  \'coc-emoji',
  \'coc-git',
  \'coc-highlight'
\]
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" navigate completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
" Close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" confirm complete (select the first completion item and confirm completion when no item have selected)
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> <Leader>c :CocList<Space>commands<CR>
nmap <silent> <Leader>s :CocList<Space>words<CR>
nmap <silent> <Leader>f :CocList<Space>files<CR>
nmap <silent> <Leader>m :CocList<Space>mru<CR>
nmap <silent> <Leader>g :CocList<Space>grep<CR>
nmap <silent> <Leader>b :CocList<Space>buffers<CR>
nmap <silent> <Leader>e :CocList diagnostics<CR>
nmap <silent> <Leader>F <Plug>(coc-format)
vmap <silent> <Leader>F <Plug>(coc-format-selected)
xmap <silent> <Leader>F <Plug>(coc-format-selected)
nmap <silent> <Leader>R <Plug>(coc-rename)
nmap <silent> <Leader>A <Plug>(coc-codeaction)
vmap <silent> <Leader>A <Plug>(coc-codeaction-selected)
xmap <silent> <Leader>A <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>] <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>d <Plug>(coc-definition)
nmap <silent> <Leader>y <Plug>(coc-type-definition)
nmap <silent> <Leader>p <Plug>(coc-implementation)
nmap <silent> <Leader>r <Plug>(coc-references)
nmap <silent> <Leader>q <Plug>(coc-fix-current)
nnoremap <silent> <Leader>k :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
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
  \'coc-fzf-preview',
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
nmap <silent> <Leader>l :CocCommand<Space>fzf-preview.Lines<CR>
nmap <silent> <Leader>f :CocCommand<Space>fzf-preview.ProjectFiles<CR>
nmap <silent> <Leader>m :CocCommand<Space>fzf-preview.ProjectMruFiles<CR>
nmap <Leader>g :CocCommand<Space>fzf-preview.ProjectGrep<Space>
nmap <silent> <Leader>F <Plug>(coc-format)
vmap <silent> <Leader>F <Plug>(coc-format-selected)
xmap <silent> <Leader>F <Plug>(coc-format-selected)
nmap <silent> <Leader>R <Plug>(coc-rename)
nmap <silent> <Leader>a <Plug>(coc-codeaction)
vmap <silent> <Leader>a <Plug>(coc-codeaction-selected)
xmap <silent> <Leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>] <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>b :CocCommand<Space>fzf-preview.Buffers<CR>
nmap <silent> <Leader>B :CocCommand<Space>fzf-preview.AllBuffers<CR>
nmap <silent> <Leader>r :CocCommand<Space>fzf-preview.CocReferences<CR>
nmap <silent> <Leader>d :CocCommand<Space>fzf-preview.CocDefinition<CR>
nmap <silent> <Leader>D :CocCommand<Space>fzf-preview.CocTypeDefinition<CR>
nmap <silent> <Leader>e :CocCommand<Space>fzf-preview.CurrentCocDiagnostics<CR>
nmap <silent> <Leader>E :CocCommand<Space>fzf-preview.CocDiagnostics<CR>
nmap <silent> <Leader>I :CocCommand<Space>fzf-preview.CocImplementations<CR>
nmap <silent> <Leader>q <Plug>(coc-fix-current)
nmap <silent> <Leader>s :CocCommand fzf-preview.GitStatus<CR>
nmap <silent> <Leader>k :CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> <Leader>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

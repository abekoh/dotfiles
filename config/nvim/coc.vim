let g:coc_global_extensions = [
  \'coc-lists',
  \'coc-pyright',
  \'coc-go',
  \'coc-rust-analyzer',
  \'coc-solargraph',
  \'coc-tsserver',
  \'coc-jest',
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
  \'coc-highlight',
  \'coc-prisma',
  \'coc-clangd',
  \'coc-deno',
  \'@yaegassy/coc-astro'
\]
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <Down> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
inoremap <silent><expr> <Up> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> <Leader>c :CocList<Space>commands<CR>
nmap <silent> <Leader>l :CocCommand<Space>fzf-preview.Lines<CR>
nmap <silent> <Leader>f :CocCommand<Space>fzf-preview.ProjectFiles<CR>
nmap <silent> <Leader>C :CocCommand<Space>fzf-preview.DirectoryFiles<CR>
nmap <silent> <Leader>m :CocCommand<Space>fzf-preview.ProjectMruFiles<CR>
nmap          <Leader>g :CocCommand<Space>fzf-preview.ProjectGrep<Space>
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
nmap <silent> <Leader>u :CocCommand<Space>fzf-preview.CocReferences<CR>
nmap <silent> <Leader>d :CocCommand<Space>fzf-preview.CocDefinition<CR>
nmap <silent> <Leader>D :CocCommand<Space>fzf-preview.CocTypeDefinition<CR>
nmap <silent> <Leader>e :CocCommand<Space>fzf-preview.CocCurrentDiagnostics<CR>
nmap <silent> <Leader>E :CocCommand<Space>fzf-preview.CocDiagnostics<CR>
nmap <silent> <Leader>I :CocCommand<Space>fzf-preview.CocImplementations<CR>
nmap <silent> <Leader>q <Plug>(coc-fix-current)
nmap <silent> <Leader>s :CocCommand fzf-preview.GitStatus<CR>
nmap <silent> <Leader>k :CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <Leader>t :CocCommand<Space>jest.singleTest<CR>
autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <Leader>T :CocCommand<Space>jest.fileTest %<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

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
  \'coc-graphql'
\]
" " use <tab> for trigger completion and navigate to the next complete item
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" inoremap <silent><expr> <TAB>
"   \ coc#pum#visible() ? coc#_select_confirm() :
"   \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? "\<C-p>" : "\<C-h>"
" " navigate completion list
" inoremap <expr> <C-j> coc#pum#visible() ? "\<C-n>" : "\<C-j>"
" inoremap <expr> <C-k> coc#pum#visible() ? "\<C-p>" : "\<C-k>"
" inoremap <expr> <Down> coc#pum#visible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up> coc#pum#visible() ? "\<C-p>" : "\<Up>"
" nnoremap <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" " Close preview window when completion is done
" autocmd! CompleteDone * if coc#pum#visible() == 0 | pclose | endif
" " confirm complete (select the first completion item and confirm completion when no item have selected)
" inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : 
"                                            \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

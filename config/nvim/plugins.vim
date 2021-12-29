call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" UI
Plug 'jacoborus/tender.vim'

Plug 'itchyny/lightline.vim'
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
let g:lightline = {
  \ 'colorscheme': 'tender',
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction',
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_default_mapping = 0

" Plug 'ryanoasis/vim-devicons'

Plug 'tomtom/tcomment_vim'
let g:tcomment_maps = 0
nmap <silent> <Leader>i :TComment<CR>
vmap <silent> <Leader>i :TComment<CR>

Plug 'cohama/lexima.vim'

Plug 'AndrewRadev/splitjoin.vim'
nmap <silent> <Leader>j :SplitjoinJoin<CR>
nmap <silent> <Leader>s :SplitjoinSplit<CR>

Plug 't9md/vim-quickhl'
nmap <Leader>h <Plug>(quickhl-manual-this)
nmap <Leader>H <Plug>(quickhl-manual-reset)

Plug 'tpope/vim-surround'

Plug 'kana/vim-textobj-user'

Plug 'kana/vim-operator-user'

Plug 'kana/vim-textobj-function'

Plug 'tpope/vim-speeddating'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" configs are in 'coc.vim'

call plug#end()

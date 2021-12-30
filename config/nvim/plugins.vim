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
  \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction',
  \   'gitbranch': 'fugitive#head',
  \   'blame': 'LightlineGitBlame'
  \ },
  \ }

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_default_mapping = 0

Plug 'lambdalisue/nerdfont.vim'

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
"
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'lambdalisue/fern.vim'
nmap <silent> <Leader>n :Fern . -drawer -reveal=% -stay -keep<CR>
function! s:init_fern() abort
  echo "This function is called ON a fern buffer WHEN initialized"
  nmap <buffer> s <Nop>
endfunction
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

Plug 'lambdalisue/fern-git-status.vim'

Plug 'lambdalisue/fern-renderer-nerdfont.vim'
let g:fern#renderer = "nerdfont"

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

Plug 'tyru/open-browser.vim'

Plug 'tyru/open-browser-github.vim'

Plug 'abekoh/snipslack.vim'
let g:snipslack_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

Plug 'tpope/vim-repeat'

Plug 'previm/previm', { 'for': 'markdown' }

Plug 'bps/vim-textobj-python', { 'for': 'python' }

call plug#end()

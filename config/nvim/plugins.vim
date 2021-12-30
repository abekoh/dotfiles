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

Plug 'lambdalisue/gina.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" configs are in 'coc.vim'
"
Plug 'antoinemadec/FixCursorHold.nvim'


Plug 'lambdalisue/fern.vim'
nmap <silent> <Leader>n :Fern . -drawer -reveal=% -stay -keep -toggle<CR>
function! s:init_fern() abort
  nmap <silent> <buffer> s <Nop>
  nmap <silent> <buffer> t <Plug>(fern-action-open:tabedit)
  " preview
  nmap <silent> <buffer> p <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

Plug 'lambdalisue/fern-git-status.vim'

Plug 'lambdalisue/fern-renderer-nerdfont.vim'
let g:fern#renderer = "nerdfont"

Plug 'yuki-yano/fern-preview.vim'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
autocmd BufWritePost * GitGutter

Plug 'tyru/open-browser.vim'

Plug 'tyru/open-browser-github.vim'

Plug 'abekoh/snipslack.vim'
let g:snipslack_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

Plug 'tpope/vim-repeat'

Plug 'previm/previm', { 'for': 'markdown' }

Plug 'bps/vim-textobj-python', { 'for': 'python' }

call plug#end()

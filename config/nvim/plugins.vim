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
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ]
  \   ]
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

Plug 'simeji/winresizer'

Plug 'lambdalisue/gina.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" configs are in 'coc.vim'
"
Plug 'antoinemadec/FixCursorHold.nvim'


Plug 'lambdalisue/fern.vim'
let g:fern#default_hidden=1
nmap <silent> <Leader>n :Fern . -drawer -reveal=% -stay -toggle<CR>
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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
autocmd BufWritePost * GitGutter

" Plug 'thinca/vim-quickrun'
" let g:quickrun_config = {}
" let g:quickrun_config._ = {}
" let g:quickrun_config.rust = {'exec' : 'cargo run'}
"
" Plug 'lambdalisue/vim-quickrun-neovim-job'
" let g:quickrun_config._.runner = 'neovim_job'
" nnoremap <silent> <Leader>r :QuickRun<CR>

Plug 'tyru/open-browser.vim'

Plug 'tyru/open-browser-github.vim'

Plug 'abekoh/snipslack.vim'
let g:snipslack_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

Plug 'tpope/vim-repeat'

Plug 'previm/previm', { 'for': 'markdown' }

Plug 'bps/vim-textobj-python', { 'for': 'python' }

Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }

Plug 'bfontaine/Brewfile.vim'

Plug 'vim-test/vim-test'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>
let g:test#strategy = "neovim"
let g:test#preserve_screen = 1
let test#neovim#term_position = "botright 20"

Plug 'zchee/vim-flatbuffers'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
let g:vim_markdown_folding_disabled = 1

call plug#end()

" treesitte
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "rust", "go", "python", "rust", "haskell", "rust", "java", "go", "gomod", "javascript", "typescript", "yaml", "json", "markdown", "make" , "html", "bash" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
}
EOF

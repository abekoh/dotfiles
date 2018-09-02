" encode
set fileencodings=utf-8,euc-jp,ucs-bom,iso-2022-jp,sjis,cp932,latin1
" Tabの設定
set tabstop=4
set softtabstop=0
set shiftwidth=4
set autoindent
set smartindent
" expandtabでスペースに
set expandtab
" 行の最後まで表示
set display=lastline
" 補間メニューの数
" set pumheight=10
" 行番号
set number
" 不可視文字を表示,設定
set list
set listchars=tab:\ \ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" 行を強調
set cursorline
" 右下に表示される行・列の番号
set ruler
" 対応するカッコの表示
set showmatch
set matchtime=1
" 対応付けるカッコの種類を追加
set matchpairs& matchpairs+=<:>
" スクロール時，下が見えるように
set scrolloff=5
" .swapファイルやバックアップを作らない
set noswapfile
set nowritebackup
set nobackup
" バックスペースで各種消せるように
set backspace=indent,eol,start
" マウスモード有効
set mouse=a
" コマンドを画面最下部に表示
" set showcmd
" モード表示をオフに
set noshowmode
" コマンドラインに使われる画面上の行数
" set cmdheight=1
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" ウィンドウタイトルにファイルパス
set title
" 検索結果をハイライト
set hlsearch
" 検索ワードの途中でも検索
set incsearch
" 検索時大小区別なし
set ignorecase
" タイトルなし
set notitle
" 下に分割
set splitbelow
" highlighting zenkaku space
autocmd MyAutoCmd BufRead,BufNew * match Error /　/
" アンダーラインをオフに
highlight CursorLine cterm=NONE
if has('nvim')
  set clipboard+=unnamedplus
else
  set clipboard=unnamed,autoselect
endif
" :terminalでのgit commitのエディタを内部で
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif
" color
if !has('nvim')
  set t_Co=256
endif
map <Space> <Leader>
" Previewをオフに
set completeopt-=preview
" build後に自動保存
set autowrite

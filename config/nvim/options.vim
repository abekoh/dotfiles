" 行番号表示
set number
" Vim内部で使われる文字エンコーディング
set encoding=utf-8
" ファイル読み込み時、左から順に試す
set fileencodings=utf-8,euc-jp,ucs-bom,iso-2022-jp,sjis,cp932,latin1
" tab入力時、空白が入力される
set expandtab
" 画面上でタブが占める幅
set tabstop=4
" 連続した空白に対しtab/backspaceでカーソルが動く幅
set softtabstop=0
" 自動インデントでずれる幅
set shiftwidth=4
" 改行時、前のインデントを継続
set autoindent
" 改行時、入力された行の末尾に合わせて次の行のインデントを増幅
set smartindent
" 右下に行・列の番号を表示
set ruler
" 対応するカッコの表示
set showmatch
" 対応するカッコが表示されるまでの秒数
set matchtime=1
" 対応付けるカッコの種類を追加
set matchpairs& matchpairs+=<:>,【:】,（:）,「:」
" スクロール時、下に余白をもたせる
set scrolloff=5
" .swapつくらない
set noswapfile
" ファイル上書き前にバックアップつくらない
set nobackup
" ファイル上書き前にバックアップファイルつくらない
set nowritebackup
" backspaceで消せる項目追加
set backspace=indent,eol,start
" マウスをすべてのモードで有効に
set mouse=a
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" モード表示をオフに
set noshowmode
" 検索結果をハイライト
set hlsearch
" 検索結果をハイライト
set hlsearch
" 検索ワードの途中でも検索
set incsearch
" 検索時大小区別なし
set ignorecase
" クリップボードとヤンクを連携
set clipboard=unnamedplus
" 不可視文字を表示
set list
" 不可視文字の表示を設定
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" previewを下に表示
set splitbelow
" 行の強調表示
set cursorline
" vim-gitgutterのスペースを最初から開けとく
set signcolumn=yes
" 保存しなくても別バッファにいける
set hidden
" CursorHold & CursorHoldIの時間
set updatetime=300
" 0.4.0以降の場合
if has('nvim-0.4.0')
  " ポップアップを半透明に
  set pumblend=20
  " コマンドライン保管をポップアップに
  set wildoptions=pum
endif

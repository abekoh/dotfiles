" vを二回で行末まで選択
vnoremap v $h
" Y -> 行末までヤンク
nnoremap Y y$
" Dでヤンクしない
nnoremap D "_D
" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
" s+hjklで移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sx <C-w>x
" Shift + 矢印でウィンドウサイズを変更
nnoremap s<S-H> <C-w>5<<CR>
nnoremap s<S-L> <C-w>5><CR>
nnoremap s<S-K> <C-w>5-<CR>
nnoremap s<S-J> <C-w>5+<CR>
" 分割
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
"インサートモードでも移動
inoremap <C-d> <DELETE>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-h> <LEFT>
inoremap <C-l> <RIGHT>
" タブ関連
nnoremap st :tabnew<CR>
nnoremap sn gt
nnoremap sp gT
" 終了
nnoremap sq :q<CR>
" ESC in terminal mode
tnoremap <silent> <ESC> <C-\><C-n>
" Leader = Space
map <Space> <Leader>
" コマンドモードでctrl+kjで履歴
cnoremap <C-k> <UP>
cnoremap <C-j> <DOWN>
" 分割ウィンドウを新しいタブに移動
noremap <silent> T :call<Space>MoveToNewTab()<CR>
noremap <silent> <Leader>l :call<Space>ReloadSettings()<CR>
" 直近のヤンクしたものをペースト
nnoremap tp "0p
nnoremap tP "0P
vnoremap tp "0p
vnoremap tP "0P
" ファイルリロード
nnoremap <silent> <Leader>E :e!<CR>

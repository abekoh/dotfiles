" Y -> 行末までヤンク
nnoremap Y y$
" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
" vを二回で行末まで選択
vnoremap v $h
" Dでヤンクしない
nnoremap D "_D
" s+hjklで移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sx <C-w>x
" Shift + 矢印でウィンドウサイズを変更
nnoremap s<S-H> <C-w><<CR>
nnoremap s<S-L> <C-w>><CR>
nnoremap s<S-K> <C-w>-<CR>
nnoremap s<S-J> <C-w>+<CR>
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
" 記録機能を無効化
nnoremap q <nop>
" ctags検索
nnoremap <Leader>t :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
" ESC in terminal mode
tnoremap <silent> <ESC> <C-\><C-n>
" Leader = Space
map <Space> <Leader>
" コマンドモードでctrl+kjで履歴
cnoremap <C-k> <up>
cnoremap <C-j> <down>
" 分割ウィンドウを新しいタブに移動
nnoremap <silent> sT :call<Space>MoveToNewTab()<CR>

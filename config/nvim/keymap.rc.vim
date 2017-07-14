" Y -> 行末までヤンク
nnoremap Y y$
" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
" vを二回で行末まで選択
vnoremap v $h
" Dでヤンクしない
nnoremap D "_D
" 検索結果をESC2回で解除
" nnoremap <silent><ESC><ESC> :noh<CR>
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
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
" タブ関連
nnoremap st :tabnew<CR>
nnoremap sn gt
nnoremap sp gT
" 終了
nnoremap sq :q<CR>
" 記録機能を無効化
nnoremap q <nop>
" Leader = Space
" nmap <Space> <Leader>
" ctags検索
nnoremap <Leader>t :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
if has('nvim')
    tnoremap <silent> <ESC> <C-\><C-n>
endif

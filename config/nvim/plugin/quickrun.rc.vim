let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'buffer',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
" ESC2回でquickfix閉じる
autocmd MyAutoCmd FileType qf nnoremap <silent><buffer><ESC><ESC> :quit<CR>
autocmd MyAutoCmd FileType quickrun nnoremap <silent><buffer><ESC><ESC> :quit<CR>
" quickfix閉じて，保存して実行
let g:quickrun_no_default_key_mappings = 1
nnoremap <Leader>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap <Leader>r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
" <C-c>で停止
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

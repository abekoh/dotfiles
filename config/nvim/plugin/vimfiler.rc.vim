nnoremap <leader>e :VimFilerExplore -split -winwidth=30 -find -no-quit -buffer-name=vimfiler<CR>
au FileType vimfiler nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" ウィンドウを分割して開く
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-j> vimfiler#do_switch_action('split')
" ウィンドウを縦に分割して開く
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-l> vimfiler#do_switch_action('vsplit')
" 新しいタブで開く
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-t> vimfiler#do_switch_action('tabopen')

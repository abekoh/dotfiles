" open
nnoremap <Leader>e :VimFilerExplore -split -winwidth=30 -find -no-quit -buffer-name=vimfiler<CR>
" set as default filer
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1
" Open filer
au FileType vimfiler nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" ウィンドウを分割して開く
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-j> vimfiler#do_switch_action('split')
" ウィンドウを縦に分割して開く
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-l> vimfiler#do_switch_action('vsplit')
" 新しいタブで開く
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-t> vimfiler#do_switch_action('tabopen')

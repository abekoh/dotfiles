" keymap
nnoremap [denite] <Nop>
nmap <Leader>f [denite]
nnoremap <silent> [denite]f :Denite<Space>file_rec<CR>
nnoremap <silent> [denite]g :Denite<Space>grep<CR>
nnoremap <silent> [denite]h :Denite<Space>file_mru<CR>
nnoremap <silent> [denite]j :DeniteBufferDir<Space>file<CR>
nnoremap <silent> [denite]b :Denite<Space>buffer<CR>
nnoremap <silent> [denite]q :Denite<Space>help<CR>
nnoremap <silent> [denite]l :Denite<Space>line<CR>
nnoremap <silent> [denite]t :Denite<Space>tag<CR>
nnoremap <silent> [denite]u :Denite<Space>menu<CR>
nnoremap <silent> [denite]y :Denite<Space>neoyank<CR>

" replace grep into ripgrep
if executable('rg')
  call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg'])
endif

" change matcher
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm', 'matcher_ignore_globs'])

" customize ignore globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', 'build/', '__pycache__/',
      \ 'images/', '*.o', '*.make',
      \ '*.min.*',
      \ 'img/', 'fonts/'])

" denite/insert モードのときは，C- で移動できるようにする
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

" tabopen や vsplit のキーバインドを割り当て
call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "v", '<denite:do_action:vsplit>')

" show in top
"call denite#custom#option('default', 'direction', 'top')

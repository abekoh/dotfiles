let g:python3_host_prog = '~/.anyenv/envs/pyenv/shims/python3'

" for plugin development
set runtimepath+=~/dotfiles/nvim 

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

runtime! plugins.vim

" theme
set termguicolors
syntax enable
colorscheme tender
set guifont=Hack\ Nerd\ Font\ Mono:h11

runtime! coc.vim

runtime! functions.vim
runtime! options.vim
runtime! keymap.vim
runtime! secret.vim

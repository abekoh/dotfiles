#!/bin/bash
brew update
brew tap neovim/homebrew-neovim
brew install fish neovim python3 tmux reattach-to-user-namespace
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
pip2 install neovim
pip3 install neovim neovim-remote virtualfish
python3 make_links.py

#!/bin/bash
yes | sudo apt-add-repository ppa:fish-shell/release-2
yes | sudo apt-add-repository ppa:neovim-ppa/unstable
yes | sudo apt update
yes | sudo apt install fish mercurial software-properties-common neovim python-dev python-pip python3-dev python3-pip tmux
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
pip2 install neovim
pip3 install neovim neovim-remote virtualfish
python3 make_links.py

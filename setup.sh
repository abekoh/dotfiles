#!/bin/bash
if [ "$(uname)" == 'Darwin' ]; then
    brew update
    brew tap neovim/homebrew-neovim
    brew install fish neovim python3 tmux reattach-to-user-namespace
elif [ "$(uname)" == 'Linux' ] && [ -e /etc/lsb-release ]; then
    yes | sudo apt-add-repository ppa:fish-shell/release-2
    yes | sudo apt-add-repository ppa:neovim-ppa/unstable
    yes | sudo apt update
    yes | sudo apt install fish mercurial software-properties-common neovim python-dev python-pip python3-dev python3-pip tmux
else
    echo "Your platform is not supported."
    exit 1
fi
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
pip install --upgrade pip
pip3 install --upgrade pip
pip install neovim
pip3 install neovim neovim-remote virtualfish
python3 make_links.py

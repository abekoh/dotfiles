#!/bin/bash
# Mac
if [ "$(uname)" == 'Darwin' ]; then
    brew tap neovim/homebrew-neovim
    brew update
    brew install fish neovim python3 tmux reattach-to-user-namespace
    brew install vim --with-override-system-vi
# Ubuntu
elif [ "$(uname)" == 'Linux' ] && [ -e /etc/lsb-release ]; then
    sudo apt-add-repository -y ppa:fish-shell/release-2
    sudo apt-add-repository -y ppa:neovim-ppa/unstable
    sudo apt-add-repository -y ppa:jonathonf/vim
    sudo apt -y update
    sudo apt -y install fish mercurial software-properties-common vim neovim python-dev python-pip python3-dev python3-pip tmux
# CentOS (>=7)
elif [ "$(uname)" == 'Linux' ] && [ -e /etc/centos-release ] && [ "$(cat /etc/redhat-release | sed -e 's/.*\s\([0-9]\)\..*/\1/')" == '7']; then
    su -
    yum -y remove "vim*"
    yum install -y https://centos7.iuscommunity.org/ius-release.rpm
    yum -y install epel-release curl
    curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
    curl -o /etc/yum.repos.d/shells:fish:release:2.repo https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
    curl -o /etc/yum.repos.d/mcepl-vim8-epel-7.repo https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo
    yum -y install neovim fish vim-enhanced tmux python36u python36u-libs python36u-devel python36u-pip python2-pip
    exit
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

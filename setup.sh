#!/bin/bash
# Mac
if [ "$(uname)" == 'Darwin' ]; then
    brew tap neovim/homebrew-neovim
    brew update
    brew install fish neovim python3 tmux reattach-to-user-namespace ripgrep boost
    brew install vim --with-override-system-vi
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
# Ubuntu
elif [ "$(uname)" == 'Linux' ] && [ -e /etc/lsb-release ]; then
    sudo apt-add-repository -y ppa:fish-shell/release-2
    sudo apt-add-repository -y ppa:neovim-ppa/unstable
    sudo apt-add-repository -y ppa:jonathonf/vim
    sudo apt -y update
    sudo apt -y install fish mercurial software-properties-common vim neovim python-dev python-pip python3-dev python3-pip tmux curl libboost-all-dev ctags automake
    wget -O ~/ripgrep_0.8.1_amd64.deb https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
    sudo dpkg -i ~/ripgrep_0.8.1_amd64.deb
    rm -f ~/ripgrep_0.8.1_amd64.deb
    git clone https://github.com/unicersal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    sudo make install
    cd ../
    rm -rf ctags
# CentOS (>=7)
# TODO: ctags
elif [ "$(uname)" == 'Linux' ] && [ -e /etc/centos-release ] && [ "$(cat /etc/redhat-release | sed -e 's/.*\s\([0-9]\)\..*/\1/')" == '7' ]; then
    yum install -y https://centos7.iuscommunity.org/ius-release.rpm
    yum remove -y vim*
    yum install -y epel-release curl
    wget -O /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
    wget -O /etc/yum.repos.d/mcepl-vim8-epel-7.repo https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo
    wget -O /etc/yum.repos.d/shells:fish:release:2.repo https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
    wget -O /etc/yum.repos.d/carlwgeorge-ripgrep-epel-7.repo https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    yum install -y vim neovim fish tmux python36u python36u-libs python36u-devel python36u-pip python2-pip boost-devel ripgrep
    ln -sf /usr/bin/python3.6 /usr/bin/python3
    ln -sf /usr/bin/pip3.6 /usr/bin/pip3
else
    echo "Your platform is not supported."
    exit 1
fi
pip install --upgrade pip
pip3 install --upgrade pip
pip install neovim
pip3 install neovim neovim-remote virtualfish jedi pycodestyle
git config --global init.template '~/.git_template'
git config --global alias.ctags '!.git/hooks/ctags'

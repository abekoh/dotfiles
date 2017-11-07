# dotfiles

## Softwares
- fish
- neovim
- vim

## Setup

### Ubuntu
```
# install fish
sudo apt-get update
sudo apt-get install fish mercurial
chsh # path of fish
# logout and login
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher
# install neovim
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip
pip2 install neovim
pip3 install neovim neovim-remote virtualfish
# install tmux
brew insatll tmux reattach-to-user-namespace
git clone https://github.com/abekoh/dotfiles.git
# config
python3 dotfiles/setup.py
```

### Mac
```
# install fish
brew install fish
chsh # path of fish
# restart terminal
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher
# install neovim
brew tap neovim/homebrew-neovim
brew install neovim
brew install python3
pip2 install neovim
pip3 install neovim neovim-remote virtualfish
# install tmux
brew insatll tmux reattach-to-user-namespace
git clone https://github.com/abekoh/dotfiles.git
# config
python3 dotfiles/setup.py
```

## Setup lint
```
# json lint
npm install -g jsonlint
```

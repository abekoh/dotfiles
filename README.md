# dotfiles

## Softwares
- fish
- neovim
- vim

## Setup

### Ubuntu
Run .sh file
```
git clone https://github.com/abekoh/dotfiles.git
cd dotfiles
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```
Change default shell
```
# Native
which fish # check fish's path
chsh -s /usr/bin/fish # input fish's path
# Windows Subsystem for Linux
C:\Windows\System32\bash.exe ~ -s /usr/bin/fish # change shortcut's link
```
Install plugins for fish
```
fisher
```


### Mac
```
# install fish
brew install fish
sudo vi /etc/shells #input path of fish
chsh # input path of fish
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

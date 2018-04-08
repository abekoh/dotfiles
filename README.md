# dotfiles

## Softwares
- fish
- neovim
- vim

## Setup

Run .sh file.
```
git clone https://github.com/abekoh/dotfiles.git
cd dotfiles
chmod +x setup_ubuntu.sh
./setup.sh
```
Change default shell.
```
# Mac
which fish # check fish's path
sudo vi /etc/shells # check path of fish
chsh -s /usr/local/bin/fish # input path of fish
# Ubuntu
which fish # check path of fish
chsh -s /usr/bin/fish # input path of fish
# Windows Subsystem for Linux
C:\Windows\System32\bash.exe ~ -s /usr/bin/fish # change shortcut's link
```
Install plugins for fish.
```
fisher
```

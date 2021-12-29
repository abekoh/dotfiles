# homebrew
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# shell config
export EDITOR=nvim
export TERM=xterm-256color

# path
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.anyenv/bin
export PATH=$PATH:$HOME/google-cloud-sdk/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/flutter/bin

# go
export GOPATH=$HOME
export GOBIN=$HOME/bin

# anyenv
eval "$(anyenv init -)"
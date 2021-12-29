# homebrew
case ${OSTYPE} in
  darwin*)
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
esac

# shell config
export EDITOR=nvim
export TERM=xterm-256color

# path
export PATH=/usr/local/bin:${PATH+:$PATH}
export PATH=$HOME/bin:${PATH+:$PATH}
export PATH=$HOME/.anyenv/bin:${PATH+:$PATH}
export PATH=$HOME/.cargo/bin:${PATH+:$PATH}
export PATH=$HOME/flutter/bin:${PATH+:$PATH}

# go
export GOPATH=$HOME
export GOBIN=$HOME/bin

# anyenv
eval "$(anyenv init -)"

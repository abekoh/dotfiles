# path
export PATH=/usr/local/bin${PATH+:$PATH}
export PATH=$HOME/bin${PATH+:$PATH}
export PATH=$HOME/.cargo/bin${PATH+:$PATH}
export PATH=/usr/local/go/bin:${PATH+:$PATH}
export PATH=$HOME/.local/bin:${PATH+:$PATH}
export PATH=$HOME/tinygo/bin:$PATH

export LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib${LIBRARY_PATH+:$LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}


export TERM=xterm-256color
export EDITOR=nvim
export HISTSIZE=10000

# starship
eval "$(starship init zsh)"

# ignore ctrl-d
set -o ignoreeof

# save history immediately
setopt incappendhistory

setopt share_history

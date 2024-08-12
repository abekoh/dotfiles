case ${OSTYPE} in
  darwin*)
    # homebrew
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    export HOMEBREW_FILE="~/dotfiles/Brewfile"
    export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    ;;
  linux*)
    ;;
esac

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

if [[ -z "$IDEA_TERMINAL" ]]; then
  export ZELLIJ_AUTO_ATTACH=true
  export ZELLIJ_AUTO_EXIT=true
  eval "$(zellij setup --generate-auto-start zsh)"
fi

# starship
eval "$(starship init zsh)"

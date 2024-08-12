case ${OSTYPE} in
  darwin*)
    # homebrew
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    export HOMEBREW_FILE="~/dotfiles/Brewfile"
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

[ -f $$HOME/.asdf/asdf.sh ] && source $$HOME/.asdf/asdf.sh
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.ghcup/env ] && source $HOME/.ghcup/env
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.docker/init-zsh.sh ] && source $HOME/.docker/init-zsh.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abekoh/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/abekoh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abekoh/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/abekoh/google-cloud-sdk/completion.zsh.inc'; fi

# direnv
eval "$(direnv hook zsh)"
# atuin
eval "$(atuin init zsh --disable-up-arrow)"
zvm_after_init_commands=('bindkey '^r' _atuin_search_widget')

export TERM=xterm-256color
export EDITOR=nvim
export HISTSIZE=10000

# ignore ctrl-d
set -o ignoreeof

# save history immediately
setopt incappendhistory

# 大文字小文字無視
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# 大文字のときは小文字を無視
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# 大文字見つからなければ小文字
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
# みつからなければ文字種無視
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# 通常補完 -> （小文字 -> 大文字） -> （小文字 -> 大文字 + 大文字 -> 小文字）.
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

if [[ -z "$IDEA_TERMINAL" ]]; then
  export ZELLIJ_AUTO_ATTACH=true
  export ZELLIJ_AUTO_EXIT=true
  eval "$(zellij setup --generate-auto-start zsh)"
fi

# starship
eval "$(starship init zsh)"

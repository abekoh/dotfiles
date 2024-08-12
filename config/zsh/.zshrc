eval "$(sheldon source)"

export TERM=xterm-256color

case ${OSTYPE} in
  darwin*)
    # homebrew
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    export HOMEBREW_FILE="~/dotfiles/Brewfile"
    # php
    export PHP_BUILD_CONFIGURE_OPTS="--with-bz2=$(brew --prefix bzip2) --with-iconv=$(brew --prefix libiconv)"
    # export TERM=alacritty
    ;;
  linux*)
    ;;
esac

# path
export PATH=/usr/local/bin${PATH+:$PATH}
export PATH=$HOME/bin${PATH+:$PATH}
export PATH=$HOME/.cargo/bin${PATH+:$PATH}
export PATH=$HOME/flutter/bin${PATH+:$PATH}
export PATH=$HOME/Library/Android/sdk/cmdline-tools/latest/bin${PATH+:$PATH}
export PATH=/opt/homebrew/opt/bzip2/bin${PATH+:$PATH}
export PATH=/opt/homebrew/opt/libiconv/bin${PATH+:$PATH}
export PATH=/opt/homebrew/opt/llvm/bin${PATH+:$PATH}
export PATH=/usr/local/go/bin:${PATH+:$PATH}
export PATH=$HOME/.poetry/bin:${PATH+:$PATH}
export PATH=$HOME/.local/bin:${PATH+:$PATH}
export PATH=$HOME/.dotnet:$HOME/.dotnet/tools:${PATH+:$PATH}
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/tinygo/bin:$PATH

export LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib${LIBRARY_PATH+:$LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export DOTNET_ROOT=$HOME/.dotnet
export BUN_INSTALL="$HOME/.bun"

. $HOME/.asdf/asdf.sh

# shell config
export EDITOR=nvim

# HISTORY
export HISTSIZE=10000

# go
export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOBIN)
export GOTOOLCHAIN=$(curl -s -L "https://go.dev/VERSION?m=text" | head -n 1)+auto

# ignore ctrl-d
set -o ignoreeof

# save history immediately
setopt incappendhistory

# google cloud# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# completion
autoload -Uz compinit
compinit
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

# alias
alias d='docker'
alias dc='docker compose'
alias g='git'
alias gs='git status'
alias gcm='git checkout main'
alias gpl='git pull'
alias gps='git push origin HEAD'
alias gc='git checkout'
alias gcb='git checkout -b'
alias ghrepov='gh repo view --web'
alias ghprc='gh pr create'
alias ghprv='gh pr view --web'
alias v='nvim'
alias vim='nvim'
alias k='kubectl'
alias ks='kubens'
alias kx='kubectx'
alias para='printf "%s\0" {1..5} | xargs -0 -I {} -P 5 echo {}'

# abbr clear-session
# abbr import-aliases --quiet
#
prj () {
  local prj_path=$(ghq list -p | sk --layout reverse --query "$LBUFFER")
  if [ -z "$prj_path" ]; then
    return
  fi
  local prj_name=$(echo "$(basename $(dirname $prj_path))/$(basename $prj_path)" | sed -e 's/\./_/g')
  if zellij action query-tab-names | grep -Fxq $prj_name; then
    zellij action go-to-tab-name $prj_name
  else
    zellij action new-tab --layout project --name $prj_name --cwd $prj_path
  fi
}


cd() {
    if [ "$#" -eq 0 ]; then
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            builtin cd "$(git rev-parse --show-toplevel)" || return 1
        else
            builtin cd ~ || return 1
        fi
    else
        builtin cd "$@" || return 1
    fi
}

[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.ghcup/env ] && source $HOME/.ghcup/env
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.docker/init-zsh.sh ] && source $HOME/.docker/init-zsh.sh
[ -s $HOME/.bun/_bun ] && source $HOME/.bun/_bun

# direnv
eval "$(direnv hook zsh)"
# starship
eval "$(starship init zsh)"
# zoxide
eval "$(zoxide init zsh)"
# atuin
eval "$(atuin init zsh --disable-up-arrow)"
zvm_after_init_commands=('bindkey '^r' _atuin_search_widget')
# github copilot
eval "$(github-copilot-cli alias -- "$0")"

if [[ -z "$IDEA_TERMINAL" ]]; then
  export ZELLIJ_AUTO_ATTACH=true
  export ZELLIJ_AUTO_EXIT=true
  eval "$(zellij setup --generate-auto-start zsh)"
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abekoh/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/abekoh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abekoh/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/abekoh/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/abekoh/.bun/_bun" ] && source "/Users/abekoh/.bun/_bun"

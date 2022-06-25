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
esac

# shell config
export EDITOR=nvim
export TERM=xterm-256color

# path
export PATH=/usr/local/bin:${PATH+:$PATH}
export PATH=$HOME/bin:${PATH+:$PATH}
export PATH=$HOME/.anyenv/bin${PATH+:$PATH}
export PATH=$HOME/.cargo/bin${PATH+:$PATH}
export PATH=$HOME/flutter/bin${PATH+:$PATH}
export PATH=$HOME/Library/Android/sdk/cmdline-tools/latest/bin${PATH+:$PATH}
export PATH=/opt/homebrew/opt/bzip2/bin${PATH+:$PATH}
export PATH=/opt/homebrew/opt/libiconv/bin${PATH+:$PATH}
export PATH=/opt/homebrew/opt/llvm/bin${PATH+:$PATH}
export LIBRARY_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib${LIBRARY_PATH+:$LIBRARY_PATH}

# go
export GOPATH=$HOME
export GOBIN=$HOME/bin

# anyenv
eval "$(anyenv init -)"
# direnv
eval "$(direnv hook zsh)"
# starship
eval "$(starship init zsh)"
# zoxide
eval "$(zoxide init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions
zinit light olets/zsh-abbr

# google cloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

abbr clear-session
abbr import-aliases --quiet

# prj
prj () {
  local prj_path=$(ghq list -p | peco --query "$LBUFFER")
  if [ -z "$prj_path" ]; then
    return
  fi
  local prj_name=$(echo "$(basename $(dirname $prj_path))/$(basename $prj_path)" | sed -e 's/\./_/g')
  if ! tmux has-session -t $prj_name; then
    tmux new-session -c $prj_path -s $prj_name -d
    tmux setenv -t $prj_name TMUX_SESSION_PATH $prj_path
  fi
  if [ -z "$TMUX" ]; then
    tmux attach -t $prj_name
  else
    tmux switch-client -t $prj_name
  fi
}

cd () {
  if [ -n "$TMUX" -a -z "$@" ]; then
    local session_path=$(tmux show-environment | grep TMUX_SESSION_PATH | sed -e 's/TMUX_SESSION_PATH=//')
    if [ -n "$session_path" ]; then
      builtin cd $session_path
      return
    fi
  fi
  builtin cd "$@"
}

nvim () {
    if [ -z "$TMUX" ]; then
      command nvim $@
      return
    fi
    # ソケットを設定
    local socket_path=/tmp/$(echo $(tmux display-message -p '#S') | sed 's/\//_/g' )
    if [ -S $socket_path ]; then
        # すでにソケットが存在してたらそれに接続
        nvr --remote-tab --servername $socket_path $argv 
        # 該当のnvimに移動
        local session_id=$(tmux list-panes -F '#{session_id}')
        local pane_ids_str=$(tmux list-panes -a -F "#{session_id},#{window_index},#{pane_index},#{pane_current_command}" | grep "^$session_id,.*,nvim\$")
        # 配列にする: https://gist.github.com/mattmc3/76ad634f362b5a9a54f1779a4737d5ae
        local pane_ids=(${(@s:,:)pane_ids_str})
        tmux select-window -t $pane_ids[2] && tmux select-pane -t $pane_ids[3]
    else 
      # ソケットがなければ作成して起動
      NVIM_LISTEN_ADDRESS=$socket_path command nvim $@
    fi
}

[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

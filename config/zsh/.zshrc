# starship
eval "$(starship init zsh)"

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
alias g='git'
alias vim='nvim'
alias k='kubectl'
alias ks='kubens'
alias kx='kubectx'

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
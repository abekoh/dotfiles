export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOBIN)
export GOTOOLCHAIN=$(curl -s -L "https://go.dev/VERSION?m=text" | head -n 1)+auto

# direnv
eval "$(direnv hook zsh)"

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

[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.ghcup/env ] && source $HOME/.ghcup/env
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.docker/init-zsh.sh ] && source $HOME/.docker/init-zsh.sh
[ -f $HOME/.local/bin/mise ] && eval $(~/.local/bin/mise activate zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abekoh/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/abekoh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abekoh/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/abekoh/google-cloud-sdk/completion.zsh.inc'; fi


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



# atuin
eval "$(atuin init zsh --disable-up-arrow)"
zvm_after_init_commands=('bindkey '^r' _atuin_search_widget')

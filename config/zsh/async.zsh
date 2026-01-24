export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOBIN)
# GOTOOLCHAIN is set asynchronously to avoid blocking shell startup
() {
  local gotoolchain=$(curl -s -L "https://go.dev/VERSION?m=text" 2>/dev/null | head -n 1)
  [[ -n "$gotoolchain" ]] && export GOTOOLCHAIN="${gotoolchain}+auto"
} &!

# direnv
eval "$(direnv hook zsh)"

# git-wt
eval "$(git wt --init zsh)"

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
[ -f $HOME/.local/bin/mise ] && eval "$($HOME/.local/bin/mise activate zsh)"

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

prjv1 () {
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

_prj () {
  local repo_path=$1
  local new_tab=$2

  if [ -z "${repo_path}" ]; then
    repo_path=$(ghq list -p | peco --query "$LBUFFER")
  fi
  if [ -z "${repo_path}" ]; then
    return
  fi
  
  # デフォルトブランチを取得（main or master）
  local default_branch=$(git -C "${repo_path}" symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if [ -z "${default_branch}" ]; then
    # フォールバック: main か master があれば使う
    default_branch=$(git -C "${repo_path}" branch --list main master | head -1 | tr -d ' *')
  fi
  
  # ブランチ一覧: ローカルのみ、デフォルトブランチを先頭に
  git fetch -C ${repo_path}
  local branch=$(
    {
      [[ -n $default_branch ]] && echo "$default_branch"
      git -C "${repo_path}" branch -a --format='%(refname:short)' | grep -v "^${default_branch}$"
    } | awk '!seen[$0]++' | peco --query "$LBUFFER"
  )
  
  if [ -z "${branch}" ]; then
    return
  fi

  local repo_escaped=$(echo "$(basename $(dirname ${repo_path}))/$(basename ${repo_path})" | sed -e 's/\./_/g')
  local branch_escaped=$(echo "${branch}" | sed -e 's/\./_/g')
  local prj_name="${repo_escaped}[${branch_escaped}]"

  if zellij action query-tab-names | grep -Fxq $prj_name; then
    zellij action go-to-tab-name $prj_name
  else
    if [[ $new_tab == "true" ]]; then
      zellij action new-tab --layout default --name $prj_name --cwd $repo_path

      if [[ $branch == $default_branch ]]; then
        zellij action write-chars "git checkout $default_branch || zellij action rename-tab \"${repo_escaped}[\$(git rev-parse --abbrev-ref HEAD | sed -e 's/\./_/g')]\""
        zellij action write 13  # Enter key
      else
        zellij action write-chars "git wt $branch || zellij action rename-tab \"${repo_escaped}[\$(git rev-parse --abbrev-ref HEAD | sed -e 's/\./_/g')]\""
        zellij action write 13  # Enter key
      fi
    else
      zellij action rename-tab $prj_name
      cd $repo_path

      local fallback_branch_escaped=$(git rev-parse --abbrev-ref HEAD | sed -e 's/\./_/g')
      local fallback_prj_name="${repo_escaped}[${fallback_branch_escaped}]"
      if [[ $branch == $default_branch ]]; then
        git checkout $default_branch \
          || zellij action rename-tab $fallback_prj_name
      else
        git wt $branch \
          || zellij action rename-tab $fallback_prj_name
      fi
    fi
  fi
}

nprj () {
  _prj "" "true"
}

cprj () {
  _prj "" "false"
}

GIT_COMMON_PATH='$(realpath $(git rev-parse --git-common-dir) | sed -E '\''s#(\.git)?/?$##'\'')'

nwt () {
  local common_path=${(e)GIT_COMMON_PATH}
  if [ -z "${common_path}" ]; then
    return
  fi
  _prj "${common_path}" "true"
}

cwt () {
  local common_path=${(e)GIT_COMMON_PATH}
  if [ -z "${common_path}" ]; then
    return
  fi
  _prj "${common_path}" "false"
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


# sgpt
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey ^] _sgpt_zsh

export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOBIN)
# GOTOOLCHAIN is set asynchronously to avoid blocking shell startup
() {
  local gotoolchain=$(curl -s -L "https://go.dev/VERSION?m=text" 2>/dev/null | head -n 1)
  [[ -n "$gotoolchain" ]] && export GOTOOLCHAIN="${gotoolchain}+auto"
} &!

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
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

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
alias gl='git log --graph --oneline --decorate --all'
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

GIT_COMMON_PATH='$(realpath $(git rev-parse --git-common-dir) | sed -E '\''s#(\.git)?/?$##'\'')'

prj () {
  local prj_path=$(ghq list -p | peco --query "$LBUFFER")
  if [ -z "$prj_path" ]; then
    return
  fi
  local prj_name="$(basename $(dirname $prj_path))/$(basename $prj_path)"
  # すでに開いているworkspaceがあればfocus（worktree listのopen_workspace_idで判定）
  local ws_id=$(herdr worktree list --cwd "$prj_path" --json 2>/dev/null \
    | jq -r --arg p "$prj_path" '.result.worktrees[] | select(.path == $p) | .open_workspace_id // empty' | head -1)
  if [ -n "$ws_id" ]; then
    herdr workspace focus "$ws_id"
  else
    herdr workspace create --cwd "$prj_path" --label "$prj_name" --focus
  fi
}

wt () {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return
  fi
  local repo_path=${(e)GIT_COMMON_PATH}
  if [ -z "${repo_path}" ]; then
    return
  fi

  git -C "${repo_path}" fetch

  # ブランチ一覧: local + remote（origin/ を剥がして重複排除、HEAD は除外）
  # --print-query: 1行目がクエリ、2行目が選択候補。候補なしで決定すると1行のみ → 新規ブランチ名として扱う
  local out=$(
    {
      git -C "${repo_path}" branch --format='%(refname:short)'
      git -C "${repo_path}" branch -r --format='%(refname:lstrip=3)' | grep -v '^HEAD$'
    } | awk '!seen[$0]++' | peco --print-query --query "$LBUFFER"
  )
  local branch=$(echo "$out" | sed -n 2p)
  [ -z "$branch" ] && branch=$(echo "$out" | sed -n 1p)
  if [ -z "$branch" ]; then
    return
  fi

  # すでに開いているworkspaceがあればfocusのみ（worktree listのopen_workspace_idで判定）
  local ws_id=$(herdr worktree list --cwd "${repo_path}" --json 2>/dev/null \
    | jq -r --arg b "${branch}" '.result.worktrees[] | select(.branch == $b) | .open_workspace_id // empty' | head -1)
  if [ -n "$ws_id" ]; then
    herdr workspace focus "$ws_id"
    return
  fi

  # 既存 worktree があれば open、なければ create（いずれもfocus）
  herdr worktree open --cwd "${repo_path}" --branch "${branch}" --focus 2>/dev/null && return
  if git -C "${repo_path}" show-ref --verify --quiet "refs/heads/${branch}"; then
    herdr worktree create --cwd "${repo_path}" --branch "${branch}" --focus
  elif git -C "${repo_path}" show-ref --verify --quiet "refs/remotes/origin/${branch}"; then
    herdr worktree create --cwd "${repo_path}" --branch "${branch}" --base "origin/${branch}" --focus
  else
    herdr worktree create --cwd "${repo_path}" --branch "${branch}" --focus
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


# claude によるコマンド生成
_claude_shell_zsh() {
if [[ -n "$BUFFER" ]]; then
    _claude_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(claude -p --model haiku \
      --system-prompt "You are a shell command generator for zsh on macOS. Convert the user's request into a single shell command. Output only the raw command, no explanation, no markdown, no code fences." \
      <<< "$_claude_prev_cmd" 2>/dev/null | sed -e 's/^```.*$//' -e '/^$/d')
    zle end-of-line
fi
}
zle -N _claude_shell_zsh
bindkey ^] _claude_shell_zsh

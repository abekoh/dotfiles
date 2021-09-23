# anyenv設定
set -x PATH ~/.anyenv/bin $PATH
# ${PATH}がfishでパースできないエラー回避のため、grepで該当を除去
status --is-interactive; and source (anyenv init - | grep -v "export PATH=\".*.anyenv/envs/pyenv/shims:\${PATH}\"" | psub)
set -x PATH ~/.anyenv/envs/pyenv/shims $PATH

# environment vars
set -x PATH /usr/local/bin $PATH
set -x EDITOR nvim
set -x TERM xterm-256color
set -x PATH ~/bin $PATH
set -x NRFSDK12_ROOT ~/sdk/nRF5_SDK_12.3.0_d7731ad
# set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
# set -x PATH $JAVA_HOME/bin $PATH
set -x PATH ~/google-cloud-sdk/bin $PATH
set -x PATH ~/.cargo/bin $PATH
set -x PATH ~/flutter/bin $PATH
set -x GOPATH ~
set -x GOBIN ~/bin

# alias
alias vi='vim -u NONE -N'
alias ij='open -b com.jetbrains.intellij'
alias vim='nvim'
alias g='git'
alias k='kubectl'
alias ks='kubens'
alias kx='kubectx'

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# eventをhookさせるため一度実行
history-merge

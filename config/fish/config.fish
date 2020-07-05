# environment vars
set -x PATH /usr/local/bin $PATH
set -x EDITOR nvim
set -x TERM xterm-256color
set -x GOPATH ~
set -x PATH ~/bin $PATH
set -x NRFSDK12_ROOT ~/sdk/nRF5_SDK_12.3.0_d7731ad
# set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
# set -x PATH $JAVA_HOME/bin $PATH
set -x PATH ~/google-cloud-sdk/bin $PATH
set -x PATH ~/.cargo/bin $PATH

# alias
alias vi='vim -u NONE -N'
alias ij='open -b com.jetbrains.intellij'
alias vim='nvim'
alias g='git'
alias k='kubectl'

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# run
status --is-interactive; and source (anyenv init -|psub)
status --is-interactive; and source (nodenv init -|psub)

# eventをhookさせるため一度実行
history-merge

# environment vars
set -x PATH /usr/local/bin $PATH
set -x WORKON_HOME ~/.virtualenvs
set -x EDITOR nvim
set -x TERM screen-256color
set -x GOPATH ~
set -x PATH ~/.nodebrew/current/bin $PATH
set -x PATH ~/bin $PATH
set -x NRFSDK12_ROOT ~/sdk/nRF5_SDK_12.3.0_d7731ad

# alias
alias vi='vim -u NONE -N'
alias ij='open -b com.jetbrains.intellij'

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# run
eval (python3 -m virtualfish)
source (rbenv init - | psub)

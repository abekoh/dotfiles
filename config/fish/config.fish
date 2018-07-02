# environment vars
set -x PATH /usr/local/bin $PATH
set -x WORKON_HOME ~/.virtualenvs
set -x EDITOR nvim
set -x TERM xterm-256color
set -x GOPATH ~/.go
set -x PATH ~/.go/bin $PATH
set -x PATH ~/.nodebrew/current/bin

# alias
alias vi='vim -u NONE -N'

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# run
eval (python3 -m virtualfish)

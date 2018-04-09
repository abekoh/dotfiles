# vi mode
# fish_vi_key_bindings
# function fish_mode_prompt 
# end
set -g fish_key_bindings fish_default_key_bindings

# environment vars
set -x PATH /usr/local/bin $PATH
set -x WORKON_HOME ~/.virtualenvs
set -x EDITOR nvim
set -x TERM xterm-256color

# alias
alias vi='vim -u NONE -N'

# key-bind
bind \cl accept-autosuggestion

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# run
eval (python3 -m virtualfish)

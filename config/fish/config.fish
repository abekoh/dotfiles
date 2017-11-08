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

switch (uname)
case Darwin
  set -x PYENV_ROOT $HOME/.pyenv
  set -x PATH $HOME/.nodebrew/current/bin $PATH
case Linux
  set -x LD_LIBRARY_PATH /usr/local/cuda/lib64:/usr/local/lib
  set -x CUDA_HOME /usr/local/cuda
  set -x PATH /usr/local/cuda/bin $PATH
end

# alias
alias vi='vim -u NONE -N'
switch (uname)
case Darwin
  alias rm='rmtrash'
end

# key-bind
bind \cl accept-autosuggestion

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# run
eval (python3 -m virtualfish)

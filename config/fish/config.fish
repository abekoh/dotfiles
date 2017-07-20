# environment vars
set -x PATH /usr/local/bin $PATH
set -x WORKON_HOME ~/.virtualenvs
set -x EDITOR nvim

switch (uname)
case Darwin
  set -x PYENV_ROOT $HOME/.pyenv
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

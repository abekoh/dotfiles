# path
set -x PATH /usr/local/bin $PATH
set -x WORKON_HOME ~/.virtualenvs

switch (uname)
  case Darwin
    set -x PYENV_ROOT $HOME/.pyenv
  case Linux
    set -x LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH
    set -x LD_LIBRARY_PATH /usr/local/lib $LD_LIBRARY_PATH
    set -x CUDA_HOME /usr/local/cuda
    set -x PATH /usr/local/cuda/bin $PATH
end

# alias
alias rm='rmtrash'

# key-bind
bind \cl accept-autosuggestion

# complete
complete -c workon -a "(ls $WORKON_HOME)"

# run
eval (python -m virtualfish)

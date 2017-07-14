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

alias rm='rmtrash'

eval (python -m virtualfish)
. $HOME/.config/fish/virtualenvwrapper.fish

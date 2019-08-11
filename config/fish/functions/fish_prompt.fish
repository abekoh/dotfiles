# set
set -g fish_prompt_pwd_dir_length 0

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (prompt_hostname)
  set_color normal

  echo -n ':'

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  if test (tput cols) -lt 85
    echo
  else
    echo -n " "
  end

  if __fish_is_git_repository
    set_color DB5837
    echo -n ":"(git symbolic-ref --short HEAD)" "
    set_color normal
  end

  __fish_hg_prompt

  if set -q VIRTUAL_ENV
    set_color 3076B8
    echo -n ":"(basename "$VIRTUAL_ENV")" "
    set_color normal
  end

  echo

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '$ '
  set_color normal
end

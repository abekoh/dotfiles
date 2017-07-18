# set
set -g fish_prompt_pwd_dir_length 80

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

  set_color red
  if __fish_is_git_repository
    echo -n ""
    __fish_git_prompt
    set_color normal
  end

  __fish_hg_prompt

  if set -q VIRTUAL_ENV
    set_color blue
    echo -n " ("(basename "$VIRTUAL_ENV")")"
    set_color normal
  end

  echo

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '$ '
  set_color normal
end

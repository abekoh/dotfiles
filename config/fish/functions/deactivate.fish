function deactivate -d "Exit virtualenv and return to normal shell environment"
  # reset old environment variables
  if test -n "$_OLD_VIRTUAL_PATH"
    set -gx PATH $_OLD_VIRTUAL_PATH
    set -e _OLD_VIRTUAL_PATH
  end
  if test -n "$_OLD_VIRTUAL_PYTHONHOME"
    set -gx PYTHONHOME $_OLD_VIRTUAL_PYTHONHOME
    set -e _OLD_VIRTUAL_PYTHONHOME
  end
  set -e VIRTUAL_ENV
end

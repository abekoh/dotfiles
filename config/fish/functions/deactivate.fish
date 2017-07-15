function deactivate -d "exit virtualenv and return to normal shell environment"
    # reset old environment variables
    if test -n "$_old_virtual_path"
        set -gx path $_old_virtual_path
        set -e _old_virtual_path
    end
    if test -n "$_old_virtual_pythonhome"
        set -gx pythonhome $_old_virtual_pythonhome
        set -e _old_virtual_pythonhome
    end
    set -e virtual_env
end

function prj -d "start project"
  if test (count $argv) -gt 0
    set prjflag --query "$argv"
  end
  set PRJ_PATH (ghq root)/(ghq list | peco $prjflag)
  if test -z $PRJ_PATH
    return
  end
  set PRJ_NAME (echo (basename (dirname $PRJ_PATH))/(basename $PRJ_PATH) | sed -e 's/\./_/g')
  if not tmux has-session -t $PRJ_NAME
    tmux new-session -c $PRJ_PATH -s $PRJ_NAME -d
    tmux setenv -t $PRJ_NAME TMUX_SESSION_PATH $PRJ_PATH
  end
  if test -z $TMUX
    tmux attach -t $PRJ_NAME
  else
    tmux switch-client -t $PRJ_NAME
  end
end

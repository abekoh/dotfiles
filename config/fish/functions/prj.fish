function prj -d "start project"
  set PRJ_PATH (ghq root)/(ghq list | peco)
  if test -z $PRJ_PATH
    return
  end
  set PRJ_NAME (echo (basename (dirname $PRJ_PATH))/(basename $PRJ_PATH) | sed -e 's/\./_/g')
  if not tmux has-session -t $PRJ_NAME
    if test -z $TMUX
      tmux new-session -c $PRJ_PATH -s $PRJ_NAME
    else
      tmux new-session -c $PRJ_PATH -s $PRJ_NAME -d
    end
  else
    if test -z $TMUX
      tmux attach -t $PRJ_NAME
    end
  end
  tmux switch-client -t $PRJ_NAME
end
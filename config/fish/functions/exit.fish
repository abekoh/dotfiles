function exit -d "exit"
  if test -n "$TMUX"
    set session_num (tmux list-sessions | wc -l | string trim) 
    if test $session_num -gt 1
      set panes_status (tmux display-message -p -F "#{window_panes}#{session_windows}")
      if test $panes_status -eq 11
        builtin exit
        tmux switch-client -t (tmux display-message -p -F "#{client_last_session}")
        return $status
      end
    end
  end
  builtin exit
  return $status
end

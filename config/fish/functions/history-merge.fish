function history-merge --on-event fish_preexec -d "merge history"
  history --save
  history --merge
end

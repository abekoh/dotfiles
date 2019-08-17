function ssh
  echo -ne "\033]0;$argv\007"
  command ssh $argv
end

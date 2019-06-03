function nvim -d "neovim binding"
  # tmuxセッション内でなければそのまま
  if test -z $TMUX
    command nvim $argv
  else
    set socket_path /tmp/(echo (tmux display-message -p '#S') | sed 's/\//_/g' )
    if test -S $socket_path
      # すでにソケットが存在してたらそれに接続
      nvr --remote-tab --servername $socket_path $argv
      # 該当のnvimに移動
      set session_id (tmux list-panes -F '#{session_id}')
      set pane_ids (tmux list-panes -a -F "#{session_id},#{window_index},#{pane_index},#{pane_current_command}" | grep "^$session_id,.*,nvim\$" | string split ',')
      tmux select-window -t $pane_ids[2] && tmux select-pane -t $pane_ids[3]
    else
      # ソケットがなければ作成して起動
      command env NVIM_LISTEN_ADDRESS=$socket_path nvim $argv
    end
  end
end

prj () {
  local prj_path=$(ghq list -p | sk --layout reverse --query "$LBUFFER")
  if [ -z "$prj_path" ]; then
    return
  fi
  local prj_name=$(echo "$(basename $(dirname $prj_path))/$(basename $prj_path)" | sed -e 's/\./_/g')
  if zellij action query-tab-names | grep -Fxq $prj_name; then
    zellij action go-to-tab-name $prj_name
  else
    zellij action new-tab --layout project --name $prj_name --cwd $prj_path
  fi
}


cd() {
    if [ "$#" -eq 0 ]; then
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            builtin cd "$(git rev-parse --show-toplevel)" || return 1
        else
            builtin cd ~ || return 1
        fi
    else
        builtin cd "$@" || return 1
    fi
}

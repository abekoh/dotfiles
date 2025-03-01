case ${OSTYPE} in
  darwin*)
    # homebrew
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    export HOMEBREW_FILE="~/dotfiles/Brewfile"
    export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    ;;
  linux*)
    ;;
esac

if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

fpath=(~/.zsh.d/ $fpath)

eval "$(sheldon source)"


if [[ "$TERM_PROGRAM" = "ghostty" ]]; then
  export ZELLIJ_AUTO_ATTACH=true
  export ZELLIJ_AUTO_EXIT=true
  eval "$(zellij setup --generate-auto-start zsh)"
fi

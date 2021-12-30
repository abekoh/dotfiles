#!/bin/bash
lsp_path=~/.cache/lsp
mkdir -p $lsp_path

# java-lsp
java_lsp_path=$lsp_path/jdt-language-server
if [ ! -d  $java_lsp_path ]; then
  mkdir -p $java_lsp_path
  java_lsp_filename=jdt-language-server-latest.tar.gz
  wget -P /tmp/ http://download.eclipse.org/jdtls/snapshots/$java_lsp_filename
  tar xf /tmp/$java_lsp_filename -C $java_lsp_path
  rm /tmp/$java_lsp_filename
else
  echo "jdt-langiage -server is already installed."
fi

# python
if type pip3 > /dev/null 2>&1; then
  pip3 install -U \
    fish \
    neovim \
    neovim-remote \
    pyright \
    yamllint \
    rope \
    pyflakes \
    mccabe \
    pycodestyle \
    pydocstyle \
    autopep8 \
    yapf \
    isort \
    black
else
  echo "pip3 is not found."
fi

# go
if type go > /dev/null 2>&1; then
  go install golang.org/x/tools/cmd/golsp@latest
  go install github.com/rubenv/sql-migrate/...@latest
  go install golang.org/x/tools/gopls@latest
else
  echo "go is not found."
fi

if type npm > /dev/null 2>&1; then
  npm install -g \
    javascript-typescript-langserver \
    bash-language-server \
    jsonlint \
    dockerfile-language-server-nodejs \
    prettier \
    sql-language-server
else
  echo "npm is not found."
fi

if type gem > /dev/null 2>&1; then
  gem install solargraph
else
  echo "gem is not found."
fi

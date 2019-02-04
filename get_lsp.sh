#!/bin/bash
lsp_path=~/.cache/lsp

# java
java_lsp_path=$lsp_path/jdt-language-server
if [ ! -d  $java_lsp_path ]; then
  mkdir -p $java_lsp_path
  java_lsp_filename=jdt-language-server-latest.tar.gz
  wget -P /tmp/ http://download.eclipse.org/jdtls/snapshots/$java_lsp_filename
  tar xf /tmp/$java_lsp_filename -C $java_lsp_path
  rm /tmp/$java_lsp_filename
else
  echo "go-langserver is already installed."
fi

# python
if type pip3 > /dev/null 2>&1; then
  function install_pip () {
    if [ -n "$2" ]; then
      cmd=$2
    else
      cmd=$1
    fi
    if ! type $cmd > /dev/null 2>&1; then
      pip3 install $1
    else
      echo $1 is already installed.
    fi
  }
  install_pip python-language-server pyls
  install_pip yamllint
else
  echo "pip3 is not found."
fi

# go
if type go > /dev/null 2>&1; then
  if ! type pyls > /dev/null 2>&1; then
    go get -u golang.org/x/tools/cmd/golsp
  else
    echo "go-langserver is already installed."
  fi
else
  echo "go is not found."
fi

if type npm > /dev/null 2>&1; then
  function install_npm () {
    if [ -n "$2" ]; then
      cmd=$2
    else
      cmd=$1
    fi
    if ! type $cmd > /dev/null 2>&1; then
      npm install -g $1
    else
      echo $1 is already installed.
    fi
  }
  install_npm javascript-typescript-langserver
  install_npm bash-language-server
  install_npm jsonlint
  install_npm dockerfile-language-server-nodejs docker-langserver
  install_npm prettier
  install_npm sql-language-server
else
  echo "npm is not found."
fi

if type gem > /dev/null 2>&1; then
  if ! type solargraph > /dev/null 2>&1; then
    gem install solargraph
  else
    echo "solargraph is already installed."
  fi
else
  echo "gem is not found."
fi

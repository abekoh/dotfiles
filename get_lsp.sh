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
  if ! type pyls > /dev/null 2>&1; then
    pip3 install python-language-server
  else
    echo "pyls is already installed."
  fi
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
  # javascript/typescript
  if ! type javascript-typescript-langserver > /dev/null 2>&1; then
    npm install -g javascript-typescript-langserver
  else
    echo "javascript-typescript-langserver is already installed."
  fi
  # bash
  if ! type bash-language-server > /dev/null 2>&1; then
    npm install -g bash-language-server
  else
    echo "bash-language-server is already installed."
  fi
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

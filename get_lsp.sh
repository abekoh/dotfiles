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
    pip3 install pyls
  else
    echo "pyls is already installed."
  fi
else
  echo "pip3 is not found."
fi

# go
if type go > /dev/null 2>&1; then
  if ! type pyls > /dev/null 2>&1; then
    go get -u github.com/sourcegraph/go-langserver
  else
    echo "go-langserver is already installed."
  fi
else
  echo "go is not found."
fi

# javascript/typescript
if type npm > /dev/null 2>&1; then
  if ! type javascript-typescript-langserver > /dev/null 2>&1; then
    npm install -g javascript-typescript-langserver
  else
    echo "javascript-typescript-langserver is already installed."
  fi
else
  echo "npm is not found."
fi

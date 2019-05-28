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
  echo "jdt-langiage -server is already installed."
fi

# python
if type pip3 > /dev/null 2>&1; then
  pip3 install python-language-server yamllint rope pyflakes mccabe \
    pycodestyle pydocstyle autopep8 yapf isort -U
else
  echo "pip3 is not found."
fi

# go
if type go > /dev/null 2>&1; then
  go get -u golang.org/x/tools/cmd/golsp
else
  echo "go is not found."
fi

if type npm > /dev/null 2>&1; then
  npm install -g javascript-typescript-langserver bash-language-server jsonlint \
    dockerfile-language-server-nodejs prettier sql-language-server
else
  echo "npm is not found."
fi

if type gem > /dev/null 2>&1; then
  gem install solargraph
else
  echo "gem is not found."
fi

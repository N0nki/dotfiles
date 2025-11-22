#!/bin/bash
# サーチパス変更 Homebrewでインストールしたアプリケーションを優先
PATH="/usr/local/bin:${PATH}"
export PATH

export PATH=$PATH:$HOME/usr/bin

# openssl
export PATH="/usr/local/opt/openssl/bin:$PATH"

# rbenv
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"

# NeoVim
export XDG_CONFIG_HOME=$HOME/.config

# Nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ "$(uname)" == 'Darwin' ]; then
  # export CC="/usr/local/bin/gcc-8 -fopenmp -I/usr/local/opt/open-mpi/include -L/usr/local/opt/open-mpi/lib -lmpi"
  export CC="/usr/local/bin/g++-8"
  # export CC="/usr/local/bin/gcc-8"
  export OMP_NUM_THREADS=2
  export CXX="/usr/local/bin/g++-8"
fi

source ~/.bashrc

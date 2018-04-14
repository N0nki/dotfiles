# サーチパス変更 Homebrewでインストールしたアプリケーションを優先
PATH="/usr/local/bin:${PATH}"
export PATH

export PATH=$PATH:$HOME/usr/bin

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
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

source ~/.bashrc

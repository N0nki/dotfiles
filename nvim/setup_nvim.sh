#!/bin/sh

export XDG_CONFIG_HOME=$HOME/.config
if [ ! -e ~/.config ]; then
  mkdir ~/.config
fi
cd ~/.config
mkdir nvim

ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/nvim/lua ~/.config/nvim/lua
ln -sf ~/dotfiles/nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf ~/dotfiles/nvim/snippets ~/.config/nvim/snippets
ln -sf ~/dotfiles/nvim/vsnippets ~/.config/nvim/vsnippets

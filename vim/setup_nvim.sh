#!/bin/sh

export XDG_CONFIG_HOME=$HOME/.config
if [ ! -e ~/.config ]; then
  mkdir ~/.config
fi
cd ~/.config
mkdir nvim

ln -sf ~/dotfiles/vim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/vim/lua ~/.config/nvim/lua
ln -sf ~/dotfiles/vim/ftdetect ~/.config/nvim/ftdetect
ln -sf ~/dotfiles/vim/ftplugin ~/.config/nvim/ftplugin
ln -sf ~/dotfiles/vim/snippets ~/.config/nvim/snippets

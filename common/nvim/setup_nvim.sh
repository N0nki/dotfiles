#!/bin/sh

if [ ! -e ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim
fi

ln -sf ~/dotfiles/common/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/common/nvim/lua ~/.config/nvim/lua
ln -sf ~/dotfiles/common/nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf ~/dotfiles/common/nvim/snippets ~/.config/nvim/snippets
ln -sf ~/dotfiles/common/nvim/vsnippets ~/.config/nvim/vsnippets

#!/bin/sh

# neovim
export XDG_CONFIG_HOME=$HOME/.config
cd ~/.config
mkdir nvim
cd nvim
mkdir colors
mkdir plugins
# install dein.vim
cd ~/.cache
mkdir dein
cd dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
sh ~/dotfiles/nvim/synbolic_links.sh

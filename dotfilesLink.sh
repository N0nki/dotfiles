#!/bin/sh

cd ~/
# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/colors ~/.vim

# atom
sh ~/dotfiles/.atom/setup_atom.sh

# nvim
sh ~/dotfiles/nvim/setup_nvim.sh

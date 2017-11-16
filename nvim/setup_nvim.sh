#!/bin/sh

# vimとneovimのセットアップ
# deinをインストールしたあとに各種設定ファイルのシンボリックリンクを貼る

# neovim
export XDG_CONFIG_HOME=$HOME/.config
if [ ! -e ~/.config ]; then
  mkdir .config
fi
cd ~/.config
mkdir nvim
cd nvim
mkdir colors
mkdir plugins
# install dein.vim
if [ ! -e ~/.cache ]; then
  mkdir .cache
fi
cd ~/.cache
mkdir dein
cd dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
sh ~/dotfiles/nvim/synbolic_links.sh
sh ../vim/setup_vim.sh

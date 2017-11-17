#!/bin/sh

# vimとneovimのセットアップ
# deinをインストールしたあとに各種設定ファイルのシンボリックリンクを貼る

export XDG_CONFIG_HOME=$HOME/.config
if [ ! -e ~/.config ]; then
  mkdir .config
fi
cd ~/.config
mkdir nvim
cd nvim
mkdir colors
mkdir plugins
if [ ! -e ~/.cache ]; then
  mkdir .cache
fi
cd ~/.cache
mkdir dein
cd dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
sh ~/dotfiles/vim/synbolic_links.sh

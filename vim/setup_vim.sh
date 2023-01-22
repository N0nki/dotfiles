#!/bin/sh

# vimのセットアップ
# deinをインストールしたあとに各種設定ファイルのシンボリックリンクを貼る

if [ ! -e ~/.vim ]; then
  mkdir ~/.vim
fi
cd ~/.cache
mkdir dein
cd dein
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
sh ~/dotfiles/vim/synbolic_links.sh

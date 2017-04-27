# curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
# sh ./install.sh
# rm ./install.sh

# プラグインマネージャーはdeinへ移行
# deinのインストールはneovimのセットアップスクリプトで行うので、ここでは不要

ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/vim/colors ~/.vim
ln -sf ~/dotfiles/vim/keymap.rc.vim ~/.vim
ln -sf ~/dotfiles/vim/options.rc.vim ~/.vim

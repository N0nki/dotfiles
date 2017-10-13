curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
mkdir ~/.vim/colors
ln -sf ~/dotfiles/vim/old/oldvim_with_plugins.vim ~/.vimrc
ln -sf ~/dotfiles/vim/old/gruvbox.vim ~/.vim/colors/

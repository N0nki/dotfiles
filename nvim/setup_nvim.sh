#!/bin/sh

# neovim
cd ~/.config
mkdir nvim
cd nvim
mkdir colors
# install dein.vim
cd ~/.cache
mkdir dein
cd dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
ln -sf ~/dotfiles/nvim/.dein.toml ~/.dein.toml
ln -sf ~/dotfiles/nvim/.dein_lazy.toml ~/.dein_lazy.toml
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/nvim/colors/gruvbox.vim ~/.config/nvim/colors/gruvbox.vim
ln -sf ~/dotfiles/nvim/colors/neodark.vim ~/.config/nvim/colors/neodark.vim
ln -sf ~/dotfiles/nvim/colors/onedark.vim ~/.config/nvim/colors/onedark.vim
ln -sf ~/dotfiles/nvim/colors/tender.vim ~/.config/nvim/colors/tender.vim

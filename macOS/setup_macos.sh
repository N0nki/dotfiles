#!/bin/sh

ln -sf ~/dotfiles/macOS/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/macOS/.bashrc ~/.bashrc
ln -sf ~/dotfiles/macOS/.zprofile ~/.zprofile
ln -sf ~/dotfiles/macOS/.zshrc ~/.zshrc
ln -sf ~/dotfiles/macOS/.latexmkrc ~/.latexmkrc
ln -sf ~/dotfiles/macOS/.xvimrc ~/.xvimrc
ln -sf ~/dotfiles/macOS/.vrapperrc ~/.vrapperrc
ln -sf ~/dotfiles/macOS/.xvimrc ~/.xvimrc
if [ ! -e ~/.config/ghostty ]; then
  mkdir -p ~/.config/ghostty
fi
ln -sf ~/dotfiles/macOS/ghostty/config ~/.config/ghostty/config
sh ./defaults.sh
softwareupdate --install-rosetta --agree-to-license

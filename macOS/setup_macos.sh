#!/bin/sh

curl -L -o ~/Downloads/iTerm2-3_1_5.zip https://iterm2.com/downloads/stable/iTerm2-3_1_5.zip
ln -sf ~/dotfiles/macOS/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/macOS/.bashrc ~/.bashrc
ln -sf ~/dotfiles/macOS/.latexmkrc ~/.latexmkrc
ln -sf ~/dotfiles/macOS/.xvimrc ~/.xvimrc
ln -sf ~/dotfiles/macOS/.vrapperrc ~/.vrapperrc
ln -sf ~/dotfiles/macOS/.xvimrc ~/.xvimrc
ln -sf ~/dotfiles/macOS/pylintrc ~/.config/pylintrc
sh ./defaults.sh

#!/bin/sh

# starship
ln -sf ~/dotfiles/common/starship.toml ~/.config/starship.toml

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/common/.tmux.conf ~/.tmux.conf

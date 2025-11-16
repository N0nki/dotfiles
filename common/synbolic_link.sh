#!/bin/sh

# starship
ln -sf ~/dotfiles/common/starship.toml ~/.config/starship.toml

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/common/.tmux.conf ~/.tmux.conf

# zellij
mkdir ~/.config/zellij
ln -sf ~/dotfiles/common/zellij.kdl ~/.config/zellij/zellij.kdl

# pet
mkdir ~/.config/pet
ln -sf ~/dotfiles/common/pet/config.toml ~/.config/pet/config.toml
#
# codex
mkdir ~/.codex
ln -sf ~/dotfiles/common/codex/config.toml ~/.codex/config.toml

# gitconfig
ln -sf ~/dotfiles/common/.gitconfig ~/.gitconfig
if [ ! -f ~/.gitconfig.local ]; then
  echo "Creating ~/.gitconfig.local..."
  cat > ~/.gitconfig.local << EOF
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
EOF
  echo "Please edit ~/.gitconfig.local to set your name and email"
fi

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
ln -sf ~/dotfiles/common/pet/snippet.toml ~/.config/pet/snippet.toml
#
# codex
mkdir -p ~/.codex
ln -sf ~/dotfiles/common/codex/config.toml ~/.codex/config.toml
ln -sf ~/dotfiles/common/codex/prompts ~/.codex/prompts

# claude
mkdir -p ~/.claude
ln -sf ~/dotfiles/common/claude/commands ~/.claude/commands

# git global ignore
mkdir -p ~/.config/git
ln -sf ~/dotfiles/common/git/ignore ~/.config/git/ignore

# gitconfig
ln -sf ~/dotfiles/common/git/.gitconfig ~/.gitconfig
if [ ! -f ~/.gitconfig.local ]; then
  echo "Creating ~/.gitconfig.local..."
  cat > ~/.gitconfig.local << EOF
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
EOF
  echo "Please edit ~/.gitconfig.local to set your name and email"
fi

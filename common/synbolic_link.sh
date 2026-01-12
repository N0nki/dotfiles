#!/bin/sh

mkdir -p ~/.config

# wezterm
mkdir ~/.config/wezterm
ln -sf ~/dotfiles/common/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

# starship
ln -sf ~/dotfiles/common/starship/starship.toml ~/.config/starship.toml

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/common/tmux/.tmux.conf ~/.tmux.conf
# tmux-nerd-font-window-name config
mkdir -p ~/.config/tmux
ln -sf ~/dotfiles/common/tmux/tmux-nerd-font-window-name.yml ~/.config/tmux/tmux-nerd-font-window-name.yml

# zellij
mkdir ~/.config/zellij
ln -sf ~/dotfiles/common/zellij/zellij.kdl ~/.config/zellij/zellij.kdl

# pet
mkdir ~/.config/pet
ln -sf ~/dotfiles/common/pet/config.toml ~/.config/pet/config.toml
ln -sf ~/dotfiles/common/pet/my_snippet.toml ~/.config/pet/my_snippet.toml
touch ~/.config/pet/snippet.toml

# codex
mkdir -p ~/.codex
ln -sf ~/dotfiles/common/codex/config.toml ~/.codex/config.toml
ln -sf ~/dotfiles/common/codex/prompts ~/.codex/prompts

# claude
mkdir -p ~/.claude
ln -sf ~/dotfiles/common/claude/commands ~/.claude/commands
ln -sf ~/dotfiles/common/claude/scripts ~/.claude/scripts
ln -sf ~/dotfiles/common/claude/settings.json ~/.claude/settings.json

# python linters
ln -sf ~/dotfiles/common/python/pylintrc ~/.config/pylintrc
ln -sf ~/dotfiles/common/python/pycodestyle ~/.config/pycodestyle
ln -sf ~/dotfiles/common/python/flake8 ~/.config/flake8

# bookokrat (EPUB reader)
mkdir ~/.config/bookokrat
ln -sf ~/dotfiles/common/bookokrat/config.yaml ~/.config/bookokrat/config.yaml

# git global ignore
mkdir -p ~/.config/git
ln -sf ~/dotfiles/common/git/ignore ~/.config/git/ignore

# gitconfig
ln -sf ~/dotfiles/common/git/.gitconfig ~/.gitconfig
if [ ! -f ~/.gitconfig.local ]; then
  echo "Creating ~/.gitconfig.local..."
  cat >~/.gitconfig.local <<EOF
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
EOF
  echo "Please edit ~/.gitconfig.local to set your name and email"
fi

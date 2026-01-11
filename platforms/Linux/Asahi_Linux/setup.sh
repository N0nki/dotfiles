#!/bin/bash

# Fedora Asahi Linux Setup Script

set -eu

sudo dnf upgrade -y

sudo dnf install -y \
  snap \
  vim \
  gcc \
  ripgrep \
  go \
  shellcheck \
  shfmt \
  direnv

sudo ln -s /var/lib/snapd/snap /snap

# Install Neovim via snap
#
echo ""
echo "==> Installing Neovim..."
sudo snap install nvim --classic

# Install yq via snap
#
echo ""
echo "==> Installing yq..."
sudo snap install yq

#
# Install yamlfmt via snap
#
echo ""
echo "==> Installing yamlfmt..."
sudo snap install yamlfmt

#
# Install Starship prompt
#
echo ""
echo "==> Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Install Node.js via n
#
echo ""
echo "==> Installing Node.js..."
sudo dnf install -y npm
sudo npm i -g n
sudo n stable
sudo dnf remove -y npm

# Install prettier (markdown formatter)
#
echo ""
echo "==> Installing prettier..."
sudo npm i -g prettier

#
# Install tree-sitter-cli
#
echo ""
echo "==> Installing tree-sitter-cli..."
sudo npm i -g tree-sitter-cli

# Install fzf (fuzzy finder)
#
echo ""
echo "==> Installing fzf..."
if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all --no-update-rc
else
  echo "fzf already installed"
fi

# Run common/synbolic_link.sh
#
echo ""
echo "==> Running common/synbolic_link.sh..."
sh ~/dotfiles/common/synbolic_link.sh || true

#
# Setup Neovim configuration
#
echo ""
echo "==> Setting up Neovim..."
sh ~/dotfiles/common/nvim/setup_nvim.sh

#
# Link platform-unified .bashrc
#
echo ""
echo "==> Linking .bashrc..."
ln -sf ~/dotfiles/platforms/Linux/Asahi_Linux/.bashrc ~/.bashrc

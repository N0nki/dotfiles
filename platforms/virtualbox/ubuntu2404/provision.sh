#!/bin/bash
#
# VirtualBox Ubuntu 24.04 Provisioning Script
# Based on platforms/WSL2/setup_wsl2.sh
#
# This script sets up a development environment equivalent to WSL2,
# excluding Windows-specific configurations.
#

set -e # Exit on error
set -u # Exit on undefined variable

echo "========================================="
echo "Starting VirtualBox Ubuntu 24.04 Provisioning"
echo "========================================="

#
# Update package list and upgrade existing packages
#
echo ""
echo "==> Updating package list and upgrading packages..."
sudo apt update && sudo apt upgrade -y

#
# Install development and utility packages
#
echo ""
echo "==> Installing development packages..."
sudo apt install -y \
  build-essential \
  autoconf \
  libssl-dev \
  libyaml-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libncursesw5-dev \
  libffi-dev \
  libgmp-dev \
  liblzma-dev \
  uuid-dev \
  tk-dev \
  libgdbm-dev \
  libnss3-dev \
  libedit-dev \
  curl \
  xz-utils \
  ca-certificates \
  rustc \
  unzip \
  golang \
  libkrb5-dev \
  python3-dev \
  gcc \
  ripgrep \
  apt-transport-https \
  gnupg \
  jq \
  zip \
  shellcheck \
  shfmt \
  csvkit

echo "==> Package installation completed."

#
# Install Neovim via snap
#
echo ""
echo "==> Installing Neovim..."
sudo snap install nvim --classic

#
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

#
# Install pyenv
#
echo ""
echo "==> Installing pyenv..."
if [ ! -d ~/.pyenv ]; then
  curl -fsSL https://pyenv.run | bash
else
  echo "pyenv already installed, skipping."
fi

#
# Install rbenv
#
echo ""
echo "==> Installing rbenv..."
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  ~/.rbenv/bin/rbenv init
else
  echo "rbenv already installed"
fi

#
# Install ruby-build
#
echo ""
echo "==> Installing ruby-build..."
if [ ! -d "$(~/.rbenv/bin/rbenv root)/plugins/ruby-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)/plugins/ruby-build"
else
  echo "ruby-build already installed, updating..."
  git -C "$(~/.rbenv/bin/rbenv root)/plugins/ruby-build" pull
fi

#
# Install tfenv
#
echo ""
echo "==> Installing tfenv..."
if [ ! -d ~/.tfenv ]; then
  git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
else
  echo "tfenv already installed"
fi

#
# Install Node.js via n
#
echo ""
echo "==> Installing Node.js..."
sudo apt install -y npm
sudo npm i -g n
sudo n stable
sudo apt autoremove --purge -y npm

#
# Install prettier (markdown formatter)
#
echo ""
echo "==> Installing prettier..."
sudo npm i -g prettier

#
# Install rustup
#
echo ""
echo "==> Installing rustup..."
if [ ! -d ~/.cargo ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "rustup already installed, skipping."
fi

#
# Install stylua (Lua formatter)
#
echo ""
echo "==> Installing stylua..."
. "$HOME/.cargo/env"
cargo install stylua

#
# Install taplo (TOML formatter)
#
echo ""
echo "==> Installing taplo..."
curl -fsSL https://github.com/tamasfe/taplo/releases/latest/download/taplo-linux-x86_64.gz |
  gzip -d - | sudo install -m 755 /dev/stdin /usr/local/bin/taplo

#
# Install GitHub CLI
#
echo ""
echo "==> Installing GitHub CLI..."
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) &&
  sudo mkdir -p -m 755 /etc/apt/keyrings &&
  out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg &&
  cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
  sudo mkdir -p -m 755 /etc/apt/sources.list.d &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
  sudo apt update &&
  sudo apt install gh -y

#
# Clone dotfiles repository with submodules
#
echo ""
echo "==> Cloning dotfiles repository..."
if [ ! -d ~/dotfiles ]; then
  git clone --recurse-submodules https://github.com/N0nki/dotfiles.git ~/dotfiles
else
  echo "dotfiles already exists, skipping clone."
  echo "Updating submodules..."
  cd ~/dotfiles
  git submodule update --init --recursive
  cd ~
fi

#
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
# Link VirtualBox-specific .bashrc
#
echo ""
echo "==> Linking .bashrc (VirtualBox version)..."
ln -sf ~/dotfiles/platforms/virtualbox/ubuntu2404/.bashrc ~/.bashrc

#
# Source .bashrc to apply changes
#
echo ""
echo "==> Sourcing .bashrc..."
# Note: source won't work in non-interactive shell, but we document it for user
echo "Run 'source ~/.bashrc' after SSH login to apply changes."

echo ""
echo "========================================="
echo "VirtualBox Ubuntu 24.04 Provisioning Completed!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. SSH into the VM: vagrant ssh"
echo "  2. Configure git user info:"
echo "       vim ~/.gitconfig.local"
echo "       # Add your name and email"
echo "  3. Install tmux plugins:"
echo "       tmux"
echo "       # Press Ctrl-t I to install plugins"
echo "  4. Reload shell configuration:"
echo "       source ~/.bashrc"
echo ""

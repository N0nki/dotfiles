#!/bin/sh

# Update package list and upgrade existing packages
echo "Updating package list and upgrading packages..."
sudo apt update && sudo apt upgrade -y

# Install development and utility packages
echo "Installing packages..."
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
  shellcheck

echo "Package installation completed."

# Install Neovim via snap
echo "Installing Neovim..."
sudo snap install nvim --classic

# Install Starship prompt
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# Link shell configuration
echo "Linking shell configuration..."
ln -sf ~/dotfiles/WSL2/.bashrc ~/.bashrc

echo "WSL2 setup completed!"

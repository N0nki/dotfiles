#!/bin/bash
#
# Ubuntu Setup Script (WSL2 & VirtualBox compatible)
# Location: platforms/Linux/Ubuntu/setup.sh
#
# This script automatically detects the platform (WSL2 or native Linux)
# and sets up a development environment accordingly.
#

set -eu

export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical

# Detect platform
if [ -n "${WSL_DISTRO_NAME:-}" ]; then
  PLATFORM="wsl2"
  echo "========================================="
  echo "Starting WSL2 Ubuntu Setup"
  echo "Distribution: $WSL_DISTRO_NAME"
  echo "========================================="
else
  PLATFORM="native"
  echo "========================================="
  echo "Starting Ubuntu Setup (Native Linux)"
  echo "========================================="
fi

#
# Update package list and upgrade existing packages
#
echo ""
echo "==> Updating package list and upgrading packages..."
sudo -E apt update && sudo -E apt upgrade -y

#
# Install development and utility packages
#
echo ""
echo "==> Installing development packages..."
sudo -E apt install -y \
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
  unzip \
  golang \
  libkrb5-dev \
  python3-dev \
  python3-venv \
  gcc \
  ripgrep \
  apt-transport-https \
  gnupg \
  jq \
  zip \
  shellcheck \
  shfmt \
  csvkit \
  direnv

echo "==> Package installation completed."

#
# Install fastfetch
#
echo ""
echo "==> Installing fastfetch..."
sudo -E add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo -E apt update
sudo -E apt install fastfetch -y

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

echo ""
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

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
sudo -E apt install -y npm
sudo npm i -g n
sudo n stable
sudo -E apt autoremove --purge -y npm

#
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
(type -p wget >/dev/null || (sudo -E apt update && sudo -E apt install wget -y)) &&
  sudo mkdir -p -m 755 /etc/apt/keyrings &&
  out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg &&
  cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
  sudo mkdir -p -m 755 /etc/apt/sources.list.d &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
  sudo -E apt update &&
  sudo -E apt install gh -y

#
# Install pet (command snippet manager)
#
echo ""
echo "==> Installing pet..."
export PATH="$HOME/go/bin:$PATH"
go install github.com/knqyf263/pet@latest

#
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

#
# Clone dotfiles repository with submodules
#
echo ""
echo "==> Setting up dotfiles..."
if [ ! -d ~/dotfiles ]; then
  echo "Cloning dotfiles repository..."
  git clone --recurse-submodules https://github.com/N0nki/dotfiles.git ~/dotfiles
else
  echo "dotfiles already exists"
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
# Link platform-unified .bashrc
#
echo ""
echo "==> Linking .bashrc..."
ln -sf ~/dotfiles/platforms/Linux/Ubuntu/.bashrc ~/.bashrc

echo ""
echo "========================================="
echo "Ubuntu Setup Completed!"
echo "Platform: $PLATFORM"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Configure git user info:"
echo "       vim ~/.gitconfig.local"
echo "  2. Install tmux plugins:"
echo "       tmux"
echo "       # Press Ctrl-t I"
echo "  3. Reload shell:"
echo "       source ~/.bashrc"
echo ""

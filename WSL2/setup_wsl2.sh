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

# Install yq via snap
echo "Installing yq..."
sudo snap install yq

# Install Starship prompt
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# Install pyenv
echo "Installing pyenv..."
curl -fsSL https://pyenv.run | bash

# Install rbenv
echo "Installing rbenv..."
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  ~/.rbenv/bin/rbenv init
else
  echo "rbenv already installed"
fi

# Install ruby-build
echo "Installing ruby-build..."
if [ ! -d "$(~/.rbenv/bin/rbenv root)/plugins/ruby-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)/plugins/ruby-build"
else
  echo "ruby-build already installed, updating..."
  git -C "$(~/.rbenv/bin/rbenv root)/plugins/ruby-build" pull
fi

# Install tfenv
echo "Installing tfenv..."
if [ ! -d ~/.tfenv ]; then
  git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
else
  echo "tfenv already installed"
fi

# Install Node.js via n
echo "Installing Node.js..."
sudo apt install -y npm
sudo npm i -g n
sudo n stable
sudo apt autoremove --purge -y npm

# Install rustup
echo "Installing rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install GitHub CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# Link shell configuration
echo "Linking shell configuration..."
ln -sf ~/dotfiles/WSL2/.bashrc ~/.bashrc

echo "WSL2 setup completed!"

#!/bin/sh

#
# Check if Xcode.app is installed
# Xcode is required for Git and other development tools.
# If Xcode is not installed, install it from the App Store before running this script.
#
if [ ! -d "/Applications/Xcode.app" ]; then
  echo "Error: Xcode.app is not installed."
  echo "Please install Xcode from the App Store first."
  exit 1
fi

git clone --recurse-submodules https://github.com/N0nki/dotfiles.git ~/dotfiles

ln -sf ~/dotfiles/platforms/macOS/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/platforms/macOS/.bashrc ~/.bashrc
ln -sf ~/dotfiles/platforms/macOS/.zprofile ~/.zprofile
ln -sf ~/dotfiles/platforms/macOS/.zshrc ~/.zshrc
ln -sf ~/dotfiles/platforms/macOS/.latexmkrc ~/.latexmkrc
ln -sf ~/dotfiles/platforms/macOS/.xvimrc ~/.xvimrc
ln -sf ~/dotfiles/platforms/macOS/.vrapperrc ~/.vrapperrc
ln -sf ~/dotfiles/platforms/macOS/.xvimrc ~/.xvimrc

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle --file=~/dotfiles/platforms/macOS/Brewfile

sh ~/dotfiles/common/synbolic_link.sh
sh ~/dotfiles/common/nvim/setup_nvim.sh

if [ ! -e ~/.config/ghostty ]; then
  mkdir -p ~/.config/ghostty
fi
ln -sf ~/dotfiles/platforms/macOS/ghostty/config ~/.config/ghostty/config
sh ~/dotfiles/platforms/macOS/defaults.sh
softwareupdate --install-rosetta --agree-to-license

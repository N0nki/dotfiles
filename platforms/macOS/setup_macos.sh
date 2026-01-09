#!/bin/sh
#
# macOS Setup Script
#
# Prerequisites:
#   - Xcode.app installed
#   - dotfiles repository cloned to ~/dotfiles
#
# For fresh install, use bootstrap.sh instead:
#   curl -fsSL https://raw.githubusercontent.com/N0nki/dotfiles/master/platforms/macOS/bootstrap.sh | sh
#

set -e

DOTFILES_DIR="$HOME/dotfiles"

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: dotfiles directory not found at $DOTFILES_DIR"
    echo "Please clone the repository first, or use bootstrap.sh:"
    echo "  curl -fsSL https://raw.githubusercontent.com/N0nki/dotfiles/master/platforms/macOS/bootstrap.sh | sh"
    exit 1
fi

ln -sf "$DOTFILES_DIR/platforms/macOS/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES_DIR/platforms/macOS/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/platforms/macOS/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/platforms/macOS/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/platforms/macOS/.latexmkrc" ~/.latexmkrc
ln -sf "$DOTFILES_DIR/platforms/macOS/.xvimrc" ~/.xvimrc
ln -sf "$DOTFILES_DIR/platforms/macOS/.vrapperrc" ~/.vrapperrc

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install
fi

# Install Homebrew if not installed
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Setup Homebrew PATH (needed for fresh install on Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle --verbose --file="$DOTFILES_DIR/platforms/macOS/Brewfile"

# Run common setup scripts
sh "$DOTFILES_DIR/common/synbolic_link.sh"
sh "$DOTFILES_DIR/common/nvim/setup_nvim.sh"

# Setup ghostty config
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/platforms/macOS/ghostty/config" ~/.config/ghostty/config

# Apply macOS defaults
sh "$DOTFILES_DIR/platforms/macOS/defaults.sh"

# Install Rosetta 2 for Apple Silicon
softwareupdate --install-rosetta --agree-to-license

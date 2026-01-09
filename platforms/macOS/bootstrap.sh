#!/bin/sh
#
# macOS Bootstrap Script
#
# Usage:
#   curl -fsSO https://raw.githubusercontent.com/N0nki/dotfiles/master/platforms/macOS/bootstrap.sh && sh bootstrap.sh
#
# This script:
#   1. Checks for Xcode.app
#   2. Clones dotfiles repository
#   3. Runs the main setup script
#

set -e

DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_REPO="https://github.com/N0nki/dotfiles.git"

# Check if Xcode.app is installed
if [ ! -d "/Applications/Xcode.app" ]; then
  echo "Error: Xcode.app is not installed."
  echo "Please install Xcode from the App Store first."
  exit 1
fi

# Clone dotfiles if not already present
if [ -d "$DOTFILES_DIR" ]; then
  echo "dotfiles directory already exists at $DOTFILES_DIR"
  echo "Pulling latest changes..."
  cd "$DOTFILES_DIR"
  git pull --recurse-submodules
  git submodule update --init --recursive
else
  echo "Cloning dotfiles..."
  git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Run main setup script
echo "Running setup script..."
sh "$DOTFILES_DIR/platforms/macOS/setup_macos.sh"

echo ""
echo "Bootstrap complete!"

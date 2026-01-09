#!/bin/sh
#
# macOS Uninstall Script
#
# Removes symbolic links and directories created by setup_macos.sh
#
# Note: This script does NOT uninstall:
#   - Rosetta 2
#   - macOS defaults changes
#

set -e

echo "This will remove all dotfiles symbolic links."
echo "Press Enter to continue or Ctrl+C to cancel..."
read -r _

# Ask about Homebrew uninstall
echo ""
echo "Do you also want to uninstall Homebrew? (y/N)"
read -r UNINSTALL_HOMEBREW

echo "Removing symbolic links..."

# === setup_macos.sh ===
rm -f ~/.bash_profile
rm -f ~/.bashrc
rm -f ~/.zprofile
rm -f ~/.zshrc
rm -f ~/.latexmkrc
rm -f ~/.xvimrc
rm -f ~/.vrapperrc
rm -f ~/.config/ghostty/config
rmdir ~/.config/ghostty 2>/dev/null || true

# === common/synbolic_link.sh ===
# starship
rm -f ~/.config/starship.toml

# tmux
rm -f ~/.tmux.conf
rm -f ~/.config/tmux/tmux-nerd-font-window-name.yml
rmdir ~/.config/tmux 2>/dev/null || true
rm -rf ~/.tmux/plugins/tpm
rmdir ~/.tmux/plugins 2>/dev/null || true
rmdir ~/.tmux 2>/dev/null || true

# zellij
rm -f ~/.config/zellij/zellij.kdl
rmdir ~/.config/zellij 2>/dev/null || true

# pet
rm -f ~/.config/pet/config.toml
rm -f ~/.config/pet/my_snippet.toml
rm -f ~/.config/pet/snippet.toml
rmdir ~/.config/pet 2>/dev/null || true

# codex
rm -f ~/.codex/config.toml
rm -f ~/.codex/prompts
rmdir ~/.codex 2>/dev/null || true

# claude
rm -f ~/.claude/commands
rm -f ~/.claude/scripts
rm -f ~/.claude/settings.json
# Note: ~/.claude/ may contain other files, so don't rmdir

# python linters
rm -f ~/.config/pylintrc
rm -f ~/.config/pycodestyle
rm -f ~/.config/flake8

# bookokrat
rm -f ~/.bookokrat_settings.yaml

# git
rm -f ~/.config/git/ignore
rmdir ~/.config/git 2>/dev/null || true
rm -f ~/.gitconfig
# Note: ~/.gitconfig.local is preserved (contains user-specific settings)

# === common/nvim/setup_nvim.sh ===
rm -f ~/.config/nvim/init.lua
rm -f ~/.config/nvim/lua
rm -f ~/.config/nvim/ftplugin
rm -f ~/.config/nvim/snippets
rm -f ~/.config/nvim/vsnippets
rmdir ~/.config/nvim 2>/dev/null || true

# Uninstall Homebrew if requested
if [ "$UNINSTALL_HOMEBREW" = "y" ] || [ "$UNINSTALL_HOMEBREW" = "Y" ]; then
    echo ""
    echo "Uninstalling Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

echo ""
echo "Uninstall complete!"
echo ""
echo "Note: The following were NOT removed:"
echo "  - ~/.gitconfig.local (contains your name/email)"
echo "  - Rosetta 2"
echo "  - macOS defaults changes"
echo "  - ~/.claude/ directory (may contain session data)"

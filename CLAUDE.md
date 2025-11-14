# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files and setup scripts for development environments across multiple platforms (macOS, WSL2, Windows).

## Architecture

### Platform-Specific Configuration Structure

The repository is organized by platform with shared common configurations:

- **macOS/**: macOS-specific shell configs (.bash_profile, .bashrc, .zshrc), Brewfile for package management, macOS system defaults, and application configs (ghostty, iTerm)
- **WSL2/**: Windows Subsystem for Linux configuration (.bashrc)
- **windows/**: Windows-specific configs (AutoHotkey scripts)
- **common/**: Shared cross-platform configurations (git, tmux, starship, zellij, pet)
- **nvim/**: Neovim configuration using lazy.nvim plugin manager
- **vim/**: Legacy vim configuration using dein.vim plugin manager
- **python/**: Python linting and code style configurations (pylintrc, pycodestyle, flake8)

### Neovim Configuration Architecture

The Neovim setup (nvim/) uses a modular Lua-based configuration:

- **init.lua**: Entry point that requires "init" module
- **lua/init.lua**: Main loader that conditionally loads neovide, keymap, options, and plugins
- **lua/plugins.lua**: Central plugin declaration using lazy.nvim (190+ plugins)
- **lua/pluginconfig/**: Individual plugin configurations (20+ files)
- **lua/keymap.lua**: Key mappings
- **lua/options.lua**: Vim options
- **ftplugin/**: Filetype-specific configurations
- **snippets/** and **vsnippets/**: Code snippet definitions

Key plugin categories in nvim:
- LSP: nvim-lspconfig, mason.nvim, mason-lspconfig.nvim
- Treesitter: nvim-treesitter with rainbow and context plugins
- Completion: nvim-cmp with multiple sources (path, buffer, lsp, treesitter, emoji)
- Telescope: Fuzzy finder with file browser
- Git: fugitive, gitsigns, diffview
- UI: lualine, bufferline, colorschemes (tokyonight, kanagawa, nightfox, etc.)

### Setup Scripts

Each platform/component has a setup script that creates symbolic links:

- **dotfilesLink.sh**: Top-level orchestrator (runs macOS, vim, nvim setup)
- **macOS/setup_macos.sh**: Links shell configs, sets up ghostty, runs defaults.sh
- **WSL2/setup_wsl2.sh**: Links WSL2-specific .bashrc
- **nvim/setup_nvim.sh**: Links nvim config directory structure
- **vim/setup_vim.sh**: Installs dein.vim and links vim configs
- **common/synbolic_link.sh**: Links shared tools (starship, tmux, zellij, pet, gitconfig)
- **python/symbolic_link.sh**: Links Python linter configs

## Common Development Commands

### Initial Setup

```bash
# Run main setup script (macOS)
sh ~/dotfiles/dotfilesLink.sh

# Setup specific components
sh ~/dotfiles/common/synbolic_link.sh  # Cross-platform tools
sh ~/dotfiles/nvim/setup_nvim.sh       # Neovim only
sh ~/dotfiles/WSL2/setup_wsl2.sh       # WSL2 only
sh ~/dotfiles/python/symbolic_link.sh  # Python tools

# macOS package installation
cd ~/dotfiles/macOS
brew bundle  # Install all packages from Brewfile
```

### Git Configuration

The gitconfig requires a local user config file:

```bash
# After running setup, edit ~/.gitconfig.local
cat ~/.gitconfig.local
# Add your name and email:
# [user]
#   name = YOUR_NAME
#   email = YOUR_EMAIL
```

Custom git alias available:
- `git wta {branch}`: Create a git worktree with sanitized directory name

### Neovim Plugin Management

Neovim uses lazy.nvim for plugin management:

```bash
# Plugins auto-install on first launch
# To manually update plugins:
:Lazy sync

# Treesitter parsers:
:TSUpdate

# LSP server management via Mason:
:Mason
```

## File Modification Guidelines

### When Modifying Neovim Configuration

- Plugin additions/changes go in **nvim/lua/plugins.lua**
- Plugin-specific configs go in **nvim/lua/pluginconfig/{plugin-name}.lua**
- General keymaps in **nvim/lua/keymap.lua**
- Vim options in **nvim/lua/options.lua**
- Neovide-specific settings in **nvim/lua/neovide.lua**

### When Modifying Setup Scripts

- Setup scripts use symbolic links (`ln -sf`), not copies
- Always check if target directory exists before linking
- Follow the pattern of creating parent directories with `mkdir -p`

### Git Workflow

- Default branch is `main` (configured in .gitconfig)
- Git editor is set to `vim`
- Excludes file: `~/.config/git/ignore`

## Important Notes

- The nvim config is actively maintained; vim config is legacy
- Some plugins in nvim/lua/plugins.lua are disabled (`enabled = false`)
- macOS setup includes system defaults via defaults.sh and Rosetta installation
- Common tools (tmux, starship, zellij) require separate installation via package manager
- Pet (command snippet manager) config expects tpm (tmux plugin manager) to be cloned

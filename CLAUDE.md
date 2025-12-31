# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files and setup scripts for development environments across multiple platforms (macOS, WSL2, Windows).

## Architecture

### Platform-Specific Configuration Structure

The repository is organized by platform with shared common configurations:

- **platforms/macOS/**: macOS-specific shell configs (.bash_profile, .bashrc, .zshrc), Brewfile for package management, macOS system defaults, and application configs (ghostty, iTerm)
- **platforms/WSL2/**: Windows Subsystem for Linux configuration (.bashrc)
- **platforms/windows/**: Windows-specific configs (AutoHotkey scripts)
- **common/**: Shared cross-platform configurations (git, tmux, starship, zellij, pet, nvim, vim, python)
- **common/nvim/**: Neovim configuration using lazy.nvim plugin manager (cross-platform)
- **common/vim/**: Legacy vim configuration using dein.vim plugin manager (cross-platform)
- **common/python/**: Python linting and code style configurations (pylintrc, pycodestyle, flake8)

### Neovim Configuration Architecture

The Neovim setup (nvim/) uses a modular Lua-based configuration:

- **init.lua**: Entry point that requires "init" module
- **lua/init.lua**: Main loader that conditionally loads neovide, keymap, options, and plugins
- **lua/plugins.lua**: Central plugin declaration using lazy.nvim (~100 plugins)
- **lua/pluginconfig/**: Individual plugin configurations (~40 files)
- **lua/keymap.lua**: Key mappings
- **lua/options.lua**: Vim options
- **ftplugin/**: Filetype-specific configurations
- **snippets/** and **vsnippets/**: Code snippet definitions

Key plugin categories in nvim:

- LSP: nvim-lspconfig, mason.nvim, mason-lspconfig.nvim, conform.nvim (formatter)
- Treesitter: nvim-treesitter with rainbow-delimiters and context plugins
- Completion: nvim-cmp with multiple sources (path, buffer, lsp, treesitter, emoji)
- Telescope: Fuzzy finder with file browser
- Git: fugitive, gitsigns, diffview
- UI: lualine, colorschemes (tokyonight, kanagawa, nightfox, iceberg, etc.)

### Setup Scripts

Each platform/component has a setup script that creates symbolic links:

- **dotfilesLink.sh**: Top-level orchestrator (runs macOS setup, then common/synbolic_link.sh)
- **platforms/macOS/setup_macos.sh**: Links shell configs, sets up ghostty, runs defaults.sh
- **platforms/WSL2/setup_wsl2.sh**: Links WSL2-specific .bashrc
- **common/nvim/setup_nvim.sh**: Links nvim config directory structure
- **common/vim/setup_vim.sh**: Installs dein.vim and links vim configs
- **common/synbolic_link.sh**: Links shared tools (starship, tmux, zellij, pet, git, nvim, vim, python)
- **common/python/symbolic_link.sh**: Links Python linter configs

## Common Development Commands

### Initial Setup

```bash
# Clone with submodules (important!)
git clone --recurse-submodules https://github.com/N0nki/dotfiles.git

# Or if already cloned without submodules:
cd ~/dotfiles
git submodule init
git submodule update

# Run main setup script (macOS)
sh ~/dotfiles/dotfilesLink.sh

# Setup specific components
sh ~/dotfiles/common/synbolic_link.sh  # Cross-platform tools (includes nvim, vim)
sh ~/dotfiles/common/nvim/setup_nvim.sh       # Neovim only
sh ~/dotfiles/platforms/WSL2/setup_wsl2.sh    # WSL2 only
sh ~/dotfiles/common/python/symbolic_link.sh  # Python tools

# macOS package installation
cd ~/dotfiles/platforms/macOS
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

### Git Submodules

This repository uses git submodules for external dependencies:

```bash
# Update submodules to latest versions
cd ~/dotfiles
git submodule update --remote common/fzf-git
git add common/fzf-git
git commit -m "update fzf-git submodule"
```

Current submodules:

- **common/fzf-git**: [junegunn/fzf-git.sh](https://github.com/junegunn/fzf-git.sh) - Git branch/commit/tag selection with fzf

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

### tmux-op-secure (1Password Integration)

Standalone TPM plugin for secure 1Password integration without token files.

**Repository:**

- Development: `/Users/n0nki/repos/tmux-op-secure/`
- GitHub: https://github.com/N0nki/tmux-op-secure
- Local copy for development: `common/tmux-op-secure/`

**Installation:**

TPM (recommended for public use):

```bash
set -g @plugin 'N0nki/tmux-op-secure'
```

Manual (current dotfiles setup):

```bash
run-shell ~/.tmux/plugins/tmux-op-secure/op-secure.tmux
```

**Key bindings:**

- `prefix + u`: Retrieve password from 1Password (default: `Ctrl-t u`)
- `prefix + o`: Retrieve OTP/2FA code from 1Password (default: `Ctrl-t o`)

**Features:**

- No token files (uses biometric authentication on every access)
- fzf integration for item selection
- Clipboard auto-clear (30s for passwords, 10s for OTP)
- Cache support for faster item listing
- tmux popup display
- Customizable key bindings
- Feature toggles (can disable password or OTP individually)
- Configurable popup dimensions

**Configuration:** `common/tmux/.tmux.conf`

Basic configuration:

```bash
set -g @1password-copy-to-clipboard 'on'
set -g @1password-auto-clear-seconds '30'
set -g @1password-otp-auto-clear-seconds '10'
set -g @1password-categories 'Login'
set -g @1password-use-cache 'on'
set -g @1password-cache-age '0'  # 0 = never expire
```

New customization options:

```bash
# Feature toggles
set -g @1password-password-enable 'on'  # Enable/disable password feature
set -g @1password-otp-enable 'on'       # Enable/disable OTP feature

# Custom key bindings
set -g @1password-key 'P'               # Custom password key
set -g @1password-otp-key 'O'           # Custom OTP key

# Popup dimensions
set -g @1password-popup-width '90%'
set -g @1password-popup-height '70%'
```

**Requirements:**

- 1Password CLI v2 (op.exe on WSL2, op on macOS)
- fzf
- jq
- Clipboard command (clip.exe/pbcopy/xclip)

**Files:**

- `common/tmux-op-secure/op-secure.tmux`: Plugin entry point (renamed from plugin.tmux)
- `common/tmux-op-secure/scripts/variables.sh`: Configuration management
- `common/tmux-op-secure/scripts/main.sh`: Password retrieval script
- `common/tmux-op-secure/scripts/otp.sh`: OTP retrieval script
- `common/tmux-op-secure/README.md`: Full documentation

See full documentation: https://github.com/N0nki/tmux-op-secure

### fzf-git Integration

Git object selection with fzf, integrated via git submodule:

**Key bindings:**

- `Ctrl-G ?`: Show all available bindings
- `Ctrl-G Ctrl-B`: Select git branches
- `Ctrl-G Ctrl-H`: Select commit hashes
- `Ctrl-G Ctrl-T`: Select tags
- `Ctrl-G Ctrl-F`: Select files
- `Ctrl-G Ctrl-R`: Select remotes
- `Ctrl-G Ctrl-S`: Select stashes
- `Ctrl-G Ctrl-L`: Select reflog entries
- `Ctrl-G Ctrl-W`: Select worktrees

**Usage examples:**

```bash
git checkout <Ctrl-G Ctrl-B>  # Checkout branch
git show <Ctrl-G Ctrl-H>      # Show commit
git cherry-pick <Ctrl-G Ctrl-H>  # Cherry-pick commit
```

**Configuration:**

- Sourced in `platforms/WSL2/.bashrc`, `platforms/macOS/.bashrc`, and `platforms/macOS/.zshrc`
- Automatically uses tmux popup when inside tmux (90% × 70%)
- Multi-selection with TAB/Shift-TAB

**Submodule location:** `common/fzf-git/`

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
- **Always clone with `--recurse-submodules`** to include fzf-git and other submodules
- tmux-op-secure requires 1Password CLI v2 and biometric authentication enabled
- fzf-git key bindings may conflict with tmux prefix if using `Ctrl-B` (this repo uses `Ctrl-T`)

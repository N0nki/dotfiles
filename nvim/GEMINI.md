# Neovim Configuration Overview

This directory contains the configuration for Neovim, managed in Lua with `lazy.nvim` as the plugin manager.

## Architecture

The configuration is structured in a modular way:

- **`init.lua`**: The main entry point, which simply loads `lua/init.lua`.
- **`lua/init.lua`**: The core configuration file that loads all other necessary modules, including options, keymaps, and plugins.
- **`lua/plugins.lua`**: This file defines all the plugins used in the configuration. It uses `lazy.nvim` to manage them.
- **`lua/pluginconfig/`**: Contains individual configuration files for many of the plugins listed in `plugins.lua`. This keeps the main plugin file clean and organized.
- **`lua/keymap.lua`**: Defines custom key mappings.
- **`lua/options.lua`**: Sets Neovim's global options.
- **`ftplugin/`**: Contains filetype-specific configurations.
- **`snippets/` & `vsnippets/`**: Store code snippets.

## Plugin Management with `lazy.nvim`

This configuration uses `lazy.nvim` to manage plugins. The setup is declared in `lua/plugins.lua`.

- **Installation**: Plugins are automatically installed when Neovim is started for the first time.
- **Updating**: You can update plugins by running `:Lazy sync` within Neovim.

### Key Plugins

The setup includes a wide range of plugins for a modern development experience:

- **LSP & Linting**: `neovim/nvim-lspconfig`, `williamboman/mason.nvim`, and `williamboman/mason-lspconfig.nvim` for managing language servers.
- **Code Completion**: `hrsh7th/nvim-cmp` with various sources for completion suggestions.
- **Treesitter**: `nvim-treesitter/nvim-treesitter` for advanced syntax highlighting and code analysis.
- **Fuzzy Finding**: `nvim-telescope/telescope.nvim` for quickly finding files, buffers, and more.
- **UI Enhancements**: `nvim-lualine/lualine.nvim` for a custom statusline, `akinsho/bufferline.nvim` for a tab-like buffer line, and multiple colorschemes like `tokyonight.nvim` and `kanagawa.nvim`.
- **Git Integration**: `tpope/vim-fugitive` and `lewis6991/gitsigns.nvim` for seamless Git operations within Neovim.
- **Terminal**: `akinsho/toggleterm.nvim` for managing terminal windows inside Neovim.

## Setup

The `setup_nvim.sh` script in this directory creates symbolic links from the files in this repository to the Neovim configuration directory (`~/.config/nvim`).

```sh
# To set up the Neovim configuration
sh ./setup_nvim.sh
```

This ensures that any changes made to the files in this repository are immediately reflected in your Neovim setup.

# Neovim Configuration Guidelines

## Directory Notes
- `init.lua` boots Neovim and requires `lua/init.lua`.
- `lua/` houses `init.lua`, `plugins.lua`, `pluginconfig/*`, and helper modules.
- `ftplugin/` stores language overrides; `snippets/` & `vsnippets/` back `vim-vsnip`.
- `setup_nvim.sh` and `uninstall_nvim_settings.sh` manage symlinks and cleanup.

## Required Workflow
1. Run `sh nvim/setup_nvim.sh` after editing config files so `~/.config/nvim` mirrors repo state.
2. Validate plugin state via `nvim --headless "+Lazy sync" +qall` followed by `nvim --headless "+checkhealth" +qall`.
3. Smoke test edited filetypes by opening buffers tied to `ftplugin/`.

## Coding Style
- Lua files use two-space indentation and stick to module paths that mirror filenames (e.g. `pluginconfig/nvim-tree.lua`).
- Shell scripts remain POSIX `#!/bin/sh`, rely on `mkdir -p` and `ln -sf`, and keep two-space indents.

## Review Checklist
- GUI-specific tweaks must sit behind `if vim.g.neovide` guards in `neovide.lua`.
- Touching plugins or configs demands a follow-up `:Lazy sync`.
- Keep generated files (e.g. `~/.gitconfig.local`) out of commits; write commit titles as short imperatives.

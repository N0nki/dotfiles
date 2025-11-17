# Repository Guidelines

## Project Structure & Module Organization
Platform-specific directories keep responsibilities isolated: `common/` hosts shared dotfiles (starship, tmux, zellij, git), `macOS/`, `windows/`, and `WSL2/` track OS defaults, while `vim/` and `nvim/` house the editor configs. `dotfilesLink.sh` chains every `setup*.sh` so symlinks stay authoritative, Python lints live in `python/`, and assets (pet snippets, Ghostty themes) stay beside the scripts that install them.

## Build, Test, and Development Commands
- `sh dotfilesLink.sh`: run the bootstrap (macOS defaults, Vim, Atom, Neovim) from a clean login shell.
- `sh macOS/setup_macos.sh`: relink shell profiles, Ghostty settings, defaults, and Rosetta after edits to `macOS/`.
- `sh common/synbolic_link.sh` & `sh python/symbolic_link.sh`: reapply shared configs (starship, tmux, pet, gitconfig, `python/{flake8,pycodestyle,pylintrc}`) idempotently.
- `sh nvim/setup_nvim.sh`: mirror `nvim/` into `~/.config/nvim` before validating Neovim updates.

## Neovim Configuration Notes
`nvim/init.lua` loads `nvim/lua/init.lua`, which stitches together `neovide.lua`, `keymap.lua`, `options.lua`, and the plugin graph. `nvim/lua/plugins.lua` bootstraps lazy.nvim, and each dependency has a sibling in `nvim/lua/pluginconfig/<name>.lua`. Language overrides live in `nvim/ftplugin/*.lua`, while snippets stay in `snippets/` and `vsnippets/` for `vim-vsnip`. After touching plugins, configs, or filetype hooks, run `:Lazy sync` (or `nvim --headless "+Lazy sync" +qall`), follow with `nvim --headless "+checkhealth" +qall`, and leave GUI-only tweaks inside `neovide.lua`'s `if vim.g.neovide` guard.
Each plugin managed by lazy.nvim lives under `/home/kinno/.local/share/nvim/lazy/`; inspect files there if upstream defaults are unclear.

## Coding Style & Naming Conventions
Shell scripts stay in POSIX `#!/bin/sh`, use two-space indentation, and rely on `ln -sf` + `mkdir -p` so reruns stay safe. Lua modules mirror that indentation, align filenames with their `require` path (`pluginconfig/nvim-tree.lua`), and route leader mappings through `keymap.lua`. Python code keeps snake_case identifiers and follows the rules baked into `python/flake8`, `python/pycodestyle`, and `python/pylintrc`.

## Testing Guidelines
Exercise installers from a stripped environment (`env -i zsh --login`) to surface missing env vars, then confirm symlinks with `ls -l ~/.config/<tool>` so they point back to `~/dotfiles`. For Neovim work, run `sh nvim/setup_nvim.sh`, `nvim --headless "+Lazy sync" "+checkhealth" +qall`, and open the filetypes mentioned in `ftplugin/` for a smoke test. Shell scripts should pass `shellcheck`, and macOS defaults deserve a `defaults read <domain> <key>` audit.

## Commit & Pull Request Guidelines
History favors short, imperative subjects (`add CLAUDE.md`, `nvim: trim cmp menu`), so keep each change focused and scoped. PR descriptions should explain the motivation, list which setup scripts were rerun, and include terminal snippets or screenshots for UI tweaks; keep generated files such as `~/.gitconfig.local` out of commits and link issues when relevant.

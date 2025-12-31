# CLAUDE.md - Vim Configuration (Legacy)

This file provides guidance to Claude Code (claude.ai/code) when working with Vim configuration in this directory.

**Note**: This is a legacy configuration in `common/vim/` (cross-platform). The primary development environment has moved to `common/nvim/` (Neovim with lazy.nvim). This Vim configuration is maintained for reference and compatibility purposes.

## Configuration Architecture

This Vim configuration uses dein.vim as the plugin manager with a modular file structure.

### Entry Point Flow

```
.vimrc
  ├─> options.rc.vim       # Vim options
  ├─> keymap.rc.vim        # Key mappings
  └─> plugins/dein.rc.vim  # Plugin manager initialization
       ├─> ~/.dein.toml       # Normal plugins
       └─> ~/.dein_lazy.toml  # Lazy-loaded plugins
            └─> plugins/*.rc.vim  # Individual plugin configs
```

### Directory Structure

```
vim/
├── .vimrc                    # Entry point
├── .gvimrc                   # GVim settings
├── keymap.rc.vim             # Key mappings
├── options.rc.vim            # Vim options
├── .dein.toml                # Plugin definitions (always loaded)
├── .dein_lazy.toml           # Plugin definitions (lazy loaded)
├── plugins/                  # Plugin configurations
│   ├── dein.rc.vim           # dein.vim setup
│   ├── airline.rc.vim        # Status line
│   ├── ale.rc.vim            # Async linter
│   ├── defx.rc.vim           # File explorer
│   ├── deoplete.rc.vim       # Auto completion
│   ├── fzf-vim.rc.vim        # Fuzzy finder
│   ├── vim-lsp.rc.vim        # LSP client
│   └── ...                   # Other plugin configs
├── setup_vim.sh              # Setup script (Linux/macOS)
├── setup_vim.bat             # Setup script (Windows)
├── synbolic_links.sh         # Symlink creation script
└── old/                      # Legacy/archived configs
```

## Plugin Management

### dein.vim

Plugins are managed by dein.vim with TOML-based configuration files.

**Plugin installation location:**

- All plugins are installed in `~/.cache/dein/`
- Configuration files: `~/.dein.toml` (normal) and `~/.dein_lazy.toml` (lazy)

**Commands:**

- `:call dein#install()` - Install plugins
- `:call dein#update()` - Update plugins
- `:CleanPlugins` - Remove unused plugins (custom command)

### Key Plugin Categories

| Category          | Plugins                                |
| ----------------- | -------------------------------------- |
| **Completion**    | deoplete.nvim, deoplete-vim-lsp        |
| **LSP**           | vim-lsp, vim-lsp-settings              |
| **Linter**        | ale                                    |
| **File Explorer** | defx.nvim (primary), vimfiler (legacy) |
| **Fuzzy Finder**  | fzf.vim, denite.nvim, unite.vim        |
| **Git**           | vim-fugitive, vim-gitgutter, gv.vim    |
| **Status Line**   | vim-airline                            |
| **Colorschemes**  | iceberg, gruvbox, nord, kanagawa       |

### Language Support

| Language  | Plugin            | Load Condition |
| --------- | ----------------- | -------------- |
| Go        | vim-go            | `.go` files    |
| Terraform | vim-terraform     | terraform/json |
| LaTeX     | vimtex            | `.tex` files   |
| Markdown  | vim-markdown      | markdown       |
| Python    | deoplete, vim-lsp | Always         |

## Key Mappings

### Leader Key

Leader is `\` (default)

### Basic Mappings

| Key         | Mode          | Action                   |
| ----------- | ------------- | ------------------------ |
| `jj`        | Insert        | Escape                   |
| `Ctrl-q`    | Insert/Visual | Escape                   |
| `Esc Esc`   | Normal        | Clear search highlight   |
| `Ctrl-hjkl` | Normal        | Window navigation        |
| `Tab`       | Normal        | Jump to matching bracket |

### Window/Tab Management

| Key     | Action            |
| ------- | ----------------- |
| `ss`    | Horizontal split  |
| `sv`    | Vertical split    |
| `st`    | New tab           |
| `gb`    | Previous tab      |
| `gn/gp` | Next/previous tab |
| `sc`    | Close tab         |

### Plugin Mappings

| Key         | Plugin     | Action                        |
| ----------- | ---------- | ----------------------------- |
| `Leader-e`  | defx       | Open file explorer (IDE mode) |
| `Leader-t`  | defx       | Open file explorer (floating) |
| `Leader-df` | fzf        | File search                   |
| `Leader-da` | fzf        | Ag search                     |
| `Leader-db` | fzf        | Buffer search                 |
| `Leader-r`  | quickrun   | Run code                      |
| `Leader-lt` | ale        | Toggle linter                 |
| `Leader-s`  | easymotion | Word search                   |

### Clipboard (with Space prefix)

| Key       | Action               |
| --------- | -------------------- |
| `Space-y` | Copy to clipboard    |
| `Space-p` | Paste from clipboard |
| `Space-d` | Cut to clipboard     |

## Setup

### Initial Setup (Linux/macOS)

```bash
# Run setup script
sh ~/dotfiles/common/vim/setup_vim.sh

# This will:
# 1. Create ~/.vim directory
# 2. Install dein.vim to ~/.cache/dein
# 3. Create symbolic links
```

### Manual Symlink Creation

```bash
sh ~/dotfiles/common/vim/synbolic_links.sh
```

Creates links for:

- `~/.vimrc` -> `vim/.vimrc`
- `~/.gvimrc` -> `vim/.gvimrc`
- `~/.dein.toml` -> `vim/.dein.toml`
- `~/.dein_lazy.toml` -> `vim/.dein_lazy.toml`
- `~/.vim/plugins/` -> `vim/plugins/`
- `~/.vim/keymap.rc.vim` -> `vim/keymap.rc.vim`
- `~/.vim/options.rc.vim` -> `vim/options.rc.vim`

### Windows Setup

```batch
vim\setup_vim.bat
```

### Uninstall

```bash
sh ~/dotfiles/common/vim/uninstall_settings.sh
```

## Platform-Specific Features

### WSL2

- Clipboard integration via `clip.exe`
- Auto-copies yanked text to Windows clipboard

### macOS

- Macdown integration (`:Macdown` command)
- Skim PDF viewer for LaTeX
- Clang path configured for deoplete

### Windows

- Python 3 path configured for Anaconda

## File Modification Guidelines

### Adding a Plugin

1. Add plugin to `.dein.toml` or `.dein_lazy.toml`:

```toml
[[plugins]]
repo = 'author/plugin-name'
```

2. If configuration needed, create `plugins/plugin-name.rc.vim`

3. Add hook in TOML:

```toml
[[plugins]]
repo = 'author/plugin-name'
hook_add = '''
  runtime! plugins/plugin-name.rc.vim
'''
```

4. Run `:call dein#install()` in Vim

### Modifying Key Mappings

- Global mappings: Edit `keymap.rc.vim`
- Plugin-specific: Edit corresponding `plugins/*.rc.vim`

### Modifying Options

- Edit `options.rc.vim`
- Filetype-specific settings use `autocmd BufNewFile,BufRead`

## Colorscheme Configuration

```vim
" In options.rc.vim
if has('gui_vimr')
  colorscheme spacegray    " VimR
elseif has('nvim')
  colorscheme iceberg      " Neovim
else
  colorscheme nord         " Vim
endif
```

## Differences from nvim/ Configuration

| Feature        | vim/ (Legacy) | nvim/ (Current) |
| -------------- | ------------- | --------------- |
| Plugin Manager | dein.vim      | lazy.nvim       |
| Config Format  | VimL + TOML   | Lua             |
| Completion     | deoplete      | nvim-cmp        |
| File Explorer  | defx          | nvim-tree       |
| Fuzzy Finder   | fzf/denite    | telescope       |
| LSP            | vim-lsp       | nvim-lspconfig  |

## Troubleshooting

### Plugins not loading

```vim
" Check dein status
:call dein#recache_runtimepath()

" Reinstall plugins
:call dein#install()
```

### Completion not working

```vim
" Check deoplete status
:echo deoplete#is_enabled()

" Enable manually
:call deoplete#enable()
```

### LSP not connecting

```vim
" Check LSP status
:LspStatus

" Install language server
:LspInstallServer
```

## Legacy Notes

- `vimfiler` is replaced by `defx` but still present for compatibility
- `unite` is replaced by `denite` but still present
- `deoplete` is deprecated upstream (consider ddc.vim for future)
- `vim/old/` contains archived colorscheme and config files

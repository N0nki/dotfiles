# CLAUDE.md - Neovim Configuration

This file provides guidance to Claude Code (claude.ai/code) when working with Neovim configuration in this directory.

## Configuration Architecture

This Neovim configuration uses a modular Lua-based setup with lazy.nvim as the plugin manager.

### Entry Point Flow

```
init.lua (root)
  └─> lua/init.lua
       ├─> lua/neovide.lua (conditional, if running in Neovide)
       ├─> lua/keymap.lua
       ├─> lua/options.lua
       └─> lua/plugins.lua
            └─> lua/pluginconfig/*.lua (individual plugin configs)
```

### Directory Structure

- **init.lua**: Minimal entry point that requires the main init module
- **lua/init.lua**: Main loader that orchestrates all configuration modules
- **lua/plugins.lua**: Central plugin declaration using lazy.nvim (~190 plugins)
- **lua/pluginconfig/**: Individual plugin configurations (one file per plugin/feature)
- **lua/keymap.lua**: Global key mappings
- **lua/options.lua**: Vim options and settings
- **lua/neovide.lua**: Neovide-specific GUI settings
- **ftplugin/**: Filetype-specific configurations
- **snippets/**: Custom snippet files
- **vsnippets/**: VS Code format snippets (used by vim-vsnip)

## Plugin Management

### lazy.nvim

This configuration uses lazy.nvim for plugin management. All plugins are declared in `lua/plugins.lua`.

**Plugin installation location:**
- All plugins are installed in `~/.local/share/nvim/lazy/`
- Each plugin has its own subdirectory (e.g., `~/.local/share/nvim/lazy/telescope.nvim/`)
- When investigating plugin behavior, documentation, or source code, refer to this directory
- The lazy.nvim plugin manager itself is installed at `~/.local/share/nvim/lazy/lazy.nvim/`

**Plugin declaration pattern:**
```lua
{"author/plugin-name",
  dependencies = {"dependency1", "dependency2"},
  config = function() require("pluginconfig/plugin-name") end,
  event = "BufReadPost",  -- lazy loading trigger
  ft = "filetype",         -- load on filetype
  keys = {"<leader>key"},  -- load on keypress
  enabled = true,          -- can be set to false to disable
}
```

**Commands:**
- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update plugins only
- `:Lazy clean` - Remove unused plugins

### Adding a New Plugin

1. Add plugin declaration to `lua/plugins.lua`
2. If plugin needs configuration, create `lua/pluginconfig/plugin-name.lua`
3. In the plugin declaration, add: `config = function() require("pluginconfig/plugin-name") end`
4. Restart Neovim or run `:Lazy sync`

**Example:**
```lua
-- In lua/plugins.lua
{"someone/awesome-plugin",
  config = function() require("pluginconfig/awesome-plugin") end
}

-- Create lua/pluginconfig/awesome-plugin.lua
require("awesome-plugin").setup({
  -- configuration here
})
```

## Plugin Categories

### LSP (Language Server Protocol)
- **nvim-lspconfig**: Core LSP configuration
- **mason.nvim**: LSP server installer
- **mason-lspconfig.nvim**: Bridge between mason and lspconfig (see `lua/pluginconfig/mason-lspconfig.lua`)
- **trouble.nvim**: Pretty diagnostics, references, and quickfix list viewer (see `lua/pluginconfig/trouble.lua`)
- **vim-illuminate**: Highlight word under cursor

**LSP Diagnostics:**

Diagnostic display is configured in `lua/options.lua` with:
- Virtual text with `●` prefix
- Signs in sign column
- Underline highlighting
- Severity-based sorting
- Rounded borders for floating windows

**Diagnostic viewing (via Telescope):**
- `<leader>xx` - Show all diagnostics
- `<leader>xe` - Show errors only
- `<leader>xw` - Show warnings only
- `<leader>xi` - Show hints only

**Diagnostic viewing (via Trouble):**
- `<leader>Tt` - Toggle diagnostics (current buffer)
- `<leader>TD` - Toggle diagnostics (workspace-wide)
- `<leader>Ts` - Toggle document symbols (outline)
- `<leader>Tr` - Toggle LSP references
- `<leader>Td` - Toggle LSP definitions
- `<leader>TT` - Toggle LSP type definitions
- `<leader>Tq` - Toggle quickfix list
- `<leader>Tl` - Toggle location list

**Diagnostic navigation:**
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic
- `gl` - Show diagnostic in floating window
- `<leader>q` - Add diagnostics to location list

### Treesitter
- **nvim-treesitter**: Syntax parsing and highlighting (see `lua/pluginconfig/nvim-treesitter.lua`)
- **p00f/nvim-ts-rainbow**: Rainbow parentheses
- **nvim_context_vt**: Show context at end of blocks

### Completion
- **nvim-cmp**: Completion engine (see `lua/pluginconfig/nvim-cmp.lua`)
- **cmp-*** sources**: path, buffer, cmdline, nvim-lsp, treesitter, emoji, spell
- **vim-vsnip**: Snippet engine
- **lspkind-nvim**: VSCode-like pictograms in completion menu

### Telescope (Fuzzy Finder)
- **telescope.nvim**: Main fuzzy finder (see `lua/pluginconfig/telescope.lua`)
- **telescope-file-browser.nvim**: File browser extension

**Key mappings:**
- `<leader>df` - Find files (includes hidden files, excludes .git/)
- `<leader>da` - Live grep (includes hidden files)
- `<leader>db` - Buffers
- `<leader>dh` - Help tags
- `<leader>fb` - File browser
- `<leader>xx` - LSP diagnostics (all)
- `<leader>xe` - LSP diagnostics (errors only)
- `<leader>xw` - LSP diagnostics (warnings only)
- `<leader>xi` - LSP diagnostics (hints only)

### Git Integration
- **vim-fugitive**: Git commands (:Git, :Gwrite, :Gread, etc.)
- **fugitive-gitlab.vim**: GitLab integration
- **gv.vim**: Git commit browser
- **gitsigns.nvim**: Git signs in gutter
- **diffview.nvim**: Diff view
- **gist-vim**: Gist management

### UI/Appearance
- **lualine.nvim**: Status line (see `lua/pluginconfig/lualine.lua`)
- **bufferline.nvim**: Buffer/tab line (see `lua/pluginconfig/bufferline.lua`)
- **Colorschemes**: tokyonight (priority 3000), nightfox (priority 2000), kanagawa (priority 1000), iceberg, gruvbox, nord, everforest, catppuccin

### Terminal Integration
- **toggleterm.nvim**: Toggle terminal (see `lua/pluginconfig/toggleterm.lua`)
- **neoterm**: Terminal wrapper

### Language-Specific
- **vim-go**: Go development (ft = "go")
- **vim-terraform**: Terraform syntax/tools
- **vimtex**: LaTeX integration
- **vim-markdown**: Markdown support
- **markdown.nvim**: Enhanced markdown rendering
- **vim-json**: JSON support
- **vim-toml**: TOML support

### Utilities
- **nvim-tree.lua**: File explorer
- **quickrun**: Quick code execution (`<leader>r`, `<leader>er`)
- **vim-surround**: Surrounding text objects
- **vim-easymotion**: Quick navigation
- **vim-visual-multi**: Multiple cursors
- **flash.nvim**: Enhanced search/jump
- **tcomment_vim**: Comment toggling
- **indent-blankline.nvim**: Indentation guides

## Modifying Configuration

### Adding/Changing Key Mappings

Global keymaps go in `lua/keymap.lua`. Plugin-specific keymaps go in the plugin's config file.

**Pattern:**
```lua
-- In lua/keymap.lua or lua/pluginconfig/plugin-name.lua
-- Use vim.keymap.set (modern API, supports functions directly)
vim.keymap.set('n', '<leader>key', function_or_command, {noremap = true, silent = true})

-- Old vim.api.nvim_set_keymap only accepts strings, not functions
-- vim.api.nvim_set_keymap('n', '<leader>key', ':command<CR>', {noremap = true, silent = true})
```

**Important:** Use `vim.keymap.set()` instead of `vim.api.nvim_set_keymap()` when mapping to Lua functions, as the latter only accepts string commands.

### Adding Vim Options

Add to `lua/options.lua`:
```lua
vim.opt.option_name = value
vim.g.global_variable = value
```

### LSP Server Configuration

LSP servers are configured in `lua/pluginconfig/mason-lspconfig.lua` using the modern `vim.lsp.config()` API (the old `require('lspconfig')` API is deprecated). The file sets up:
1. Default capabilities for all LSP servers (`vim.lsp.config('*', {...})`)
2. Common LSP keybindings in `on_attach` function (gd, gr, K, ga, gn, gf, g?, ge)
3. Server-specific settings (e.g., lua_ls)

**lua_ls configuration:**
The lua_ls server is configured to recognize `vim` as a global variable and includes Neovim runtime files:
```lua
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = {"vim"} },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false }
    }
  }
})
```

**To add a new LSP server:**
1. Add server name to `ensure_installed` table in `mason-lspconfig.lua`
2. For custom settings, use `vim.lsp.config('server_name', {...})`
3. Restart Neovim or run `:Mason` to manually install

### Treesitter Parsers

Treesitter parsers are managed in `lua/pluginconfig/nvim-treesitter.lua`.

**To add a parser:**
Add language to `ensure_installed` table and restart or run `:TSUpdate`

### Filetype-Specific Settings

Create or edit files in `ftplugin/{filetype}.vim` or `ftplugin/{filetype}.lua`:
```lua
-- ftplugin/python.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
```

## Snippet Management

### Snippet Locations
- **snippets/**: Custom snippets in various formats
- **vsnippets/**: VS Code format snippets (JSON)

### vsnip Configuration

The configuration uses vim-vsnip for snippet management (see `lua/pluginconfig/vsnip.lua`).

**To add snippets:**
1. Edit or create files in `vsnippets/` directory
2. Use VS Code snippet JSON format
3. Snippets are automatically loaded by vsnip

## Disabled Plugins

Some plugins are explicitly disabled (`enabled = false`) in `lua/plugins.lua`:
- **defx.nvim**: Alternative file explorer (replaced by nvim-tree)
- **indentLine**: Replaced by indent-blankline
- **vim-airline**: Replaced by lualine
- **fzf.vim**: Replaced by telescope

These can be re-enabled by changing `enabled = false` to `enabled = true` or removing the enabled field, though this may cause conflicts with their replacements.

## Common Tasks

### Debugging Plugin Issues
1. Check `:Lazy` for plugin status
2. Run `:checkhealth` to diagnose issues
3. Check `:messages` for error messages
4. Test with minimal config by commenting out suspect plugins

### Performance Optimization
- Use `event`, `ft`, `keys` options for lazy loading in plugin declarations
- Profile with `:Lazy profile`
- Check startup time with `nvim --startuptime startup.log`

### Updating Configuration
After modifying Lua files:
- Restart Neovim (recommended)
- Or source the specific file: `:source ~/.config/nvim/lua/path/to/file.lua`
- For plugins.lua changes, always restart Neovim

## Setup Script

The `setup_nvim.sh` script creates symbolic links from this directory to `~/.config/nvim/`:
```bash
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/nvim/lua ~/.config/nvim/lua
ln -sf ~/dotfiles/nvim/ftplugin ~/.config/nvim/ftplugin
ln -sf ~/dotfiles/nvim/snippets ~/.config/nvim/snippets
ln -sf ~/dotfiles/nvim/vsnippets ~/.config/nvim/vsnippets
```

After modifying files in this dotfiles directory, changes are immediately reflected in Neovim after restart (no need to run setup again).

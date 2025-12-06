# CLAUDE.md - Common Configuration

This file provides guidance to Claude Code (claude.ai/code) when working with common (cross-platform) configuration files in this directory.

## Overview

The `common/` directory contains shared configuration files used across multiple platforms (macOS, WSL2, Windows). These configurations are symlinked to appropriate locations by the setup script.

## Directory Structure

```
common/
├── starship.toml           # starship prompt configuration
├── zellij.kdl              # zellij terminal multiplexer configuration
├── synbolic_link.sh        # setup script for symlinking configurations
├── tmux/                   # tmux configuration
│   ├── .tmux.conf          # main tmux configuration
│   └── tmux-nerd-font-window-name.yml  # nerd font window name config
├── tmux-op-secure/         # custom 1Password integration plugin (submodule)
├── git/                    # git configuration
│   ├── .gitconfig          # main git config (requires .gitconfig.local)
│   └── ignore              # global git ignore patterns
├── pet/                    # pet (command snippet manager) configuration
│   ├── config.toml         # pet settings
│   └── snippet.toml        # command snippets
├── codex/                  # OpenAI Codex CLI configuration
│   ├── config.toml         # codex settings and MCP servers
│   └── prompts/            # custom prompts for codex
│       ├── work.md         # work log helper prompt
│       ├── commit.md       # commit message helper prompt
│       └── convert_design.md
└── claude/                 # Claude Code CLI configuration
    ├── commands/           # custom slash commands for Claude Code
    │   ├── work.md         # /work command for work logs
    │   ├── commit.md       # /commit command for commit messages
    │   └── nvim-diagnostics.md  # /nvim-diagnostics command for Neovim LSP diagnostics
    ├── scripts/            # automation scripts for hooks
    │   └── format_lua.sh   # automatic Lua formatting with stylua
    ├── settings.json       # Claude Code settings and hooks configuration
    └── claude_desktop_config_win.json  # Claude Desktop Windows config
```

## Setup Script

**File**: `synbolic_link.sh`

This script creates symbolic links from the dotfiles repository to the appropriate locations:

```bash
# Run from anywhere
sh ~/dotfiles/common/synbolic_link.sh
```

### What it links:

1. **Starship**: `~/.config/starship.toml`
2. **tmux**:
   - `~/.tmux.conf` (main configuration)
   - `~/.config/tmux/tmux-nerd-font-window-name.yml` (nerd font window name config)
   - Clones TPM plugin manager
   - Links tmux-op-secure plugin
3. **Zellij**: `~/.config/zellij/zellij.kdl`
4. **Pet**: `~/.config/pet/config.toml`
5. **Codex**: `~/.codex/config.toml` and `~/.codex/prompts/`
6. **Claude**: `~/.claude/commands/`, `~/.claude/scripts/`, and `~/.claude/settings.json`
7. **Git**:
   - `~/.config/git/ignore` (global ignore)
   - `~/.gitconfig` (main config)
   - Creates `~/.gitconfig.local` if missing (user must edit)

## Configuration Details

### Git Configuration

**Files**: `git/.gitconfig`, `git/ignore`

**Key features:**
- Uses `~/.gitconfig.local` for user name and email (not tracked in repo)
- Default branch: `main`
- Default editor: `vim`
- Global exclude file: `~/.config/git/ignore`

**Custom alias:**
- `git wta {branch}`: Create git worktree with sanitized directory name
  - Example: `git wta feature/foo-bar` creates worktree in `feature-foo-bar/`

**Global ignore patterns:**
- `.codex_work/`, `.claude_work/` (AI agent working directories)
- `pyproject.toml`, `uv.lock` (Python uv package manager)
- `.envrc` (direnv)
- `**/.claude/settings.local.json` (local Claude settings)

**First-time setup:**
```bash
# After running setup script, edit this file:
vim ~/.gitconfig.local

# Add your information:
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
```

### tmux Configuration

**Files**:
- `tmux/.tmux.conf` - Main tmux configuration
- `tmux/tmux-nerd-font-window-name.yml` - Window name icon configuration

**Theme**: Iceberg (dark blue)

**Key bindings:**
- Prefix: `Ctrl-t` (not the default `Ctrl-b`)

**Window management:**
- `Ctrl-t h/l`: Move between windows
- `Ctrl-t Ctrl-a/e`: Swap window left/right
- `Ctrl-t v`: Split horizontally
- `Ctrl-t w`: Split vertically
- `Ctrl-t V`: Split horizontally with even layout
- `Ctrl-t W`: Split vertically with even layout

**Pane management:**
- `Ctrl-t h/j/k/l`: Move between panes (vim-style)
- `Ctrl-t H/J/K/L`: Resize panes
- `Ctrl-t o`: Open current pane in new window
- `Ctrl-t b`: Toggle synchronize panes

**AI agent layouts:**
- `Ctrl-t A`: Horizontal layout (claude + codex at bottom)
  - Creates 2 panes at bottom: left=claude, right=codex
- `Ctrl-t B`: Vertical layout (claude + codex on right)
  - Creates 2 panes on right: top=claude, bottom=codex

**Copy mode:**
- Vi-style key bindings
- `v`: Begin selection
- `y`: Copy to clipboard (pbcopy)
- `Escape`: Clear selection

**Other:**
- `Ctrl-t r`: Reload config
- `Ctrl-t n`: Show status bar
- `Ctrl-t f`: Hide status bar

**Plugins** (managed by TPM - tmux plugin manager):
- **tmux-sensible**: Sensible defaults
- **tmux-resurrect**: Save/restore sessions
  - `Ctrl-t Ctrl-s`: Save session
  - `Ctrl-t Ctrl-r`: Restore session
- **tmux-continuum**: Automatic session saving (enabled)
- **tmux-sessionist**: Session management utilities
  - `Ctrl-t Shift-c`: Create new session
  - `Ctrl-t Shift-x`: Kill current session
- **tmux-logging**: Logging and screen capture
  - `Ctrl-t Shift-p`: Toggle logging
  - `Ctrl-t Alt-p`: Screen capture
  - `Ctrl-t Alt-Shift-p`: Save complete history
- **tmux-thumbs**: Pattern matching and copying
  - `Ctrl-t Space`: Copy matched patterns
- **tmux-nerd-font-window-name**: Display nerd font icons in window names
  - Config: `~/.config/tmux/tmux-nerd-font-window-name.yml`
  - Automatically shows icons based on running command
  - Customizable icons for shells, editors, programming languages, tools
- **tmux-fzf**: fzf integration for tmux management
  - `Ctrl-t F` (Shift+F): Open tmux-fzf menu
  - Manage sessions, windows, panes, commands with fzf
  - Supports multiple selection with TAB
- **tmux-op-secure**: Custom 1Password integration (see detailed section above)
- **tmux-pet**: Pet snippet integration
  - `Ctrl-t Ctrl-s`: Open pet snippet in new pane

**Plugin management:**
- `Ctrl-t I`: Install plugins
- `Ctrl-t U`: Update plugins
- `Ctrl-t Alt-u`: Uninstall unused plugins

### Starship Configuration

**File**: `starship.toml`

Minimal configuration for the starship prompt:
- No newline before prompt
- Command timeout: 1000ms
- Time module: enabled
- Battery module: disabled

### Zellij Configuration

**File**: `zellij.kdl`

Terminal multiplexer with extensive keybindings. Key modes:

**Mode switching:**
- `Ctrl-g`: Locked mode
- `Ctrl-p`: Pane mode
- `Ctrl-n`: Resize mode
- `Ctrl-h`: Move mode
- `Ctrl-t`: Tab mode
- `Ctrl-s`: Scroll mode
- `Ctrl-o`: Session mode
- `Ctrl-b`: Tmux mode (compatibility)

**Quick actions (works in most modes):**
- `Ctrl-q`: Quit
- `Alt-n`: New pane
- `Alt-h/j/k/l`: Navigate panes
- `Alt-=/+`: Increase size
- `Alt--`: Decrease size

**Plugins:**
- tab-bar, status-bar, strider, compact-bar, session-manager

### Pet (Command Snippet Manager)

**Files**: `pet/config.toml`, `pet/snippet.toml`

**Configuration:**
- Backend: gist
- Editor: vim
- Selector: fzf with custom prompt
- Format: `[$description]: $command $tags`

**Included snippets:**
- Launch deepseek-r1:70b with ollama
- Update codex CLI: `npm i -g @openai/codex`
- Update Claude Code: `npm i -g @anthropic-ai/claude-code`
- Update Gemini CLI: `npm i -g @google/gemini-cli`
- Activate uv venv with direnv
- Launch codex in read-only mode
- Launch codex with workspace write access

**Usage:**
```bash
pet new     # Create new snippet
pet search  # Search snippets (uses fzf)
pet exec    # Execute snippet
pet list    # List all snippets
```

### Codex CLI Configuration

**File**: `codex/config.toml`

**Settings:**
- Model: `gpt-5.1-codex`
- Web search: enabled

**MCP Servers:**
1. **aws_api_mcp_server**: AWS API integration
   - Command: `uvx awslabs.aws-api-mcp-server@latest`
   - Region: ap-northeast-1
   - Startup timeout: 300s

2. **terraform_mcp_server**: Terraform integration
   - Command: `docker run -i --rm hashicorp/terraform-mcp-server:latest`
   - Startup timeout: 300s

**Custom prompts** (in `codex/prompts/`):
- **work.md**: Work log creation helper
  - Creates detailed work logs in `.codex_work/work-logs/`
  - Activated by: "記録して" or "作業ログが欲しい"
- **commit.md**: Commit message helper
  - Analyzes `git status` and `git diff --staged`
  - Suggests commit messages following conventions

### Claude Code Configuration

**Custom commands** (in `claude/commands/`):

Slash commands available in Claude Code CLI:

1. **/work**: Work log creation helper
   - Creates detailed work logs in `.claude_work/work-logs/`
   - Filename format: `YYYY-MM-DD-task-title.md`
   - Includes: summary, background, steps, results, files changed, decisions, next actions
   - Activated by user request: "記録して" or "作業ログが欲しい"

2. **/commit**: Commit message helper
   - Analyzes staged changes from `git status --short` and `git diff --staged`
   - Provides 3 commit message suggestions with rationale
   - Format: 50 chars, imperative mood, lowercase
   - Suggests splitting commits if multiple topics detected

3. **/nvim-diagnostics**: Neovim LSP diagnostics helper
   - Retrieves diagnostic information (errors, warnings, hints) from Neovim LSP
   - Usage: `/nvim-diagnostics` (from Neovim :term) or `/nvim-diagnostics path/to/file.lua`
   - Analyzes issues and provides specific fix suggestions
   - Supports all LSP-enabled file types (Lua, Python, JavaScript, TypeScript, Shell, Go, Rust, etc.)

**Hooks** (in `claude/settings.json`):

Automatic actions triggered by Claude Code events:

1. **ToolResult hook for Lua formatting**:
   - Automatically runs `stylua` on `.lua` files after Edit or Write operations
   - Script: `~/.claude/scripts/format_lua.sh`
   - Detects modified Lua files via git diff and applies formatting
   - Requires: `stylua` installed (`cargo install stylua`)
   - Conditions: Triggered on `Edit` or `Write` tool completion

**Scripts** (in `claude/scripts/`):

Helper scripts for hooks and automation:

1. **format_lua.sh**: Automatic Lua file formatting
   - Runs `stylua` on modified `.lua` files
   - Three detection methods:
     1. Reads file path from hook stdin (JSON parsing)
     2. Checks git working directory for modified `.lua` files
     3. Accepts file paths as command-line arguments
   - Colorized output for success/failure
   - Gracefully skips if `stylua` not installed
   - Usage: Called automatically by hook, or manually: `~/.claude/scripts/format_lua.sh path/to/file.lua`

**Claude Desktop config** (Windows):
- File: `claude_desktop_config_win.json`
- Contains Windows-specific Claude Desktop settings

## Common Development Tasks

### Initial Setup

```bash
# Run setup script
sh ~/dotfiles/common/synbolic_link.sh

# Edit git user info
vim ~/.gitconfig.local
# Add:
# [user]
#   name = YOUR_NAME
#   email = YOUR_EMAIL

# Install tmux plugins (inside tmux)
# Press: Ctrl-t I
```

### Git Worktree Management

```bash
# Create worktree with sanitized name
git wta feature/new-feature
# Creates worktree in: ./feature-new-feature/

git wta bugfix/issue-123
# Creates worktree in: ./bugfix-issue-123/
```

### tmux Session Management

```bash
# Start new session
tmux new -s session-name

# Attach to existing session
tmux attach -t session-name

# List sessions
tmux ls

# Inside tmux:
# Save session: Ctrl-t Ctrl-s
# Restore session: Ctrl-t Ctrl-r (after restart)

# Launch AI agents side by side:
# Horizontal layout: Ctrl-t A
# Vertical layout: Ctrl-t B
```

### Using Pet Snippets

```bash
# Search and execute snippet
pet search
# or with fzf keybind (if configured in shell)

# Add new snippet
pet new

# Edit snippets directly
vim ~/.config/pet/snippet.toml
```

### Using Claude Code Custom Commands

```bash
# In Claude Code CLI:

# Get commit message suggestions:
/commit
# Then paste output from:
# git status --short
# git diff --staged

# Create work log:
/work
# Then request: "記録して" or describe the work to log

# Get Neovim LSP diagnostics:
/nvim-diagnostics
# From Neovim :term, or specify file:
/nvim-diagnostics nvim/lua/plugins.lua

# Automatic Lua formatting (via hook):
# Edit any .lua file using Claude Code, and stylua will run automatically
# To manually run the formatting script:
~/.claude/scripts/format_lua.sh path/to/file.lua
```

### Using Codex Custom Prompts

```bash
# In Codex CLI:

# Use work log prompt:
codex --prompt work
# Then request: "記録して"

# Use commit helper:
codex --prompt commit
# Then paste git status and diff output
```

## File Modification Guidelines

### When Modifying Git Configuration

- User-specific settings go in `~/.gitconfig.local` (not tracked)
- Shared settings and aliases go in `git/.gitconfig`
- Global ignore patterns go in `git/ignore`
- After changes, test with: `git config --list`

### When Modifying tmux Configuration

**Main config (.tmux.conf)**:
- Test changes with: `Ctrl-t r` (reload config)
- Plugin additions require: `Ctrl-t I` to install
- Verify keybindings don't conflict with existing ones
- Color scheme uses iceberg theme values

**Window name icons (tmux-nerd-font-window-name.yml)**:
- Add custom icons in the `icons:` section
- Use Nerd Font icons, emoji, or any Unicode symbols
- Format: `command_name: "icon"`
- Changes take effect immediately on new windows
- Example:
  ```yaml
  icons:
    htop: ""
    python: ""
  ```

### When Adding Pet Snippets

- Edit `pet/snippet.toml` in TOML array format
- Each snippet needs: `description`, `command`, `output` fields
- Use clear, searchable descriptions
- Test with: `pet search`

### When Modifying Codex/Claude Configurations

**Codex**:
- MCP servers go in `config.toml` under `[mcp_servers.name]`
- Custom prompts go in `prompts/` directory as Markdown files
- Use descriptive prompt filenames

**Claude Code**:
- Custom commands go in `commands/` directory as Markdown files
- Command name = filename without .md extension
- Use Markdown frontmatter if needed

### When Modifying Setup Script

- Always use `ln -sf` for safe overwriting
- Create parent directories with `mkdir -p`
- Check if files exist before creating defaults
- Test on clean system if possible

## Tool Dependencies

These tools must be installed separately (not managed by this repo):

1. **starship**: Cross-shell prompt
   - Install: See https://starship.rs/

2. **tmux**: Terminal multiplexer
   - Install: `brew install tmux` (macOS) or `apt install tmux` (Linux)
   - TPM is auto-cloned by setup script

3. **zellij**: Modern terminal multiplexer
   - Install: See https://zellij.dev/

4. **pet**: Command snippet manager
   - Install: See https://github.com/knqyf263/pet
   - Requires fzf for selection

5. **fzf**: Fuzzy finder (required by pet)
   - Install: `brew install fzf` or `apt install fzf`

6. **codex**: OpenAI Codex CLI
   - Install: `npm i -g @openai/codex`

7. **claude**: Claude Code CLI
   - Install: `npm i -g @anthropic-ai/claude-code`

8. **stylua**: Lua code formatter (optional, for automatic formatting)
   - Install: `cargo install stylua`
   - Required by: Claude Code hook for automatic Lua formatting
   - Hook gracefully skips formatting if not installed

## Integration with Other Configs

### Shell Integration

Shell configs (in `platforms/macOS/` or `platforms/WSL2/`) should source or initialize:
- Starship: `eval "$(starship init bash)"` or `eval "$(starship init zsh)"`
- Pet: Shell-specific keybindings for `pet search`

### Platform-Specific Overrides

If platform-specific configs exist:
- macOS: `platforms/macOS/.tmux.conf.local` (if needed)
- WSL2: WSL-specific clipboard commands in tmux

Priority: Platform-specific > Common

## Troubleshooting

### Git config not working

```bash
# Check if .gitconfig.local exists and has user info
cat ~/.gitconfig.local

# Verify git can read it
git config user.name
git config user.email

# Check global ignore is working
git config core.excludesfile
```

### tmux plugins not loading

```bash
# Check TPM is installed
ls ~/.tmux/plugins/tpm

# If missing, clone it:
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Inside tmux, install plugins:
# Press: Ctrl-t I
```

### Pet snippets not found

```bash
# Check config file location
cat ~/.config/pet/config.toml

# Check snippet file
cat ~/.config/pet/snippet.toml

# Verify symlinks
ls -la ~/.config/pet/
```

### Starship not appearing

```bash
# Check starship is installed
starship --version

# Check shell init includes starship
# For bash: check ~/.bashrc
# For zsh: check ~/.zshrc

# Should contain:
# eval "$(starship init bash)"
# or
# eval "$(starship init zsh)"
```

### Codex/Claude commands not found

```bash
# Check CLI is installed
codex --version
claude --version

# Check symlinks exist
ls -la ~/.codex/
ls -la ~/.claude/

# Reinstall if needed
npm i -g @openai/codex
npm i -g @anthropic-ai/claude-code
```

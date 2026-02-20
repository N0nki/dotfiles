# Symlink Map

dotfiles リポジトリで管理しているシンボリックリンクの完全なマッピング。

## セットアップスクリプト一覧

| スクリプト | 場所 | 用途 |
|-----------|------|------|
| `dotfilesLink.sh` | ルート | 全体オーケストレータ |
| `setup_macos.sh` | `platforms/macOS/` | macOS シェル設定・Homebrew |
| `synbolic_link.sh` | `common/` | 共通ツールのリンク作成 |
| `setup_nvim.sh` | `common/nvim/` | Neovim 設定リンク |
| `setup_vim.sh` | `common/vim/` | Vim 設定リンク |
| `setup.sh` | `platforms/Linux/Ubuntu/` | Ubuntu セットアップ |

## リンクマッピング（common/synbolic_link.sh）

| ソース（dotfiles 内） | リンク先 | 備考 |
|----------------------|---------|------|
| `common/ghostty/config` | `~/.config/ghostty/config` | |
| `common/ghostty/toggle-opacity.sh` | `~/.config/ghostty/toggle-opacity.sh` | |
| `common/wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` | |
| `common/starship/starship.toml` | `~/.config/starship.toml` | ディレクトリなし |
| `common/tmux/.tmux.conf` | `~/.tmux.conf` | |
| `common/tmux/tmux-nerd-font-window-name.yml` | `~/.config/tmux/tmux-nerd-font-window-name.yml` | |
| `common/zellij/zellij.kdl` | `~/.config/zellij/zellij.kdl` | |
| `common/pet/config.toml` | `~/.config/pet/config.toml` | |
| `common/pet/my_snippet.toml` | `~/.config/pet/my_snippet.toml` | |
| `common/codex/config.toml` | `~/.codex/config.toml` | |
| `common/claude/skills` | `~/.codex/skills`, `~/.claude/skills` | ディレクトリリンク |
| `common/claude/scripts` | `~/.claude/scripts` | ディレクトリリンク |
| `common/claude/settings.json` | `~/.claude/settings.json` | |
| `common/claude/statusline-command.sh` | `~/.claude/statusline-command.sh` | |
| `common/python/pylintrc` | `~/.config/pylintrc` | |
| `common/python/pycodestyle` | `~/.config/pycodestyle` | |
| `common/python/flake8` | `~/.config/flake8` | |
| `common/git/ignore` | `~/.config/git/ignore` | |
| `common/git/.gitconfig` | `~/.gitconfig` | |
| `common/bookokrat/config.yaml` | macOS: `~/Library/Application Support/bookokrat/config.yaml`、Linux: `~/.config/bookokrat/config.yaml` | プラットフォーム依存 |
| `common/lazygit/config.yml` | macOS: `~/Library/Application Support/lazygit/config.yml`、Linux: `~/.config/lazygit/config.yml` | プラットフォーム依存 |

## リンクマッピング（common/nvim/setup_nvim.sh）

| ソース | リンク先 |
|-------|---------|
| `common/nvim/init.lua` | `~/.config/nvim/init.lua` |
| `common/nvim/lua` | `~/.config/nvim/lua` |
| `common/nvim/ftplugin` | `~/.config/nvim/ftplugin` |
| `common/nvim/snippets` | `~/.config/nvim/snippets` |
| `common/nvim/vsnippets` | `~/.config/nvim/vsnippets` |

## リンクマッピング（platforms/macOS/setup_macos.sh）

| ソース | リンク先 |
|-------|---------|
| `platforms/macOS/.bash_profile` | `~/.bash_profile` |
| `platforms/macOS/.bashrc` | `~/.bashrc` |
| `platforms/macOS/.zprofile` | `~/.zprofile` |
| `platforms/macOS/.zshrc` | `~/.zshrc` |
| `platforms/macOS/.latexmkrc` | `~/.latexmkrc` |
| `platforms/macOS/.xvimrc` | `~/.xvimrc` |
| `platforms/macOS/.vrapperrc` | `~/.vrapperrc` |

## プラットフォーム依存パスのパターン

macOS アプリは `~/Library/Application Support/` を使うケースが多い：

```bash
if [ "$(uname)" = "Darwin" ]; then
  # macOS
  mkdir -p "$HOME/Library/Application Support/{app}"
  ln -sf ~/dotfiles/common/{app}/{config} "$HOME/Library/Application Support/{app}/{config}"
else
  # Linux
  mkdir -p ~/.config/{app}
  ln -sf ~/dotfiles/common/{app}/{config} ~/.config/{app}/{config}
fi
```

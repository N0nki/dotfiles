#!/bin/bash
# dotfiles のシンボリックリンク状態をチェック
# Usage: bash check_links.sh

DOTFILES_DIR="$HOME/dotfiles"
OK=0
BROKEN=0
MISSING=0

# 色定義
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo "=== Dotfiles Symlink Status ==="
echo ""

# synbolic_link.sh からリンク定義を抽出して検証
check_link() {
  local target="$1"
  local source="$2"

  # ~ を展開
  target="${target/#\~/$HOME}"
  source="${source/#\~\/dotfiles/$DOTFILES_DIR}"

  if [ -L "$target" ]; then
    local actual_source
    actual_source=$(readlink "$target")
    # ソースが存在するか
    if [ -e "$target" ]; then
      echo -e "${GREEN}OK${NC}  $target -> $actual_source"
      OK=$((OK + 1))
    else
      echo -e "${RED}BROKEN${NC}  $target -> $actual_source (target missing)"
      BROKEN=$((BROKEN + 1))
    fi
  elif [ -e "$target" ]; then
    echo -e "${YELLOW}FILE${NC}  $target (not a symlink, regular file exists)"
    MISSING=$((MISSING + 1))
  else
    echo -e "${RED}MISSING${NC}  $target (not created)"
    MISSING=$((MISSING + 1))
  fi
}

echo "--- Common Tools ---"
check_link ~/.config/ghostty/config ~/dotfiles/common/ghostty/config
check_link ~/.config/ghostty/toggle-opacity.sh ~/dotfiles/common/ghostty/toggle-opacity.sh
check_link ~/.config/wezterm/wezterm.lua ~/dotfiles/common/wezterm/wezterm.lua
check_link ~/.config/starship.toml ~/dotfiles/common/starship/starship.toml
check_link ~/.tmux.conf ~/dotfiles/common/tmux/.tmux.conf
check_link ~/.config/tmux/tmux-nerd-font-window-name.yml ~/dotfiles/common/tmux/tmux-nerd-font-window-name.yml
check_link ~/.config/zellij/zellij.kdl ~/dotfiles/common/zellij/zellij.kdl

echo ""
echo "--- Pet ---"
check_link ~/.config/pet/config.toml ~/dotfiles/common/pet/config.toml
check_link ~/.config/pet/my_snippet.toml ~/dotfiles/common/pet/my_snippet.toml

echo ""
echo "--- AI Tools ---"
check_link ~/.codex/config.toml ~/dotfiles/common/codex/config.toml
check_link ~/.codex/skills ~/dotfiles/common/claude/skills
check_link ~/.claude/skills ~/dotfiles/common/claude/skills
check_link ~/.claude/scripts ~/dotfiles/common/claude/scripts
check_link ~/.claude/settings.json ~/dotfiles/common/claude/settings.json
check_link ~/.claude/statusline-command.sh ~/dotfiles/common/claude/statusline-command.sh

echo ""
echo "--- Python ---"
check_link ~/.config/pylintrc ~/dotfiles/common/python/pylintrc
check_link ~/.config/pycodestyle ~/dotfiles/common/python/pycodestyle
check_link ~/.config/flake8 ~/dotfiles/common/python/flake8

echo ""
echo "--- Git ---"
check_link ~/.config/git/ignore ~/dotfiles/common/git/ignore
check_link ~/.gitconfig ~/dotfiles/common/git/.gitconfig

echo ""
echo "--- Lazygit ---"
if [ "$(uname)" = "Darwin" ]; then
  check_link "$HOME/Library/Application Support/lazygit/config.yml" ~/dotfiles/common/lazygit/config.yml
else
  check_link ~/.config/lazygit/config.yml ~/dotfiles/common/lazygit/config.yml
fi

echo ""
echo "--- Bookokrat ---"
if [ "$(uname)" = "Darwin" ]; then
  check_link "$HOME/Library/Application Support/bookokrat/config.yaml" ~/dotfiles/common/bookokrat/config.yaml
else
  check_link ~/.config/bookokrat/config.yaml ~/dotfiles/common/bookokrat/config.yaml
fi

echo ""
echo "--- Neovim ---"
check_link ~/.config/nvim/init.lua ~/dotfiles/common/nvim/init.lua
check_link ~/.config/nvim/lua ~/dotfiles/common/nvim/lua
check_link ~/.config/nvim/ftplugin ~/dotfiles/common/nvim/ftplugin
check_link ~/.config/nvim/snippets ~/dotfiles/common/nvim/snippets
check_link ~/.config/nvim/vsnippets ~/dotfiles/common/nvim/vsnippets

echo ""
echo "--- tmux Plugins ---"
if [ -d ~/.tmux/plugins/tpm ]; then
  echo -e "${GREEN}OK${NC}  TPM installed at ~/.tmux/plugins/tpm"
else
  echo -e "${RED}MISSING${NC}  TPM not installed at ~/.tmux/plugins/tpm"
  MISSING=$((MISSING + 1))
fi

echo ""
echo "=== Summary ==="
echo -e "${GREEN}OK: $OK${NC}  ${RED}Broken: $BROKEN${NC}  ${YELLOW}Missing: $MISSING${NC}"

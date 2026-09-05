#!/bin/bash
# dotfiles 環境のフルヘルスチェック
# Usage: bash health_check.sh

DOTFILES_DIR="$HOME/dotfiles"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

PASS=0
FAIL=0
WARN=0

check_pass() {
  echo -e "  ${GREEN}PASS${NC}  $1"
  PASS=$((PASS + 1))
}

check_fail() {
  echo -e "  ${RED}FAIL${NC}  $1"
  FAIL=$((FAIL + 1))
}

check_warn() {
  echo -e "  ${YELLOW}WARN${NC}  $1"
  WARN=$((WARN + 1))
}

check_symlink() {
  local target="$1"
  local label="$2"
  if [ -L "$target" ] && [ -e "$target" ]; then
    check_pass "$label"
  elif [ -L "$target" ]; then
    check_fail "$label (broken symlink)"
  elif [ -e "$target" ]; then
    check_warn "$label (exists but not a symlink)"
  else
    check_fail "$label (missing)"
  fi
}

check_command() {
  local cmd="$1"
  local label="${2:-$1}"
  if command -v "$cmd" &>/dev/null; then
    local version
    version=$($cmd --version 2>/dev/null | head -1 || echo "installed")
    check_pass "$label ($version)"
  else
    check_fail "$label (not installed)"
  fi
}

echo "========================================="
echo "  Dotfiles Health Check"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "  Platform: $(uname -s) $(uname -m)"
echo "========================================="
echo ""

# --- 1. Dotfiles リポジトリ ---
echo -e "${CYAN}[1/6] Dotfiles Repository${NC}"
if [ -d "$DOTFILES_DIR/.git" ]; then
  check_pass "Repository exists at $DOTFILES_DIR"
else
  check_fail "Repository not found at $DOTFILES_DIR"
fi

# --- 2. シンボリックリンク ---
echo ""
echo -e "${CYAN}[2/6] Symlinks${NC}"
check_symlink ~/.config/ghostty/config "ghostty config"
check_symlink ~/.config/starship.toml "starship.toml"
check_symlink ~/.tmux.conf ".tmux.conf"
check_symlink ~/.config/tmux/tmux-nerd-font-window-name.yml "tmux nerd font"
check_symlink ~/.config/zellij/zellij.kdl "zellij.kdl"
check_symlink ~/.config/pet/config.toml "pet config"
check_symlink ~/.gitconfig ".gitconfig"
check_symlink ~/.config/git/ignore "git ignore"
check_symlink ~/.claude/settings.json "claude settings"
check_symlink ~/.claude/skills "claude skills"
check_symlink ~/.config/nvim/init.lua "nvim init.lua"
check_symlink ~/.config/nvim/lua "nvim lua/"

# --- 3. 必須ツール ---
echo ""
echo -e "${CYAN}[3/6] Required Tools${NC}"
check_command nvim "Neovim"
check_command tmux "tmux"
check_command starship "Starship"
check_command fzf "fzf"
check_command rg "ripgrep"
check_command gh "GitHub CLI"
check_command jq "jq"
check_command git "Git"
check_command node "Node.js"
check_command stylua "StyLua"
check_command zoxide "zoxide"
check_command bat "bat"
check_command eza "eza"

# --- 4. Git Submodules ---
echo ""
echo -e "${CYAN}[4/6] Git Submodules${NC}"
if [ -f "$DOTFILES_DIR/.gitmodules" ]; then
  cd "$DOTFILES_DIR" || exit
  # submodule の状態をチェック
  while IFS= read -r line; do
    # '-' prefix = not initialized, '+' = out of sync, ' ' = OK
    status_char="${line:0:1}"
    submodule_path=$(echo "$line" | awk '{print $2}')
    case "$status_char" in
      " ")
        check_pass "submodule: $submodule_path (synced)"
        ;;
      "+")
        check_warn "submodule: $submodule_path (out of sync)"
        ;;
      "-")
        check_fail "submodule: $submodule_path (not initialized)"
        ;;
      *)
        check_warn "submodule: $submodule_path (unknown state)"
        ;;
    esac
  done < <(git submodule status 2>/dev/null)
else
  check_warn "No .gitmodules found"
fi

# --- 5. ローカル設定ファイル ---
echo ""
echo -e "${CYAN}[5/6] Local Configuration${NC}"
if [ -f ~/.gitconfig.local ]; then
  # name と email が設定されているか
  if grep -q 'YOUR_NAME\|YOUR_EMAIL' ~/.gitconfig.local 2>/dev/null; then
    check_warn ".gitconfig.local exists but has placeholder values"
  else
    check_pass ".gitconfig.local configured"
  fi
else
  check_fail ".gitconfig.local missing"
fi

if [ -f ~/.config/pet/snippet.toml ]; then
  check_pass "pet snippet.toml exists"
else
  check_warn "pet snippet.toml missing (created by setup)"
fi

# --- 6. tmux / Neovim Plugins ---
echo ""
echo -e "${CYAN}[6/6] Plugin Managers${NC}"
if [ -d ~/.tmux/plugins/tpm ]; then
  check_pass "TPM (tmux plugin manager)"
else
  check_fail "TPM not installed (git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)"
fi

if [ -d ~/.local/share/nvim/lazy ]; then
  lazy_count=$(find ~/.local/share/nvim/lazy -maxdepth 1 -type d | wc -l | tr -d ' ')
  lazy_count=$((lazy_count - 1))  # exclude the lazy dir itself
  check_pass "lazy.nvim ($lazy_count plugins installed)"
else
  check_warn "lazy.nvim plugin directory not found (plugins install on first nvim launch)"
fi

# --- Summary ---
echo ""
echo "========================================="
TOTAL=$((PASS + FAIL + WARN))
echo -e "  ${GREEN}PASS: $PASS${NC}  ${RED}FAIL: $FAIL${NC}  ${YELLOW}WARN: $WARN${NC}  Total: $TOTAL"
echo "========================================="

if [ "$FAIL" -gt 0 ]; then
  echo ""
  echo "Run setup scripts to fix FAIL items:"
  echo "  sh ~/dotfiles/dotfilesLink.sh     # Full setup"
  echo "  sh ~/dotfiles/common/synbolic_link.sh  # Common tools only"
  exit 1
fi

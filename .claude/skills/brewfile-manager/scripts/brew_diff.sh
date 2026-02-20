#!/bin/bash
# Brewfile とインストール済みパッケージの差分を表示
# Usage: bash brew_diff.sh

BREWFILE="$HOME/dotfiles/platforms/macOS/Brewfile"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ "$(uname)" != "Darwin" ]; then
  echo -e "${RED}ERROR: This script is macOS only${NC}"
  exit 1
fi

if ! command -v brew &>/dev/null; then
  echo -e "${RED}ERROR: Homebrew is not installed${NC}"
  exit 1
fi

if [ ! -f "$BREWFILE" ]; then
  echo -e "${RED}ERROR: Brewfile not found at $BREWFILE${NC}"
  exit 1
fi

echo "=== Brewfile Diff ==="
echo ""

# 現在のインストール状態をダンプ
TMPFILE=$(mktemp)
brew bundle dump --file="$TMPFILE" --force 2>/dev/null

# Brewfile の各カテゴリのエントリ数
brewfile_taps=$(grep -c '^tap ' "$BREWFILE" 2>/dev/null || echo 0)
brewfile_brews=$(grep -c '^brew ' "$BREWFILE" 2>/dev/null || echo 0)
brewfile_casks=$(grep -c '^cask ' "$BREWFILE" 2>/dev/null || echo 0)
brewfile_mas=$(grep -c '^mas ' "$BREWFILE" 2>/dev/null || echo 0)
brewfile_vscode=$(grep -c '^vscode ' "$BREWFILE" 2>/dev/null || echo 0)

current_taps=$(grep -c '^tap ' "$TMPFILE" 2>/dev/null || echo 0)
current_brews=$(grep -c '^brew ' "$TMPFILE" 2>/dev/null || echo 0)
current_casks=$(grep -c '^cask ' "$TMPFILE" 2>/dev/null || echo 0)
current_mas=$(grep -c '^mas ' "$TMPFILE" 2>/dev/null || echo 0)
current_vscode=$(grep -c '^vscode ' "$TMPFILE" 2>/dev/null || echo 0)

echo -e "${CYAN}--- Package Count ---${NC}"
printf "%-10s  Brewfile  Installed\n" "Type"
printf "%-10s  %8s  %9s\n" "tap" "$brewfile_taps" "$current_taps"
printf "%-10s  %8s  %9s\n" "brew" "$brewfile_brews" "$current_brews"
printf "%-10s  %8s  %9s\n" "cask" "$brewfile_casks" "$current_casks"
printf "%-10s  %8s  %9s\n" "mas" "$brewfile_mas" "$current_mas"
printf "%-10s  %8s  %9s\n" "vscode" "$brewfile_vscode" "$current_vscode"
echo ""

# Brewfile にあるがインストールされていない
echo -e "${RED}--- In Brewfile but NOT installed ---${NC}"
not_installed=0
while IFS= read -r line; do
  # コメント行・空行をスキップ
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "$line" ]] && continue
  if ! grep -qF "$line" "$TMPFILE" 2>/dev/null; then
    echo -e "  ${RED}MISSING${NC}  $line"
    not_installed=$((not_installed + 1))
  fi
done <"$BREWFILE"

if [ "$not_installed" -eq 0 ]; then
  echo -e "  ${GREEN}All Brewfile packages are installed${NC}"
fi
echo ""

# インストール済みだが Brewfile にない（brew のみ表示、差分が多すぎる場合があるため）
echo -e "${YELLOW}--- Installed but NOT in Brewfile (brew only) ---${NC}"
not_in_brewfile=0
while IFS= read -r line; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "$line" ]] && continue
  [[ ! "$line" =~ ^brew\  ]] && continue
  if ! grep -qF "$line" "$BREWFILE" 2>/dev/null; then
    echo -e "  ${YELLOW}NEW${NC}  $line"
    not_in_brewfile=$((not_in_brewfile + 1))
  fi
done <"$TMPFILE"

if [ "$not_in_brewfile" -eq 0 ]; then
  echo -e "  ${GREEN}No new brew packages to add${NC}"
fi

rm -f "$TMPFILE"

echo ""
echo "=== Done ==="

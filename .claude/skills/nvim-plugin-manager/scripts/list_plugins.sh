#!/bin/bash
# Neovim プラグインの状態を解析・表示
# Usage: bash list_plugins.sh

NVIM_DIR="$HOME/dotfiles/common/nvim"
PLUGINS_FILE="$NVIM_DIR/lua/plugins.lua"
PLUGINCONFIG_DIR="$NVIM_DIR/lua/pluginconfig"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ ! -f "$PLUGINS_FILE" ]; then
  echo -e "${RED}ERROR: plugins.lua not found at $PLUGINS_FILE${NC}"
  exit 1
fi

echo "=== Neovim Plugin Status ==="
echo ""

# プラグイン宣言を抽出（"author/name" パターン）
all_plugins=$(grep -oE '"[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+"' "$PLUGINS_FILE" | sort -u)
total=$(echo "$all_plugins" | wc -l | tr -d ' ')

# 無効化プラグインを抽出
disabled_plugins=$(grep -B5 'enabled\s*=\s*false' "$PLUGINS_FILE" | grep -oE '"[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+"' | sort -u)
if [ -z "$disabled_plugins" ]; then
  disabled_count=0
else
  disabled_count=$(echo "$disabled_plugins" | wc -l | tr -d ' ')
fi
enabled_count=$((total - disabled_count))

echo -e "${CYAN}Total: $total${NC} (${GREEN}Enabled: $enabled_count${NC}, ${YELLOW}Disabled: $disabled_count${NC})"
echo ""

# 無効化プラグイン一覧
if [ "$disabled_count" -gt 0 ]; then
  echo -e "${YELLOW}--- Disabled Plugins ---${NC}"
  echo "$disabled_plugins" | sed 's/"//g' | while read -r plugin; do
    echo -e "  ${YELLOW}OFF${NC}  $plugin"
  done
  echo ""
fi

# カテゴリ別の設定ファイル数
echo -e "${CYAN}--- Config Files by Category ---${NC}"
for category in "$PLUGINCONFIG_DIR"/*/; do
  if [ -d "$category" ]; then
    cat_name=$(basename "$category")
    file_count=$(find "$category" -name "*.lua" -type f | wc -l | tr -d ' ')
    echo -e "  ${GREEN}$cat_name${NC}: $file_count files"
  fi
done
echo ""

# pluginconfig にある設定ファイルを列挙
config_files=$(find "$PLUGINCONFIG_DIR" -name "*.lua" -type f | sort)

# plugins.lua 内の require 文を抽出（スラッシュ区切りとドット区切りの両方に対応）
requires=$(grep -oE 'require\("[^"]+"\)' "$PLUGINS_FILE" | grep 'pluginconfig' | sed 's/require("//;s/")//' | sort -u)

# 孤立設定ファイル（require されていない）を検出
echo -e "${YELLOW}--- Orphaned Config Files ---${NC}"
orphan_found=false
while IFS= read -r filepath; do
  [ -z "$filepath" ] && continue
  # ファイルパスから lua/ 以降の相対パスを取得（拡張子なし）
  relative=$(echo "$filepath" | sed "s|$NVIM_DIR/lua/||" | sed 's|\.lua$||')
  # スラッシュ区切りのままチェック
  if ! echo "$requires" | grep -qF "$relative"; then
    # ドット区切りに変換してもチェック
    dot_form=$(echo "$relative" | sed 's|/|.|g')
    if ! echo "$requires" | grep -qF "$dot_form"; then
      echo -e "  ${YELLOW}ORPHAN${NC}  $relative"
      orphan_found=true
    fi
  fi
done <<< "$config_files"

if [ "$orphan_found" = false ]; then
  echo -e "  ${GREEN}No orphaned config files${NC}"
fi

# require はあるが設定ファイルがないプラグイン
echo ""
echo -e "${RED}--- Missing Config Files ---${NC}"
missing_found=false
while IFS= read -r req; do
  [ -z "$req" ] && continue
  # スラッシュ区切りのパスをファイルパスに変換
  filepath="$NVIM_DIR/lua/${req}.lua"
  if [ ! -f "$filepath" ]; then
    # ドット区切りの場合も試す
    alt_filepath="$NVIM_DIR/lua/$(echo "$req" | sed 's|\.|/|g').lua"
    if [ ! -f "$alt_filepath" ]; then
      echo -e "  ${RED}MISSING${NC}  $req"
      missing_found=true
    fi
  fi
done <<< "$requires"

if [ "$missing_found" = false ]; then
  echo -e "  ${GREEN}All config files exist${NC}"
fi

echo ""
echo "=== Done ==="

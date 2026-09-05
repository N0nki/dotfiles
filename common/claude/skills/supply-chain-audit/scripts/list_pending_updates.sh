#!/usr/bin/env bash
# 各パッケージマネージャーの更新候補を一括出力する。
# サプライチェーン監査の入口として「これから何を upgrade することになるか」を見渡す用途。
#
# 使い方:
#   bash ~/dotfiles/.claude/skills/supply-chain-audit/scripts/list_pending_updates.sh
#
# 出力はセクション区切りのプレーンテキスト。各行はタブ区切り。

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

print_section() {
  printf '\n=== %s ===\n' "$1"
}

# --- Homebrew formula ---------------------------------------------------------
print_section "brew_formula"
if command -v brew >/dev/null 2>&1; then
  if ! command -v jq >/dev/null 2>&1; then
    echo "jq が見つからないため、brew outdated を生出力します"
    brew outdated --formula --verbose
  else
    brew outdated --formula --json=v2 2>/dev/null | jq -r '
      if (.formulae | length) == 0 then
        "(なし)"
      else
        "name\tinstalled\tlatest\tpinned",
        (.formulae[] | [.name, (.installed_versions | join(",")), .current_version, (.pinned|tostring)] | @tsv)
      end
    '
  fi
else
  echo "brew コマンドが見つかりません"
fi

# --- Homebrew cask ------------------------------------------------------------
print_section "brew_cask"
if command -v brew >/dev/null 2>&1; then
  if ! command -v jq >/dev/null 2>&1; then
    brew outdated --cask --verbose
  else
    brew outdated --cask --json=v2 2>/dev/null | jq -r '
      if (.casks | length) == 0 then
        "(なし)"
      else
        "name\tinstalled\tlatest",
        (.casks[] | [.name, (.installed_versions|tostring), .current_version] | @tsv)
      end
    '
  fi
else
  echo "brew コマンドが見つかりません"
fi

# --- mas ----------------------------------------------------------------------
print_section "mas"
if command -v mas >/dev/null 2>&1; then
  out=$(mas outdated 2>/dev/null)
  if [ -z "$out" ]; then
    echo "(なし)"
  else
    echo "$out"
  fi
else
  echo "mas コマンドが見つかりません"
fi

# --- Neovim plugins (lazy-lock.json) -----------------------------------------
print_section "nvim"
LOCK="$DOTFILES/common/nvim/lazy-lock.json"
if [ ! -f "$LOCK" ]; then
  echo "lazy-lock.json が見つかりません: $LOCK"
else
  # 未コミットの差分があれば、それが「これからコミットされる更新」の中身
  if ! git -C "$DOTFILES" diff --quiet -- "$LOCK" 2>/dev/null ||
    ! git -C "$DOTFILES" diff --cached --quiet -- "$LOCK" 2>/dev/null; then
    echo "lazy-lock.json に未コミットの差分があります:"
    git -C "$DOTFILES" --no-pager diff -- "$LOCK"
  else
    echo "(lazy-lock.json に未コミットの差分なし)"
    echo ""
    echo "更新候補を確認するには Neovim を起動して :Lazy check を実行するか、以下を実行:"
    echo "  nvim --headless '+Lazy! check' '+qa'"
    echo "実行後、再度このスクリプトを走らせると lazy-lock.json の差分が出力されます。"
  fi
fi

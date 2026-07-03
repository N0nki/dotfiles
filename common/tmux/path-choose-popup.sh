#!/bin/bash
set -eu

# fd (macOS: fd / Debian系: fdfind) を優先し、無ければ find にフォールバック
if command -v fd >/dev/null 2>&1; then
  FD_CMD="fd"
elif command -v fdfind >/dev/null 2>&1; then
  FD_CMD="fdfind"
else
  FD_CMD=""
fi

# bat (macOS: bat / Debian系: batcat) を検出
if command -v bat >/dev/null 2>&1; then
  BAT_CMD="bat"
elif command -v batcat >/dev/null 2>&1; then
  BAT_CMD="batcat"
else
  BAT_CMD=""
fi

# 候補一覧 (ファイル・ディレクトリ両方、.gitignore を尊重)
if [ -n "$FD_CMD" ]; then
  list_cmd="$FD_CMD --hidden --exclude .git"
else
  list_cmd="find . -not -path '*/.git/*' -mindepth 1"
fi

# プレビュー: ディレクトリなら中身、ファイルなら bat で表示
if [ -n "$BAT_CMD" ]; then
  preview_cmd="if [ -d {} ]; then ls -la --color=always {} 2>/dev/null || ls -la {}; else $BAT_CMD --color=always --style=plain {} 2>/dev/null; fi"
else
  preview_cmd="if [ -d {} ]; then ls -la {}; else cat {}; fi"
fi

selected=$(eval "$list_cmd" |
  fzf --ansi --layout reverse --prompt 'path> ' \
    --preview "$preview_cmd" --preview-window 'right,50%') || exit 0

if [ -n "$selected" ]; then
  # クリップボード分岐 (WSL: clip.exe / macOS: pbcopy)
  if [ -n "${WSL_DISTRO_NAME:-}" ]; then
    printf "%s" "$selected" | clip.exe
  else
    printf "%s" "$selected" | pbcopy
  fi
fi

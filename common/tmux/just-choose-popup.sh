#!/bin/bash

if ! just --summary >/dev/null 2>&1; then
  echo "No justfile found"
  read -r
  exit 0
fi

if command -v batcat >/dev/null 2>&1; then
  BAT_CMD="batcat"
elif command -v bat >/dev/null 2>&1; then
  BAT_CMD="bat"
else
  BAT_CMD=""
fi

if [ -n "$BAT_CMD" ]; then
  preview_cmd="just --show {1} | $BAT_CMD --language=Makefile --color=always --style=plain"
else
  preview_cmd="just --show {1}"
fi

selected=$(just --list --unsorted --list-heading '' --list-prefix '' --color never |
  fzf --ansi --preview "$preview_cmd") || exit 0

if [ -n "$selected" ]; then
  recipe=$(echo "$selected" | awk '{print $1}')
  if [ -n "${WSL_DISTRO_NAME:-}" ]; then
    printf "%s" "just $recipe" | clip.exe
  else
    printf "%s" "just $recipe" | pbcopy
  fi
fi

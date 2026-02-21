#!/bin/bash

if ! just --summary >/dev/null 2>&1; then
  echo "No justfile found"
  read -r
  exit 0
fi

selected=$(just --list --unsorted --list-heading '' --list-prefix '' --color never |
  fzf --preview 'just --show {1}') || exit 0

if [ -n "$selected" ]; then
  recipe=$(echo "$selected" | awk '{print $1}')
  if [ -n "${WSL_DISTRO_NAME:-}" ]; then
    printf "%s" "just $recipe" | clip.exe
  else
    printf "%s" "just $recipe" | pbcopy
  fi
fi

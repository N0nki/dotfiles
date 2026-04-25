#!/bin/bash
session="$1"

tmux list-windows -t "$session" \
  -F '#I: #W #F [#{pane_current_command}] #{pane_current_path}' |
  awk '{
    if (/\*/) printf "\033[1;32m%s\033[0m\n", $0
    else printf "\033[90m%s\033[0m\n", $0
  }'

echo "---"
tmux capture-pane -e -t "$session" -p

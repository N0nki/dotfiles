#!/bin/sh
session="$1"
script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

# session info
tmux display-message -t "$session" -p \
  '#{session_windows} windows | #{?session_attached,attached,detached} | created: #{t:session_created}'
printf '\n'
python3 "$script_dir/agent-status.py" preview "$session"

printf '\n── Active pane ──\n'
tmux capture-pane -e -t "$session" -p

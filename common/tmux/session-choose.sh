#!/bin/sh
# fzf 0.74+ provides every(N) and identity tracking across reloads.
script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
export TMUX_AGENT_SCRIPT_DIR="$script_dir"

# fzf expands these variables when its reload/preview commands run.
# shellcheck disable=SC2016
selection=$(python3 "$script_dir/agent-status.py" list | fzf \
  --reverse --ansi --no-sort --no-multi \
  --delimiter='\t' --with-nth=2.. --track --id-nth=1 \
  --prompt='session> ' \
  --header='Approval requests first | Refresh: 1s | Enter: Switch / Esc: Back' \
  --bind='every(1):reload-sync(python3 "$TMUX_AGENT_SCRIPT_DIR/agent-status.py" list)' \
  --bind='load:refresh-preview' \
  --bind='ctrl-r:reload-sync(python3 "$TMUX_AGENT_SCRIPT_DIR/agent-status.py" list)' \
  --preview='sh "$TMUX_AGENT_SCRIPT_DIR/session-preview.sh" {1}' \
  --preview-window=right:60%) || exit 0

# The hidden first column is an immutable session ID, never a display label.
session_id=$(printf '%s\n' "$selection" | cut -f1)
[ -n "$session_id" ] || exit 0
if [ -n "${1-}" ]; then
  tmux switch-client -c "$1" -t "$session_id"
else
  tmux switch-client -t "$session_id"
fi

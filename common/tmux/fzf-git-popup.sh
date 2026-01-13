#!/bin/sh
set -eu

action="${1:-}"

case "$action" in
  branches|hashes|tags|files|remotes|stashes|lreflogs|worktrees) ;;
  *)
    echo "Usage: $0 {branches|hashes|tags|files|remotes|stashes|lreflogs|worktrees}" >&2
    exit 1
    ;;
esac

export FZF_GIT_ACTION="$action"

shell="${SHELL:-/bin/sh}"

"$shell" -l -c '
  source ~/dotfiles/common/fzf-git/fzf-git.sh --run
  _fzf_git_fzf() {
    fzf --height 50% \
      --layout reverse --multi --min-height 20+ --border \
      --no-separator --header-border horizontal \
      --border-label-pos 2 \
      --color "label:blue" \
      --preview-window "right,50%" --preview-border line \
      --bind "ctrl-/:change-preview-window(down,50%|hidden|)" "$@"
  }
  result=$(_fzf_git_${FZF_GIT_ACTION})
  printf "%s" "$result" | pbcopy
  sleep 1
'

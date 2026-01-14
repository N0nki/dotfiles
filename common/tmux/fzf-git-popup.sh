#!/bin/bash
set -eu

action="${1:-}"

case "$action" in
branches | hashes | tags | files | remotes | stashes | lreflogs | worktrees) ;;
*)
  echo "Usage: $0 {branches|hashes|tags|files|remotes|stashes|lreflogs|worktrees}" >&2
  exit 1
  ;;
esac

# Define custom _fzf_git_fzf function and export via __fzf_git_fzf
_fzf_git_fzf() {
  fzf --height 99% \
    --layout reverse --multi --min-height 20+ --border \
    --no-separator --header-border horizontal \
    --border-label-pos 2 \
    --color "label:blue" \
    --preview-window "right,50%" --preview-border line \
    --bind "ctrl-/:change-preview-window(down,50%|hidden|)" "$@"
}
export __fzf_git_fzf
__fzf_git_fzf="$(declare -f _fzf_git_fzf)"

# Run fzf-git with --run option
result=$(bash ~/dotfiles/common/fzf-git/fzf-git.sh --run "$action")

# Copy result to clipboard
if [ -n "${WSL_DISTRO_NAME:-}" ]; then
  printf "%s" "$result" | clip.exe
else
  printf "%s" "$result" | pbcopy
fi

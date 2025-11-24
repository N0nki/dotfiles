#!/bin/bash
# Secure 1Password integration for tmux
# No token files - uses biometric authentication on every access

set -e

# Redirect all output to show errors in popup
exec 2>&1

# Trap errors and show them
trap 'echo ""; echo "Error occurred at line $LINENO"; echo "Press any key to close..."; read -n 1' ERR

# Get tmux option with default value
get_tmux_option() {
  local option="$1"
  local default="$2"
  local value
  value=$(tmux show-option -gqv "$option")
  echo "${value:-$default}"
}

# Detect 1Password CLI command (prefer Windows version in WSL)
get_op_cmd() {
  if command -v op.exe &> /dev/null; then
    echo "op.exe"
  elif command -v op &> /dev/null; then
    echo "op"
  else
    echo ""
  fi
}

# Check required commands
check_dependencies() {
  local missing=()

  OP_CMD=$(get_op_cmd)
  if [ -z "$OP_CMD" ]; then
    missing+=("op (1Password CLI)")
  fi

  if ! command -v fzf &> /dev/null; then
    missing+=("fzf")
  fi

  if ! command -v jq &> /dev/null; then
    missing+=("jq")
  fi

  if [ ${#missing[@]} -gt 0 ]; then
    echo "Error: Missing dependencies: ${missing[*]}"
    echo "Press any key to close..."
    read -n 1
    exit 1
  fi
}

# Get clipboard command based on platform
get_clipboard_cmd() {
  if command -v clip.exe &> /dev/null; then
    echo "clip.exe"
  elif command -v pbcopy &> /dev/null; then
    echo "pbcopy"
  elif command -v xclip &> /dev/null; then
    echo "xclip -selection clipboard"
  else
    echo ""
  fi
}

# Main function
main() {
  check_dependencies

  local copy_to_clipboard
  local auto_clear_seconds
  local vault
  local account

  copy_to_clipboard=$(get_tmux_option "@1password-copy-to-clipboard" "off")
  auto_clear_seconds=$(get_tmux_option "@1password-auto-clear-seconds" "30")
  vault=$(get_tmux_option "@1password-vault" "")
  account=$(get_tmux_option "@1password-account" "")
  local categories=$(get_tmux_option "@1password-categories" "Login")
  local use_cache=$(get_tmux_option "@1password-use-cache" "off")
  local cache_file="/tmp/tmux-op-secure-cache.json"
  local cache_age=$(get_tmux_option "@1password-cache-age" "300")

  # Build op item list command
  local list_cmd="$OP_CMD item list --format=json"
  [ -n "$vault" ] && list_cmd="$list_cmd --vault \"$vault\""
  [ -n "$account" ] && list_cmd="$list_cmd --account \"$account\""
  [ -n "$categories" ] && list_cmd="$list_cmd --categories \"$categories\""

  # Get items and format for fzf
  local items
  local error_output

  # Check cache if enabled
  local exit_code=0
  if [ "$use_cache" = "on" ] && [ -f "$cache_file" ]; then
    local cache_timestamp=$(stat -c %Y "$cache_file" 2>/dev/null || echo 0)
    local current_time=$(date +%s)
    local age=$((current_time - cache_timestamp))

    # If cache_age is 0 or negative, cache never expires
    if [ "$cache_age" -le 0 ] || [ $age -lt $cache_age ]; then
      items=$(cat "$cache_file")
      exit_code=$?
      if [ "$cache_age" -le 0 ]; then
        echo "Using cached data (never expires)..."
      else
        echo "Using cached data (age: ${age}s)..."
      fi
      sleep 0.5
    else
      echo "Fetching items from 1Password..."
      items=$(eval "$list_cmd" 2>&1)
      exit_code=$?
      [ $exit_code -eq 0 ] && echo "$items" > "$cache_file" 2>/dev/null
    fi
  else
    echo "Fetching items from 1Password..."
    items=$(eval "$list_cmd" 2>&1)
    exit_code=$?
    [ $exit_code -eq 0 ] && [ "$use_cache" = "on" ] && echo "$items" > "$cache_file" 2>/dev/null
  fi

  if [ $exit_code -ne 0 ]; then
    # Extract first line of error message
    error_output=$(echo "$items" | head -1)
    echo "1Password CLI Error:"
    echo "$error_output"
    echo ""
    echo "Troubleshooting:"
    echo "1. Check 1Password app is running"
    echo "2. Enable: Settings > Developer > 'Integrate with 1Password CLI'"
    echo "3. Run: op signin"
    echo ""
    echo "Press any key to close..."
    read -n 1
    exit 1
  fi

  local formatted_items
  formatted_items=$(echo "$items" | jq -r '.[] | "\(.title)\t\(.vault.name)\t\(.id)"')

  if [ -z "$formatted_items" ]; then
    echo "No items found in 1Password"
    echo "Press any key to close..."
    read -n 1
    exit 1
  fi

  # Show fzf selector (already in tmux popup)
  local selected
  selected=$(echo "$formatted_items" | fzf \
    --layout=reverse \
    --border \
    --prompt="1Password > " \
    --delimiter='\t' \
    --with-nth=1,2 \
    --preview="echo {1}" \
    --preview-window=up:3:wrap)

  if [ -z "$selected" ]; then
    exit 0
  fi

  local item_id
  item_id=$(echo "$selected" | awk -F'\t' '{print $3}')

  # Get password using op read (triggers biometric authentication)
  local password_cmd="$OP_CMD item get \"$item_id\" --format=json --fields label=password"
  [ -n "$account" ] && password_cmd="$password_cmd --account \"$account\""

  local password
  password=$(eval "$password_cmd" 2>&1 | jq -r '.value // empty')

  if [ -z "$password" ]; then
    echo "Failed to get password"
    echo "Press any key to close..."
    read -n 1
    exit 1
  fi

  # Send password to target pane or clipboard
  if [ "$copy_to_clipboard" = "on" ]; then
    local clip_cmd
    clip_cmd=$(get_clipboard_cmd)

    if [ -z "$clip_cmd" ]; then
      echo "No clipboard command found"
      echo "Press any key to close..."
      read -n 1
      exit 1
    fi

    echo -n "$password" | eval "$clip_cmd"
    echo "✓ Password copied to clipboard (auto-clear in ${auto_clear_seconds}s)"
    sleep 1

    # Clear clipboard after specified seconds
    if [ "$auto_clear_seconds" -gt 0 ]; then
      (sleep "$auto_clear_seconds" && echo -n "" | eval "$clip_cmd" 2>/dev/null) &
    fi
  else
    # Send keys to current pane
    tmux send-keys -t "$TMUX_PANE" "$password"
    echo "✓ Password sent to pane"
    sleep 1
  fi
}

main "$@"

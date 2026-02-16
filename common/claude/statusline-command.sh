#!/bin/bash

set -eux

# Read JSON input from stdin
input=$(cat)

# Extract values
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
output_style=$(echo "$input" | jq -r '.output_style.name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
agent_name=$(echo "$input" | jq -r '.agent.name // empty')

# Build status line components
status_parts=()

# Model name
status_parts+=("$(printf '\033[1;36m%s\033[0m' "$model")")

# Agent name if present
if [ -n "$agent_name" ]; then
  status_parts+=("$(printf '\033[1;35m[%s]\033[0m' "$agent_name")")
fi

# Current directory (basename only)
if [ -n "$current_dir" ]; then
  dir_name=$(basename "$current_dir")
  status_parts+=("$(printf '\033[1;32m%s\033[0m' "$dir_name")")
fi

# Vim mode if present
if [ -n "$vim_mode" ]; then
  status_parts+=("$(printf '\033[1;34m[%s]\033[0m' "$vim_mode")")
fi

# Context usage with color coding
if [ -n "$used_pct" ]; then
  formatted_input=$(printf "%'d" "$total_input" 2>/dev/null || echo "$total_input")
  formatted_output=$(printf "%'d" "$total_output" 2>/dev/null || echo "$total_output")

  if (($(echo "$used_pct >= 80" | bc -l 2>/dev/null || echo 0))); then
    color='\033[1;31m' # Red
  elif (($(echo "$used_pct >= 50" | bc -l 2>/dev/null || echo 0))); then
    color='\033[1;33m' # Yellow
  else
    color='\033[1;32m' # Green
  fi

  usage_info=$(printf "${color}%.1f%% used\033[0m (\033[0;36m%s\033[0m in / \033[0;36m%s\033[0m out)" "$used_pct" "$formatted_input" "$formatted_output")

  if [ -n "$cache_read" ] && [ "$cache_read" -gt 0 ]; then
    formatted_cache=$(printf "%'d" "$cache_read" 2>/dev/null || echo "$cache_read")
    usage_info+=$(printf " [\033[0;35m%s cached\033[0m]" "$formatted_cache")
  fi

  status_parts+=("$usage_info")
fi

# Join parts with separator
separator=" $(printf '\033[0;90m|\033[0m') "
result=""
for i in "${!status_parts[@]}"; do
  if [ $i -eq 0 ]; then
    result="${status_parts[$i]}"
  else
    result+="$separator${status_parts[$i]}"
  fi
done

echo "$result"

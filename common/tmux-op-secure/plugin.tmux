#!/bin/bash
# tmux-op-secure plugin
# Secure 1Password integration without token files

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Default key binding
default_key="u"
key_binding=$(tmux show-option -gqv "@1password-key")
key_binding=${key_binding:-$default_key}

# Register key binding - use display-popup for interactive input
tmux bind-key "$key_binding" display-popup -E -w 80% -h 60% "$CURRENT_DIR/scripts/main.sh"

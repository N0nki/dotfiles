#!/bin/bash
# tmux-op-secure plugin
# Secure 1Password integration without token files

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Default key binding for password
default_key="u"
key_binding=$(tmux show-option -gqv "@1password-key")
key_binding=${key_binding:-$default_key}

# Register password key binding - use display-popup for interactive input
tmux bind-key "$key_binding" display-popup -E -w 80% -h 60% "$CURRENT_DIR/scripts/main.sh"

# Default key binding for OTP
default_otp_key="o"
otp_key_binding=$(tmux show-option -gqv "@1password-otp-key")
otp_key_binding=${otp_key_binding:-$default_otp_key}

# Register OTP key binding
tmux bind-key "$otp_key_binding" display-popup -E -w 80% -h 60% "$CURRENT_DIR/scripts/otp.sh"

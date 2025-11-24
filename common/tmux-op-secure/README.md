# tmux-op-secure

Secure 1Password integration for tmux without token files.

## Features

- **No token files**: Uses 1Password CLI v2's biometric authentication on every access
- **fzf integration**: Fuzzy search through your 1Password items
- **Clipboard support**: Auto-copy with configurable auto-clear
- **Secure by default**: No persistent authentication tokens stored on disk

## Security Advantages

Unlike other tmux 1Password plugins that store session tokens in `~/.op_tmux_token_tmp`, this plugin:

1. **Never stores tokens**: Each access triggers fresh biometric authentication
2. **Zero token exposure**: No token files that could be compromised
3. **Transparent security**: You know exactly when authentication happens

## Requirements

- [1Password CLI](https://developer.1password.com/docs/cli) v2.0.0+
- [fzf](https://github.com/junegunn/fzf)
- [jq](https://stedolan.github.io/jq/)
- Clipboard command:
  - WSL2: `clip.exe`
  - macOS: `pbcopy`
  - Linux: `xclip`

## Installation

This plugin is designed to be used directly from your dotfiles repository via symlink.

1. Ensure the plugin is in your dotfiles:
   ```
   ~/dotfiles/common/tmux-op-secure/
   ```

2. Create symlink (automatically done by `common/synbolic_link.sh`):
   ```bash
   ln -sf ~/dotfiles/common/tmux-op-secure ~/.tmux/plugins/tmux-op-secure
   ```

3. Add to your `~/.tmux.conf`:
   ```bash
   run-shell ~/.tmux/plugins/tmux-op-secure/plugin.tmux
   ```

4. Reload tmux config:
   ```bash
   tmux source-file ~/.tmux.conf
   ```

## Usage

### Basic Usage

1. Press `prefix + u` (default: `Ctrl-t u`)
2. Select an item using fzf
3. Password is copied to clipboard (auto-clears in 30s)

### Configuration Options

Add these to your `~/.tmux.conf` before loading the plugin:

```bash
# Enable/disable clipboard copy (default: off)
set -g @1password-copy-to-clipboard 'on'

# Auto-clear clipboard after N seconds (default: 30)
set -g @1password-auto-clear-seconds '30'

# Change key binding (default: u)
set -g @1password-key 'p'

# Filter by categories (default: Login)
# Options: Login, Password, SecureNote, CreditCard, etc.
set -g @1password-categories 'Login'

# Enable cache (default: off)
# Cache contains only metadata (titles, IDs), no passwords
set -g @1password-use-cache 'on'
set -g @1password-cache-age '300'  # seconds (default: 300 = 5 min)

# Specify vault (optional)
set -g @1password-vault 'Private'

# Specify account (optional)
set -g @1password-account 'your-account'
```

### Send to Pane vs Clipboard

**Clipboard mode** (recommended, `@1password-copy-to-clipboard 'on'`):
- Password copied to clipboard
- Auto-clears after configured seconds
- Safe for any input field

**Send-keys mode** (`@1password-copy-to-clipboard 'off'`):
- Password sent directly to current pane
- Useful for terminal password prompts
- Less safe if wrong pane is active

## Example Configuration

```bash
# In ~/.tmux.conf

## tmux-op-secure (custom secure 1Password integration)
run-shell ~/.tmux/plugins/tmux-op-secure/plugin.tmux
set -g @1password-copy-to-clipboard 'on'
set -g @1password-auto-clear-seconds '30'
set -g @1password-categories 'Login'
set -g @1password-use-cache 'on'
set -g @1password-vault 'Private'
```

## Troubleshooting

### "1Password CLI error: Please sign in first"

Sign in to 1Password CLI:
```bash
op signin
```

### "Missing dependencies: fzf"

Install fzf:
```bash
# macOS
brew install fzf

# Linux
sudo apt install fzf
```

### "No clipboard command found"

Install a clipboard tool:
```bash
# WSL2 (should already have clip.exe)
# macOS (should already have pbcopy)

# Linux
sudo apt install xclip
```

### Biometric authentication not working

Enable biometric unlock in 1Password CLI:
1. Ensure 1Password app is running
2. Enable biometric unlock in app settings
3. Sign in once: `op signin`

## Comparison with tmux-1password

| Feature | tmux-op-secure | tmux-1password |
|---------|----------------|----------------|
| Token storage | ❌ None | ⚠️ `~/.op_tmux_token_tmp` |
| Biometric auth | ✅ Every access | ⚠️ Once per session |
| Security | ✅ High | ⚠️ Medium |
| Setup complexity | ✅ Simple | ⚠️ Moderate |
| fzf integration | ✅ Yes | ✅ Yes |
| OTP support | ❌ Not yet | ✅ Yes |

## License

This plugin is part of a personal dotfiles repository.

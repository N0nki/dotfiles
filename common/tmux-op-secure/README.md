# tmux-op-secure

Secure 1Password integration for tmux without token files.

## Features

- **No token files**: Uses 1Password CLI v2's biometric authentication on every access
- **fzf integration**: Fuzzy search through your 1Password items
- **Clipboard support**: Auto-copy with configurable auto-clear
- **OTP/2FA support**: Retrieve one-time passwords (TOTP) from 1Password items
- **Secure by default**: No persistent authentication tokens stored on disk

## Security Advantages

Unlike other tmux 1Password plugins that store session tokens, this plugin:

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

**Password retrieval:**

1. Press `prefix + u` (default: `Ctrl-t u`)
2. Select an item using fzf
3. Password is copied to clipboard (auto-clears in 30s)

**OTP/2FA code retrieval:**

1. Press `prefix + o` (default: `Ctrl-t o`)
2. Select an item using fzf
3. OTP code is copied to clipboard (auto-clears in 10s)

### Configuration Options

Add these to your `~/.tmux.conf` before loading the plugin:

```bash
# Enable/disable clipboard copy (default: off)
set -g @1password-copy-to-clipboard 'on'

# Auto-clear clipboard after N seconds (default: 30)
set -g @1password-auto-clear-seconds '30'

# Change key binding for password (default: u)
set -g @1password-key 'p'

# Change key binding for OTP (default: o)
set -g @1password-otp-key 'O'

# Auto-clear clipboard for OTP (default: 10 seconds)
set -g @1password-otp-auto-clear-seconds '15'

# Filter by categories (default: Login)
# Options: Login, Password, SecureNote, CreditCard, etc.
set -g @1password-categories 'Login'

# Enable cache (default: off)
# Cache contains only metadata (titles, IDs), no passwords
set -g @1password-use-cache 'on'
set -g @1password-cache-age '300'  # seconds (default: 300 = 5 min, 0 = never expire)

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
set -g @1password-otp-auto-clear-seconds '10'
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

### OTP code not found

Error: "Failed to get OTP code - This item may not have OTP/2FA configured"

This means the selected 1Password item doesn't have a TOTP field. To fix:

1. Open the item in 1Password app
2. Add a one-time password field (Edit > Add More > One-Time Password)
3. Scan QR code or enter secret key
4. Try retrieving OTP again with `prefix + o`

## License

This plugin is part of a personal dotfiles repository.

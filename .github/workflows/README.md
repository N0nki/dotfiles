# GitHub Actions Workflows

This directory contains automated workflows for validating and testing the dotfiles repository.

## Workflows

### 1. Lint and Validate (`lint.yml`)

Triggers on push/pull_request to `master` (add `main` if that is your default branch).

**Jobs:**
- **ShellCheck**: Validates shell script syntax and best practices
- **Lua Syntax Check**: Validates Lua configuration files (Neovim config)
- **YAML/JSON Validation**: Checks syntax of YAML and JSON files
- **Symlink Target Validation**: Verifies that critical config files and setup scripts exist

**Purpose**: Catch syntax errors and configuration issues early before they break your setup.

### 2. Test Setup Scripts (`test-setup.yml`)

Triggers on push/pull_request to `master` (add `main` if that is your default branch).

**Jobs:**
- **Test Common Setup (Ubuntu)**: Tests `common/synbolic_link.sh` for cross-platform tools
- **Test Neovim Setup (Ubuntu)**: Tests `nvim/setup_nvim.sh`
- **Test Python Setup (Ubuntu)**: Tests `python/symbolic_link.sh`
- **Test WSL2 Setup (Ubuntu)**: Tests `WSL2/setup_wsl2.sh`
- **Test macOS Setup**: Tests `macOS/setup_macos.sh` (without Homebrew installation)

**Features:**
- Verifies symlinks are created correctly
- Tests idempotency (running setup multiple times is safe)
- Cross-platform testing (Ubuntu and macOS)

**Purpose**: Ensure setup scripts work correctly across different platforms and won't break when you need them.

### 3. Neovim Health Check (`neovim-check.yml`)

Triggers on push/PR to `master` when files in `nvim/` are modified (add `main` if needed).

**Jobs:**
- **Neovim Lua Syntax Check**: Tests if Neovim can start and load Lua configs
- **Neovim Plugin Configuration Check**: Validates plugin declarations and checks for duplicates
- **Neovim Health Check**: Runs `:checkhealth` to identify missing dependencies

**Purpose**: Catch Neovim configuration errors before they break your editor.

## Configuration Files

- **`.github/yamllint-config.yml`**: Configuration for YAML linting
  - Line length: 120 characters (warning level)
  - Indentation: 2 spaces
  - Truthy values: 'true', 'false', 'on', 'off'

## Status Badges

Add these badges to your main README.md to show workflow status:

```markdown
![Lint and Validate](https://github.com/USERNAME/dotfiles/workflows/Lint%20and%20Validate/badge.svg)
![Test Setup Scripts](https://github.com/USERNAME/dotfiles/workflows/Test%20Setup%20Scripts/badge.svg)
![Neovim Health Check](https://github.com/USERNAME/dotfiles/workflows/Neovim%20Health%20Check/badge.svg)
```

Replace `USERNAME` with your GitHub username.

## Local Testing

You can test workflows locally using [act](https://github.com/nektos/act):

```bash
# Install act (macOS)
brew install act

# Run all workflows
act

# Run specific workflow
act -j shellcheck
act -j test-common-setup

# Run with specific event
act push
act pull_request
```

## Troubleshooting

### Workflow Failures

1. **ShellCheck failures**: Fix shell script syntax issues
2. **Lua syntax errors**: Check your Neovim config files
3. **Setup script failures**: Verify symlink paths and directory structure
4. **Neovim startup failures**: Check for plugin conflicts or missing dependencies

### Common Issues

- **"File not found" errors**: Ensure files exist in repository
- **"Permission denied"**: Check file permissions (should be executable for .sh files)
- **"Symlink already exists"**: Setup scripts should handle this with `ln -sf`

## Contributing

When adding new setup scripts or configuration files:

1. Ensure they pass linting checks
2. Add corresponding test jobs if needed
3. Update this README with new workflow information
4. Test locally with `act` before pushing

## Notes and Caveats

- `lint.yml` Luacheck step and `neovim-check.yml` plugin/health steps are best-effort (`continue-on-error` / `|| true`); remove these guards to make failures blocking.
- Symlink validation in `lint.yml` is logging-only; add `set -e` if you want missing files to fail the job.
- macOS setup skips Homebrew bundle installation in CI (set `SKIP_BREW_BUNDLE=1`).
- Pin workflow actions to commit SHAs (e.g., `actions/checkout@<sha>`, `ludeeus/action-shellcheck@<sha>`) to avoid supply-chain drift.

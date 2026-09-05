# Remediation Guide

ヘルスチェックで検出された問題の修復手順。

## シンボリックリンクの修復

### 全リンクを再作成

```bash
sh ~/dotfiles/common/synbolic_link.sh
```

### 個別リンクの修復

```bash
# 壊れたリンクを削除して再作成
rm -f ~/.config/{tool}/{config}
mkdir -p ~/.config/{tool}
ln -sf ~/dotfiles/common/{tool}/{config} ~/.config/{tool}/{config}
```

## 必須ツールのインストール

### macOS (Homebrew)

```bash
# Brewfile から一括インストール
cd ~/dotfiles/platforms/macOS && brew bundle

# 個別インストール
brew install neovim tmux starship fzf ripgrep gh jq git node stylua zoxide bat eza
```

### Ubuntu / WSL2

```bash
sh ~/dotfiles/platforms/Linux/Ubuntu/setup.sh
```

## Git Submodule の修復

### 初期化されていない場合

```bash
cd ~/dotfiles
git submodule init
git submodule update
```

### 同期が外れている場合

```bash
cd ~/dotfiles
git submodule update --remote
```

## ローカル設定ファイル

### .gitconfig.local

```bash
cat > ~/.gitconfig.local << 'EOF'
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
EOF
# YOUR_NAME と YOUR_EMAIL を実際の値に変更
```

## tmux プラグイン

### TPM のインストール

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### プラグインのインストール

tmux 内で `prefix + I`（`Ctrl-t I`）を実行。

## Neovim プラグイン

### lazy.nvim の初期化

Neovim を起動すると自動でプラグインがインストールされる：

```bash
nvim
# 初回起動時に lazy.nvim が自動インストール
# :Lazy sync で全プラグインを同期
```

### Treesitter パーサーの更新

```bash
nvim -c ":TSUpdate" -c "quitall"
```

### Mason LSP サーバーの管理

Neovim 内で `:Mason` を実行。

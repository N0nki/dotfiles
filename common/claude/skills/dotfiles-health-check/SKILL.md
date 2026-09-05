---
name: dotfiles-health-check
description: dotfiles 環境全体のヘルスチェックを実行します。シンボリックリンクの有効性、必須ツールのインストール状態、git submodule の同期状態、ローカル設定ファイルの存在を一括検証します。「ヘルスチェック」「環境確認」「dotfiles 検証」「セットアップ確認」「環境チェック」などのリクエストで使用してください。
---

# Dotfiles Health Check

dotfiles 環境全体の健全性を一括で検証するスキル。

## ワークフロー

### 1. フルヘルスチェック

全項目を一括でチェック：

```bash
bash ~/dotfiles/.claude/skills/dotfiles-health-check/scripts/health_check.sh
```

チェック項目:
1. **シンボリックリンク**: 全リンクの存在・有効性
2. **必須ツール**: 開発に必要なツールのインストール確認
3. **Git submodule**: submodule の同期状態
4. **ローカル設定**: `.gitconfig.local` 等の必須ローカルファイル
5. **tmux プラグイン**: TPM とプラグインのインストール状態
6. **Neovim**: プラグインディレクトリの存在

### 2. 個別チェック

問題が見つかった場合の修復手順は [references/remediation.md](references/remediation.md) を参照。

### 3. 新規セットアップ時の活用

新しいマシンでセットアップした後にヘルスチェックを実行して、漏れがないか確認：

```bash
# セットアップ実行
sh ~/dotfiles/dotfilesLink.sh

# ヘルスチェック
bash ~/dotfiles/.claude/skills/dotfiles-health-check/scripts/health_check.sh
```

出力を確認して、FAIL / WARN の項目を修正する。

## チェック対象ツール

必須ツール一覧（[references/remediation.md](references/remediation.md) に修復手順あり）：

| ツール | 用途 | macOS インストール |
|-------|------|------------------|
| nvim | エディタ | `brew install neovim` |
| tmux | ターミナルマルチプレクサ | `brew install tmux` |
| starship | プロンプト | `brew install starship` |
| fzf | ファジーファインダ | `brew install fzf` |
| rg (ripgrep) | 高速検索 | `brew install ripgrep` |
| gh | GitHub CLI | `brew install gh` |
| jq | JSON 処理 | `brew install jq` |
| git | バージョン管理 | `brew install git` |
| node | Node.js | `brew install node` |
| stylua | Lua フォーマッタ | `brew install stylua` |
| zoxide | ディレクトリジャンプ | `brew install zoxide` |
| bat | cat の代替 | `brew install bat` |
| eza | ls の代替 | `brew install eza` |

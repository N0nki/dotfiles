---
name: brewfile-manager
description: Homebrew の Brewfile 管理を支援します。インストール済みパッケージと Brewfile の差分表示、新パッケージの追加、不要パッケージの検出・削除、Brewfile の整理を行います。「Brewfile 更新」「brew 差分」「パッケージ追加」「brew 整理」「Brewfile 同期」などのリクエストで使用してください。macOS 環境でのみ使用可能です。
---

# Brewfile Manager

Homebrew の Brewfile とインストール済みパッケージを同期管理するスキル。

Brewfile の場所: `~/dotfiles/platforms/macOS/Brewfile`

## ワークフロー

### 1. 差分の確認

現在のインストール状態と Brewfile の差分を確認：

```bash
bash ~/dotfiles/.claude/skills/brewfile-manager/scripts/brew_diff.sh
```

出力内容:
- **Brewfile にあるがインストールされていない**: 未インストールのパッケージ
- **インストール済みだが Brewfile にない**: Brewfile に追加すべき候補
- カテゴリ別（brew, cask, mas, vscode, tap）の内訳

### 2. Brewfile の更新

#### 現在の状態を Brewfile に反映

```bash
# 現在のインストール状態からダンプ（確認用、直接上書きはしない）
brew bundle dump --file=/tmp/Brewfile.current

# 差分を確認
diff ~/dotfiles/platforms/macOS/Brewfile /tmp/Brewfile.current
```

#### パッケージを追加

Brewfile に手動で追記する際は、以下のセクション順序に従う：

```ruby
# 1. tap（リポジトリ追加）
tap "org/repo"

# 2. brew（CLI ツール）
brew "package-name"

# 3. cask（GUI アプリ）
cask "app-name"

# 4. mas（Mac App Store）
mas "App Name", id: 123456789

# 5. vscode（VS Code 拡張）
vscode "publisher.extension-name"
```

各セクション内はアルファベット順にソートする。

#### パッケージをインストール

```bash
cd ~/dotfiles/platforms/macOS && brew bundle
```

### 3. 不要パッケージの検出

```bash
# Brewfile にあるが不要なパッケージを確認
brew bundle cleanup --file=~/dotfiles/platforms/macOS/Brewfile

# 実際に削除する場合（確認後）
brew bundle cleanup --file=~/dotfiles/platforms/macOS/Brewfile --force
```

### 4. Brewfile の整理

整理する際のルール：

- `tap` は先頭にまとめる
- `brew` はアルファベット順
- `cask` はアルファベット順
- `mas` はアプリ名でアルファベット順
- `vscode` はパブリッシャー名でアルファベット順
- コメントでカテゴリ分けする場合は `# brew bundle dump` のような既存コメントを維持

### 5. Mac App Store アプリの ID 取得

新しい mas エントリを追加する際、アプリ ID が必要：

```bash
# インストール済みアプリから検索
mas list | grep -i "app-name"

# App Store で検索
mas search "app-name"
```

## 注意事項

- `brew bundle dump` は現在のインストール状態をそのまま出力するため、Brewfile を直接上書きしない
- cask のバージョン指定は Brewfile では不要（常に最新がインストールされる）
- `mas` はサインイン済みの Apple ID に紐づくアプリのみ管理可能

---
name: dotfiles-sync
description: dotfiles リポジトリのシンボリックリンク管理を支援します。新しいツールの設定追加、壊れたリンクの検出、リンク状態の一覧表示を行います。「リンク確認」「新しいツール追加」「dotfiles 同期」「シンボリックリンク」「設定を追加して」などのリクエストで使用してください。
---

# Dotfiles Sync

dotfiles リポジトリのシンボリックリンク管理を一元化するスキル。

## ワークフロー

### 1. リンク状態の確認

リンク状態を確認する際は `scripts/check_links.sh` を実行：

```bash
bash ~/dotfiles/.claude/skills/dotfiles-sync/scripts/check_links.sh
```

出力内容:
- 正常なリンク一覧（リンク元 -> リンク先）
- 壊れたリンク（リンク先が存在しない）
- リンクされていない dotfiles 内のファイル

### 2. 新しいツールの設定追加

ユーザーが新しいツールの設定を dotfiles に追加したい場合：

1. ツール名と設定ファイルのパスを確認
2. `common/` 配下に設定ディレクトリを作成
3. 設定ファイルを `common/{tool}/` に移動
4. `common/synbolic_link.sh` にリンク作成コマンドを追記

追記パターン（既存のスクリプトに合わせる）：

```bash
# {tool_name}
mkdir -p ~/.config/{tool_name}
ln -sf ~/dotfiles/common/{tool_name}/{config_file} ~/.config/{tool_name}/{config_file}
```

プラットフォーム依存の設定パスがある場合（lazygit, bookokrat と同じパターン）：

```bash
# {tool_name}
if [ "$(uname)" = "Darwin" ]; then
  mkdir -p "$HOME/Library/Application Support/{tool_name}"
  ln -sf ~/dotfiles/common/{tool_name}/{config_file} "$HOME/Library/Application Support/{tool_name}/{config_file}"
else
  mkdir -p ~/.config/{tool_name}
  ln -sf ~/dotfiles/common/{tool_name}/{config_file} ~/.config/{tool_name}/{config_file}
fi
```

#### チェックリスト

新ツール追加時に確認すべき事項：

- [ ] 設定ファイルを `common/{tool}/` にコピー済みか
- [ ] `synbolic_link.sh` にリンクコマンドを追記済みか
- [ ] `mkdir -p` で親ディレクトリを作成しているか
- [ ] macOS / Linux で設定パスが異なるか確認したか
- [ ] CLAUDE.md の該当セクションを更新したか

### 3. リンクの修復

壊れたリンクが見つかった場合：

1. リンク先ファイルが dotfiles リポジトリ内に存在するか確認
2. ファイルが移動・削除されている場合は原因を特定
3. `synbolic_link.sh` 内のパスを修正するか、不要なリンクエントリを削除

### 4. 設定ファイルの逆取り込み

既に `~/.config/` に設定がある場合の取り込み手順：

```bash
# 1. 設定ファイルを dotfiles にコピー
cp ~/.config/{tool}/{config} ~/dotfiles/common/{tool}/{config}

# 2. 元ファイルを削除
rm ~/.config/{tool}/{config}

# 3. シンボリックリンクを作成
ln -sf ~/dotfiles/common/{tool}/{config} ~/.config/{tool}/{config}

# 4. synbolic_link.sh に追記
```

## リファレンス

- リンク定義の詳細: [references/link-map.md](references/link-map.md)

---
name: nvim-checkhealth-report
description: Neovim の `:checkhealth` を実行し、検出された問題（ERROR / WARNING）の修正方法を調査して重要度で優先順位付けし、Markdown 形式のレポートを生成します。「checkhealth」「Neovim のヘルスチェック」「nvim 健康診断」「nvim の健康状態を確認」などのリクエストで使用してください。デフォルトはレポート作成のみ、修正実行はユーザー承認後に行います。
---

# Neovim checkhealth レポート生成

Neovim の `:checkhealth` を headless モードで実行し、検出された問題の修正方法を調査して重要度で優先順位付けした Markdown レポートを作成します。プラグイン LSP 診断 (`nvim-diagnostics` skill) と異なり、こちらは Neovim 全体（プラグイン・プロバイダ・ランタイム）の健全性を対象とします。

## 発動条件

- 「checkhealth」
- 「Neovim のヘルスチェック」
- 「nvim 健康診断」
- 「nvim の健康状態を確認」

## ワークフロー

### 1. レポート保存先の確認

デフォルト: `.claude_work/checkhealth-reports/YYYY-MM-DD-HHmm.md`

ユーザーに必ず提示してから進める:

> 「デフォルトの `.claude_work/checkhealth-reports/2026-04-26-1234.md` で作成します。別のパスを希望される場合は指定してください」

`.claude_work/` はグローバル gitignore 対象 (`~/.config/git/ignore`) のため commit には含まれない。

### 2. checkhealth 実行

headless モードで実行し、結果を一時ファイルへ保存:

```bash
nvim --headless "+checkhealth" "+write! /tmp/checkhealth.txt" "+qa" 2>/dev/null
```

完了後、Read ツールで `/tmp/checkhealth.txt` を読む。大きい場合は offset 指定で分割読み込み。

### 3. 問題の抽出と分類

出力フォーマット:

- セクション区切り: `==============================================================================`
- セクションタイトル直後にカウンタ表示 (例: `lazy: 2 ⚠️  1 ❌`)
- 問題行の prefix:
  - `- ❌ ERROR ...` : 致命的な問題（必須対応）
  - `- ⚠️ WARNING ...` : 警告（推奨対応）
  - `- ✅ OK ...` : 正常（レポート対象外）

抽出例:

```bash
grep -nE "❌ ERROR|⚠️ WARNING" /tmp/checkhealth.txt
```

各問題は属するセクション名（プラグイン/モジュール名）と前後の ADVICE 行を保持する。`ADVICE` ブロックは checkhealth 自身が出力する公式の修正提案であり、最重要情報源。

### 4. 修正方法の調査

各 ERROR / WARNING に対して、以下の優先順で情報を集める:

1. **checkhealth の ADVICE 行** を最優先で参照（公式の修正手順）
2. **不足ツールの場合**: macOS なら Homebrew、Linux なら apt 等のインストール方法を確認
3. **Neovim プラグイン関連の最新仕様**: 必要に応じて context7 (`mcp__plugin_context7_context7__resolve-library-id` → `query-docs`) で確認
4. **既存設定ファイル**: `~/.config/nvim/` (dotfiles では `common/nvim/`) の関連箇所を Grep / Read で確認
5. **不明な場合のみ** WebSearch / WebFetch で公式ドキュメントを取得

### 5. 重要度の優先順位付け

| ランク       | 区分                    | 判定基準                                                                                  |
| ------------ | ----------------------- | ----------------------------------------------------------------------------------------- |
| 🔴 Critical  | ERROR                   | 機能停止・起動失敗につながる                                                              |
| 🟡 Important | WARNING（機能影響あり） | LSP / Treesitter / 主要プロバイダ (node/python3/clipboard) 未設定など、編集体験が劣化する |
| 🟢 Minor     | WARNING（任意機能）     | 利用していないオプション機能の不足（例: `hg` 未インストール、未使用言語のプロバイダ）     |

判定が曖昧な場合は Important 寄りに分類し、レポート内で根拠を明記する。

### 6. レポート生成

決定済みパスへ Write ツールで以下のフォーマットで出力:

````markdown
# Neovim checkhealth レポート

**実行日時**: YYYY-MM-DD HH:mm
**Neovim**: vX.Y.Z（取得できれば）
**検出件数**: 🔴 N 件 / 🟡 M 件 / 🟢 L 件

## サマリ

（全体感を 2-3 行で。最も対応すべき項目を 1 つ強調）

---

## 🔴 Critical（要対応）

### 1. [セクション名] 簡潔なタイトル

- **症状**: `❌ ERROR ...` の原文
- **影響**: どの機能が動かなくなるか
- **原因**: 調査結果
- **修正手順**:
  1. ...
  2. ...
- **コマンド例**:
  ```bash
  brew install ...
  ```
- **参照**: ADVICE 行 / 公式ドキュメント URL（あれば）

---

## 🟡 Important

（同フォーマット）

---

## 🟢 Minor

（同フォーマット。簡潔でよい）

---

## 修正後の再チェック

```bash
nvim --headless "+checkhealth" "+qa"
```

または問題のあったセクションのみ:

```bash
nvim --headless "+checkhealth lazy" "+qa"
```
````

### 7. 修正実行の確認

レポート完成を報告したら、必ず以下のいずれを希望するかユーザーに尋ねる:

> 「`path/to/report.md` を作成しました。記載した修正手順をどう進めますか?
>
> - (A) 🔴 Critical のみ修正実行
> - (B) すべて修正実行
> - (C) 実行しない（レポート確認のみ）」

ユーザーが (A) または (B) を選んだ場合のみ修正手順を順次適用する。各手順は実行前に「これから〜を実行します」と短く宣言する。破壊的操作（パッケージ削除等）は対象に含まれた時点でその都度確認する。

## 実装上の注意

### Neovim バージョン取得

```bash
nvim --version | head -1
```

### 出力の文字コード

絵文字 (✅ ⚠️ ❌) は UTF-8。grep / ripgrep ともに問題なく扱える。Bash 経由ではなく Read ツールで /tmp/checkhealth.txt を読むのが安全。

### 出力サイズ

100 プラグイン規模では 700〜1500 行になる。Read ツールで全体を一度に読むか、`grep -nE "==|❌|⚠️"` で構造を把握してから該当セクションを offset 指定で読む。

### 一時ファイルのクリーンアップ

`/tmp/checkhealth.txt` は OS 再起動で消えるため明示削除は不要。同名で再実行すれば上書きされる。

### 重複ファイル名

同一分内に再実行された場合は同じファイル名となる。差分追記ではなく上書きが既定。意図的に履歴を残したい場合は `-v2` などのサフィックスを付与する。

### 対象外

- **LSP の診断情報**（バッファ単位のエラー/警告）は別 skill `nvim-diagnostics` を使用する
- **プラグインの個別動作テスト**（`:Lazy check` 等）はスコープ外

## 例: 出力スニペット → レポート抜粋

入力（checkhealth.txt の一部）:

```
==============================================================================
lazy:                                                               2 ⚠️  1 ❌

luarocks ~
- ❌ ERROR {/Users/.../lazy-rocks/hererocks/bin/luarocks} not installed
- ⚠️ WARNING {/Users/.../lazy-rocks/hererocks/bin/lua} version `5.1` not installed
- ADVICE:
  - Install lua5.1 and luarocks, OR set `opts.rocks.enabled = false`
```

レポート出力:

````markdown
## 🔴 Critical（要対応）

### 1. [lazy] luarocks がインストールされていない

- **症状**: `❌ ERROR ... luarocks not installed`
- **影響**: luarocks を必要とするプラグインの自動インストールが失敗する
- **原因**: lazy.nvim の hererocks 機能が有効だが lua5.1 / luarocks 未導入
- **修正手順** (どちらかを選択):
  1. **luarocks を導入する**:
     ```bash
     brew install lua@5.1 luarocks
     ```
  2. **luarocks 機能を無効化する** (luarocks 依存プラグインを使わない場合):
     `common/nvim/lua/plugins.lua` の lazy セットアップで `opts.rocks.enabled = false` を追加
- **参照**: ADVICE 行
````

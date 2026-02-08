---
name: nvim-diagnostics
description: Neovim の LSP が検出したエラー、警告、情報、ヒントを取得し、コードの問題点と修正案を提案します。「LSP の診断」「Neovim のエラー」「コードチェック」「診断情報」「LSP エラー」などのリクエストで使用してください。
---

# Neovim LSP 診断情報

Neovim の LSP が検出したエラー、警告、情報、ヒントを取得し、コードの問題点と修正案を提案します。

## 発動条件

以下のようなリクエストで発動：

- 「LSP の診断情報を取得して」
- 「Neovim のエラーを確認して」
- 「このファイルのコードチェックをして」
- 「診断情報を見せて」
- 「LSP のエラーを教えて」

## ワークフロー

### 1. 診断情報の取得方法を決定

ユーザーのリクエストに応じて、以下の方法から選択：

1. **引数なし**: 実行中の Neovim インスタンスから現在のバッファの診断情報を取得
2. **ファイルパス指定**: 指定されたファイルの診断情報を Neovim の headless モードで取得
3. **ディレクトリ指定**: カレントディレクトリ内の対象ファイル一覧を表示

### 2. 診断情報の分析

取得した診断情報（エラー、警告など）を以下の観点で分析：

- エラーの重要度順に整理（ERROR > WARN > INFO > HINT）
- 各問題の根本原因を特定
- 関連する問題をグルーピング

### 3. 修正案と説明の提供

各問題に対して以下を提供：

- 具体的な修正案（修正前後のコード）
- 根本原因の説明
- 関連する問題の指摘
- ベストプラクティスの提案

## 診断情報の取得方法

### 方法1: 実行中の Neovim インスタンスから取得（推奨）

**前提条件:**

- Neovim のターミナルモード (`:term`) から Claude Code を起動している
- 環境変数 `$NVIM` が設定されている

**確認コマンド:**

```bash
echo $NVIM
```

`$NVIM` が設定されていれば、以下のコマンドで診断情報を取得：

```bash
nvim --server "$NVIM" --remote-expr 'luaeval("vim.diagnostic.get()")'
```

**利点:**

- リアルタイムの診断情報
- LSP サーバーが既に起動している
- 現在編集中のバッファの情報を直接取得
- 最も高速で正確

### 方法2: Headless モードで特定ファイルを解析

**使用ケース:**

- ファイルパスを指定した場合
- Neovim を実行していない状態
- CI/CD やスクリプトからの自動実行

**取得コマンド例:**

```bash
nvim --headless -c "edit $FILE_PATH" \
  -c "lua local diags = vim.diagnostic.get(0); \
       for _, d in ipairs(diags) do \
         print(string.format('[%s] Line %d: %s', \
           d.severity == 1 and 'ERROR' or d.severity == 2 and 'WARN' or 'INFO', \
           d.lnum + 1, d.message)) \
       end" \
  -c "quitall"
```

**注意事項:**

- 初回実行時は LSP サーバーの起動に時間がかかる場合がある
- LSP サーバーの設定が必要

### 方法3: ディレクトリ内のファイル一覧表示

**使用ケース:**

- ユーザーが `.` を指定した場合
- 診断対象となるファイルを確認したい場合

**対象ファイルタイプ:**

- Lua (`.lua`)
- Python (`.py`)
- JavaScript/TypeScript (`.js`, `.ts`, `.jsx`, `.tsx`)
- Shell (`.sh`, `.bash`, `.zsh`)
- Go (`.go`)
- Rust (`.rs`)

**コマンド例:**

```bash
find . -type f \( -name "*.lua" -o -name "*.py" -o -name "*.js" -o -name "*.ts" \) 2>/dev/null
```

## 診断結果の形式

取得される診断情報には以下のフィールドが含まれます：

| フィールド | 説明                   | 例                              |
| ---------- | ---------------------- | ------------------------------- |
| `severity` | 重要度                 | 1=ERROR, 2=WARN, 3=INFO, 4=HINT |
| `lnum`     | 行番号（0-indexed）    | 42 → 実際は43行目               |
| `col`      | 列番号（0-indexed）    | 5 → 実際は6列目                 |
| `message`  | エラーメッセージ       | "undefined variable 'foo'"      |
| `source`   | 診断ソース             | "lua_ls", "pylint", "tsserver"  |
| `code`     | エラーコード（あれば） | "undefined-global"              |

**重要度の優先順位:**

1. **ERROR** (severity=1): 必ず修正すべき問題
2. **WARN** (severity=2): 修正を推奨する問題
3. **INFO** (severity=3): 参考情報
4. **HINT** (severity=4): 改善提案

## 分析と提案

診断情報を取得した後、以下の観点で分析と修正案を提供：

### 1. エラーの優先順位付け

ERROR > WARN > INFO > HINT の順に整理し、最も重要な問題から提示する。

### 2. 具体的な修正案

該当行のコードと修正後のコードを示す。

**例:**

````markdown
**修正前（10行目）:**

```lua
local x = undefinedVariable
```
````

**修正後:**

```lua
local x = definedVariable  -- または変数を定義
```

````

### 3. 根本原因の説明

なぜそのエラーが発生しているかを説明。

**例:**
```markdown
**原因**: `undefinedVariable` が定義されていないため、lua_ls が未定義変数として検出しています。
````

### 4. 関連する問題の指摘

連鎖的に発生している問題があれば指摘。

**例:**

```markdown
**関連問題**:

- 15行目でも同じ変数を参照しているため、同様のエラーが発生します
- この変数は `require()` で読み込むべきモジュールの可能性があります
```

### 5. ベストプラクティス

より良い書き方があれば提案。

**例:**

```markdown
**推奨**:

- 変数の型を明示的にアノテーションする
- `---@type string` のようなコメントを追加
```

## 対象ファイルタイプと LSP サーバー

このスキルは以下のファイルタイプに特に有効です：

| ファイルタイプ | 拡張子                 | LSP サーバー             |
| -------------- | ---------------------- | ------------------------ |
| Lua            | `.lua`                 | lua_ls                   |
| Python         | `.py`                  | pyright, pylsp, ruff_lsp |
| JavaScript     | `.js`, `.jsx`          | tsserver, eslint         |
| TypeScript     | `.ts`, `.tsx`          | tsserver, eslint         |
| Shell          | `.sh`, `.bash`, `.zsh` | bashls, shellcheck       |
| Go             | `.go`                  | gopls                    |
| Rust           | `.rs`                  | rust-analyzer            |
| C/C++          | `.c`, `.cpp`, `.h`     | clangd                   |
| JSON           | `.json`                | jsonls                   |
| YAML           | `.yaml`, `.yml`        | yamlls                   |

## 実行例

### 例1: 実行中の Neovim から診断情報を取得

**ユーザー:** 「現在のバッファの LSP 診断情報を取得して」

**Claude の対応:**

1. `$NVIM` が設定されているか確認

   ```bash
   echo $NVIM
   ```

2. 診断情報を取得

   ```bash
   nvim --server "$NVIM" --remote-expr 'luaeval("vim.diagnostic.get()")'
   ```

3. 結果を分析して提示

   ```markdown
   ## 診断結果（2件のエラー、1件の警告）

   ### ERROR (10行目): 未定義変数

   **メッセージ**: undefined global 'foo'
   **修正案**: 変数 `foo` を定義するか、typo を確認してください

   ### ERROR (25行目): 型不一致

   **メッセージ**: expected string, got number
   **修正案**: 数値を文字列に変換 `tostring(value)`

   ### WARN (30行目): 未使用変数

   **メッセージ**: unused local variable 'bar'
   **修正案**: 使用しない変数は削除するか、`_` で始める
   ```

### 例2: 特定ファイルの診断情報を取得

**ユーザー:** 「`src/config.lua` の診断情報を確認して」

**Claude の対応:**

1. headless モードで診断情報を取得

   ```bash
   nvim --headless -c "edit src/config.lua" \
     -c "lua local diags = vim.diagnostic.get(0); ..." \
     -c "quitall"
   ```

2. 結果を分析して修正案を提示

### 例3: ディレクトリ内のファイル一覧

**ユーザー:** 「カレントディレクトリの診断対象ファイルを見せて」

**Claude の対応:**

```bash
find . -type f \( -name "*.lua" -o -name "*.py" -o -name "*.js" \) 2>/dev/null
```

結果：

```
./src/init.lua
./src/config.lua
./tests/test_config.py
./scripts/build.js
```

## 注意事項

### LSP サーバーが必要

- LSP サーバーが起動していない場合、診断情報は取得できません
- Neovim の設定（LSP の設定）によって検出される問題が異なります

### パフォーマンス

- headless モードでは、初回実行時に LSP サーバーの起動に時間がかかる場合があります
- 大きなプロジェクトでは、診断情報の取得に数秒かかることがあります

### 診断情報の精度

- LSP サーバーの設定や品質によって、検出される問題の精度が異なります
- false positive（誤検出）が含まれる場合があります

## トラブルシューティング

### 問題1: 診断情報が取得できない

**症状**: コマンドを実行しても診断情報が表示されない

**確認手順:**

1. **$NVIM 環境変数が設定されているか確認**

   ```bash
   echo $NVIM
   ```

   **解決策**:
   - Neovim のターミナルモード (`:term`) 内で Claude Code を実行
   - または、ファイルパスを明示的に指定

2. **LSP サーバーが起動しているか確認**

   Neovim で以下を実行：

   ```vim
   :LspInfo
   ```

   **解決策**:
   - `:LspStart` で LSP サーバーを起動
   - LSP の設定を確認（`~/.config/nvim/init.lua` など）

3. **LSP サーバーがインストールされているか確認**

   **解決策**:
   - Mason を使用している場合: `:Mason` でインストール
   - 手動の場合: 対応する LSP サーバーをインストール
     ```bash
     # lua_ls の例
     brew install lua-language-server
     ```

### 問題2: 診断情報が空

**症状**: コマンドは成功するが、診断情報が空

**原因:**

- そのファイルにエラーや警告がない（正常な状態）
- LSP サーバーがまだ解析を完了していない

**解決策:**

- 数秒待ってから再度実行
- 意図的にエラーを含むコードで動作確認

### 問題3: headless モードが遅い

**症状**: headless モードでの実行に時間がかかる

**原因:**

- LSP サーバーの初回起動時間
- 大規模なプロジェクトの解析

**解決策:**

- 実行中の Neovim インスタンスから取得する方法（方法1）を使用
- LSP サーバーのキャッシュを利用

### 問題4: Neovim が見つからない

**症状**: `nvim: command not found`

**解決策:**

```bash
# Neovim がインストールされているか確認
which nvim

# インストールされていない場合
# macOS
brew install neovim

# Ubuntu/Debian
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim
```

## 応用例

### 1. CI/CD での自動チェック

```bash
# すべての Lua ファイルをチェック
for file in $(find . -name "*.lua"); do
  echo "Checking $file..."
  nvim --headless -c "edit $file" -c "lua ..." -c "quitall"
done
```

### 2. pre-commit フックでの利用

```bash
#!/bin/bash
# .git/hooks/pre-commit

changed_files=$(git diff --cached --name-only --diff-filter=ACMR | grep '\.lua$')

for file in $changed_files; do
  # LSP 診断を実行
  # エラーがあればコミットを中断
done
```

### 3. バッチ処理

複数のファイルをまとめて診断：

```bash
files=("src/init.lua" "src/config.lua" "src/utils.lua")

for file in "${files[@]}"; do
  echo "=== Diagnosing $file ==="
  # 診断実行
done
```

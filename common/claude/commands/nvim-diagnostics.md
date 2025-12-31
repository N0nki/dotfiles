# Neovim LSP 診断情報

## 役割

Neovim の LSP が検出したエラー、警告、情報、ヒントを取得し、コードの問題点と修正案を提案する。

## ワークフロー

1. ユーザーがこのコマンドを実行したら、以下の方法で診断情報を取得する：
   - 引数なし: 実行中の Neovim インスタンスから現在のバッファの診断情報を取得
   - 引数あり: 指定されたファイルの診断情報を Neovim の headless モードで取得
2. 取得した診断情報（エラー、警告など）を分析する
3. 各問題に対して具体的な修正案と説明を提供する

## 使い方

### 基本的な使い方

```
/nvim-diagnostics                    # 実行中の Neovim から診断情報を取得
/nvim-diagnostics path/to/file.lua   # 特定ファイルの診断情報を取得
/nvim-diagnostics .                  # カレントディレクトリ内の対象ファイル一覧を表示
```

## 診断情報の取得

### 方法1: 実行中の Neovim インスタンスから取得（推奨）

Neovim のターミナルモード (`:term`) から Claude Code を起動している場合、環境変数 `$NVIM` が設定されているため、RPC 経由でライブ診断情報を取得できます。

**取得コマンド:**

```bash
nvim --server "$NVIM" --remote-expr 'luaeval("vim.diagnostic.get()")'
```

**利点:**

- リアルタイムの診断情報
- LSP サーバーが既に起動している
- 現在編集中のバッファの情報を直接取得

### 方法2: Headless モードで特定ファイルを解析

ファイルパスを指定した場合、Neovim を headless モードで起動して診断情報を取得します。

**取得コマンド例:**

```bash
nvim --headless -c "edit $1" \
  -c "lua local diags = vim.diagnostic.get(0); \
       for _, d in ipairs(diags) do \
         print(string.format('[%s] Line %d: %s', \
           d.severity == 1 and 'ERROR' or d.severity == 2 and 'WARN' or 'INFO', \
           d.lnum + 1, d.message)) \
       end" \
  -c "quitall"
```

**利点:**

- Neovim を実行していない状態でも診断可能
- CI/CD やスクリプトからの自動実行に適している

### 方法3: ディレクトリ内のファイル一覧

引数に `.` を指定した場合、診断対象となるファイル（Lua, Python, JavaScript, TypeScript, Shell など）のリストを表示します。

## 診断結果の形式

取得される診断情報には以下が含まれます：

- **severity**: 重要度 (1=ERROR, 2=WARN, 3=INFO, 4=HINT)
- **lnum**: 行番号（0-indexed）
- **col**: 列番号（0-indexed）
- **message**: エラーメッセージ
- **source**: 診断ソース（例: "lua_ls", "pylint"）
- **code**: エラーコード（利用可能な場合）

## 分析と提案

診断情報を取得した後、以下の観点で分析と修正案を提供する：

1. **エラーの優先順位付け**: ERROR > WARN > INFO > HINT の順
2. **具体的な修正案**: 該当行のコードと修正後のコードを示す
3. **根本原因の説明**: なぜそのエラーが発生しているか
4. **関連する問題の指摘**: 連鎖的に発生している問題があれば指摘
5. **ベストプラクティス**: より良い書き方があれば提案

## 注意事項

- LSP サーバーが起動していない場合、診断情報は取得できません
- Neovim の設定（LSP の設定）によって検出される問題が異なります
- headless モードでは、初回実行時に LSP サーバーの起動に時間がかかる場合があります

## 対象ファイルタイプ

このコマンドは以下のファイルタイプに特に有効です：

- **Lua** (`.lua`): lua_ls による診断
- **Python** (`.py`): pyright, pylsp などによる診断
- **JavaScript/TypeScript** (`.js`, `.ts`, `.jsx`, `.tsx`): tsserver による診断
- **Shell** (`.sh`, `.bash`, `.zsh`): bashls, shellcheck による診断
- **Go** (`.go`): gopls による診断
- **Rust** (`.rs`): rust-analyzer による診断

## トラブルシューティング

### 診断情報が取得できない場合

1. **$NVIM 環境変数が設定されていない**
   - Neovim のターミナルモード (`:term`) 内で Claude Code を実行してください
   - または、ファイルパスを明示的に指定してください

2. **LSP サーバーが起動していない**
   - Neovim で `:LspInfo` を実行して、LSP サーバーの状態を確認してください
   - `:LspStart` で LSP サーバーを起動してください

3. **診断情報が空の場合**
   - そのファイルにエラーや警告がない状態です
   - または、LSP サーバーがまだ解析を完了していない可能性があります

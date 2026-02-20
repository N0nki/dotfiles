---
name: nvim-plugin-manager
description: Neovim プラグインの管理を支援します。plugins.lua を解析してプラグイン一覧・カテゴリ別整理、無効化プラグインの検出、未使用設定ファイルの発見、新規プラグイン追加のボイラープレート生成を行います。「プラグイン一覧」「プラグイン整理」「プラグイン追加」「未使用プラグイン」「nvim プラグイン」などのリクエストで使用してください。
---

# Neovim Plugin Manager

Neovim プラグイン（lazy.nvim）の管理を効率化するスキル。

## ファイル構成

```
common/nvim/
├── lua/plugins.lua              # プラグイン宣言（全プラグインのエントリポイント）
└── lua/pluginconfig/            # プラグイン個別設定
    ├── appearance/              # UI・テーマ・ステータスライン
    ├── lsp/                     # LSP・補完・シンタックス
    ├── explorer/                # ファイル探索・検索
    ├── motion/                  # 移動・ウィンドウ操作
    ├── git/                     # Git 連携
    ├── terminal/                # ターミナル・実行
    ├── lang/                    # 言語固有
    └── util/                    # ユーティリティ
```

## ワークフロー

### 1. プラグイン一覧の取得

`scripts/list_plugins.sh` を実行して現在のプラグイン状態を把握：

```bash
bash ~/dotfiles/.claude/skills/nvim-plugin-manager/scripts/list_plugins.sh
```

出力内容:
- 全プラグイン数（有効 / 無効）
- カテゴリ別の内訳
- 無効化されているプラグイン一覧
- 設定ファイルがあるがプラグイン宣言のないファイル（孤立設定）
- プラグイン宣言はあるが設定ファイルのないプラグイン

### 2. 新規プラグイン追加

新しいプラグインを追加する際の手順：

#### Step 1: plugins.lua にプラグイン宣言を追加

`common/nvim/lua/plugins.lua` の適切なカテゴリセクションに追記：

```lua
-- 設定不要の場合
{ "author/plugin-name" },

-- 設定ファイルがある場合
{
  "author/plugin-name",
  config = function()
    require("pluginconfig.{category}.{plugin-name}")
  end,
},

-- 遅延読み込みの場合
{
  "author/plugin-name",
  event = "BufReadPre",  -- or "VeryLazy", "InsertEnter", etc.
  config = function()
    require("pluginconfig.{category}.{plugin-name}")
  end,
},
```

#### Step 2: 設定ファイルを作成（必要な場合）

`common/nvim/lua/pluginconfig/{category}/{plugin-name}.lua` を作成。

カテゴリの選択基準：

| カテゴリ | 用途 | 例 |
|---------|------|-----|
| `appearance` | UI、テーマ、表示 | lualine, noice, colorscheme |
| `lsp` | LSP、補完、フォーマッタ | nvim-cmp, conform, trouble |
| `explorer` | ファイル検索・ブラウズ | telescope, nvim-tree |
| `motion` | カーソル移動、ウィンドウ | flash, easymotion |
| `git` | Git 操作 | fugitive, gitsigns, diffview |
| `terminal` | ターミナル、コード実行 | toggleterm, quickrun |
| `lang` | 言語固有の設定 | vim-go, vimtex |
| `util` | その他ユーティリティ | |

#### Step 3: 確認

Neovim を起動して `:Lazy` でプラグインが正しくインストールされたか確認。

### 3. プラグインの無効化

一時的に無効化する場合、`plugins.lua` のプラグイン宣言に `enabled = false` を追加：

```lua
{
  "author/plugin-name",
  enabled = false,  -- 一時的に無効化
  config = function()
    require("pluginconfig.category.plugin-name")
  end,
},
```

### 4. プラグインの削除

完全に削除する場合：

1. `plugins.lua` からプラグイン宣言を削除
2. `pluginconfig/{category}/{plugin-name}.lua` を削除
3. `keymap.lua` 内の関連キーマップを削除
4. Neovim を起動して `:Lazy clean` で未使用プラグインを除去

### 5. 孤立設定ファイルの整理

スクリプトが検出した孤立設定ファイル（pluginconfig 内にあるが plugins.lua で参照されていない）は、以下を確認：

- プラグインが削除済みなら設定ファイルも削除
- `require` パスのタイポがないか確認
- 別の場所から `require` されている可能性を確認

**除外対象（孤立として無視してよいファイル）:**

- `pluginconfig/appearance/colorscheme.lua`: plugins.lua からではなく独立して使用されるカラースキーム設定

## リファレンス

- カテゴリ別プラグイン一覧: [references/plugin-categories.md](references/plugin-categories.md)

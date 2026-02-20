# Neovim Plugin Categories

プラグイン設定ファイルのカテゴリ分類ガイド。

## カテゴリ定義

### appearance (UI・テーマ)

見た目に関するプラグイン。

- カラースキーム (tokyonight, kanagawa, nightfox, iceberg, gruvbox)
- ステータスライン (lualine)
- インデントガイド (indent-blankline)
- 通知・コマンドライン UI (noice)
- アイコン (devicons, lspkind)

### lsp (LSP・補完・構文)

コード補完・診断・フォーマットに関するプラグイン。

- LSP クライアント (nvim-lspconfig)
- LSP サーバー管理 (mason, mason-lspconfig)
- 補完エンジン (nvim-cmp + ソース)
- フォーマッタ (conform)
- 診断 UI (trouble)
- Treesitter (nvim-treesitter, rainbow-delimiters, treesitter-context)

### explorer (検索・ブラウズ)

ファイル検索・ブラウジングに関するプラグイン。

- ファジーファインダ (telescope + extensions)
- ファイルツリー (nvim-tree)
- 検索ステータス (vim-anzu)

### motion (移動・ウィンドウ)

カーソル移動・ウィンドウ操作に関するプラグイン。

- ジャンプ (flash, easymotion)
- マルチカーソル (vim-visual-multi)
- ウィンドウ管理・リサイズ

### git (Git 連携)

Git 操作に関するプラグイン。

- Git コマンド (fugitive + gitlab)
- 変更表示 (gitsigns)
- Diff ビュー (diffview)
- Gist 管理

### terminal (ターミナル・実行)

ターミナル・コード実行に関するプラグイン。

- ターミナルトグル (toggleterm)
- tmux 連携 (tmux-coding-agent)
- コード実行 (neoterm, quickrun)

### lang (言語固有)

特定言語のサポートプラグイン。

- Go (vim-go)
- Terraform (vim-terraform)
- LaTeX (vimtex)
- Markdown (vim-markdown, render-markdown)
- JSON (vim-json)
- TOML (vim-toml)

### util (ユーティリティ)

その他の汎用ユーティリティプラグイン。

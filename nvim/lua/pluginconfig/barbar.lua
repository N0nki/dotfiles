-- barbar

require('barbar').setup({
  -- アニメーション有効化
  animation = true,

  -- 自動非表示（1つのバッファ/タブのみの場合）
  auto_hide = false,

  -- タブページモード（bufferlineの設定に合わせる）
  tabpages = true,

  -- クリック可能なアイコン
  clickable = true,

  -- 除外するファイルタイプとバッファタイプ
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  -- アイコン設定
  icons = {
    -- deviconsを有効化
    buffer_index = false,
    buffer_number = false,
    button = '',

    -- 診断マーカー
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ' '},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },

    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },

    -- ファイルタイプアイコンを表示
    filetype = {
      custom_colors = false,
      enabled = true,
    },

    separator = {left = '▎', right = ''},

    -- 修正マーカー
    modified = {button = '●'},

    -- ピン留めアイコン
    pinned = {button = '', filename = true},

    -- 代替バッファのマーカー
    alternate = {filetype = {enabled = false}},

    -- 現在のバッファのマーカー
    current = {buffer_index = true},

    -- 非アクティブバッファ
    inactive = {button = 'x'},

    -- 表示可能なバッファ
    visible = {modified = {buffer_number = false}},
  },

  -- 最大バッファ名長
  maximum_padding = 1,

  -- 最小バッファ名長
  minimum_padding = 1,

  -- 最大長
  maximum_length = 30,

  -- 最小長
  minimum_length = 0,

  -- セマンティックレター
  semantic_letters = true,

  -- タブラベルにパスではなくファイル名のみ表示
  no_name_title = nil,
})

-- キーマップ設定
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- タブ間の移動
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- タブの並び替え
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- 番号でタブに移動
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- ピン留め
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- タブを閉じる
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- マジックバッファピッカーモード
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- 並び替え: バッファ番号順、ディレクトリ順、言語順、ウィンドウ番号順
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

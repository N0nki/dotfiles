-- bufferline

local bufferline = require('bufferline')

require("bufferline").setup({
  options = {
    -- タブページモード
    mode = "tabs",

    -- style_preset の代わりに詳細なカスタマイズ
    themable = true, -- カラースキームに合わせてハイライトを調整

    -- タブ番号を表示
    numbers = "ordinal",

    -- マウスアクション
    close_command = "tabclose %d",
    right_mouse_command = "tabclose %d",
    left_mouse_command = "tabnext %d",
    middle_mouse_command = nil,

    -- インジケータ設定
    indicator = {
      icon = "▎",
      style = "icon",
    },

    -- アイコン設定
    buffer_close_icon = 'x',
    modified_icon = '●',
    close_icon = 'X',
    left_trunc_marker = '<',
    right_trunc_marker = '>',

    -- 表示設定
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 20,

    -- LSP診断表示
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_update_on_event = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,

    -- アイコン表示
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,

    -- セパレータースタイル
    separator_style = "slant",

    -- タブラインを常に表示
    always_show_bufferline = true,

    -- ホバーイベント（Neovim 0.8+）
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },

    -- タブのソート方法
    sort_by = 'tabs',
  },
})

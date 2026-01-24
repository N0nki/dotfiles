require("vimade").setup({
    recipe = { "default", { animate = true } },
    -- fadelevel: 非アクティブウィンドウの暗さ (0.0-1.0)
    -- 0.0 = 完全にフェード, 1.0 = フェードなし
    fadelevel = 0.7,
    -- ncmode: フェード対象の選択
    -- 'buffers': 同じバッファを表示していないウィンドウをフェード
    -- 'windows': 全ての非アクティブウィンドウをフェード
    ncmode = "windows",

    -- 特定のファイルタイプやバッファタイプを除外
    blocklist = {
        default = {
            buf_opts = {
                buftype = { "prompt", "terminal" },
                filetype = { "NvimTree" },
            },
        },
    },
})

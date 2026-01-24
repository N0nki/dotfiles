-- vimade

-- フェードを許可するbuftype/filetype
local allowed_buftypes = { "prompt", "terminal" }
local allowed_filetypes = { "help", "qf", "NvimTree", "fugitive", "fugitiveblame", "git", "GV" }

require("vimade").setup({
    recipe = { "default", { animate = true } },
    -- fadelevel: 非アクティブウィンドウの暗さ (0.0-1.0)
    -- 0.0 = 完全にフェード, 1.0 = フェードなし
    fadelevel = 0.7,
    -- ncmode: フェード対象の選択
    -- 'buffers': 同じバッファを表示していないウィンドウをフェード
    -- 'windows': 全ての非アクティブウィンドウをフェード
    ncmode = "windows",

    blocklist = {
        -- 指定したbuftype/filetypeのみフェードを許可（それ以外はブロック）
        allowlist = function(win, current)
            local bufnr = win.bufnr
            local bt = vim.bo[bufnr].buftype
            local ft = vim.bo[bufnr].filetype

            -- allowed_buftypesに含まれていればフェードを許可
            for _, buftype in ipairs(allowed_buftypes) do
                if bt == buftype then
                    return false -- フェードを許可
                end
            end

            -- allowed_filetypesに含まれていればフェードを許可
            for _, filetype in ipairs(allowed_filetypes) do
                if ft == filetype then
                    return false -- フェードを許可
                end
            end

            return true -- それ以外はフェードをブロック
        end,
    },
})

-- true-zen.nvim

require("true-zen").setup({
    modes = {
        -- Ataraxis: Traditional zen mode with padding windows
        ataraxis = {
            minimum_writing_area_width = { 80 },
            padding = {
                left = 20,
                right = 20,
                top = 2,
                bottom = 2,
            },
            backdrop = 0.95, -- Backdrop transparency (0-1)
        },
    },
    integrations = {
        tmux = true, -- Hide tmux status bar in ataraxis mode
        lualine = true,
    },
})

-- Keybinding
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<Leader>tz", ":TZAtaraxis<CR>", opts)

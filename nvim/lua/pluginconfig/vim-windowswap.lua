-- vim-windowswap

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.windowswap_map_keys = 0

keymap("n", "<Leader>ww", ":call WindowSwap#EasyWindowSwap()<CR>", opts)

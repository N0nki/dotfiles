-- vim-anzu

local opts = {noremap = false, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap('n', "n", "<Plug>(anzu-n-with-echo)", opts)
keymap('n', "N", "<Plug>(anzu-N-with-echo)", opts)
keymap('n', "*", "<Plug>(anzu-star-with-echo)", opts)
keymap('n', "#", "<Plug>(anzu-sharp-with-echo)", opts)
-- keymap('n', "<Esc><Esc>", "<Plug>(anzu-clear-search-status)", opts)

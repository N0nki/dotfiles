-- CamelCaseMotion

local opts = {noremap = false, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("", "w", "<Plug>CamelCaseMotion_w", opts)
keymap("", "b", "<Plug>CamelCaseMotion_b", opts)
keymap("", "e", "<Plug>CamelCaseMotion_e", opts)
keymap("", "ge", "<Plug>CamelCaseMotion_ge", opts)

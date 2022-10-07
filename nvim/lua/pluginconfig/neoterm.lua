-- neoterm

local opts = {noremap = false, silent = true}
local keymap = vim.api.nvim_set_keymap

vim.g.neoterm_fixedsize = 1
vim.g.neoterm_size = 12
vim.g.neoterm_default_mod = "botright"

keymap("x", "gx", "<Plug>(neoterm-repl-send)", opts)

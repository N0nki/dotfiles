local opts = {noremap = false, silent = true}
local keymap = vim.api.nvim_set_keymap

vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_do_mapping = 0

keymap("n", "<Leader>", "<Plug>(easymotion-prefix)", opts)
keymap("n", "<Leader>j", "<Plug>(easymotion-j)", opts)
keymap("n", "<Leader>k", "<Plug>(easymotion-k)", opts)
keymap("n", "<Leader>s", "<Plug>(easymotion-sn)", opts)
keymap("n", "<Leader>f", "<Plug>(easymotion-f)", opts)
keymap("n", "<Leader>t", "<Plug>(easymotion-t)", opts)

-- fzf-vim

local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
local command = vim.api.nvim_create_user_command

keymap("n", "<Leader>df", ":<C-u>Files<CR>", opts)
keymap("n", "<Leader>dl", ":<C-u>Lines<CR>", opts)
keymap("n", "<Leader>da", ":<C-u>Ag<CR>", opts)
keymap("n", "<Leader>dh", ":<C-u>History<CR>", opts)
keymap("n", "<Leader>db", ":<C-u>Buffers<CR>", opts)

-- gist-vim

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.gist_open_browser_after_post = 1
vim.g.gist_show_privates = 1
vim.g.gist_post_private = 1
vim.g.gist_get_multiplefile = 1

-- post gist when execute w!
vim.g.gist_update_on_write = 2
keymap("n", "<Leader>gl", ":<C-u>tabnew<CR>:Gist -l<CR>", opts)

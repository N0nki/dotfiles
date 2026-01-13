-- vim-maximizer
-- Toggle window zoom (like tmux zoom)

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Toggle maximize current window
keymap("n", "<Leader>z", ":MaximizerToggle<CR>", opts)

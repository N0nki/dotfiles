-- nvim_context_vt

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

require("nvim_context_vt").setup({
    enabled = false,
    prefix = "",
    keymap("n", "<Leader>ht", ":<C-u>NvimContextVtToggle<CR>", opts),
})

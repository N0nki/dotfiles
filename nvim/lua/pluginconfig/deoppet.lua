-- deoppet

local opts = {noremap = false, silent = true}
local keymap = vim.api.nvim_set_keymap

vim.fn["deoppet#initialize"]()
vim.fn["deoppet#custom#option"](
  "snippets",
  vim.fn.map(vim.fn.globpath(vim.o.runtimepath, '*snippets', 1, 1), function(_, val) return {path = val} end)
)

keymap('i', "<C-k>", '<Plug>(deoppet_expand)', opts)
keymap('i', "<C-l>", '<Plug>(deoppet_jump_forward)', opts)
keymap('i', "<C-h>", '<Plug>(deoppet_jump_backward)', opts)
keymap('s', "<C-l>", '<Plug>(deoppet_jump_forward)', opts)
keymap('s', "<C-b>", '<Plug>(deoppet_jump_backward)', opts)

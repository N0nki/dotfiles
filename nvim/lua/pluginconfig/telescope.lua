-- telescope.nvim

local opts = {noremap = true, silent = true}
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    mappings = {
      n = {
        ["<C-g>"] = actions.close
      },
      i = {
        ["<C-g>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-f>"] = actions.select_vertical,
        ["<C-r>"] = actions.select_tab,
      }
    }
  }
})

require("telescope").load_extension("file_browser")

vim.keymap.set('n', '<leader>df', builtin.find_files, opts)
vim.keymap.set('n', '<leader>da', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>db', builtin.buffers, opts)
vim.keymap.set('n', '<leader>dh', builtin.help_tags, opts)
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', opts)

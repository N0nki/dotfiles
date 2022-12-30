-- nvim-tree

local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

require("nvim-tree").setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    width = 35,
    mappings = {
      list = {
        {key = {"<2-RightMouse>"}, action = ""},
        {key = "f", action = ""},
        {key = "l", action = "cd"},
        {key = "h", action = "dir_up"},
        {key = "s", action = "split"},
        {key = "v", action = "vsplit"},
        {key = "t", action = "tabnew"},
        {key = "<C-l>", action = "refresh"},
        {key = ".", action = "toggle_dotfiles"},
        {key = "m", action = "cut"},
        {key = "yy", action = "copy_absolute_path"},
        {key = "x", action = "system_open"},
        {key = "N", action = "create"},
        -- {key = "<Space>", action = "toggle_mark"},
      }
    },
  },
  git = {
    ignore = false,
  },
  filters = {
    dotfiles = true,
  },
})

keymap("n", "<Leader>e", ":<C-u>NvimTreeToggle<CR>", opts)

if vim.fn["argc"]() == 0 then
  autocmd("VimEnter", {
    pattern = "*",
    command = "NvimTreeToggle"
  })
end

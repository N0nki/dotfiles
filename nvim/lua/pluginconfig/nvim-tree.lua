-- nvim-tree

local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap
local del_keymap = vim.api.nvim_del_keymap

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
  vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
  vim.keymap.set("n", "f", "", { buffer = bufnr })
  vim.keymap.del("n", "f", { buffer = bufnr })

  vim.keymap.set("n", "l", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "<C-l>", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "m", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Remove"))
  vim.keymap.set("n", "yy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy relative Path"))
  vim.keymap.set("n", "x", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "N", api.fs.create, opts("Create"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
end

require("nvim-tree").setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    width = 35,
  },
  git = {
    ignore = false,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = on_attach,
})

keymap("n", "<Leader>e", ":<C-u>NvimTreeToggle<CR>", opts)

if vim.fn["argc"]() == 0 then
  autocmd("VimEnter", {
    pattern = "*",
    command = "NvimTreeToggle"
  })
end

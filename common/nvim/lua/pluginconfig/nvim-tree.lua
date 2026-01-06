-- nvim-tree

local autocmd = vim.api.nvim_create_autocmd
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function tree_opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
    vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
    vim.keymap.set("n", "f", "", { buffer = bufnr })
    vim.keymap.del("n", "f", { buffer = bufnr })

    vim.keymap.set("n", "l", api.tree.change_root_to_node, tree_opts("CD"))
    vim.keymap.set("n", "h", api.tree.change_root_to_parent, tree_opts("Up"))
    vim.keymap.set("n", "o", api.node.open.edit, tree_opts("Open"))
    vim.keymap.set("n", "s", api.node.open.horizontal, tree_opts("Open: Horizontal Split"))
    vim.keymap.set("n", "v", api.node.open.vertical, tree_opts("Open: Vertical Split"))
    vim.keymap.set("n", "t", api.node.open.tab, tree_opts("Open: New Tab"))
    vim.keymap.set("n", "q", api.tree.close, tree_opts("Close"))
    vim.keymap.set("n", "<C-l>", api.tree.reload, tree_opts("Refresh"))
    vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, tree_opts("Toggle Dotfiles"))
    vim.keymap.set("n", "m", api.fs.cut, tree_opts("Cut"))
    vim.keymap.set("n", "c", api.fs.copy.node, tree_opts("Copy"))
    vim.keymap.set("n", "d", api.fs.remove, tree_opts("Remove"))
    vim.keymap.set("n", "yy", api.fs.copy.absolute_path, tree_opts("Copy Absolute Path"))
    vim.keymap.set("n", "Y", api.fs.copy.relative_path, tree_opts("Copy relative Path"))
    vim.keymap.set("n", "x", api.node.run.system, tree_opts("Run System"))
    vim.keymap.set("n", "N", api.fs.create, tree_opts("Create"))
    vim.keymap.set("n", "r", api.fs.rename, tree_opts("Rename"))
    vim.keymap.set("n", "p", api.fs.paste, tree_opts("Paste"))
    vim.keymap.set("n", "<leader>m", api.marks.toggle, tree_opts("Toggle Bookmark"))
    vim.keymap.set("n", "bmv", api.marks.bulk.move, tree_opts("Bulk Move"))
    vim.keymap.set("n", "bd", api.marks.bulk.delete, tree_opts("Bulk Delete"))
    vim.keymap.set("n", "bt", api.marks.bulk.trash, tree_opts("Bulk Trash"))
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
    tab = {
        sync = {
            open = false,
            close = false,
            ignore = {},
        },
    },
    on_attach = on_attach,
})

keymap("n", "<Leader>e", ":<C-u>NvimTreeToggle<CR>", opts)
keymap("n", "<Leader>o", ":<C-u>NvimTreeOpen<CR>", opts)

if vim.fn["argc"]() == 0 then
    autocmd("VimEnter", {
        pattern = "*",
        -- command = "NvimTreeToggle"
        command = "NvimTreeOpen",
    })
end

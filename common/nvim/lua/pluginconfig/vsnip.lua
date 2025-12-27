-- vsnip

vim.g.vsnip_snippet_dirs = {
    vim.fn.expand("~/.config/nvim/vsnippets"),
    vim.fn.expand("~/.config/nvim/vsnippets.local"),
}

-- Helper function to create expression mappings
local function vsnip_map(mode, lhs, condition_fn, plug_name, fallback)
    vim.keymap.set(mode, lhs, function()
        if condition_fn() then
            return plug_name
        else
            return fallback
        end
    end, { expr = true, remap = true })
end

-- Expand snippet
vsnip_map("i", "<C-j>", function()
    return vim.fn["vsnip#expandable"]() == 1
end, "<Plug>(vsnip-expand)", "<C-j>")
vsnip_map("s", "<C-j>", function()
    return vim.fn["vsnip#expandable"]() == 1
end, "<Plug>(vsnip-expand)", "<C-j>")

-- Expand or jump
vsnip_map("i", "<C-l>", function()
    return vim.fn["vsnip#available"](1) == 1
end, "<Plug>(vsnip-expand-or-jump)", "<C-l>")
vsnip_map("s", "<C-l>", function()
    return vim.fn["vsnip#available"](1) == 1
end, "<Plug>(vsnip-expand-or-jump)", "<C-l>")

-- Jump forward or backward
vsnip_map("i", "<Tab>", function()
    return vim.fn["vsnip#jumpable"](1) == 1
end, "<Plug>(vsnip-jump-next)", "<Tab>")
vsnip_map("s", "<Tab>", function()
    return vim.fn["vsnip#jumpable"](1) == 1
end, "<Plug>(vsnip-jump-next)", "<Tab>")
vsnip_map("i", "<S-Tab>", function()
    return vim.fn["vsnip#jumpable"](-1) == 1
end, "<Plug>(vsnip-jump-prev)", "<S-Tab>")
vsnip_map("s", "<S-Tab>", function()
    return vim.fn["vsnip#jumpable"](-1) == 1
end, "<Plug>(vsnip-jump-prev)", "<S-Tab>")

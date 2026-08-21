-- markdown.nvim

local render_markdown = require("render-markdown")

render_markdown.setup({
    bullet = {
        icons = { "•", "◦", "▪", "▫" },
        left_pad = 1,
        right_pad = 1,
    },
    overrides = {
        preview = {
            enabled = true,
        },
    },
})
render_markdown.set(false) -- start disabled globally

-- Toggle render-markdown globally with <leader>mt
vim.keymap.set("n", "<leader>mt", function()
    render_markdown.toggle()
end, { desc = "Toggle markdown render" })

vim.keymap.set("n", "<leader>mT", function()
    render_markdown.preview()
end, { desc = "Preview markdown render" })

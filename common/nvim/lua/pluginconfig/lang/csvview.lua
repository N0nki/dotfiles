require("csvview").setup({
    view = {
        display_mode = "border",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "csv", "tsv" },
    callback = function()
        vim.keymap.set("n", "<leader>ct", "<cmd>CsvViewToggle<cr>", { buffer = true, desc = "Toggle CSV view" })
    end,
})

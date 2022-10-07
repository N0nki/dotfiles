local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufNewFile, BufRead"}, {
        pattern = "*.json",
        command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4",
})

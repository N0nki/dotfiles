-- conform.nvim

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        go = { "gofmt" },
        json = { "jq" },
        toml = { "taplo" },
        yaml = { "yamlfmt" },
        markdown = { "prettier" },
    },
    formatters = {
        jq = {
            args = { "--indent", "2" },
        },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local ignore_patterns = { "/fzf%-git/" }
        for _, pattern in ipairs(ignore_patterns) do
            if bufname:match(pattern) then
                return
            end
        end
        return {
            timeout_ms = 500,
            lsp_format = "fallback",
        }
    end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, { desc = "Enable autoformat-on-save" })

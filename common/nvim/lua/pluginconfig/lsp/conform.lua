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

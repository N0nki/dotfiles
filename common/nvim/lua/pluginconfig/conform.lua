-- conform.nvim

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        go = { "gofmt" },
        json = { "jq" },
        toml = { "taplo" },
        yaml = { "yamlfmt" },
        markdown = { "prettier" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

-- mason-lspconfig

require("mason-lspconfig").setup({
    ensure_installed = {
        "pylsp",
        "bashls",
        "lua_ls",
        "marksman",
        "terraformls",
        "gopls",
    },
})

local code_lens_method = vim.lsp.protocol.Methods.textDocument_codeLens

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local buf_keymap = vim.api.nvim_buf_set_keymap

    buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_keymap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_keymap(bufnr, "n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_keymap(bufnr, "n", "ge", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

    if client:supports_method(code_lens_method, bufnr) then
        vim.lsp.codelens.enable(true, { bufnr = bufnr, client_id = client.id })
        vim.keymap.set("n", "grx", vim.lsp.codelens.run, { buffer = bufnr, desc = "Run code lens", silent = true })
        vim.keymap.set("n", "<leader>cl", function()
            local enabled = vim.lsp.codelens.is_enabled({ bufnr = bufnr })
            vim.lsp.codelens.enable(not enabled, { bufnr = bufnr })
        end, { buffer = bufnr, desc = "Toggle code lens", silent = true })
    end
end

-- Default capabilities for all LSP servers
vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- lua_ls specific configuration to recognize 'vim' global
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- pylsp configuration
vim.lsp.config("pylsp", {})

-- bashls configuration
vim.lsp.config("bashls", {})
--
-- marksman configuration
vim.lsp.config("marksman", {})

-- terraform-ls configuration
vim.lsp.config("terraformls", {
    filetypes = { "terraform", "terraform-vars", "hcl" },
})

-- gopls configuration
vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            staticcheck = true,
        },
    },
})

-- Enable LSP servers
vim.lsp.enable("pylsp")
vim.lsp.enable("bashls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("terraformls")
vim.lsp.enable("gopls")

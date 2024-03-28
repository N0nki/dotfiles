-- mason-lspconfig


require("mason-lspconfig").setup()

local on_attach = function(client, bufnr)
  local opts = {noremap = true, silent = true}
  local buf_keymap = vim.api.nvim_buf_set_keymap

  buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_keymap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_keymap(bufnr, "n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_keymap(bufnr, "n", "ge", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim"
        }
      }
    }
  }
})

vim.g.lsp_diagnostics_enabled = 1
vim.g.lsp_virtual_text_enabled = 1
vim.g.lsp_diagnostics_echo_cursor = 1
vim.g.lsp_highlights_enabled = 0

local pyls_workspace_config = {
  pyls = {
    plugins = {
      pycodestyle = {enabled = true},
      pydocstyle = {enabled = false},
      pylint = {enabled = false},
      flake8 = {enabled = false},
      jedi_definition = {
        follow_imports = true,
        follow_builtin_imports = true,
      }
    }
  }
}

vim.g.lsp_settings = {
  pyls = {
    workspace_config = pyls_workspace_config
  }
}

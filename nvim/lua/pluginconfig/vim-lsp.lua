vim.g.lsp_diagnostics_enabled = 1
vim.g.lsp_diagnostics_virtual_text_enabled = 1
vim.g.lsp_diagnostics_signs_insert_mode_enabled = 1
vim.g.lsp_diagnostics_echo_cursor = 1
vim.g.lsp_diagnostics_highlights_enabled = 0
vim.g.lsp_diagnostics_virtual_text_prefix = " ‣ "
vim.g.lsp_diagnostics_signs_error = {text =  "❌"}
vim.g.lsp_diagnostics_signs_warning = {text =  "⚠️"}
vim.g.lsp_diagnostics_signs_hint = {text =  "☝️"}

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
-- vim-go

vim.g.go_highlight_functions = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_operators = 1
vim.g.go_fmt_command = "gopls"
-- Disable legacy gometalinter (deprecated) and rely on gopls for diagnostics
vim.g.go_metalinter_autosave = 0

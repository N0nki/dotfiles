-- vim-airline

-- vim.g.airline_theme = "base16_spacemacs"
-- vim.g.airline_theme = "base16_gruvbox_dark_medium"
vim.g.airline_theme = "deus"
vim.g.airline_section_c = "%F %{anzu#search_status()}"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#switch_buffers_and_tabs"] = 0
vim.g["airline#extensions#tabline#show_buffers"] = 0
vim.g["airline#extensions#lsp#enabled"] = 1

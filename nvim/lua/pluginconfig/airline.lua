-- vim-airline

vim.g.airline_theme = "base16_spacemacs"
vim.g.airline_section_c = "%F %{anzu#search_status()}"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#switch_buffers_and_tabs"] = 1
vim.g["airline#extensions#ale#enabled"] = 1

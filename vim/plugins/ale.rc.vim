let g:ale_sign_column_always = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_linters = {
\   'python': ['pylint'],
\}
"
" neovim(>=0.3.2) virtual text
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '▬▶  '
highlight link ALEVirtualTextError ErrorMsg
highlight link ALEVirtualTextStyleError ALEVirtualTextError
highlight link ALEVirtualTextWarning WarningMsg
highlight link ALEVirtualTextInfo ALEVirtualTextWarning
highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning

nnoremap <Leader>lt :<C-u>ALEToggle<CR>

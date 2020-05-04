let g:lsp_diagnostics_enabled = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlights_enabled = 0

" vim-lsp-settings configuration
let s:pyls_workspace_config = {'pyls': {'plugins': {
\  'pycodestyle': {'enabled': v:false},
\  'pydocstyle': {'enabled': v:false},
\  'pylint': {'enabled': v:false},
\  'flake8': {'enabled': v:false},
\  'jedi_definition': {
\    'follow_imports': v:true,
\    'follow_builtin_imports': v:true,
\  },
\}}}
let g:lsp_settings = {
\  'pyls': {
\    'workspace_config': s:pyls_workspace_config
\  },
\}

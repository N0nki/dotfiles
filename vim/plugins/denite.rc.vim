call denite#custom#option('default', 'prompt', '>')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

nnoremap <Leader>do :<C-U>Denite outline -cursor-wrap -highlight-mode-insert=Search -split=vertical -direction=aboveleft -winwidth=40<CR>
nnoremap <Leader>db :<C-U>Denite dirmark<CR>
nnoremap <Leader>da :<C-U>Denite -resume<CR>

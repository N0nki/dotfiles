" denite

call denite#custom#option('default', 'prompt', '>')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-g>', '<denite:quit>', 'noremap')
call denite#custom#map('insert', '<C-q>', '<denite:suspend>', 'noremap')
call denite#custom#map('normal', '<C-g>', '<denite:quit>', 'noremap')
call denite#custom#map('normal', '<C-q>', '<denite:suspend>', 'noremap')

nnoremap <Leader>do :<C-U>Denite outline -auto-resume -cursor-wrap -highlight-mode-insert=Search -split=vertical -direction=aboveleft -winwidth=40<CR>
nnoremap <Leader>db :<C-U>Denite dirmark<CR>

autocmd FileType tex call s:denite_tex_settings()
function! s:denite_tex_settings() abort
  nnoremap <buffer><Leader>do :<C-U>Denite vimtex -auto-resume -cursor-wrap -highlight-mode-insert=Search -split=vertical -direction=aboveleft -winwidth=40<CR>
endfunction

autocmd FileType markdown call s:denite_markdown_settings()
function! s:denite_markdown_settings() abort
  nnoremap <buffer><Leader>do :<C-U>Denite markdown -auto-resume -cursor-wrap -highlight-mode-insert=Search -split=vertical -direction=aboveleft -winwidth=40<CR>
endfunction

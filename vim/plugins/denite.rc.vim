" denite

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings()
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
endfunction

nnoremap <Leader>do :<C-U>Denite outline -resume -split=vertical -direction=aboveleft -winwidth=40<CR>
nnoremap <Leader>dd :<C-U>Denite dirmark<CR>

autocmd FileType tex call s:denite_tex_settings()
function! s:denite_tex_settings() abort
  nnoremap <Leader>do :<C-U>Denite vimtex -resume -split=vertical -direction=aboveleft -winwidth=40<CR>
endfunction

autocmd FileType markdown call s:denite_markdown_settings()
function! s:denite_markdown_settings() abort
  nnoremap <Leader>do :<C-U>Denite markdown -resume -split=vertical -direction=aboveleft -winwidth=40<CR>
endfunction

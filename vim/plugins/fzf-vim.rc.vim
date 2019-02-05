" fzf.vim

" :Fileでファイルをプレビュー
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" :Ag実行中に?押下でプレビュー
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

nnoremap <Leader>df :<C-u>Files<CR>
nnoremap <Leader>dl :<C-u>Lines<CR>
nnoremap <Leader>da :<C-u>Ag<CR>
nnoremap <Leader>dh :<C-u>History<CR>

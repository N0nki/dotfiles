" deoplete

if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:neocomplete#enable_at_startup = 0
else
  let g:deoplete#enable_at_startup = 0
  let g:neocomplete#enable_at_startup = 1
endif


" vim-airline

if has('nvim')
  let g:airline_theme = 'molokai'
else
  let g:airline_theme = 'powerlineish'
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1

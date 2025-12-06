" vim-airline

if has('nvim')
  " let g:airline_theme = 'molokai'
  " let g:airline_theme = 'tomorrow'
  let g:airline_theme = 'base16_spacemacs'
else
  let g:airline_theme = 'bubblegum'
endif

let g:airline_section_c = '%F %{anzu#search_status()}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#ale#enabled = 1

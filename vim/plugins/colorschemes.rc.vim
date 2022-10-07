if has('gui_vimr')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme spacegray
elseif has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme iceberg
  " colorscheme icy
else
  colorscheme nord
endif

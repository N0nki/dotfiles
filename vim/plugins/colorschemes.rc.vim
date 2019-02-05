if has('gui_vimr')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme onedark
elseif has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme iceberg
else
  colorscheme colorsbox-stnight
endif

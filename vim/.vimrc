augroup MyAutoCmd
  autocmd!
augroup END


" plugin settings ------------------------
" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:unite_source_history_yank_enable = 1


" neocomplete
let g:neocomplete#enable_at_startup = 1


" vim-airline
let g:airline_theme = 'powerlineish'


" indentLine
let g:indent_guides_start_level = 2
" let g:indent_guides_color_term = 239
let g:indentLine_color_term = 239
let g:indentLine_char = '│'

" vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_scrollback_limit = 100000


" vimtex
" 下記URLを参考にした
" https://texwiki.texjp.org/?vimtex
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1
"let g:vimtex_latexmk_options = '-pdf'
let g:vimtex_latexmk_options = '-pdfdvi'
"let g:vimtex_latexmk_options = '-pdfps'
"let g:vimtex_view_general_viewer = 'open'
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '@line @pdf @tex'

" end plugin settings --------------------


"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Required:
" set runtimepath+=/Users/MacMini/.cache/dein/repos/github.com/Shougo/dein.vim
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" begin setting
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" 各種設定とkeymapを読み込み
runtime! options.rc.vim
runtime! keymap.rc.vim

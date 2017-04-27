augroup MyAutoCmd
  autocmd!
augroup END


let g:neocomplete#enable_at_startup = 0


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

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
  " call dein#install('Townk/vim-autoclose')
endif


" 各種設定とkeymapを読み込み
runtime! options.rc.vim
runtime! keymap.rc.vim

" options

syntax on
set termguicolors
" set t_Co=256
set background=dark
if has('gui_vimr')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme onedark
elseif has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme iceberg
else
  colorscheme gruvbox
endif

if has('nvim')
  " terminalのカラーパレット
  let g:terminal_color_0 = '#161821'
  let g:terminal_color_1 = '#e27878'
  let g:terminal_color_2 = '#b4be82'
  let g:terminal_color_3 = '#e2a478'
  let g:terminal_color_4 = '#84a0c6'
  let g:terminal_color_5 = '#a093c7'
  let g:terminal_color_6 = '#89b8c2'
  let g:terminal_color_7 = '#c6c8d1'
  let g:terminal_color_8 = '#6b7089'
  let g:terminal_color_9 = '#e98989'
  let g:terminal_color_10 = '#c0ca8e'
  let g:terminal_color_11 = '#e9b189'
  let g:terminal_color_12 = '#91acd1'
  let g:terminal_color_13 = '#ada0d3'
  let g:terminal_color_14 = '#95c4ce'
  let g:terminal_color_15 = '#d2d4de'
endif

" タイトルバーにファイルのパス情報等を表示
set title

" 行番号を表示
set number
"カーソル行をハイライト
set cursorline

"タブを表示
set showtabline=2
" タブが対応する空白の数
set tabstop=2
"インデントの段階に使われる空白の数
set softtabstop=2
set shiftwidth=2
set autoindent
" タブをスペースに変換
set expandtab
" 対応する括弧を表示

" 拡張子ごとにインデント幅を変更する
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

set showmatch
" 対応括弧のハイライト表示を3秒
set matchtime=3

set encoding=utf-8
" set fileencodings=iso-2022-jp,sjis,euc-jp,utf-8

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 検索結果をハイライト
set hlsearch

" コマンドラインモードでTabキーによるファイル名補完を有効
set wildmenu
" 入力中のコマンドを表示
set showcmd

" viとの互換性を無効にする
set nocompatible

" Backspaceで削除する要素を指定
set backspace=indent,eol,start

" vim-airlineの動作に必要
set laststatus=2

" swapファイル、Backupファイルを無効
set nowritebackup
set nobackup
set noswapfile

set incsearch

set splitright splitbelow

" set ambiwidth=double

" vim終了時に現在のセッションを保存する
au VimLeave * mks! ~/.vim.session

" texのconceal（数式のレンダリング）を無効
let g:tex_conceal = ''

if has("mac")
  " Macdownで現在のバッファのファイルを開く
  command Macdown :!open -a macdown %
endif

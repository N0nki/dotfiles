" options

syntax on
set termguicolors
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
  let g:terminal_color_0  = "#2E3436"
  let g:terminal_color_1  = "#DD6060" " 赤 ファイル
  let g:terminal_color_2  = "#4E9A06"
  let g:terminal_color_3  = "#C4A000"
  let g:terminal_color_4  = "#438DED" " 青 ディレクトリ
  let g:terminal_color_5  = "#BA6BC6" " 紫 シンボリックリンク
  let g:terminal_color_6  = "#93A1A1"
  let g:terminal_color_7  = "#D3D7CF"
  let g:terminal_color_8  = "#555753"
  let g:terminal_color_9  = "#EF2929"
  let g:terminal_color_10 = "#8AE234"
  let g:terminal_color_11 = "#FCE94F"
  let g:terminal_color_12 = "#729FCF"
  let g:terminal_color_13 = "#AD7FA8"
  let g:terminal_color_14 = "#34E2E2"
  let g:terminal_color_15 = "#EEEEEC"
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

" lightlineの動作に必要
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

" swapファイル、Backupファイルを無効
set nowritebackup
set nobackup
set noswapfile

" ファイルの変更を可能
set modifiable
set write

" vim終了時に現在のセッションを保存する
au VimLeave * mks! ~/.vim.session

" texのconceal（数式のレンダリング）を無効
let g:tex_conceal = ''

if has("mac")
  " Macdownで現在のバッファのファイルを開く
  command Macdown :!open -a macdown %
endif

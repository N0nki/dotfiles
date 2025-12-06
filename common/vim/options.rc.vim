" options

augroup MyAutoCmd
  autocmd!
augroup END

if &compatible
  set nocompatible
endif

syntax on
set termguicolors
" set t_Co=256
set background=dark
autocmd ColorScheme * highlight WarningMsg ctermfg=150 guifg=#b4be82

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
  autocmd BufNewFile,BufRead *.c setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.json setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

set showmatch
" 対応括弧のハイライト表示を3秒
set matchtime=3

set encoding=utf-8

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
if has('nvim')
  set laststatus=3
else
  set laststatus=2
endif

" swapファイル、Backupファイルを無効
set nowritebackup
set nobackup
set noswapfile

set incsearch
set ignorecase
set smartcase

set splitright splitbelow

" vim起動時に.gitが存在するならgit pullする
" au VimEnter * call s:pullIfGitExist()
" function! s:pullIfGitExist()
"   if isdirectory("./.git")
"     execute "!git pull"
"   endif
" endfunction

" vim終了時に現在のセッションを保存する
au VimLeave * mks! ~/.vim.session

" texのconceal（数式のレンダリング）を無効
let g:tex_conceal = ''

if has("mac")
  " Macdownで現在のバッファのファイルを開く
  command Macdown :!open -a macdown %
endif

if has('win32') || has ('win64')
	let g:python3_host_prog = '~\AppData\Local\Continuum\anaconda3\python.exe'
endif

" WSL2でyankしたときにWindowsのクリップボードに保存
if system('uname -a | grep microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif"

" カラースキームの設定
colorscheme Tomorrow-Night-Eighties
" colorscheme hybrid
syntax on
set t_Co=256
set background=dark

" タイトルバーにファイルのパス情報等を表示
set title

" 行番号を表示
set number

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
set showmatch

"OSのクリップボードとリンク
nmap _ :.w !nkf -Ws\|pdcopy<CR><CR>
vmap _ :w !nkf -Ws\|pdcopy<CR><CR>

" 不可視文字を表示
set list
set listchars=tab:>-,trail:-

" 検索結果をハイライト
set hlsearch

" コマンドラインモードでTabキーによるファイル名補完を有効
set wildmenu
" 入力中のコマンドを表示
set showcmd

" key remap begin-----------------------------
" インサート、ビジュアルを抜ける
inoremap <C-q> <Esc>
vnoremap <C-q> <Esc>
" 前のタブに移動
nnoremap gb gT

" USキーボードのみ
noremap ; :
" key remap end------------------------------

"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " Required:
  call neobundle#begin(expand('~/.vim/bundle'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Add or remove your Bundles here:
  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  " ファイルビューア
  NeoBundle 'Shougo/unite.vim'
  " ツリー表示
  NeoBundle 'scrooloose/nerdtree'
  " Rubyのendキーワードを自動挿入
  NeoBundle 'tpope/vim-endwise'
  " インデントの可視化
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " let g:indent_guides_enable_on_vim_startup = 1
  " 括弧を自動で閉じる
  NeoBundle 'Townk/vim-autoclose'
  " 複数行コメントアウト gcc
  NeoBundle 'tomtom/tcomment_vim'

  " You can specify revision/branch/tag.
  NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  "End NeoBundle Scripts-------------------------

syntax on
" set t_Co=256
" TrueColorを使用
if has('patch-7.4.1778')
  set guicolors
endif
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set background=dark
" colorscheme gruvbox
let g:neodark#background='dark'
colorscheme neodark
let g:neodark#use_custom_terminal_theme = 1
" colorscheme tender
" colorscheme onedark

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
set showmatch
" 対応括弧のハイライト表示を3秒
set matchtime=3

"OSのクリップボードとリンク
nmap _ :.w !nkf -Ws\|pdcopy<CR><CR>
vmap _ :w !nkf -Ws\|pdcopy<CR><CR>

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 検索結果をハイライト
set hlsearch

" コマンドラインモードでTabキーによるファイル名補完を有効
set wildmenu
" 入力中のコマンドを表示
set showcmd

" yankをclipboardに格納
" set clipboard=unnamed,autoselect

" Backspaceで削除する要素を指定
set backspace=indent,eol,start

" lightlineの動作に必要
set laststatus=2

" swapファイル、Backupファイルを無効
set nowritebackup
set nobackup
set noswapfile

" ファイルの変更を可能
set modifiable
set write

" key remap ----------------------------------
" jjでinsertからnormal
inoremap jj <ESC>
inoremap <C-q> <ESC>
vnoremap <C-q> <ESC>

" ESC2回で検索結果マッチのハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

"sを無効 代替はcl
nnoremap s <NOP>
nnoremap ss :<C-u>new<CR>
nnoremap sv :<C-u>vnew<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sr <C-w>x
nnoremap s= <C-w>=

" 折り返したテキストで自然に移動
nnoremap j gj
nnoremap k gk
" 行先頭へ移動
noremap <Space>h ^
" 行末尾へ移動
noremap <Space>l $

" vを2回で行末まで選択
vnoremap v $h

" TABで対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

"前のタブに移動
nnoremap gb gT
" タブを右に1つ移動
nnoremap gn :tabm +1<CR>
" タブを左に1つ移動
nnoremap gp :tabm -1<CR>
" タブを先頭に移動
nnoremap gN :tabm 0<CR>
" タブを末尾に移動
nnoremap gP :tabm<CR>

" USキーボードのみ
noremap ; :

" カレントディレクトリをオープン
nnoremap <silent> sc :<C-u>e .<CR>

" terminal modeからcommand modeへ移行
tnoremap <silent> jj <C-\><C-n>

" VimFiler key remap
" eでファイルを新規タブでオープン
" let g:vimfiler_edit_action='tabopen'
" VimFiler起動
nnoremap <silent> ,vf :<C-u>VimFilerCreate -simple<CR>
" 新規タブでVimFiler起動
nnoremap <silent> ,ft :tabnew<CR>:<C-u>VimFilerCreate -simple<CR>
" バッファを水平分割してVimFilerBufferDir
nnoremap <silent> ,svf :split<CR>:<C-u>VimFilerCreate -simple<CR>
" バッファを垂直分割してVimFilerBufferDir
nnoremap <silent> ,vvf :vsplit<CR>:<C-u>VimFilerCreate -simple<CR>
" IDE風にバッファをオープン
nnoremap <silent> ,ide :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -no-quit<CR>

" VimShell key remap
" VimShell起動
nnoremap <silent> ,vs :VimShellCreate<CR>
" バッファを水平分割してVimShellCreate
nnoremap <silent> ,svs :split<CR>:VimShellCreate<CR>
" バッファを垂直分割してVimShellCreate
nnoremap <silent> ,vvs :vsplit<CR>:VimShellCreate<CR>
" VimShellPop起動
nnoremap <silent> ,vp :VimShellPop<CR>
" VimShellTab起動
nnoremap <silent> ,vt :tabnew<CR>:VimShellCreate<CR>
" nnoremap <silent> ,vt :VimShellTab<CR>
" RubyとPythonのインタプリタ起動
nnoremap <silent> ,rb :VimShellInteractive irb<CR>
nnoremap <silent> ,pry :VimShellInteractive pry<CR>
nnoremap <silent> ,py :VimShellInteractive python<CR>
nnoremap <silent> ,ip :VimShellInteractive ipython<CR>

" Unite key remap
" buffer以外はdefault-action=tabopen
" カレントディレクトリのファイル一覧
nnoremap <silent> ,uf :Unite file -default-action=tabopen<CR>
" 現在開いているバッファ、ファイルの一覧
nnoremap <silent> ,ub :Unite buffer<CR>
" 最近開いたファイル一覧
nnoremap <silent> ,um :Unite file_mru -default-action=tabopen<CR>
" ブックマーク一覧 ブックマーク追加は:UniteBookmarkAdd
nnoremap <silent> ,uk :Unite bookmark -default-action=tabopen<CR>
" 全機能
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file -default-action=tabopen<CR>

" end key remap -----------------------------

" plugin settings ------------------------
" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:unite_source_history_yank_enable = 1


" deoplete
let g:deoplete#enable_at_startup = 1


" vim-airline
let g:airline_theme = 'molokai'

-
" indentLine
let g:indent_guides_start_level = 2


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

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
  " call dein#install('Townk/vim-autoclose')
endif

"End dein Scripts-------------------------

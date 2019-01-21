" 想定する環境
" vimのversionが7.3~7.4
" True Color未対応の端末(MacのTerminal.appなど)

syntax on
set t_Co=256
set background=dark
colorscheme iceberg
" colorscheme Tomorrow-Night-Eighties
" colorscheme gruvbox

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

" 拡張子ごとにインデント幅を変更する
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

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
set clipboard=unnamed,autoselect

" viとの互換性を無効にする
set nocompatible

" Backspaceで削除する要素を指定
set backspace=indent,eol,start

" swapファイル、Backupファイルを無効
set nowritebackup
set nobackup
set noswapfile

" ファイルの変更を可能
set modifiable
set write

" vim終了時に現在のセッションを保存する
au VimLeave * mks! ~/.vim.session

" key remap ----------------------------------
" jjでinsertからnormal
inoremap jj <ESC>
inoremap <C-q> <ESC>
vnoremap <C-q> <ESC>

" ESC2回で検索結果マッチのハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

"sを無効 代替はcl
nnoremap s <NOP>
" 水平分割
nnoremap ss :<C-u>new<CR>
" 垂直分割
nnoremap sv :<C-u>vnew<CR>
" 新規タブ
nnoremap st :<C-u>tabnew<CR>
" タブ回転
nnoremap sr <C-w>x
" タブ幅リセット
nnoremap s= <C-w>=

" 折り返したテキストで自然に移動
nnoremap j gj
nnoremap k gk
" 行先頭へ移動
noremap <Leader>h ^
" 行末尾へ移動
noremap <Leader>l $

" vを2回で行末まで選択
vnoremap v $h

" クリップボードと連携したコピーアンドペースト
nnoremap <Leader>d "*dd
vnoremap <Leader>d "*dd
nnoremap <Leader>y "*yy
vnoremap <Leader>y "*yy
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p

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
" 今いるタブを閉じる
nnoremap <silent> sc :tabc <CR>
" 今いるタブ以外を閉じる
nnoremap <silent> so :tabo <CR>

" USキーボードのみ
noremap ; :

" カレントディレクトリをオープン
nnoremap <silent> sc :<C-u>e .<CR>
" end key remap -----------------------------


"NeoBundle Scripts-----------------------------
augroup MyAutoCmd
  autocmd!
augroup END

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

  " Unite
  NeoBundle 'Shougo/unite.vim'
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1

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

  " カレントディレクトリ以下をgrep
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endi
  nnoremap <silent> ,grep :<C-u>Unite grep:. -buffer-name=grep-buffer -no-quit<CR>
  " カーソル位置の単語でgrep
  nnoremap <silent> ,cgrep :<C-u>Unite grep:. -buffer-name=grep-buffer -no-quit<CR><C-R><C-W>
  " grep検索結果を再表示
  nnoremap <silent> ,rgrep :<C-u>UniteResume grep-buffer -no-quit<CR>

  " カレントディレクトリ以下をfind
  nnoremap <silent> ,find :<C-u>Unite find:. -buffer-name=find-buffer -no-quit<CR>
  " find検索結果を再表示
  nnoremap <silent> ,rfind :<C-u>UniteResume find-buffer -no-quit<CR>


  " Vimfiler
  NeoBundle 'Shougo/vimfiler'
  let g:vimfiler_as_default_explorer=1
  let g:unite_source_history_yank_enable =1
  let g:vimfiler_safe_mode_by_default = 0
  if !argc()
    autocmd VimEnter * VimFilerCreate -split -simple -winwidth=30 -no-quit
  endif
  nnoremap <silent> ,vf :<C-u>VimFilerCreate -simple -no-quit<CR>
  " 新規タブでVimFiler起動
  nnoremap <silent> ,ft :tabnew<CR>:<C-u>VimFilerCreate -simple<CR>
  " バッファを水平分割してVimFilerBufferDir
  nnoremap <silent> ,svf :split<CR>:<C-u>VimFilerCreate -simple<CR>
  " バッファを垂直分割してVimFilerBufferDir
  nnoremap <silent> ,vvf :vsplit<CR>:<C-u>VimFilerCreate -simple<CR>
  " IDE風にバッファをオープン
  nnoremap <silent> ,ide :<C-u>VimFilerExplorer<CR>
  nnoremap <silent> ,side :<C-u>VimFilerExplorer -double<CR>

  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings()
    nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
    nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
    nnoremap <silent><buffer><expr> t vimfiler#do_action('tabopen')
    nmap <silent><buffer> l <Plug>(vimfiler_cd_or_edit)
  endfunction

  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = '-'
  let g:vimfiler_marked_file_icon = '*'

  " 括弧を自動で閉じる
  NeoBundle 'Townk/vim-autoclose'

  " 複数行コメントアウト コマンド:gc
  NeoBundle 'tomtom/tcomment_vim'

  NeoBundle 'tpope/vim-surround'

  " ステータスライン強化
  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'vim-airline/vim-airline-themes'
  let g:airline_theme = "molokai"


  " neocomplcache
  NeoBundle 'Shougo/neocomplcache'  
    " neocomplcache-------------------------------
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 1
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : ''
            \ }

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()
    " end neocomplcache----------------------------


    " Plugin key-mappings.
  
  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  "End NeoBundle Scripts-------------------------

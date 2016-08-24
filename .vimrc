syntax on
set t_Co=256
set background=dark
" カラースキームの設定
" colorscheme Tomorrow-Night-Eighties
colorscheme gruvbox
" colorscheme material-theme
" colorscheme molokai
" colorscheme jellybeans
" colorscheme hybrid_reverse
" colorscheme hybrid_material
" colorscheme desertEx
" colorscheme deep-space
" colorscheme solarized
" colorscheme lucario
" colorscheme happy_hacking
" colorscheme two-firewatch
" colorscheme hybrid

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
" set listchars=tab:>-,trail:-

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

" lightlineの動作に必要
set laststatus=2

" swapファイル、Backupファイルを無効
set nowritebackup
set nobackup
set noswapfile


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

" USキーボードのみ
noremap ; :

" カレントディレクトリをオープン
nnoremap <silent> sc :<C-u>e .<CR>

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
nnoremap <silent> ,vt :VimShellTab<CR>
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

" NeoComplete key remap
" NeoCompleteを有効/無効
nnoremap <silent> ,ce :NeoCompleteEnable<CR>
nnoremap <silent> ,cd :NeoCompleteDisable<CR>

" end key remap -----------------------------


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
  " 非同期通信を可能にする
  NeoBundle 'Shougo/vimproc', {
    \ 'bundle' : {
      \ 'windows' : 'make -f make_mingw32.mak',
      \ 'cygwin' : 'make -f make_cygwin.mak',
      \ 'mac' : 'make -f make_mac.mak',
      \ 'unix' : 'make -f make_unix.mak',
      \ }}

  NeoBundle 'Shougo/neosnippet.vim'
    NeoBundleLazy 'Shougo/neosnippet.vim', {
        \ "autoload": {"insert": 1}}

  NeoBundle 'Shougo/neosnippet-snippets'
  " ファイルビューア
  NeoBundle 'Shougo/unite.vim'
  " Uniteのfile_mruを使用可能にする
  NeoBundle 'Shougo/neomru.vim'
  " ファイル操作支援
  NeoBundle 'Shougo/vimfiler'
  let g:vimfiler_as_default_explorer=1
  let g:unite_source_history_yank_enable =1
  " ツリー表示
  " 削除
  " NeoBundle 'scrooloose/nerdtree'
  " Rubyのendキーワードを自動挿入
  NeoBundle 'tpope/vim-endwise'
  " インデントの可視化1
  " 現在は無効
  NeoBundle 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_enable_on_vim_startup = 0
  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_auto_colors=0
  " 奇数番目のインデントの色
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
  " 偶数番目のインデントの色
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray

  " インデントの可視化2
  " インデント可視化は現状こちらを仕様
  NeoBundle 'Yggdroot/indentLine'
  " let g:indentLine_color_term = 110
  " let g:indentLine_color_gui = '#042652'
  " let g:indentLine_char = '〓'
  let g:indent_guides_start_level = 2
  " 括弧を自動で閉じる
  NeoBundle 'Townk/vim-autoclose'
  " 複数行コメントアウト コマンド:gc
  NeoBundle 'tomtom/tcomment_vim'


  " ステータスライン強化
  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'vim-airline/vim-airline-themes'
  let g:airline_theme = "molokai"
  " let g:airline_theme = "badwolf"
  " let g:airline_theme = "base16"
  " let g:airline_theme = "gruvbox"
  " let g:airline_theme = "murmur"
  " let g:airline_theme = "distinguished"


  " ステータスライン強化
  " NeoBundle 'itchyny/lightline.vim'
  "   let g:lightline = {
  "           \ 'colorscheme': 'wombat',
  "           \ 'mode_map': {'c': 'NORMAL'},
  "           \ 'active': {
  "           \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  "           \ },
  "           \ 'component_function': {
  "           \   'modified': 'LightLineModified',
  "           \   'readonly': 'LightLineReadonly',
  "           \   'fugitive': 'LightLineFugitive',
  "           \   'filename': 'LightLineFilename',
  "           \   'fileformat': 'LightLineFileformat',
  "           \   'filetype': 'LightLineFiletype',
  "           \   'fileencoding': 'LightLineFileencoding',
  "           \   'mode': 'LightLineMode'
  "           \ }
  "           \ }
  "
  "   function! LightLineModified()
  "     return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  "   endfunction
  "
  "   function! LightLineReadonly()
  "     return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
  "   endfunction
  "
  "   function! LightLineFilename()
  "     return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
  "           \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
  "           \  &ft == 'unite' ? unite#get_status_string() :
  "           \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
  "           \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
  "           \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  "   endfunction
  "
  "   function! LightLineFugitive()
  "     if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
  "       return fugitive#head()
  "     else
  "       return ''
  "     endif
  "   endfunction
  "
  "   function! LightLineFileformat()
  "     return winwidth(0) > 70 ? &fileformat : ''
  "   endfunction
  "
  "   function! LightLineFiletype()
  "     return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  "   endfunction
  "
  "   function! LightLineFileencoding()
  "     return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
  "   endfunction
  "
  "   function! LightLineMode()
  "     return winwidth(0) > 60 ? lightline#mode() : ''
  "   endfunction
  

  " " 自動補完 lua無し
  " NeoBundle 'Shougo/neocomplcache'  
  "   " neocomplcache-------------------------------
  "   " Disable AutoComplPop.
  "   let g:acp_enableAtStartup = 1
  "   " Use neocomplcache.
  "   let g:neocomplcache_enable_at_startup = 1
  "   " Use smartcase.
  "   let g:neocomplcache_enable_smart_case = 1
  "   " Set minimum syntax keyword length.
  "   let g:neocomplcache_min_syntax_length = 3
  "   let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  "
  "   " Define dictionary.
  "   let g:neocomplcache_dictionary_filetype_lists = {
  "       \ 'default' : ''
  "           \ }
  "
  "   " Plugin key-mappings.
  "   inoremap <expr><C-g>     neocomplcache#undo_completion()
  "   inoremap <expr><C-l>     neocomplcache#complete_common_string()
  "
  "   " Recommended key-mappings.
  "   " <CR>: close popup and save indent.
  "   inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  "   function! s:my_cr_function()
  "     return neocomplcache#smart_close_popup() . "\<CR>"
  "   endfunction
  "   " <TAB>: completion.
  "   inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  "   " <C-h>, <BS>: close popup and delete backword char.
  "   inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  "   inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  "   inoremap <expr><C-y>  neocomplcache#close_popup()
  "   inoremap <expr><C-e>  neocomplcache#cancel_popup()
  "   " end neocomplcache----------------------------


  " 自動補完 lua有り
  NeoBundle 'shougo/neocomplete'
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ "autoload": {"insert": 1}}
    " neocompleteのhooksを取得
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    " neocomplete用の設定関数を定義。下記関数はneocompleteロード時に実行される
    function! s:hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_smart_case = 1
      " NeoCompleteを有効化
      NeoCompleteEnable
    endfunction

    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 1
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
 
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>  neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    " inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    let g:neocomplete#enable_auto_select = 1

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^.  \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

  
  " You can specify revision/branch/tag.
  NeoBundle 'Shougo/vimshell.vim'
    " let g:vimshell_prompt_expr = 'getcwd()."$ "'
    " let g:vimshell_prompt_pattern = '^\f\+$ '
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    let g:vimshell_scrollback_limit = 100000

  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  "End NeoBundle Scripts-------------------------

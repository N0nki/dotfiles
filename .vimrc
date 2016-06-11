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

" yankをclipboardに格納
set clipboard=unnamed,autoselect

" viとの互換性を無効にする
set nocompatible

" Backspaceで削除する要素を指定
set backspace=indent,eol,start


" key remap ----------------------------------
" インサート、ビジュアルを抜ける
inoremap <C-q> <Esc>
vnoremap <C-q> <Esc>
" 前のタブに移動
nnoremap gb gT

" USキーボードのみ
noremap ; :
" endkey remap ------------------------------


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
  " 複数行コメントアウト コマンド:gc
  NeoBundle 'tomtom/tcomment_vim'
  " ステータスライン強化
  NeoBundle 'itchyny/lightline.vim'
    " テーマをwombatに変更
    let g:lightline = {
      \ 'colorscheme': 'wombat',
      \}

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
    autocmd FileType ruby setlocal omnifunc=pythoncomplete#Complete
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
  NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  "End NeoBundle Scripts-------------------------

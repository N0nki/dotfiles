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
noremap <Space>h ^
" 行末尾へ移動
noremap <Space>l $

" vを2回で行末まで選択
vnoremap v $h

" クリップボードと連携したコピーアンドペースト
nnoremap <Space>d "*dd
vnoremap <Space>d "*dd
nnoremap <Space>y "*yy
vnoremap <Space>y "*yy
nnoremap <Space>p "*p
vnoremap <Space>p "*p

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

" NeoComplete key remap
" NeoCompleteを有効/無効
nnoremap <silent> ,ce :NeoCompleteEnable<CR>
nnoremap <silent> ,cd :NeoCompleteDisable<CR>

" end key remap -----------------------------

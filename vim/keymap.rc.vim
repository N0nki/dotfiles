" key remap

let mapleader = "\<Space>"

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

" vim terminal mode
if exists(':tmap')
  tnoremap <C-c> <C-w>N
  " nnoremap :q<CR> :q!<CR>
  " tnoremap <C-q> <C-w>N
  " tnoremap <C-q> <C-w><C-c>
endif

" neovim
if has("nvim")
  " terminal modeからcommand modeへ移行
  " tnoremap <silent> jj <C-\><C-n>
  tnoremap <silent> <C-q> <C-\><C-n>
  " tnoremap <silent> <C-c> <C-\><C-n>
endif

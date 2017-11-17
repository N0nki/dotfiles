" Unite

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
nnoremap <silent> ,grep :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語でgrep
nnoremap <silent> ,cgrep :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果を再表示
nnoremap <silent> ,rgrep :<C-u>UniteResume search-buffer<CR>

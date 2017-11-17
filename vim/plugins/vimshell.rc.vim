" VimShell

" keyremap
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


let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_scrollback_limit = 100000



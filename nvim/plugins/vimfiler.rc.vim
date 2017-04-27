" vimfiler

" call vimfiler#custom#profile('default', 'context', {
"         \ 'safe' : 0,
"         \ 'edit_action' : 'tabopen',
"         \ })

let g:vimfiler_as_default_explorer = 1
let g:unite_source_history_yank_enable = 1

" key remap
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

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
  nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
  nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
  nnoremap <silent><buffer><expr> t vimfiler#do_action('tabopen')
endfunction

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

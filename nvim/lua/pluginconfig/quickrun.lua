-- quickrun

 -- [leader] + rでlatexmkを使ってtexファイルをコンパイル
 -- さらにpdfビューアでpdfファイルをオープン
 -- 成功時はbufferに結果表示，quickfixが開いていれば閉じる
 -- 失敗時はquickfixに表示
 -- 成功時にbufferを開きたいときは以下をquickrun_configに追加して
 -- hook/close_buffer/enable_successを0指定する
 -- \ 'outputter/error/success' : 'buffer',
 -- buffer，quickfixは幅60で垂直分割して表示
 -- 幅の指定はsplit，vsplitなら:[N][v]sp[lit]，botrightなら:botright [N]
 -- \ 'exec': ['%c -cd -gg -pdfdvi %s', 'open -ga /Applications/Skim.app %s:r.pdf'],

vim.cmd([[
  call quickrun#module#register(shabadou#make_quickrun_hook_anim(
  \	"tex_compiling",
  \	['Compiling |', 'Compiling /', 'Compiling -', 'Compiling \'],
  \	2,
  \), 1)

  let g:quickrun_config = {
        \'tex': {
          \ 'runner': 'vimproc',
          \ 'runner/vimproc/updatetime': 40,
          \ 'outputter': 'error',
          \ 'outputter/error/error': 'quickfix',
          \ 'hook/echo/enable': 1,
          \ 'hook/echo/priority_output': 1,
          \ 'hook/tex_compiling/enable': 1,
          \ 'hook/echo/output_success': 'Compile succeeded',
          \ 'hook/echo/output_failure': 'Compile Failed. Fix error displayed in quickfix',
          \ 'hook/close_buffer/enable_success' : 1,
          \ 'hook/close_quickfix/enable_success' : 1,
          \	'hook/back_tabpage/enable_exit' : 1,
          \	'hook/back_window/enable_exit': 1,
          \	'hook/back_tabpage/priority_exit': 1,
          \	'hook/back_window/priority_exit': 1,
          \ 'hook/time/enable': '1',
          \ 'command': 'latexmk',
          \ 'outputter/buffer/split': ':60vsplit',
          \ 'hook/sweep/files' : [
          \                      '%S:p:r.aux',
          \                      '%S:p:r.bbl',
          \                      '%S:p:r.blg',
          \                      '%S:p:r.dvi',
          \                      '%S:p:r.fdb_latexmk',
          \                      '%S:p:r.fls',
          \                      '%S:p:r.out'
          \                      ],
          \ 'exec': ['%c %a -cd -gg -pdfdvi %s', 'open -g %s:r.pdf'],
          \},
        \'ruby': {
          \ 'runner': 'vimproc',
          \ 'runner/vimproc/updatetime': 40,
          \ 'outputter': 'error',
          \ 'outputter/error/success' : 'buffer',
          \ 'outputter/error/error': 'quickfix',
          \ 'hook/close_quickfix/enable_success' : 1,
          \ 'outputter/buffer/split': ':60vsplit',
          \ 'outputter/buffer/close_on_empty': 1,
        \},
        \'python': {
          \ 'runner': 'vimproc',
          \ 'runner/vimproc/updatetime': 40,
          \ 'outputter': 'error',
          \ 'outputter/error/success' : 'buffer',
          \ 'outputter/error/error': 'quickfix',
          \ 'hook/close_quickfix/enable_success' : 1,
          \ 'outputter/buffer/split': ':split',
          \ 'outputter/buffer/close_on_empty': 1,
        \},
        \'java': {
          \ 'runner': 'vimproc',
          \ 'runner/vimproc/updatetime': 40,
          \ 'outputter': 'error',
          \ 'outputter/error/success' : 'buffer',
          \ 'outputter/error/error': 'quickfix',
          \ 'hook/close_quickfix/enable_success' : 1,
          \ 'outputter/buffer/split': ':60vsplit',
          \ 'outputter/buffer/close_on_empty': 1,
        \},
        \'markdown': {
          \ 'exec': ['open -g %s'],
          \ 'outputter/buffer/close_on_empty': 1,
        \},
        \'cpp': {
        \ 'outputter/buffer/split': ':split',
        \ 'type':
        \   executable('g++')            ? 'cpp/g++' :
        \   executable('clang++')        ? 'cpp/clang++'  :
        \   s:is_win && executable('cl') ? 'cpp/vc'  : '',
        \},
  \}

  let g:quickrun_no_default_key_mappings = 1

  au FileType quickrun nnoremap <buffer>q :quit<CR>

  nnoremap <silent><Leader>r :write<CR>:QuickRun -mode n<CR>
  xnoremap <silent><Leader>r :<C-U>write<CR>gv:QuickRun -mode v<CR>

  command QuickRunRedirect :QuickRun <./redirect_input.txt
  nnoremap <silent><Leader>er :write<CR>:QuickRunRedirect<CR>
]])

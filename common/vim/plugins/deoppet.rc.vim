" deoppet

call deoppet#initialize()
call deoppet#custom#option('snippets',
      \ [{ 'path': expand('~/.vim/snippets')}] +
      \ map(globpath(&runtimepath, 'neosnippets', 1, 1),
      \     "{ 'path': v:val }"))

imap <C-k>  <Plug>(deoppet_expand)
imap <C-l>  <Plug>(deoppet_jump_forward)
imap <C-h>  <Plug>(deoppet_jump_backward)
smap <C-l>  <Plug>(deoppet_jump_forward)
smap <C-h>  <Plug>(deoppet_jump_backward)


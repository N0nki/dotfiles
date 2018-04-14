" deoplete

if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:neocomplete#enable_at_startup = 0
  " 補完が確定したらpreviwe windowを自動で閉じる
  autocmd CompleteDone * silent! pclose!
else
  let g:deoplete#enable_at_startup = 0
  let g:neocomplete#enable_at_startup = 1
endif

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

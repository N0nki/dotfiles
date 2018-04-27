" deoplete

if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

let g:deoplete#enable_at_startup = 1

" 補完が確定したらpreviwe windowを自動で閉じる
autocmd CompleteDone * silent! pclose!

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" deoplete-clang
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/6.0.0/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/usr/local/Cellar/llvm/6.0.0/lib/clang"

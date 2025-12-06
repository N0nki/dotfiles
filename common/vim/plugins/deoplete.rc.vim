" deoplete

let g:deoplete#enable_at_startup = 1

" 補完が確定したらpreviwe windowを自動で閉じる
autocmd CompleteDone * silent! pclose!

call deoplete#custom#option({
  \'auto_complete_delay': 0,
  \'min_pattern_length': 1,
  \'smart_case': v:true,
  \})

" deoplete-clang
if has("mac")
  let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/10.0.0_3/lib/libclang.dylib"
  let g:deoplete#sources#clang#clang_header = "/usr/local/Cellar/llvm/10.0.0_3/lib/clang"
endif

command! -nargs=? AtCoder call s:atcoder(<f-args>)
function! s:atcoder(...) abort
  if a:0 >= 1
    call openbrowser#open("https://atcoder.jp/contests/".a:1)
  else
    call openbrowser#open("https://atcoder.jp/contests/")
  end
endfunction

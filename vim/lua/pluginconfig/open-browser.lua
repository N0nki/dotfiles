-- open-browser

-- local command = vim.api.nvim_create_user_command
--
-- command("AtCoder", atcoder, {nargs = "?", force = true})
--
-- function atcoder(...)
--   local n = select("#", ...)
--   if n >= 1 then
--     vim.fn["openbrowser#open"]("https://atcoder.jp/contests/" .. "test")
--   else
--     vim.fn["openbrowser#open"]("https://atcoder.jp/contests/")
--   end
-- end

vim.cmd([[
  function! s:atcoder(...) abort
    if a:0 >= 1
      call openbrowser#open("https://atcoder.jp/contests/".a:1)
    else
      call openbrowser#open("https://atcoder.jp/contests/")
    end
  endfunction
  command! -nargs=? AtCoder call s:atcoder(<f-args>)
]])

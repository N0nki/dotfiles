-- deoplete

local autocmd = vim.api.nvim_create_autocmd

vim.g["deoplete#enable_at_startup"] = 1

autocmd("CompleteDone", {
  pattern = "*",
  command = "silent! pclose!"
})

vim.fn["deoplete#custom#option"]({
  auto_complete_delay = 0,
  min_pattern_length = 1,
  smart_case = true
})

if vim.fn.has("macunix") == 1 then
  vim.g["deoplete#sources#clang#libclang_path"] = "/usr/local/Cellar/llvm/10.0.0_3/lib/libclang.dylib"
  vim.g["deoplete#sources#clang#clang_header"] = "/usr/local/Cellar/llvm/10.0.0_3/lib/clang"
end

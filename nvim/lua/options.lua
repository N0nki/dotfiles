local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("MyAutoCmd", {})

vim.o.termguicolors = true
vim.o.background = "dark"
autocmd("ColorScheme", {
        pattern = "*",
        command = "highlight WarningMsg ctermfg=150 guifg=#b4be82",
})

if vim.fn.system('uname -a | grep microsoft') ~= '' then
  local my_yank = vim.api.nvim_create_augroup("MyYank", {clear = true})
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = my_yank,
    pattern = "*",
    callback = function()
      local text = vim.fn.getreg('"')
      if text ~= '' then
        vim.fn.system('iconv -f UTF-8 -t UTF-16LE | clip.exe', text)
      end
    end,
  })
end

-- disable line number on Terminal
autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber"
})

vim.o.title = true
vim.o.number = true
vim.o.cursorline = true

vim.opt.clipboard = "unnamedplus"

vim.o.showtabline = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

vim.o.showmatch = true
vim.o.matchtime = 3

vim.o.encoding = "utf-8"

vim.o.list = true
vim.o.listchars = "tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲"

vim.o.hlsearch = true
vim.o.wildmenu = true
vim.o.showcmd = true

vim.o.backspace = "indent,eol,start"

vim.o.cmdheight = 0
vim.o.laststatus = 3

vim.o.writebackup = false
vim.o.backup = false
vim.o.swapfile = false

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.spell = true
vim.opt.spelllang = {"en_us"}

-- LSP診断メッセージの設定
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',  -- アイコン
    source = "if_many",  -- 複数ソースがある場合のみソースを表示
  },
  signs = true,  -- サインカラムに表示
  underline = true,  -- 下線表示
  update_in_insert = false,  -- インサートモード中は更新しない
  severity_sort = true,  -- 重要度順にソート
  float = {
    source = "always",  -- フロート表示時は常にソースを表示
    border = "rounded",
  },
})

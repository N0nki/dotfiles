local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("MyAutoCmd", {})

vim.o.termguicolors = true
vim.o.background = "dark"
autocmd("ColorScheme", {
        pattern = "*",
        command = "highlight WarningMsg ctermfg=150 guifg=#b4be82",
})

-- for wsl, save to clipboard when yanked
if vim.fn.system('uname -a | grep microsoft') ~= '' then
  augroup("MyYank", {
    autocmd("TextYankPost", {
    pattern = "*",
    command = ":call system('clip.exe', @\")"
    })
  })
end

vim.o.title = true
vim.o.number = true
vim.o.cursorline = true

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

vim.o.laststatus = 3

vim.o.nowritebackup = true
vim.o.nobackup = true
vim.o.noswapfile = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

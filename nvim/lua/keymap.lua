local command = vim.api.nvim_create_user_command
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- use space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move insert mode
keymap("i", "jj", "<ESC>", opts)
keymap("i", "<C-q>", "<ESC>", opts)
keymap("v", "<C-q>", "<ESC>", opts)

-- unhighlight
keymap("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)

-- disable s
keymap("", "s", "<Nop>", opts)
-- split window horizontally
keymap("n", "ss", ":<C-u>new<CR>", opts)
-- split window vartically
keymap("n", "sv", ":<C-u>vnew<CR>", opts)
-- create new tab
keymap("n", "st", ":<C-u>tabnew<CR>", opts)
-- rotate window
keymap("n", "sr", "<C-w>x", opts)
-- reset window width
keymap("n", "s=", "<C-w>=", opts)

-- move wrapped text
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- jump start of line
keymap("n", "<Leader>h", "^", opts)
-- jump end of line
keymap("n", "<Leader>l", "$", opts)
--  select to end of line
keymap("v", "v", "$h", opts)

-- yank and paste cooperate with clipboard
keymap("n", "<Leader>d", "\"*dd", opts)
keymap("v", "<Leader>d", "\"*dd", opts)
keymap("n", "<Leader>y", "\"*yy", opts)
keymap("v", "<Leader>y", "\"*yy", opts)
keymap("n", "<Leader>p", "\"*p", opts)
keymap("v", "<Leader>p", "\"*p", opts)

-- yank file full path
command("CopyFullPath", function()
  vim.fn.setreg("\"", vim.fn.expand("%:p"))
end, {})
keymap("n", "<Leader>cp", ":<C-u>CopyFullPath<CR>", opts)
-- yank directory path
command("CopyDirectoryPath", function()
  vim.fn.setreg("\"", vim.fn.expand("%:p:h"))
end, {})
keymap("n", "<Leader>cd", ":<C-u>CopyDirectoryPath<CR>", opts)
-- yank file name
command("CopyFileName", function()
  vim.fn.setreg("\"", vim.fn.expand("%:t"))
end, {})
keymap("n", "<Leader>cf", ":<C-u>CopyFileName<CR>", opts)

-- jump to paired element
keymap("n", "<Tab>", "%", opts)
keymap("v", "<Tab>", "%", opts)

-- move between window with hjkl
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- modify window size by shift + cursor
keymap("n", "<S-Left>", "<C-w><<CR>", opts)
keymap("n", "<S-Right>", "<C-w>><CR>", opts)
keymap("n", "<S-Up>", "<C-w>-<CR>", opts)
keymap("n", "<S-Down>", "<C-w>+<CR>", opts)

-- move previous tab
keymap("n", "gb", "gT", opts)
-- move tab to right
keymap("n", "gn", ":tabm +1<CR>", opts)
-- move tab to left
keymap("n", "gp", ":tabm -1<CR>", opts)
-- move tab to head
keymap("n", "gN", ":tabm 0<CR>", opts)
-- move tab to end
keymap("n", "gP", ":tabm<CR>", opts)
-- close current tab
keymap("n", "sc", ":tabc<CR>", opts)
-- close all tabs except current tab
keymap("n", "so", ":tabo<CR>", opts)

-- keymap("i", "<F1>", vim.cmd([[strftime("%Y-%m-%d %H:%M:%S")]]), {noremap = false})
keymap("i", "<F1>", os.date("%Y-%m-%d %H:%M:%S"), {noremap = false})
keymap("n", "<F1>", os.date("%Y-%m-%d %H:%M:%S"), {noremap = false})
keymap("i", "<F2>", os.date("%H:%M:%S"), {noremap = false})
keymap("n", "<F2>", os.date("%H:%M:%S"), {noremap = false})

keymap("t", "<C-q>", "<C-\\><C-n>", opts)

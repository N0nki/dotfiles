-- toggleterm

require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "double",
  },
  hidden = true,
})

function _lazygit_toggle()
  lazygit:toggle()
end

function _open_filer()
  if vim.fn.system("uname -a | grep microsoft") ~= "" then
    filer_cmd = "TermExec open=0 dir='%:h' cmd='explore.exe .'"
  elseif vim.fn.has("mac") then
    filer_cmd = "TermExec open=0 dir='%:h' cmd='open .'"
  end
  vim.fn.execute(filer_cmd)
end

vim.api.nvim_set_keymap("n", "<leader>tt", ":<C-u>ToggleTerm size=15<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>lua _open_filer()<CR>", {noremap = true, silent = true})

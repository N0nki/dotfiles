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
    filer_cmd = "TermExec open=0 dir='%:h' cmd='explorer.exe .'"
  elseif vim.fn.has("mac") then
    filer_cmd = "TermExec open=0 dir='%:h' cmd='open .'"
  end
  vim.fn.execute(filer_cmd)
end

-- Claude Code terminal (id = 100)
local claude_code = Terminal:new({
  cmd = "claude",
  direction = "horizontal",
  size = math.floor(vim.o.lines * 0.4),
  hidden = true,
  id = 100,
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
})

function _claude_code_toggle()
  claude_code:toggle()
end

-- Claude Code with current file context (id = 101)
_claude_with_file = nil

function _claude_code_with_file()
  if _claude_with_file == nil then
    local filepath = vim.fn.expand('%:p')
    local cmd = string.format("claude --file '%s'", filepath)
    _claude_with_file = Terminal:new({
      cmd = cmd,
      direction = "horizontal",
      size = math.floor(vim.o.lines * 0.4),
      close_on_exit = false,
      id = 101,
    })
  end
  _claude_with_file:toggle()
end

-- Claude Code with visual selection (id = 102)
_claude_selection = nil

function _claude_code_with_selection()
  -- Get visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- Create temp file with selection
  local tmpfile = vim.fn.tempname()
  vim.fn.writefile(lines, tmpfile)

  local cmd = string.format("claude --file '%s'", tmpfile)
  if _claude_selection == nil then
    _claude_selection = Terminal:new({
      cmd = cmd,
      direction = "horizontal",
      size = math.floor(vim.o.lines * 0.4),
      close_on_exit = false,
      id = 102,
      on_exit = function()
        vim.fn.delete(tmpfile)
      end,
    })
  end
  _claude_selection:toggle()
end

-- Codex/OpenAI Codex terminal (id = 103)
local codex = Terminal:new({
  cmd = "codex",
  direction = "horizontal",
  size = math.floor(vim.o.lines * 0.4),
  hidden = true,
  id = 103,
})

function _codex_toggle()
  codex:toggle()
end

-- Claude Code and Codex side by side (both horizontal)
-- Store terminals globally to allow toggling
_claude_dual = nil
_codex_dual = nil

function _claude_and_codex_toggle()
  -- Save current tab number
  local current_tab = vim.fn.tabpagenr()

  -- Move to first tab to ensure terminals open in the main editing tab
  vim.cmd("1tabnext")

  -- Initialize terminals if they don't exist
  if _claude_dual == nil then
    _claude_dual = Terminal:new({
      cmd = "claude",
      direction = "horizontal",
      size = math.floor(vim.o.lines * 0.2),
      id = 104,
      hidden = true,
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })
  end

  if _codex_dual == nil then
    _codex_dual = Terminal:new({
      cmd = "codex",
      direction = "horizontal",
      size = math.floor(vim.o.lines * 0.2),
      id = 105,
      hidden = true,
    })
  end

  -- Toggle both terminals
  _claude_dual:toggle()
  _codex_dual:toggle()

  -- Return to original tab if it wasn't tab 1
  if current_tab ~= 1 and vim.fn.tabpagenr() == 1 then
    vim.cmd(current_tab .. "tabnext")
  end
end

-- Terminal keymaps
vim.api.nvim_set_keymap("n", "<leader>tt", ":ToggleTerm direction='vertical' size=100<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tl", ":ToggleTerm direction='tab'<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ts", ":ToggleTerm direction='horizontal'<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tf", ":ToggleTerm direction='float' size=15<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>lua _open_filer()<CR>", {noremap = true, silent = true})

-- AI tool keymaps
vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua _claude_code_toggle()<CR>", {noremap = true, silent = true, desc = "Toggle Claude Code"})
vim.api.nvim_set_keymap("n", "<leader>tcf", "<cmd>lua _claude_code_with_file()<CR>", {noremap = true, silent = true, desc = "Claude Code with current file"})
vim.api.nvim_set_keymap("v", "<leader>tcs", "<cmd>lua _claude_code_with_selection()<CR>", {noremap = true, silent = true, desc = "Claude Code with selection"})
vim.api.nvim_set_keymap("n", "<leader>tx", "<cmd>lua _codex_toggle()<CR>", {noremap = true, silent = true, desc = "Toggle Codex"})
vim.api.nvim_set_keymap("n", "<leader>tcc", "<cmd>lua _claude_and_codex_toggle()<CR>", {noremap = true, silent = true, desc = "Toggle Claude Code and Codex"})

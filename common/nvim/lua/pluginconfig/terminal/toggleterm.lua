-- toggleterm

require("toggleterm").setup()

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
        border = "double",
    },
    hidden = true,
})

local function lazygit_toggle()
    lazygit:toggle()
end

local function open_filer()
    local filer_cmd
    if vim.fn.system("uname -a | grep microsoft") ~= "" then
        filer_cmd = "TermExec open=0 dir='%:h' cmd='explorer.exe .'"
    elseif vim.fn.has("mac") then
        filer_cmd = "TermExec open=0 dir='%:h' cmd='open .'"
    end
    vim.fn.execute(filer_cmd)
end

-- Terminal keymaps
vim.api.nvim_set_keymap("n", "<leader>tt", ":ToggleTerm direction='vertical' size=100<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":ToggleTerm direction='tab'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", ":ToggleTerm direction='horizontal'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":ToggleTerm direction='float' size=15<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tg", lazygit_toggle, { silent = true, desc = "Toggle lazygit" })
vim.keymap.set("n", "<leader>to", open_filer, { silent = true, desc = "Open filer" })

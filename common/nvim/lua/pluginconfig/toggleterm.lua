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

local function claude_code_toggle()
    claude_code:toggle()
end

-- Claude Code with current file context (id = 101)
local claude_with_file = nil

local function claude_code_with_file()
    if claude_with_file == nil then
        local filepath = vim.fn.expand("%:p")
        local cmd = string.format("claude --file '%s'", filepath)
        claude_with_file = Terminal:new({
            cmd = cmd,
            direction = "horizontal",
            size = math.floor(vim.o.lines * 0.4),
            close_on_exit = false,
            id = 101,
        })
    end
    claude_with_file:toggle()
end

-- Claude Code with visual selection (id = 102)
local claude_selection = nil

local function claude_code_with_selection()
    -- Get visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    -- Create temp file with selection
    local tmpfile = vim.fn.tempname()
    vim.fn.writefile(lines, tmpfile)

    local cmd = string.format("claude --file '%s'", tmpfile)
    if claude_selection == nil then
        claude_selection = Terminal:new({
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
    claude_selection:toggle()
end

-- Codex/OpenAI Codex terminal (id = 103)
local codex = Terminal:new({
    cmd = "codex",
    direction = "horizontal",
    size = math.floor(vim.o.lines * 0.4),
    hidden = true,
    id = 103,
})

local function codex_toggle()
    codex:toggle()
end

-- ccusage (id = 106)
-- Claude Code and Codex side by side (both horizontal)
-- Store terminals globally to allow toggling
local claude_dual = nil
local codex_dual = nil

local function claude_and_codex_toggle()
    -- Save current tab number
    local current_tab = vim.fn.tabpagenr()

    -- Move to first tab to ensure terminals open in the main editing tab
    vim.cmd("1tabnext")

    -- Initialize terminals if they don't exist
    if claude_dual == nil then
        claude_dual = Terminal:new({
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

    if codex_dual == nil then
        codex_dual = Terminal:new({
            cmd = "codex",
            direction = "horizontal",
            size = math.floor(vim.o.lines * 0.2),
            id = 105,
            hidden = true,
        })
    end

    -- Toggle both terminals
    claude_dual:toggle()
    codex_dual:toggle()

    -- Return to original tab if it wasn't tab 1
    if current_tab ~= 1 and vim.fn.tabpagenr() == 1 then
        vim.cmd(current_tab .. "tabnext")
    end
end

-- Terminal keymaps
vim.api.nvim_set_keymap("n", "<leader>tt", ":ToggleTerm direction='vertical' size=100<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":ToggleTerm direction='tab'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", ":ToggleTerm direction='horizontal'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":ToggleTerm direction='float' size=15<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tg", lazygit_toggle, { silent = true, desc = "Toggle lazygit" })
vim.keymap.set("n", "<leader>to", open_filer, { silent = true, desc = "Open filer" })

-- AI tool keymaps
vim.keymap.set("n", "<leader>tc", claude_code_toggle, { silent = true, desc = "Toggle Claude Code" })
vim.keymap.set("n", "<leader>tcf", claude_code_with_file, { silent = true, desc = "Claude Code with current file" })
vim.keymap.set("v", "<leader>tcs", claude_code_with_selection, { silent = true, desc = "Claude Code with selection" })
vim.keymap.set("n", "<leader>tx", codex_toggle, { silent = true, desc = "Toggle Codex" })
vim.keymap.set("n", "<leader>tcc", claude_and_codex_toggle, { silent = true, desc = "Toggle Claude Code and Codex" })

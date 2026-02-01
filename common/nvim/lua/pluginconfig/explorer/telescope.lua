-- telescope.nvim

local opts = { noremap = true, silent = true }
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
    defaults = {
        mappings = {
            n = {
                ["<C-g>"] = actions.close,
            },
            i = {
                ["<C-g>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-f>"] = actions.select_vertical,
                ["<C-r>"] = actions.select_tab,
            },
        },
        file_ignore_patterns = {
            "^.git/",
            "node_modules/",
            ".DS_Store",
        },
    },
    pickers = {
        find_files = {
            hidden = true, -- ドットファイルを含める
        },
        live_grep = {
            additional_args = function()
                return { "--hidden" } -- grepでもドットファイルを含める
            end,
        },
    },
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("git_worktree")

-- File/Search pickers
vim.keymap.set("n", "<leader>df", builtin.find_files, opts)
vim.keymap.set("n", "<leader>dg", function()
    builtin.find_files({
        file_ignore_patterns = { "^.git/", "node_modules/", ".DS_Store", "my_worktrees/" },
    })
end, opts) -- Find files excluding my_worktrees
vim.keymap.set("n", "<leader>uc", function()
    builtin.colorscheme({ enable_preview = true })
end, opts) -- Colorscheme picker with live preview
vim.keymap.set("n", "<leader>da", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>db", builtin.buffers, opts)
vim.keymap.set("n", "<leader>dh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", opts)

-- Git pickers
vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts) -- Branches
vim.keymap.set("n", "<leader>gc", function()
    local action_state = require("telescope.actions.state")
    builtin.git_commits({
        git_command = { "git", "log", "--pretty=%h%d %s (%cr) <%an>", "--abbrev-commit", "--all" },
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                    vim.cmd("DiffviewOpen " .. selection.value .. "^!")
                end
            end)
            return true
        end,
    })
end, opts) -- Commits -> Diffview
vim.keymap.set("n", "<leader>gs", builtin.git_status, opts) -- Status
vim.keymap.set("n", "<leader>gt", builtin.git_stash, opts) -- Stash
vim.keymap.set("n", "<leader>gw", ":Telescope git_worktree git_worktrees<CR>", opts) -- Worktrees
vim.keymap.set("n", "<leader>gW", ":Telescope git_worktree create_git_worktree<CR>", opts) -- Create worktree

-- LSP diagnostics
vim.keymap.set("n", "<leader>xx", builtin.diagnostics, opts) -- All diagnostics
vim.keymap.set("n", "<leader>xw", function()
    builtin.diagnostics({ severity = vim.diagnostic.severity.WARN })
end, opts) -- Warnings only
vim.keymap.set("n", "<leader>xi", function()
    builtin.diagnostics({ severity = vim.diagnostic.severity.HINT })
end, opts) -- Hints only
vim.keymap.set("n", "<leader>xe", function()
    builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR })
end, opts) -- Errors only

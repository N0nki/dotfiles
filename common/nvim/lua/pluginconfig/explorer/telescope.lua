-- telescope.nvim

local opts = { noremap = true, silent = true }
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local function git_changed_files()
    local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
    if vim.v.shell_error ~= 0 or root == nil or root == "" then
        vim.notify("Not in a git repository", vim.log.levels.WARN)
        return nil, nil
    end

    local seen = {}
    local files = {}

    local function add_files(command)
        for _, file in ipairs(vim.fn.systemlist(command)) do
            if file ~= "" and not seen[file] then
                seen[file] = true
                table.insert(files, file)
            end
        end
    end

    add_files({ "git", "-C", root, "diff", "--name-only", "--diff-filter=ACMRTUXB" })
    add_files({ "git", "-C", root, "diff", "--cached", "--name-only", "--diff-filter=ACMRTUXB" })
    add_files({ "git", "-C", root, "ls-files", "--others", "--exclude-standard" })

    if #files == 0 then
        vim.notify("No changed git files", vim.log.levels.INFO)
        return root, nil
    end

    return root, files
end

local function find_git_changed_files()
    local root, files = git_changed_files()
    if files == nil then
        return
    end

    pickers.new({
        cwd = root,
    }, {
        prompt_title = "Git Changed Files",
        finder = finders.new_table({
            results = files,
            entry_maker = make_entry.gen_from_file({ cwd = root }),
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.file_sorter({}),
    }):find()
end

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
vim.keymap.set("n", "<leader>dG", find_git_changed_files, opts) -- Find changed git files
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

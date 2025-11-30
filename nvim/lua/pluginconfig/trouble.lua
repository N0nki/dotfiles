-- trouble.nvim
-- A pretty diagnostics, references, telescope results, quickfix and location list

local opts = { noremap = true, silent = true }

require("trouble").setup({
    auto_close = false, -- auto close when there are no items
    auto_open = false, -- auto open when there are items
    auto_preview = true, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    auto_jump = false, -- auto jump to the item when there's only one
    focus = false, -- Focus the window when opened
    restore = true, -- restores the last location in the list when opening
    follow = true, -- Follow the current item
    indent_guides = true, -- show indent guides
    max_items = 200, -- limit number of items that can be displayed per section
    multiline = true, -- render multi-line messages
    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer

    -- Window options for the results window. Can be a split or a floating window.
    win = {
        type = "split", -- split, vsplit, float
        relative = "win", -- win, editor, cursor
        position = "bottom", -- right, bottom, left, top
        size = { height = 10 }, -- height for horizontal splits, width for vertical splits
    },

    -- Window options for the preview window
    preview = {
        type = "main", -- main, float, split, vsplit
        scratch = true,
    },

    -- Throttle/Debounce settings. Should usually not be changed.
    throttle = {
        refresh = 20, -- fetches new data when needed
        update = 10, -- updates the window
        render = 10, -- renders the window
        follow = 100, -- follows the current item
        preview = { ms = 100, debounce = true }, -- shows the preview for the current item
    },

    -- Key mappings can be set to the name of a builtin action,
    -- or you can define your own custom action.
    keys = {
        ["?"] = "help",
        r = "refresh",
        R = "toggle_refresh",
        q = "close",
        o = "jump_close",
        ["<esc>"] = "cancel",
        ["<cr>"] = "jump",
        ["<2-leftmouse>"] = "jump",
        ["<c-s>"] = "jump_split",
        ["<c-v>"] = "jump_vsplit",
        -- go down to next item (accepts count)
        -- j = "next",
        ["}"] = "next",
        ["]]"] = "next",
        -- go up to previous item (accepts count)
        -- k = "prev",
        ["{"] = "prev",
        ["[["] = "prev",
        dd = "delete",
        d = { action = "delete", mode = "v" },
        i = "inspect",
        p = "preview",
        P = "toggle_preview",
        zo = "fold_open",
        zO = "fold_open_recursive",
        zc = "fold_close",
        zC = "fold_close_recursive",
        za = "fold_toggle",
        zA = "fold_toggle_recursive",
        zm = "fold_more",
        zM = "fold_close_all",
        zr = "fold_reduce",
        zR = "fold_open_all",
        zx = "fold_update",
        zX = "fold_update_all",
        zn = "fold_disable",
        zN = "fold_enable",
        zi = "fold_toggle_enable",
        gb = { -- example of a custom action that toggles the active view filter
            action = function(view)
                view:filter({ buf = 0 }, { toggle = true })
            end,
            desc = "Toggle Current Buffer Filter",
        },
        s = { -- example of a custom action that toggles the severity
            action = function(view)
                local f = view:get_filter("severity")
                local severity = ((f and f.filter.severity or 0) + 1) % 5
                view:filter({ severity = severity }, {
                    id = "severity",
                    template = "{hl:Title}Filter:{hl} {severity}",
                    del = severity == 0,
                })
            end,
            desc = "Toggle Severity Filter",
        },
    },

    -- Add mode-specific configurations
    modes = {
        -- Diagnostic modes
        diagnostics = {
            mode = "diagnostics",
            preview = {
                type = "split",
                relative = "win",
                position = "right",
                size = 0.3,
            },
        },
        -- LSP modes
        lsp_references = {
            params = {
                include_declaration = true,
            },
        },
        lsp_document_symbols = {
            win = { position = "right" },
        },
    },

    -- Set custom icons and signs in the sign column
    icons = {
        indent = {
            top = "│ ",
            middle = "├╴",
            last = "└╴",
            fold_open = " ",
            fold_closed = " ",
            ws = "  ",
        },
        folder_closed = " ",
        folder_open = " ",
        kinds = {
            Array = " ",
            Boolean = "󰨙 ",
            Class = " ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Function = "󰊕 ",
            Interface = " ",
            Key = " ",
            Method = "󰊕 ",
            Module = " ",
            Namespace = "󰦮 ",
            Null = " ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            String = " ",
            Struct = "󰆼 ",
            TypeParameter = " ",
            Variable = "󰀫 ",
        },
    },
})

-- Keymaps (using <leader>T* to avoid conflict with toggleterm's <leader>t*)
-- Toggle Trouble (diagnostics for current buffer)
vim.keymap.set("n", "<leader>Tt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)

-- Diagnostics (workspace-wide)
vim.keymap.set("n", "<leader>TD", "<cmd>Trouble diagnostics toggle<cr>", opts)

-- LSP Document Symbols (outline)
vim.keymap.set("n", "<leader>Ts", "<cmd>Trouble symbols toggle focus=false<cr>", opts)

-- LSP References
vim.keymap.set("n", "<leader>Tr", "<cmd>Trouble lsp_references toggle<cr>", opts)

-- LSP Definitions
vim.keymap.set("n", "<leader>Td", "<cmd>Trouble lsp_definitions toggle<cr>", opts)

-- LSP Type Definitions
vim.keymap.set("n", "<leader>TT", "<cmd>Trouble lsp_type_definitions toggle<cr>", opts)

-- Quickfix list
vim.keymap.set("n", "<leader>Tq", "<cmd>Trouble qflist toggle<cr>", opts)

-- Location list
vim.keymap.set("n", "<leader>Tl", "<cmd>Trouble loclist toggle<cr>", opts)

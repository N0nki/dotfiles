local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- essential
    { "nvim-lua/plenary.nvim" },
    { "MunifTanjim/nui.nvim" },
    { "rcarriga/nvim-notify" },
    { "nvim-tree/nvim-web-devicons" },
    { "echasnovski/mini.nvim" },
    {
        "ryanoasis/vim-devicons",
        config = function()
            require("pluginconfig/appearance/vim-devicons")
        end,
    },

    -- tmux integration
    {
        "n0nki/tmux-coding-agent.nvim",
        config = function()
            require("pluginconfig/terminal/tmux-coding-agent")
        end,
    },

    -- lsp
    { "neovim/nvim-lspconfig" },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        config = function()
            require("pluginconfig/lsp/trouble")
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("pluginconfig/lsp/mason-lspconfig")
        end,
    },
    { "RRethy/vim-illuminate" },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require("pluginconfig/lsp/conform")
        end,
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event = "BufReadPost",
        build = ":TSInstall vim lua bash zsh just diff tmux git_config ssh_config html markdown json toml yaml sql terraform python ruby go",
        config = function()
            require("pluginconfig/lsp/nvim-treesitter")
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "BufReadPost",
    },
    {
        "haringsrob/nvim_context_vt",
        config = function()
            require("pluginconfig/lsp/nvim-context-vt")
        end,
    },

    -- completion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("pluginconfig/lsp/nvim-cmp")
        end,
    },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "f3fora/cmp-spell" },
    { "ray-x/cmp-treesitter" },
    { "hrsh7th/cmp-emoji" },
    { "hrsh7th/cmp-vsnip" },
    {
        "hrsh7th/vim-vsnip",
        config = function()
            require("pluginconfig/lsp/vsnip")
        end,
    },
    { "hrsh7th/vim-vsnip-integ" },
    {
        "onsails/lspkind-nvim",
        config = function()
            require("pluginconfig/lsp/lspkind-nvim")
        end,
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("pluginconfig/explorer/telescope")
        end,
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "ThePrimeagen/git-worktree.nvim" },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("pluginconfig/appearance/noice")
        end,
    },

    -- colorscheme
    { "arcticicestudio/nord-vim" },
    { "sainnhe/everforest" },
    { "morhetz/gruvbox" },
    { "elianiva/icy.nvim" },
    { "catppuccin/nvim" },
    {
        "cocopon/iceberg.vim",
        lazy = false,
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("pluginconfig/appearance/colorscheme")
        end,
        lazy = false,
        priority = 1000,
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("pluginconfig/appearance/colorscheme")
        end,
        lazy = false,
        priority = 2000,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("pluginconfig/appearance/colorscheme")
        end,
        lazy = false,
        priority = 3000,
    },
    {
        "vague-theme/vague.nvim",
        config = function()
            require("pluginconfig/appearance/colorscheme")
        end,
        lazy = false,
        priority = 4000,
    },

    -- visual mode whitespace
    {
        "mcauley-penney/visual-whitespace.nvim",
        event = "ModeChanged *:[vV\x16]",
        config = function()
            require("pluginconfig/appearance/visual-whitespace")
        end,
    },

    -- fade inactive windows
    {
        "tadaa/vimade",
        event = "VimEnter",
        config = function()
            require("pluginconfig/appearance/vimade")
        end,
    },

    -- status|tab bar
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("pluginconfig/appearance/lualine")
        end,
    },
    -- git
    { "tpope/vim-fugitive" },
    {
        "shumphrey/fugitive-gitlab.vim",
        config = function()
            require("pluginconfig/git/fugitive-gitlab")
        end,
    },
    { "junegunn/gv.vim" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("pluginconfig/git/gitsigns")
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("pluginconfig/git/diffview")
        end,
    },
    {
        "isakbm/gitgraph.nvim",
        dependencies = { "sindrets/diffview.nvim" },
        config = function()
            require("pluginconfig/git/gitgraph")
        end,
    },

    -- quickrun
    {
        "thinca/vim-quickrun",
        config = function()
            require("pluginconfig/terminal/quickrun")
        end,
        keys = { "<leader>r", "<leader>er" },
    },
    { "osyo-manga/shabadou.vim" },
    { "Shougo/vimproc.vim", build = "make" },

    -- language
    { "cespare/vim-toml" },
    {
        "hashivim/vim-terraform",
        config = function()
            require("pluginconfig/lang/vim-terraform")
        end,
    },
    {
        "fatih/vim-go",
        config = function()
            require("pluginconfig/lang/vim-go")
        end,
        ft = "go",
    },
    {
        "elzr/vim-json",
        config = function()
            require("pluginconfig/lang/vim-json")
        end,
    },
    { "mattn/vim-sqlfmt" },
    {
        "lervag/vimtex",
        config = function()
            require("pluginconfig/lang/vimtex")
        end,
    },
    {
        "plasticboy/vim-markdown",
        config = function()
            require("pluginconfig/lang/vim-markdown")
        end,
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        config = function()
            require("pluginconfig/lang/render-markdown")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.nvim",
        },
    },

    -- utils
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-rhubarb" },
    { "mattn/emmet-vim" },
    { "mattn/webapi-vim" },
    { "mattn/vim-maketable" },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("pluginconfig/terminal/toggleterm")
        end,
    },
    {
        "kassio/neoterm",
        config = function()
            require("pluginconfig/terminal/neoterm")
        end,
    },
    { "tomtom/tcomment_vim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("pluginconfig/appearance/indent-blankline")
        end,
    },
    { "junegunn/fzf", build = "./install --bin" },
    {
        "easymotion/vim-easymotion",
        config = function()
            require("pluginconfig/motion/vim-easymotion")
        end,
    },
    { "mg979/vim-visual-multi" },
    {
        "wesQ3/vim-windowswap",
        config = function()
            require("pluginconfig/motion/vim-windowswap")
        end,
    },
    {
        "szw/vim-maximizer",
        config = function()
            require("pluginconfig/motion/vim-maximizer")
        end,
    },
    {
        "pocco81/true-zen.nvim",
        config = function()
            require("pluginconfig/motion/true-zen")
        end,
    },
    { "aserebryakov/vim-todo-lists" },
    { "cohama/lexima.vim" },
    { "simeji/winresizer" },
    {
        "bkad/CamelCaseMotion",
        config = function()
            require("pluginconfig/motion/CamelCaseMotion")
        end,
    },
    {
        "tversteeg/registers.nvim",
        config = function()
            require("registers").setup()
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("pluginconfig/explorer/nvim-tree")
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "m00qek/baleia.nvim",
        tag = "v1.3.0",
        config = function()
            require("pluginconfig/appearance/baleia")
        end,
    },

    { "Shougo/neosnippet-snippets" },
    { "tpope/vim-endwise" },
    { "mzlogin/vim-markdown-toc" },
    { "osyo-manga/vim-over" },
    {
        "osyo-manga/vim-anzu",
        config = function()
            require("pluginconfig/explorer/vim-anzu")
        end,
    },
    {
        "tyru/open-browser.vim",
        config = function()
            require("pluginconfig/util/open-browser")
        end,
    },
    { "folke/flash.nvim" },
    { "vim-scripts/ReplaceWithRegister" },
    { "kevinhwang91/nvim-bqf" },
    { "ray-x/lsp_signature.nvim" },
})

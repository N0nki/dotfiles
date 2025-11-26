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
  {"nvim-lua/plenary.nvim"},
  {"MunifTanjim/nui.nvim"},
  {"rcarriga/nvim-notify"},
  {"nvim-tree/nvim-web-devicons"},
  {"echasnovski/mini.nvim"},
  {"ryanoasis/vim-devicons", config = function() require("pluginconfig/vim-devicons") end},

  -- lsp
  {"neovim/nvim-lspconfig"},
  {"glepnir/lspsaga.nvim", config = function() require("pluginconfig/lspsaga") end, enabled = false},
  {"williamboman/mason.nvim", config = function() require("mason").setup() end},
  {"williamboman/mason-lspconfig.nvim", config = function() require("pluginconfig/mason-lspconfig") end},
  {"RRethy/vim-illuminate"},

  -- treesitter
  {"nvim-treesitter/nvim-treesitter",
      branch = "main",
      event = "BufReadPost",
      build = ":TSUpdate",
      config = function() require("pluginconfig/nvim-treesitter") end,
  },
  {"p00f/nvim-ts-rainbow",
    dependencies = {"nvim-treesitter"},
    enabled = false,
  },
  {"haringsrob/nvim_context_vt",
      config = function() require("pluginconfig/nvim-context-vt") end
  },

  -- completion
  {"hrsh7th/nvim-cmp", config = function() require("pluginconfig/nvim-cmp") end},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-cmdline"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-nvim-lsp-signature-help"},
  {"f3fora/cmp-spell"},
  {"ray-x/cmp-treesitter"},
  {"hrsh7th/cmp-emoji"},
  {"hrsh7th/cmp-vsnip"},
  {"hrsh7th/vim-vsnip", config = function() require("pluginconfig/vsnip") end},
  {"hrsh7th/vim-vsnip-integ"},
  {"onsails/lspkind-nvim", config = function() require("pluginconfig/lspkind-nvim") end},

  -- telescope
  {"nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function() require("pluginconfig/telescope") end,
  },
  {"nvim-telescope/telescope-file-browser.nvim"},

  {"folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function() require("pluginconfig/noice") end,
  },

  -- colorscheme
  {"arcticicestudio/nord-vim"},
  {"sainnhe/everforest"},
  {"morhetz/gruvbox"},
  {"elianiva/icy.nvim"},
  {"catppuccin/nvim"},
  {"cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,
  },
  {"rebelot/kanagawa.nvim",
    config = function() require("pluginconfig/colorscheme") end,
    lazy = false,
    priority = 1000,
  },
  {"EdenEast/nightfox.nvim",
    config = function() require("pluginconfig/colorscheme") end,
    lazy = false,
    priority = 2000,
  },
  {"folke/tokyonight.nvim",
    config = function() require("pluginconfig/colorscheme") end,
    lazy = false,
    priority = 3000,
  },

  -- status|tab bar
  {"nvim-lualine/lualine.nvim",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function() require("pluginconfig/lualine") end
  },
  {"romgrk/barbar.nvim",
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function() require("pluginconfig/barbar") end,
    enabled = false
  },
  {"akinsho/bufferline.nvim", config = function() require("pluginconfig/bufferline") end, enabled = false},

  -- git
  {"tpope/vim-fugitive"},
  {"shumphrey/fugitive-gitlab.vim", config = function() require("pluginconfig/fugitive-gitlab") end},
  {"junegunn/gv.vim"},
  {"lewis6991/gitsigns.nvim", config = function() require("pluginconfig/gitsigns") end},
  {"mattn/gist-vim", config = function() require("pluginconfig/gist-vim") end},
  {"sindrets/diffview.nvim", dependencies = {"nvim-lua/plenary.nvim"}},

  -- quickrun
  {"thinca/vim-quickrun", config = function() require("pluginconfig/quickrun") end, keys = {"<leader>r", "<leader>er"}},
  {"osyo-manga/shabadou.vim"},
  {"Shougo/vimproc.vim", build = "make"},

  -- language
  {"cespare/vim-toml"},
  {"hashivim/vim-terraform", config = function() require("pluginconfig/vim-terraform") end},
  {"fatih/vim-go", config = function() require("pluginconfig/vim-go") end, ft = "go"},
  {"elzr/vim-json", config = function() require("pluginconfig/vim-json") end},
  {"mattn/vim-sqlfmt"},
  {"lervag/vimtex", config = function() require("pluginconfig/vimtex") end},
  {"plasticboy/vim-markdown", config = function() require("pluginconfig/vim-markdown") end},
  {
    "MeanderingProgrammer/markdown.nvim",
    config = function() require("pluginconfig/render-markdown") end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim"
    }
  },

  -- utils
  {"tpope/vim-surround"},
  {"tpope/vim-repeat"},
  {"tpope/vim-rhubarb"},
  {"mattn/emmet-vim"},
  {"mattn/webapi-vim"},
  {"mattn/vim-maketable"},
  {"akinsho/toggleterm.nvim", config = function() require("pluginconfig/toggleterm") end},
  {"kassio/neoterm", config = function() require("pluginconfig/neoterm") end},
  {"tomtom/tcomment_vim"},
  {"lukas-reineke/indent-blankline.nvim", config = function() require("pluginconfig/indent-blankline") end},
  {"junegunn/fzf", build = "./install --bin"},
  {"easymotion/vim-easymotion", config = function() require("pluginconfig/vim-easymotion") end},
  {"mg979/vim-visual-multi"},
  {"wesQ3/vim-windowswap", config = function() require("pluginconfig/vim-windowswap") end},
  {"aserebryakov/vim-todo-lists"},
  {"cohama/lexima.vim"},
  {"simeji/winresizer"},
  {"bkad/CamelCaseMotion", config = function() require("pluginconfig/CamelCaseMotion") end},
  {"mg979/vim-visual-multi"},
  {"tversteeg/registers.nvim", config = function() require("registers").setup() end},
  {"nvim-tree/nvim-tree.lua",
      dependencies = {"nvim-tree/nvim-web-devicons"},
      config = function() require("pluginconfig/nvim-tree") end,
  },
  {"norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end},
  {"m00qek/baleia.nvim", tag = "v1.3.0", config = function() require("pluginconfig/baleia") end},

  {"Shougo/neosnippet-snippets"},
  {"tpope/vim-endwise"},
  {"mzlogin/vim-markdown-toc"},
  {"osyo-manga/vim-over"},
  {"osyo-manga/vim-anzu", config = function() require("pluginconfig/vim-anzu") end},
  {"tyru/open-browser.vim", config = function() require("pluginconfig/open-browser") end},
  {"folke/flash.nvim"},
  {"vim-scripts/ReplaceWithRegister"},
  {"kevinhwang91/nvim-bqf"},
  {"ray-x/lsp_signature.nvim"},

  -- disabled plugins
  {"Valloric/MatchTagAlways", enabled = false},
  {"Shougo/defx.nvim",
      enabled = false,
      build = ":UpdateRemotePlugins",
      config = function() require("pluginconfig/defx") end
  },
  {"kristijanhusak/defx-icons", enabled = false},
  {"kristijanhusak/defx-git", enabled = false},
  {"Yggdroot/indentLine",
      enabled = false,
      config = function() require("pluginconfig/indentline") end
  },
  {"vim-airline/vim-airline",
    enabled = false,
    config = function() require("pluginconfig/airline") end
  },
  {"vim-airline/vim-airline-themes",
    enabled = false
  },
  {"junegunn/fzf.vim",
    enabled = false,
    config = function() require("pluginconfig/fzf-vim") end,
  },
})

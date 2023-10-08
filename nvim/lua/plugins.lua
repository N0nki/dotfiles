local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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
  {"nvim-lua/plenary.nvim"},
  {"MunifTanjim/nui.nvim"},
  {"rcarriga/nvim-notify"},
  {"nvim-tree/nvim-web-devicons"},
  {"ryanoasis/vim-devicons", config = function() require("pluginconfig/vim-devicons") end},

  {"akinsho/toggleterm.nvim", config = function() require("pluginconfig/toggleterm") end},

  {"neovim/nvim-lspconfig"},
  {"glepnir/lspsaga.nvim", config = function() require("pluginconfig/lspsaga") end, enabled = false},
  {"williamboman/mason.nvim", config = function() require("mason").setup() end},
  {"williamboman/mason-lspconfig.nvim", config = function() require("pluginconfig/mason-lspconfig") end},

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

  {"nvim-lualine/lualine.nvim",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function() require("pluginconfig/lualine") end
  },
  {"akinsho/bufferline.nvim", config = function() require("pluginconfig/bufferline") end},

  {"tpope/vim-surround"},
  {"tpope/vim-repeat"},
  {"tpope/vim-rhubarb"},

  {"tpope/vim-fugitive"},
  {"junegunn/gv.vim"},
  {"lewis6991/gitsigns.nvim", config = function() require("pluginconfig/gitsigns") end},

  {"osyo-manga/shabadou.vim"},
  {"Shougo/vimproc.vim", build = "make"},
  {"thinca/vim-quickrun", config = function() require("pluginconfig/quickrun") end, keys = {"<leader>r", "<leader>er"}},
  {"osyo-manga/vim-over"},
  {"osyo-manga/vim-anzu", config = function() require("pluginconfig/vim-anzu") end},
  {"tyru/open-browser.vim", config = function() require("pluginconfig/open-browser") end},

  {"nvim-treesitter/nvim-treesitter",
      event = "BufReadPost",
      build = ":TSUpdate",
      config = function() require("pluginconfig/nvim-treesitter") end,
  },
  {"p00f/nvim-ts-rainbow", dependencies = {"nvim-treesitter"}},
  {"haringsrob/nvim_context_vt",
      config = function() require("pluginconfig/nvim-context-vt") end
  },

  {"mattn/emmet-vim"},
  {"mattn/webapi-vim"},
  {"mattn/gist-vim", config = function() require("pluginconfig/gist-vim") end},
  {"cespare/vim-toml"},
  {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function() require("pluginconfig/chatgpt") end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {"kassio/neoterm", config = function() require("pluginconfig/neoterm") end},
  {"tomtom/tcomment_vim"},
  {"lukas-reineke/indent-blankline.nvim", config = function() require("pluginconfig/indent-blankline") end},
  {"junegunn/fzf", build = "./install --bin"},
  {"easymotion/vim-easymotion", config = function() require("pluginconfig/vim-easymotion") end},
  {"liuchengxu/vista.vim", config = function() require("pluginconfig/vista") end},
  {"wesQ3/vim-windowswap", config = function() require("pluginconfig/vim-windowswap") end},
  {"aserebryakov/vim-todo-lists"},
  {"cohama/lexima.vim"},
  {"simeji/winresizer"},
  {"bkad/CamelCaseMotion", config = function() require("pluginconfig/CamelCaseMotion") end},
  {"mg979/vim-visual-multi"},
  {"tversteeg/registers.nvim", config = function() require("registers").setup() end},
  {"sindrets/diffview.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
  {"nvim-tree/nvim-tree.lua",
      dependencies = {"nvim-tree/nvim-web-devicons"},
      config = function() require("pluginconfig/nvim-tree") end,
  },
  {"norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end},

  {"Shougo/neosnippet-snippets"},
  {"tpope/vim-endwise"},
  {"fatih/vim-go", config = function() require("pluginconfig/vim-go") end, ft = "go"},
  {"plasticboy/vim-markdown", config = function() require("pluginconfig/vim-markdown") end},
  {"mzlogin/vim-markdown-toc"},
  {"mattn/vim-maketable"},
  {"lervag/vimtex", config = function() require("pluginconfig/vimtex") end},
  {"mattn/vim-sqlfmt"},
  {"elzr/vim-json", config = function() require("pluginconfig/vim-json") end},
  {"hashivim/vim-terraform", config = function() require("pluginconfig/vim-terraform") end},

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

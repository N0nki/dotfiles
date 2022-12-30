local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    packer_install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local packer_config = augroup("PackerConfig", {clear = true})
autocmd("BufWritePost", {
  group = packer_config,
  pattern = "plugins.lua",
  command = "PackerCompile"
})

local packer = require("packer")

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({border = "rounded"})
    end,
  },
  max_job = 10,
})

return packer.startup(function(use)
  use({"wbthomason/packer.nvim"})

  use({"nvim-lua/plenary.nvim"})
  use({"nvim-tree/nvim-web-devicons"})
  use({"ryanoasis/vim-devicons", config = function() require("pluginconfig/vim-devicons") end})

  use({"kristijanhusak/defx-icons"})
  use({"kristijanhusak/defx-git"})

  use({"Shougo/deol.nvim"})

  use({"neovim/nvim-lspconfig"})
  use({"williamboman/mason.nvim", config = function() require("mason").setup() end})
  use({"williamboman/mason-lspconfig.nvim", config = function() require("pluginconfig/mason-lspconfig") end})
  use({"hrsh7th/nvim-cmp", config = function() require("pluginconfig/nvim-cmp") end})
  use({"hrsh7th/cmp-path"})
  use({"hrsh7th/cmp-buffer"})
  use({"hrsh7th/cmp-cmdline"})
  use({"hrsh7th/cmp-nvim-lsp"})
  use({"hrsh7th/vim-vsnip"})

  use({"nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    config = function() require("pluginconfig/telescope") end,
  })

  local colorscheme = "nightfox.nvim"
  use({"cocopon/iceberg.vim"})
  use({"ackyshake/Spacegray.vim"})
  use({"arcticicestudio/nord-vim"})
  use({"sainnhe/everforest"})
  use({"morhetz/gruvbox"})
  use({"elianiva/icy.nvim"})
  use({"catppuccin/nvim"})
  use({"rebelot/kanagawa.nvim", config = function() require("pluginconfig/colorscheme") end})
  use({"EdenEast/nightfox.nvim", config = function() require("pluginconfig/colorscheme") end})

  use({"nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require("pluginconfig/lualine") end
  })

  use({"tpope/vim-surround"})
  use({"tpope/vim-repeat"})
  use({"tpope/vim-rhubarb"})

  use({"tpope/vim-fugitive"})
  use({"junegunn/gv.vim"})
  use({"lewis6991/gitsigns.nvim", config = function() require("pluginconfig/gitsigns") end})

  use({"osyo-manga/shabadou.vim"})
  use({"Shougo/vimproc.vim", run = "make"})
  use({"thinca/vim-quickrun", config = function() require("pluginconfig/quickrun") end})
  use({"osyo-manga/vim-over"})
  use({"osyo-manga/vim-anzu", config = function() require("pluginconfig/vim-anzu") end})
  use({"tyru/open-browser.vim", config = function() require("pluginconfig/open-browser") end})

  use({"nvim-treesitter/nvim-treesitter",
      event = "BufReadPost",
      run = ":TSUpdate",
      config = function() require("pluginconfig/nvim-treesitter") end,
  })
  use({"p00f/nvim-ts-rainbow", after = {"nvim-treesitter"}})
  use({"haringsrob/nvim_context_vt",
      after = {"nvim-treesitter", colorscheme},
      config = function() require("pluginconfig/nvim-context-vt") end
  })

  use({"mattn/emmet-vim"})
  use({"mattn/webapi-vim"})
  use({"mattn/gist-vim", config = function() require("pluginconfig/gist-vim") end})
  use({"cespare/vim-toml"})
  use({"kassio/neoterm", config = function() require("pluginconfig/neoterm") end})
  use({"tomtom/tcomment_vim"})
  use({"lukas-reineke/indent-blankline.nvim", config = function() require("pluginconfig/indent-blankline") end})
  use({"junegunn/fzf", {run = "./install --bin"}})
  use({"easymotion/vim-easymotion", config = function() require("pluginconfig/vim-easymotion") end})
  use({"liuchengxu/vista.vim", config = function() require("pluginconfig/vista") end})
  use({"wesQ3/vim-windowswap", config = function() require("pluginconfig/vim-windowswap") end})
  use({"aserebryakov/vim-todo-lists"})
  use({"junegunn/goyo.vim"})
  use({"cohama/lexima.vim"})
  use({"bkad/CamelCaseMotion", config = function() require("pluginconfig/CamelCaseMotion") end})
  use({"mg979/vim-visual-multi"})
  use({"tversteeg/registers.nvim", config = function() require("registers").setup() end})
  use({"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"})
  use({"nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons",
      config = function() require("pluginconfig/nvim-tree") end,
  })

  -- lazy load
  -- TODO: lazy load settings
  use({"Shougo/deoppet.nvim",
      run = ":UpdateRemotePlugins",
      config = function() require("pluginconfig/deoppet") end
  })
  use({"Shougo/neosnippet-snippets"})
  use({"tpope/vim-endwise"})
  use({"fatih/vim-go", config = function() require("pluginconfig/vim-go") end})
  use({"plasticboy/vim-markdown", config = function() require("pluginconfig/vim-markdown") end})
  use({"mzlogin/vim-markdown-toc"})
  use({"mattn/vim-maketable"})
  use({"Valloric/MatchTagAlways"})
  use({"lervag/vimtex", config = function() require("pluginconfig/vimtex") end})
  use({"mattn/vim-sqlfmt"})
  use({"elzr/vim-json", config = function() require("pluginconfig/vim-json") end})
  use({"hashivim/vim-terraform", config = function() require("pluginconfig/vim-terraform") end})

  -- disabled
  use({"Shougo/defx.nvim",
      disable = true,
      run = ":UpdateRemotePlugins",
      config = function() require("pluginconfig/defx") end
  })
  use({"Yggdroot/indentLine",
      disable = true,
      config = function() require("pluginconfig/indentline") end
  })
  use({"vim-airline/vim-airline",
    disable = true,
    config = function() require("pluginconfig/airline") end
  })
  use({"vim-airline/vim-airline-themes",
    disable = true
  })
  use({"junegunn/fzf.vim",
    disable = true,
    config = function() require("pluginconfig/fzf-vim") end,
  })


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

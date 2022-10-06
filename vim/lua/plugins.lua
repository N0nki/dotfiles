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
})

return packer.startup(function(use)
  use({"wbthomason/packer.nvim"})

  use({"Shougo/defx.nvim", config = function() require("pluginconfig/defx") end})
  use({"kristijanhusak/defx-icons"})
  use({"kristijanhusak/defx-git"})

  use({"Shougo/denite.nvim"})
  use({"kmnk/denite-dirmark"})
  use({"N0nki/denite-markdown"})
  use({"chemzqm/unite-location"})
  use({"Shougo/deol.nvim"})
  use({"Shougo/vimproc.vim", run = "make"})

  use({"vim-airline/vim-airline", config = function() require("pluginconfig/airline") end})
  use({"vim-airline/vim-airline-themes"})

  local colorscheme = "kanagawa.nvim"
  use({"cocopon/iceberg.vim"})
  use({"ackyshake/Spacegray.vim"})
  use({"arcticicestudio/nord-vim"})
  use({"sainnhe/everforest"})
  use({"morhetz/gruvbox"})
  use({"elianiva/icy.nvim"})
  use({"rebelot/kanagawa.nvim", config = function() require("pluginconfig/colorscheme") end})

  use({"tpope/vim-fugitive"})
  use({"junegunn/gv.vim"})
  use({"tpope/vim-surround"})
  use({"tpope/vim-repeat"})
  use({"tpope/vim-rhubarb"})
  use({"airblade/vim-gitgutter", config = function() require("pluginconfig/vim-gitgutter") end})
  use({"osyo-manga/shabadou.vim"})
  use({"thinca/vim-quickrun", config = function() require("pluginconfig/quickrun") end})
  use({"osyo-manga/vim-over"})
  use({"osyo-manga/vim-anzu", config = function() require("pluginconfig/vim-anzu") end})
  use({"tyru/open-browser.vim", config = function() require("pluginconfig/open-browser") end})
  use({"nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function() require("pluginconfig/nvim-treesitter") end,
  })

  use({"mattn/emmet-vim"})
  use({"ryanoasis/vim-devicons", config = function() require("pluginconfig/vim-devicons") end})
  use({"mattn/webapi-vim"})
  use({"mattn/gist-vim", config = function() require("pluginconfig/gist-vim") end})
  use({"cespare/vim-toml"})
  use({"kassio/neoterm", config = function() require("pluginconfig/neoterm") end})
  use({"tomtom/tcomment_vim"})
  use({"Yggdroot/indentLine", config = function() require("pluginconfig/indentline") end})
  use({"junegunn/fzf.vim", config = function() require("pluginconfig/fzf-vim") end})
  use({"junegunn/fzf", {run = "./install --bin"}})
  use({"easymotion/vim-easymotion", config = function() require("pluginconfig/vim-easymotion") end})
  use({"prabirshrestha/vim-lsp", config = function() require("pluginconfig/vim-lsp") end})
  use({"mattn/vim-lsp-settings"})
  use({"liuchengxu/vista.vim", config = function() require("pluginconfig/vista") end})
  use({"wesQ3/vim-windowswap", config = function() require("pluginconfig/vim-windowswap") end})
  use({"aserebryakov/vim-todo-lists"})
  use({"junegunn/goyo.vim"})
  use({"cohama/lexima.vim"})

  -- lazy load
  -- TODO: lazy load settings
  use({"Shougo/neomru.vim"})
  use({"Shougo/neoyank.vim"})
  use({"Shougo/deoplete.nvim", config = function() require("pluginconfig/deoplete") end})
  use({"lighttiger2505/deoplete-vim-lsp"})
  use({"fishbullet/deoplete-ruby"})
  use({"deoplete-plugins/deoplete-clang"})
  use({"Shougo/deoppet.nvim", config = function() require("pluginconfig/deoppet") end})
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

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

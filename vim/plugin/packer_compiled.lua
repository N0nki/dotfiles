-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/julymini/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/julymini/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/julymini/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/julymini/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/julymini/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  MatchTagAlways = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/MatchTagAlways",
    url = "https://github.com/Valloric/MatchTagAlways"
  },
  ["Spacegray.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/Spacegray.vim",
    url = "https://github.com/ackyshake/Spacegray.vim"
  },
  ["defx-git"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/defx-git",
    url = "https://github.com/kristijanhusak/defx-git"
  },
  ["defx-icons"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/defx-icons",
    url = "https://github.com/kristijanhusak/defx-icons"
  },
  ["defx.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22pluginconfig/defx\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/defx.nvim",
    url = "https://github.com/Shougo/defx.nvim"
  },
  ["denite-dirmark"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/denite-dirmark",
    url = "https://github.com/kmnk/denite-dirmark"
  },
  ["denite-markdown"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/denite-markdown",
    url = "https://github.com/N0nki/denite-markdown"
  },
  ["denite.nvim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/denite.nvim",
    url = "https://github.com/Shougo/denite.nvim"
  },
  ["deol.nvim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/deol.nvim",
    url = "https://github.com/Shougo/deol.nvim"
  },
  ["deoplete-clang"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/deoplete-clang",
    url = "https://github.com/deoplete-plugins/deoplete-clang"
  },
  ["deoplete-ruby"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/deoplete-ruby",
    url = "https://github.com/fishbullet/deoplete-ruby"
  },
  ["deoplete-vim-lsp"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/deoplete-vim-lsp",
    url = "https://github.com/lighttiger2505/deoplete-vim-lsp"
  },
  ["deoplete.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/deoplete\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/deoplete.nvim",
    url = "https://github.com/Shougo/deoplete.nvim"
  },
  ["deoppet.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/deoppet\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/deoppet.nvim",
    url = "https://github.com/Shougo/deoppet.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  everforest = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  fzf = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/fzf-vim\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gist-vim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/gist-vim\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/gist-vim",
    url = "https://github.com/mattn/gist-vim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/gv.vim",
    url = "https://github.com/junegunn/gv.vim"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/iceberg.vim",
    url = "https://github.com/cocopon/iceberg.vim"
  },
  ["icy.nvim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/icy.nvim",
    url = "https://github.com/elianiva/icy.nvim"
  },
  indentLine = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28pluginconfig/indentline\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/indentLine",
    url = "https://github.com/Yggdroot/indentLine"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29pluginconfig/colorscheme\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/lexima.vim",
    url = "https://github.com/cohama/lexima.vim"
  },
  ["neomru.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/neomru.vim",
    url = "https://github.com/Shougo/neomru.vim"
  },
  ["neosnippet-snippets"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/neosnippet-snippets",
    url = "https://github.com/Shougo/neosnippet-snippets"
  },
  neoterm = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/neoterm\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/neoterm",
    url = "https://github.com/kassio/neoterm"
  },
  ["neoyank.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/neoyank.vim",
    url = "https://github.com/Shougo/neoyank.vim"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!pluginconfig/nvim-treesitter\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["open-browser.vim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30pluginconfig/open-browser\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/open-browser.vim",
    url = "https://github.com/tyru/open-browser.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["shabadou.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/shabadou.vim",
    url = "https://github.com/osyo-manga/shabadou.vim"
  },
  tcomment_vim = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/tcomment_vim",
    url = "https://github.com/tomtom/tcomment_vim"
  },
  ["unite-location"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/unite-location",
    url = "https://github.com/chemzqm/unite-location"
  },
  ["vim-airline"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/airline\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-airline-themes",
    url = "https://github.com/vim-airline/vim-airline-themes"
  },
  ["vim-anzu"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/vim-anzu\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-anzu",
    url = "https://github.com/osyo-manga/vim-anzu"
  },
  ["vim-devicons"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30pluginconfig/vim-devicons\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easymotion"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 pluginconfig/vim-easymotion\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-endwise",
    url = "https://github.com/tpope/vim-endwise"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31pluginconfig/vim-gitgutter\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-go"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24pluginconfig/vim-go\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-go",
    url = "https://github.com/fatih/vim-go"
  },
  ["vim-json"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/vim-json\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-json",
    url = "https://github.com/elzr/vim-json"
  },
  ["vim-lsp"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/vim-lsp\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-lsp",
    url = "https://github.com/prabirshrestha/vim-lsp"
  },
  ["vim-lsp-settings"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-lsp-settings",
    url = "https://github.com/mattn/vim-lsp-settings"
  },
  ["vim-maketable"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-maketable",
    url = "https://github.com/mattn/vim-maketable"
  },
  ["vim-markdown"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30pluginconfig/vim-markdown\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-markdown-toc"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-markdown-toc",
    url = "https://github.com/mzlogin/vim-markdown-toc"
  },
  ["vim-over"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-over",
    url = "https://github.com/osyo-manga/vim-over"
  },
  ["vim-quickrun"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/quickrun\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-quickrun",
    url = "https://github.com/thinca/vim-quickrun"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-sqlfmt"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-sqlfmt",
    url = "https://github.com/mattn/vim-sqlfmt"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-terraform"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31pluginconfig/vim-terraform\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-terraform",
    url = "https://github.com/hashivim/vim-terraform"
  },
  ["vim-todo-lists"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-todo-lists",
    url = "https://github.com/aserebryakov/vim-todo-lists"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-windowswap"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 pluginconfig/vim-windowswap\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vim-windowswap",
    url = "https://github.com/wesQ3/vim-windowswap"
  },
  ["vimproc.vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vimproc.vim",
    url = "https://github.com/Shougo/vimproc.vim"
  },
  vimtex = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24pluginconfig/vimtex\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["vista.vim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23pluginconfig/vista\frequire\0" },
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  },
  ["webapi-vim"] = {
    loaded = true,
    path = "/Users/julymini/.local/share/nvim/site/pack/packer/start/webapi-vim",
    url = "https://github.com/mattn/webapi-vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vista.vim
time([[Config for vista.vim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23pluginconfig/vista\frequire\0", "config", "vista.vim")
time([[Config for vista.vim]], false)
-- Config for: vim-airline
time([[Config for vim-airline]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/airline\frequire\0", "config", "vim-airline")
time([[Config for vim-airline]], false)
-- Config for: vim-json
time([[Config for vim-json]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/vim-json\frequire\0", "config", "vim-json")
time([[Config for vim-json]], false)
-- Config for: gist-vim
time([[Config for gist-vim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/gist-vim\frequire\0", "config", "gist-vim")
time([[Config for gist-vim]], false)
-- Config for: defx.nvim
time([[Config for defx.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22pluginconfig/defx\frequire\0", "config", "defx.nvim")
time([[Config for defx.nvim]], false)
-- Config for: neoterm
time([[Config for neoterm]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/neoterm\frequire\0", "config", "neoterm")
time([[Config for neoterm]], false)
-- Config for: vim-anzu
time([[Config for vim-anzu]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/vim-anzu\frequire\0", "config", "vim-anzu")
time([[Config for vim-anzu]], false)
-- Config for: vim-terraform
time([[Config for vim-terraform]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31pluginconfig/vim-terraform\frequire\0", "config", "vim-terraform")
time([[Config for vim-terraform]], false)
-- Config for: vim-devicons
time([[Config for vim-devicons]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30pluginconfig/vim-devicons\frequire\0", "config", "vim-devicons")
time([[Config for vim-devicons]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/fzf-vim\frequire\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
-- Config for: vim-easymotion
time([[Config for vim-easymotion]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 pluginconfig/vim-easymotion\frequire\0", "config", "vim-easymotion")
time([[Config for vim-easymotion]], false)
-- Config for: deoppet.nvim
time([[Config for deoppet.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/deoppet\frequire\0", "config", "deoppet.nvim")
time([[Config for deoppet.nvim]], false)
-- Config for: indentLine
time([[Config for indentLine]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28pluginconfig/indentline\frequire\0", "config", "indentLine")
time([[Config for indentLine]], false)
-- Config for: open-browser.vim
time([[Config for open-browser.vim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30pluginconfig/open-browser\frequire\0", "config", "open-browser.vim")
time([[Config for open-browser.vim]], false)
-- Config for: vim-windowswap
time([[Config for vim-windowswap]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 pluginconfig/vim-windowswap\frequire\0", "config", "vim-windowswap")
time([[Config for vim-windowswap]], false)
-- Config for: kanagawa.nvim
time([[Config for kanagawa.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29pluginconfig/colorscheme\frequire\0", "config", "kanagawa.nvim")
time([[Config for kanagawa.nvim]], false)
-- Config for: vim-markdown
time([[Config for vim-markdown]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30pluginconfig/vim-markdown\frequire\0", "config", "vim-markdown")
time([[Config for vim-markdown]], false)
-- Config for: vim-lsp
time([[Config for vim-lsp]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginconfig/vim-lsp\frequire\0", "config", "vim-lsp")
time([[Config for vim-lsp]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!pluginconfig/nvim-treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-quickrun
time([[Config for vim-quickrun]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/quickrun\frequire\0", "config", "vim-quickrun")
time([[Config for vim-quickrun]], false)
-- Config for: vimtex
time([[Config for vimtex]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24pluginconfig/vimtex\frequire\0", "config", "vimtex")
time([[Config for vimtex]], false)
-- Config for: vim-gitgutter
time([[Config for vim-gitgutter]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31pluginconfig/vim-gitgutter\frequire\0", "config", "vim-gitgutter")
time([[Config for vim-gitgutter]], false)
-- Config for: deoplete.nvim
time([[Config for deoplete.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginconfig/deoplete\frequire\0", "config", "deoplete.nvim")
time([[Config for deoplete.nvim]], false)
-- Config for: vim-go
time([[Config for vim-go]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24pluginconfig/vim-go\frequire\0", "config", "vim-go")
time([[Config for vim-go]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

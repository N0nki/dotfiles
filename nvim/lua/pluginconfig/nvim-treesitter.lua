-- treesitter

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    disable = {}
  },
  -- nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = true,
  }
}

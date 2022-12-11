-- lualine

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "codedark",
  },
  sections = {
    lualine_c = {"filename", "searchcount"}
  },
  tabline = {
    lualine_a = {"tabs", "filename"},
  },
})

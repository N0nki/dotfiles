-- lualine

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "codedark",
    globalstatus = true,
  },
  sections = {
    lualine_c = {
      {
        "filename",
        path = 3,
      },
      "searchcount",
    }
  },
  -- tabline = {
  --   lualine_a = {"tabs", "filename"},
  -- },
})

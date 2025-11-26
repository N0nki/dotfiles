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
  tabline = {
    lualine_a = {
      {
        "tabs",
        mode = 2,  -- 0: タブ番号のみ, 1: タブ名のみ, 2: 両方
        max_length = vim.o.columns,
        show_modified_status = true,
        symbols = {
          modified = " ●",
        },
        tabs_color = {
          active = { fg = "#282C34", bg = "#6b9dad", gui = "bold" },
          inactive = { fg = "#c6c8d1", bg = "#1e2132" },
        },
        separator = { left = "", right = "" },
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})

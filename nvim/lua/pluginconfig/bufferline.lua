-- bufferline

local bufferline = require('bufferline')
require("bufferline").setup({
  options = {
    mode = "tabs",
    style_preset = bufferline.style_preset.default,
    indicator = {
        style = "underline"
    },
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
    end,
    modified_icon = "●",
    close_icon = "",
    diagnostics = "nvim_lsp",
    separator_style = "slope",
    show_close_icon = true,
    show_tab_indicators = true,
  },
})

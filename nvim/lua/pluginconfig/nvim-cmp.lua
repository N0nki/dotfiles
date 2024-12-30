-- nvim-cmp

local cmp = require("cmp")

cmp.setup({
  formatting = {
    -- fields = {'abbr', 'kind', 'menu'},
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[VSnip]",
        nvim_lua = "[NeovimLua]",
        path = "[Path]",
        spell = "[Spell]",
        emoji = "[Emoji]",
        rg = "[Rg]",
        treesitter = "[TS]",
        cmdline_history = "[History]",
      },
    }),
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),

  sources = cmp.config.sources({
    {name = "nvim_lsp"},
    {name = "nvim_lsp_signature_help"},
    {name = "path"},
    {name = "buffer"},
    {name = "spell"},
    {name = "treesitter"},
    {name = "emoji"},
    {name = "vsnip"},
  })
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" },
  }, {
    { name = "buffer" },
  })
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

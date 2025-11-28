-- lualine

-- Git worktree名を取得するカスタムコンポーネント（複数worktree時のみ表示）
local function git_worktree_name()
  local cwd = vim.fn.getcwd()
  local handle = io.popen("git worktree list --porcelain 2>/dev/null")
  if not handle then return "" end

  local result = handle:read("*a")
  handle:close()

  local worktrees = {}
  local current_worktree = nil
  local worktree_path = nil

  for line in result:gmatch("[^\n]+") do
    if line:match("^worktree ") then
      worktree_path = line:gsub("^worktree ", "")
    elseif line:match("^branch ") and worktree_path then
      local branch = line:gsub("^branch refs/heads/", "")
      table.insert(worktrees, { path = worktree_path, branch = branch })
      if cwd:find(worktree_path, 1, true) == 1 then
        current_worktree = branch
      end
      worktree_path = nil
    end
  end

  -- 複数worktreeがある場合のみアイコン表示
  if #worktrees > 1 and current_worktree then
    return "🌲"
  end
  return ""
end

-- アクティブなLSPサーバー名を取得
local function lsp_server_name()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return "🚫 No LSP"
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return "🔧 " .. table.concat(names, ", ")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "codedark",
    globalstatus = true,
  },
  sections = {
    lualine_b = {
      git_worktree_name,
      "branch",
      "diff",
    },
    lualine_c = {
      {
        "filename",
        path = 3,
        color = { fg = "#b4be82" },  -- 緑
      },
      "searchcount",
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = "❌ ", warn = "⚠️ ", info = "ℹ️ ", hint = "💡 " },
        colored = true,
      },
    },
    lualine_x = {
      {
        lsp_server_name,
        color = { fg = "#e2a478" },  -- オレンジ
      },
      {
        "encoding",
        color = { fg = "#89b8c2" },  -- シアン
      },
      {
        "filetype",
        color = { fg = "#a093c7" },  -- 紫
      },
    },
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

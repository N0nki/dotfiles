-- open-browser

-- Load environment variables from ~/dotfiles/.env
local function load_env(key)
    local env_file = vim.fn.expand("~/dotfiles/.env")
    if vim.fn.filereadable(env_file) ~= 1 then
        return nil
    end

    for _, line in ipairs(vim.fn.readfile(env_file)) do
        if not line:match("^%s*#") and not line:match("^%s*$") then
            local k, v = line:match("^%s*([%w_]+)%s*=%s*(.*)%s*$")
            if k == key and v then
                -- Remove quotes and expand ~
                v = v:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
                return vim.fn.expand(v)
            end
        end
    end
    return nil
end

-- AtCoder command: Open AtCoder contest page
-- Usage: :AtCoder [contest-name]
local function atcoder(opts)
    local contest_name = opts.args
    local url

    if contest_name ~= "" then
        url = "https://atcoder.jp/contests/" .. contest_name
    else
        url = "https://atcoder.jp/contests/"
    end

    vim.fn["openbrowser#open"](url)
end

vim.api.nvim_create_user_command("AtCoder", atcoder, {
    nargs = "?",
    desc = "Open AtCoder contest page in browser",
})

-- GitBook command: Open GitBook page for current file
-- Usage: :GitBook
-- Converts path/to/gitbook_project/python/tips.md
-- to https://n-0-nki.gitbook.io/gitbook_project/python/tips
local function gitbook()
    local filepath = vim.fn.expand("%:p")
    local base_path = load_env("GITBOOK_BASE_PATH")
    local base_url = load_env("GITBOOK_BASE_URL")

    if not base_path or not base_url then
        vim.notify("GITBOOK_BASE_PATH or GITBOOK_BASE_URL not set in ~/dotfiles/.env", vim.log.levels.ERROR)
        return
    end

    -- Check if current file is in the knowledge base directory
    if not filepath:match("^" .. vim.pesc(base_path)) then
        vim.notify("Current file is not in " .. base_path, vim.log.levels.WARN)
        return
    end

    -- Extract relative path and remove .md extension
    local relative_path = filepath:sub(#base_path + 1)
    local url_path = relative_path:gsub("%.md$", "")

    -- Construct final URL
    local url = base_url .. url_path

    vim.fn["openbrowser#open"](url)
end

vim.api.nvim_create_user_command("GitBook", gitbook, {
    desc = "Open GitBook page for current file",
})

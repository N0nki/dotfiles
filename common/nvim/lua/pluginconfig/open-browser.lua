-- open-browser

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

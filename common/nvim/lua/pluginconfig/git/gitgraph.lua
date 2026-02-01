require("gitgraph").setup({
    symbols = {
        merge_commit = "M",
        commit = "*",
    },
    format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
    },
    hooks = {
        on_select_commit = function(commit)
            vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        on_select_range_commit = function(from, to)
            vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
    },
})

vim.keymap.set("n", "<leader>gl", function()
    vim.cmd("split")
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
end, { desc = "GitGraph (horizontal split)" })

-- tmux-coding-agent.nvim

local tmux_ai = require("tmux-coding-agent")

-- Setup
tmux_ai.setup({
    ai_tools = {
        { name = "Claude Code", pattern = "claude" },
        { name = "Codex", pattern = "codex" },
        { name = "Gemini", pattern = "gemini" },
    },
})

-- Keymaps
local opts = { noremap = true, silent = true }

-- ==================== Auto-detect AI tool ====================
-- ビジュアル選択をAIツールに送信（自動検出）
vim.keymap.set("v", "<leader>tc", function()
    tmux_ai.send_visual_to_ai()
end, vim.tbl_extend("force", opts, { desc = "Send visual selection to AI tool (auto-detect)" }))

-- バッファ全体をAIツールに送信（自動検出）
vim.keymap.set("n", "<leader>tC", function()
    tmux_ai.send_buffer_to_ai()
end, vim.tbl_extend("force", opts, { desc = "Send buffer to AI tool (auto-detect)" }))

-- ファイルパス付きでバッファを送信（自動検出）
vim.keymap.set("n", "<leader>tF", function()
    tmux_ai.send_buffer_with_filepath()
end, vim.tbl_extend("force", opts, { desc = "Send buffer with filepath to AI tool (auto-detect)" }))

-- プロンプト付きで送信（レビュー依頼、自動検出）
vim.keymap.set("n", "<leader>tr", tmux_ai.send_with_prompt("このコードをレビューしてください。"), vim.tbl_extend("force", opts, { desc = "Send buffer for review (auto-detect)" }))

-- プロンプト付きで送信（説明依頼、自動検出）
vim.keymap.set("n", "<leader>te", tmux_ai.send_with_prompt("このコードを説明してください。"), vim.tbl_extend("force", opts, { desc = "Send buffer for explanation (auto-detect)" }))

-- ビジュアル選択範囲をプロンプト付きで送信（レビュー依頼、自動検出）
vim.keymap.set(
    "v",
    "<leader>tr",
    tmux_ai.send_visual_with_prompt("このコードをレビューしてください。"),
    vim.tbl_extend("force", opts, { desc = "Send selection for review (auto-detect)" })
)

-- ビジュアル選択範囲をプロンプト付きで送信（説明依頼、自動検出）
vim.keymap.set(
    "v",
    "<leader>te",
    tmux_ai.send_visual_with_prompt("このコードを説明してください。"),
    vim.tbl_extend("force", opts, { desc = "Send selection for explanation (auto-detect)" })
)

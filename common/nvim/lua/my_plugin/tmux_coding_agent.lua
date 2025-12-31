local M = {}

-- AIツールのパターンリスト（優先順位順）
local AI_TOOLS = {
    { name = "Claude Code", pattern = "claude" },
    { name = "Codex", pattern = "codex" },
    { name = "Gemini", pattern = "gemini" },
}

-- ペインで実行中のコマンドを取得（TTYベース）
local function get_pane_command(pane_tty)
    -- TTYで動いているプロセスを取得（シェル以外）
    local ps_output = vim.fn.system(string.format("ps -t %s -o command=", pane_tty))

    -- 各プロセスのコマンドラインをチェック
    for line in ps_output:gmatch("[^\r\n]+") do
        -- シェル（zsh, bash, sh）以外で、AIツールパターンにマッチするものを返す
        if not line:match("^%-?[zb]?sh") and not line:match("^npm") and not line:match("^ps ") then
            return line
        end
    end

    return nil
end

-- コマンドラインからAIツール名を判別
local function detect_ai_tool(command_line)
    if not command_line then
        return nil
    end

    for _, tool in ipairs(AI_TOOLS) do
        if command_line:match(tool.pattern) then
            return tool.name
        end
    end

    return nil
end

-- tmuxペインを選択してテキストを送信
function M.send_to_ai(text, tool_name)
    -- tmux内で実行されているかチェック
    if vim.fn.getenv("TMUX") == vim.NIL then
        vim.notify("tmux環境外では使用できません", vim.log.levels.WARN)
        return
    end

    -- tmuxのペインリストを取得（TTY付き）
    local panes = vim.fn.system("tmux list-panes -F '#{pane_index}:#{pane_tty}'")
    local current_pane = vim.fn.system("tmux display-message -p '#{pane_index}'"):gsub("\n", "")

    -- AIツールペインを検出
    local ai_panes = {}
    for line in panes:gmatch("[^\r\n]+") do
        local pane_idx, pane_tty = line:match("^(%d+):(.+)")
        if pane_idx and pane_idx ~= current_pane then
            local command = get_pane_command(pane_tty)
            local detected_tool = detect_ai_tool(command)
            if detected_tool then
                table.insert(ai_panes, { index = pane_idx, name = detected_tool, command = command })
            end
        end
    end

    if #ai_panes == 0 then
        vim.notify("AIツールペインが見つかりません (claude, codex, gemini)", vim.log.levels.WARN)
        return
    end

    -- デバッグ情報を表示
    local debug_msg = string.format("検出されたAIツール: %d個", #ai_panes)
    for i, pane in ipairs(ai_panes) do
        debug_msg = debug_msg .. string.format("\n  %d. %s (pane %s)", i, pane.name, pane.index)
    end
    vim.notify(debug_msg, vim.log.levels.INFO)

    local target_pane = nil
    local target_tool_name = nil

    -- 特定のツール名が指定されている場合
    if tool_name then
        for _, pane in ipairs(ai_panes) do
            if pane.name:lower():match(tool_name:lower()) or pane.command:lower():match(tool_name:lower()) then
                target_pane = pane.index
                target_tool_name = pane.name
                break
            end
        end
        if not target_pane then
            vim.notify(string.format("%s ペインが見つかりません", tool_name), vim.log.levels.WARN)
            return
        end
    -- 複数のAIツールペインがある場合は選択
    elseif #ai_panes > 1 then
        local choices = {}
        for i, pane in ipairs(ai_panes) do
            table.insert(choices, string.format("%d. %s (pane %s)", i, pane.name, pane.index))
        end

        vim.ui.select(choices, {
            prompt = "送信先のAIツールを選択してください:",
        }, function(choice, idx)
            if idx then
                target_pane = ai_panes[idx].index
                M._send_text_to_pane(target_pane, text, ai_panes[idx].name)
            end
        end)
        return
    else
        -- 1つだけの場合は自動選択
        target_pane = ai_panes[1].index
        target_tool_name = ai_panes[1].name
    end

    M._send_text_to_pane(target_pane, text, target_tool_name)
end

-- 内部関数: ペインにテキストを送信
function M._send_text_to_pane(pane_idx, text, tool_name)
    -- テキストを整形（改行を保持しつつ、シングルクォートをエスケープ）
    local escaped_text = text:gsub("'", "'\\''")

    -- tmuxペインにテキストを送信
    local cmd = string.format("tmux send-keys -t %s -l '%s'", pane_idx, escaped_text)
    vim.fn.system(cmd)

    -- Enterキーを送信してプロンプトを実行
    vim.fn.system(string.format("tmux send-keys -t %s Enter", pane_idx))

    vim.notify(string.format("%s (pane %s) にテキストを送信しました", tool_name, pane_idx), vim.log.levels.INFO)
end

-- ビジュアル選択範囲を送信
function M.send_visual_to_ai(tool_name)
    -- ビジュアルモードの選択範囲を取得（0-indexed）
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- 座標が正しく取得できているか確認
    if start_pos[2] == 0 or end_pos[2] == 0 then
        vim.notify("ビジュアル選択範囲が取得できませんでした", vim.log.levels.WARN)
        return
    end

    -- vim.api.nvim_buf_get_text を使用（0-indexed行、0-indexed列）
    local bufnr = vim.api.nvim_get_current_buf()
    local start_row = start_pos[2] - 1 -- 1-indexed to 0-indexed
    local start_col = start_pos[3] - 1 -- 1-indexed to 0-indexed
    local end_row = end_pos[2] - 1 -- 1-indexed to 0-indexed
    local end_col = end_pos[3] -- end_col は inclusive なので調整不要

    local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

    -- linesが空でないか確認
    if not lines or #lines == 0 then
        vim.notify("選択範囲が空です", vim.log.levels.WARN)
        return
    end

    local text = table.concat(lines, "\n")
    M.send_to_ai(text, tool_name)
end

-- バッファ全体を送信
function M.send_buffer_to_ai(tool_name)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local text = table.concat(lines, "\n")
    M.send_to_ai(text, tool_name)
end

-- 現在のファイルパスと内容を送信
function M.send_buffer_with_filepath(tool_name)
    local filepath = vim.fn.expand("%:p")
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, "\n")

    local text = string.format("ファイル: %s\n\n```\n%s\n```", filepath, content)
    M.send_to_ai(text, tool_name)
end

-- カスタムプロンプトと一緒に送信
function M.send_with_prompt(prompt_text, tool_name)
    return function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local text = table.concat(lines, "\n")
        local full_text = string.format("%s\n\n```\n%s\n```", prompt_text, text)
        M.send_to_ai(full_text, tool_name)
    end
end

-- ビジュアル選択範囲をプロンプトと一緒に送信
function M.send_visual_with_prompt(prompt_text, tool_name)
    return function()
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")

        -- 座標が正しく取得できているか確認
        if start_pos[2] == 0 or end_pos[2] == 0 then
            vim.notify("ビジュアル選択範囲が取得できませんでした", vim.log.levels.WARN)
            return
        end

        -- vim.api.nvim_buf_get_text を使用（0-indexed行、0-indexed列）
        local bufnr = vim.api.nvim_get_current_buf()
        local start_row = start_pos[2] - 1 -- 1-indexed to 0-indexed
        local start_col = start_pos[3] - 1 -- 1-indexed to 0-indexed
        local end_row = end_pos[2] - 1 -- 1-indexed to 0-indexed
        local end_col = end_pos[3] -- end_col は inclusive なので調整不要

        local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

        -- linesが空でないか確認
        if not lines or #lines == 0 then
            vim.notify("選択範囲が空です", vim.log.levels.WARN)
            return
        end

        local text = table.concat(lines, "\n")
        local full_text = string.format("%s\n\n```\n%s\n```", prompt_text, text)
        M.send_to_ai(full_text, tool_name)
    end
end

return M

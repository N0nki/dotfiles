local M = {}

-- tmuxペインを選択してテキストを送信
function M.send_to_claude(text)
  -- tmux内で実行されているかチェック
  if vim.fn.getenv("TMUX") == vim.NIL then
    vim.notify("tmux環境外では使用できません", vim.log.levels.WARN)
    return
  end

  -- tmuxのペインリストを取得（現在のウィンドウのみ）
  local panes = vim.fn.system("tmux list-panes -F '#{pane_index}:#{pane_current_command}'")

  -- Claude Codeが動いているペインを探す
  local claude_pane = nil
  local current_pane = vim.fn.system("tmux display-message -p '#{pane_index}'"):gsub("\n", "")

  for line in panes:gmatch("[^\r\n]+") do
    local pane_idx = line:match("^(%d+):")
    -- 現在のペイン以外で、nodeまたはclaudeを含むペインを探す
    if pane_idx ~= current_pane and (line:match("node") or line:match("claude")) then
      claude_pane = pane_idx
      break
    end
  end

  if not claude_pane then
    vim.notify("Claude Codeペインが見つかりません", vim.log.levels.WARN)
    return
  end

  -- テキストを整形（改行を保持しつつ、シングルクォートをエスケープ）
  local escaped_text = text:gsub("'", "'\\''")

  -- tmuxペインにテキストを送信
  local cmd = string.format("tmux send-keys -t %s -l '%s'", claude_pane, escaped_text)
  vim.fn.system(cmd)

  -- Enterキーを送信してプロンプトを実行
  vim.fn.system(string.format("tmux send-keys -t %s Enter", claude_pane))

  vim.notify(string.format("Claude Code (pane %s) にテキストを送信しました", claude_pane), vim.log.levels.INFO)
end

-- ビジュアル選択範囲を送信
function M.send_visual_to_claude()
  -- ビジュアルモードで選択された範囲を取得
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- 最初と最後の行の部分選択を処理
  if #lines == 1 then
    lines[1] = lines[1]:sub(start_pos[3], end_pos[3])
  else
    lines[1] = lines[1]:sub(start_pos[3])
    lines[#lines] = lines[#lines]:sub(1, end_pos[3])
  end

  local text = table.concat(lines, "\n")
  M.send_to_claude(text)
end

-- バッファ全体を送信
function M.send_buffer_to_claude()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(lines, "\n")
  M.send_to_claude(text)
end

-- 現在のファイルパスと内容を送信
function M.send_buffer_with_filepath()
  local filepath = vim.fn.expand("%:p")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")

  local text = string.format("ファイル: %s\n\n```\n%s\n```", filepath, content)
  M.send_to_claude(text)
end

-- カスタムプロンプトと一緒に送信
function M.send_with_prompt(prompt_text)
  return function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local text = table.concat(lines, "\n")
    local full_text = string.format("%s\n\n```\n%s\n```", prompt_text, text)
    M.send_to_claude(full_text)
  end
end

-- ビジュアル選択範囲をプロンプトと一緒に送信
function M.send_visual_with_prompt(prompt_text)
  return function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    if #lines == 1 then
      lines[1] = lines[1]:sub(start_pos[3], end_pos[3])
    else
      lines[1] = lines[1]:sub(start_pos[3])
      lines[#lines] = lines[#lines]:sub(1, end_pos[3])
    end

    local text = table.concat(lines, "\n")
    local full_text = string.format("%s\n\n```\n%s\n```", prompt_text, text)
    M.send_to_claude(full_text)
  end
end

return M

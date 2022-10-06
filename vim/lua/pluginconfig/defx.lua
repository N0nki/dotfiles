local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

vim.fn["defx#custom#column"]("filename", {
    directory_icon =  '▸',
    opened_icon =  '▾',
    indent =  "  ",
})

function defx_my_settings()
  local opts = {noremap = true, silent = true, expr = true}
  local buf_keymap = vim.api.nvim_buf_set_keymap

  buf_keymap(0, "n", "l", [[defx#do_action("drop")]], opts)
  buf_keymap(0, "n", "h", [[defx#do_action("cd", ['..'])]], opts)
  buf_keymap(0, "n", "<CR>", [[defx#do_action("drop")]], opts)
  buf_keymap(0, "n", "s", [[defx#do_action("drop", "split")]], opts)
  buf_keymap(0, "n", "v", [[defx#do_action("drop", "vsplit")]], opts)
  buf_keymap(0, "n", "t", [[defx#do_action("open", "tabe")]], opts)
  buf_keymap(0, "n", "c", [[defx#do_action("copy")]], opts)
  buf_keymap(0, "n", "m", [[defx#do_action("move")]], opts)
  buf_keymap(0, "n", "p", [[defx#do_action("paste")]], opts)
  buf_keymap(0, "n", "o", [[defx#do_action("open_or_close_tree")]], opts)
  buf_keymap(0, "n", "K", [[defx#do_action("new_directory")]], opts)
  buf_keymap(0, "n", "N", [[defx#do_action("new_file")]], opts)
  buf_keymap(0, "n", "d", [[defx#do_action("remove")]], opts)
  buf_keymap(0, "n", "r", [[defx#do_action("rename")]], opts)
  buf_keymap(0, "n", "x", [[defx#do_action("execute_system")]], opts)
  buf_keymap(0, "n", "yy", [[defx#do_action("yank_path")]], opts)
  buf_keymap(0, "n", "~", [[defx#do_action("cd")]], opts)
  buf_keymap(0, "n", "S", [[defx#do_action("toggle_sort", "extension")]], opts)
  buf_keymap(0, "n", ".", [[defx#do_action("toggle_ignored_files")]], opts)
  buf_keymap(0, "n", "q", [[defx#do_action("quit")]], opts)
  buf_keymap(0, "n", "<Leader>", [[defx#do_action("toggle_select") . "j"]], opts)
  buf_keymap(0, "n", "*", [[defx#do_action("toggle_select_all")]], opts)
  buf_keymap(0, "n", "j", [[line(".") == line("$") ? "gg": "j"]], opts)
  buf_keymap(0, "n", "k", [[line(".") == 1 ? "G": "k"]], opts)
  buf_keymap(0, "n", "<C-l>", [[defx#do_action("redraw")]], opts)
  buf_keymap(0, "n", "<C-g>", [[defx#do_action("print")]], opts)
end

autocmd("FileType", {
  pattern = "defx",
  command = "lua defx_my_settings()"
})

function defx_explorer_mode()
  vim.fn["defx#util#call_defx"]('Defx',
  '-new -auto-cd -split=vertical -winwidth=35 -direction=topleft -columns=indent:git:icons:space:filename -search=`expand("%:p")` `expand("%:p:h")`'
  )
end

function defx_floating_mode()
  vim.fn["defx#util#call_defx"]('Defx',
  '-new -auto-cd -split=floating -columns=indent:git:icons:space:filename:size:type:time -search=`expand("%:p")` `expand("%:p:h")`'
  )
end

function defx_detail_mode()
  vim.fn["defx#util#call_defx"]('Defx',
  '-new -auto-cd -columns=indent:git:icons:space:filename:size:type:time -search=`expand("%:p")` `expand("%:p:h")`'
  )
end

command("DefxExplorerMode", defx_explorer_mode, {force = true})
command("DefxFloatingMode", defx_floating_mode, {force = true})
command("DefxDetailMode", defx_detail_mode, {force = true})

keymap("n", "<Leader>e", ":<C-u>DefxExplorerMode<CR>", opts)
keymap("n", "<Leader>t", ":<C-u>DefxFloatingMode<CR>", opts)

if vim.fn["argc"]() == 0 then
  autocmd("VimEnter", {
    pattern = "*",
    command = "DefxExplorerMode"
  })
end

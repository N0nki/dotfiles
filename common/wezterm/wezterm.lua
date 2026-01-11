local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つのときは非表示
config.hide_tab_bar_if_only_one_tab = true

-- フルスクリーンで起動
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

return config

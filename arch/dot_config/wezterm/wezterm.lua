local wezterm = require "wezterm"
local config = wezterm.config_builder()
local mux = wezterm.mux

-- TODO: upstream issue: <https://github.com/wez/wezterm/issues/5604>
config.enable_wayland = false
config.font = wezterm.font_with_fallback {
  "CaskaydiaCove Nerd Font",
  "MonaspiceNe Nerd Font",
  "FiraCode Nerd Font",
  "Cascadia Code",
  "Monaspace Neon",
  "FiraCode",
  "JetBrains Mono",
  "Noto Sans Mono",
  "Noto Sans Mono CJK SC",
  "Twemoji Flags",
  "Segoe UI Emoji",
  "Noto Color Emoji",
  "Nerd Font Symbols",
}
config.hide_tab_bar_if_only_one_tab = true

wezterm.on('gui-startup', function(cmd)
  -- luacheck: no unused secondaries
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config

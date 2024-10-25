local wezterm = require "wezterm"
local mux = wezterm.mux
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  "CaskaydiaCove Nerd Font",
  "MonaspiceNe Nerd Font",
  "FiraCode Nerd Font",
  "Cascadia Code",
  "Monaspace Neon",
  "FiraCode",
  "JetBrains Mono",
  "Symbols Nerd Font",
  "Noto Color Emoji",
  "Noto Sans",
  "Noto Sans CJK SC",
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config

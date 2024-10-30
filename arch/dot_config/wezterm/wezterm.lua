local wezterm = require "wezterm"
local mux = wezterm.mux
local config = wezterm.config_builder()

-- TODO: upstream bug: <https://github.com/wez/wezterm/issues/5604>
config.enable_wayland = false

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
  -- luacheck: no unused secondaries
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config

local wezterm = require "wezterm"

local config = wezterm.config_builder()

-- TODO: switch to Cascadia Code
-- https://github.com/microsoft/cascadia-code/issues/730
config.font = wezterm.font_with_fallback {
  "CaskaydiaCove Nerd Font",
  "MonaspiceNe Nerd Font",
  "FiraCode Nerd Font",
}

return config

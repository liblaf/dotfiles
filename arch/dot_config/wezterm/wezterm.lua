local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  {
    family = 'MonaspiceNe Nerd Font',
    harfbuzz_features = { 'ss01', 'ss02', 'ss03', 'ss06', 'ss07', 'ss08', 'calt', 'dlig' },
  },
  'FiraCode Nerd Font'
}

return config

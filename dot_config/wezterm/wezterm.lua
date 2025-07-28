local wezterm = require 'wezterm'
return {
  font = wezterm.font_with_fallback { 'Monaspace Neon Nerd Font', 'Monaspace Radon Nerd Font' },
  color_scheme = 'Catppuccin Mocha',
  use_dead_keys = false,
}

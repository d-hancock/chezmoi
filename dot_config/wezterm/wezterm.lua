local wezterm = require 'wezterm'
local config = {}

-- Use config builder for newer versions
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font configuration
config.font = wezterm.font_with_fallback {
  'Monaspace Neon Nerd Font',
  'Monaspace Radon Nerd Font',
  'JetBrains Mono Nerd Font',
  'Fira Code Nerd Font',
}
config.font_size = 11.0
config.line_height = 1.1

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'

-- Window configuration
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"

-- Disable dead keys
config.use_dead_keys = false

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

-- Cursor
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 500

-- Performance
config.max_fps = 60
config.animation_fps = 60

-- Keybindings
config.keys = {
  -- Pane management
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'D', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
  
  -- Navigate panes
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  
  -- Resize panes
  { key = 'LeftArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
  
  -- Tab management
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  
  -- Font size
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
  
  -- Copy mode
  { key = 'X', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
  
  -- Search
  { key = 'F', mods = 'CTRL|SHIFT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
}

-- Mouse bindings
config.mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- SSH domains (example)
config.ssh_domains = {
  -- {
  --   name = 'my.server',
  --   remote_address = 'my.server:22',
  --   username = 'username',
  -- },
}

-- Local environment variables
config.set_environment_variables = {
  -- Set TERM for better compatibility
  TERM = 'wezterm',
}

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 150,
}

-- Hyperlink rules
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Add rule for file paths
table.insert(config.hyperlink_rules, {
  regex = [[\b\w+://(?:[\w.-]+)\.[a-z]{2,15}\S*\b]],
  format = '$0',
})

return config

-- ===================================================================
-- WezTerm Terminal Configuration
-- ===================================================================
-- This file configures WezTerm terminal emulator
-- WezTerm is a GPU-accelerated terminal with advanced features
-- Applied to ~/.config/wezterm/wezterm.lua by ChezMoi
-- Documentation: https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'
local config = {}

-- Use config builder for newer versions of WezTerm
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ===================================================================
-- Font Configuration
-- ===================================================================
-- Configure fonts with fallback hierarchy for best glyph coverage
config.font = wezterm.font_with_fallback {
  'Monaspace Neon Nerd Font',    -- Primary: Monaspace Neon with Nerd Font icons
  'Monaspace Radon Nerd Font',   -- Fallback: Monaspace Radon variant
  'JetBrains Mono Nerd Font',    -- Fallback: JetBrains Mono
  'Fira Code Nerd Font',         -- Fallback: Fira Code
}
config.font_size = 11.0          -- Base font size
config.line_height = 1.1         -- Slightly increased line spacing for readability

-- ===================================================================
-- Appearance and Theme
-- ===================================================================
-- Color scheme and visual settings
config.color_scheme = 'Catppuccin Mocha'  -- Dark theme that matches our Starship config

-- ===================================================================
-- Window Configuration
-- ===================================================================
-- Window appearance and behavior
config.window_decorations = "RESIZE"        -- Show resize controls but hide title bar
config.window_close_confirmation = "AlwaysPrompt"  -- Confirm before closing
config.scrollback_lines = 3000              -- Keep 3000 lines of scrollback history
config.default_workspace = "home"           -- Default workspace name

-- ===================================================================
-- Input and Keyboard
-- ===================================================================
-- Keyboard and input handling
config.use_dead_keys = false                -- Disable dead keys for faster typing

-- ===================================================================
-- Tab Bar Configuration
-- ===================================================================
-- Tab bar appearance and behavior
config.hide_tab_bar_if_only_one_tab = true  -- Clean interface when only one tab
config.tab_bar_at_bottom = false            -- Tab bar at top
config.use_fancy_tab_bar = true             -- Use styled tab bar

-- ===================================================================
-- Cursor Configuration
-- ===================================================================
-- Cursor appearance and behavior
config.default_cursor_style = 'SteadyBlock' -- Block cursor that doesn't blink
config.cursor_blink_rate = 500              -- Blink rate in milliseconds

-- ===================================================================
-- Performance Settings
-- ===================================================================
-- Optimize for smooth performance
config.max_fps = 60                         -- Limit FPS for battery efficiency
config.animation_fps = 60                   -- Animation frame rate

-- ===================================================================
-- Key Bindings
-- ===================================================================
-- Custom keyboard shortcuts for productivity
config.keys = {
  -- ===== Pane Management =====
  -- Split panes horizontally and vertically
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'D', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
  
  -- ===== Pane Navigation (Vim-style) =====
  -- Navigate between panes using hjkl keys
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  
  -- ===== Pane Resizing =====
  -- Resize panes using arrow keys with modifier
  { key = 'LeftArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
  
  -- ===== Tab Management =====
  -- Create and navigate tabs
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  
  -- ===== Font Size Control =====
  -- Adjust font size dynamically
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
  
  -- ===== Text Operations =====
  -- Copy mode and search functionality
  { key = 'X', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
  { key = 'F', mods = 'CTRL|SHIFT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
}

-- ===================================================================
-- Mouse Configuration
-- ===================================================================
-- Mouse interaction settings
config.mouse_bindings = {
  -- Ctrl+click to open links
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- ===================================================================
-- Remote Access Configuration
-- ===================================================================
-- SSH domains for connecting to remote servers
-- Uncomment and configure as needed
config.ssh_domains = {
  -- Example SSH domain configuration:
  -- {
  --   name = 'my.server',          -- Friendly name for the connection
  --   remote_address = 'my.server:22',  -- Server address and port
  --   username = 'username',       -- SSH username
  -- },
}

-- ===================================================================
-- Environment Variables
-- ===================================================================
-- Set environment variables for the terminal
config.set_environment_variables = {
  TERM = 'wezterm',                -- Set TERM for better compatibility
  -- Enable WezTerm detection for shell integration
  WEZTERM_EXECUTABLE = wezterm.executable_dir,
}

-- ===================================================================
-- Notifications and Alerts
-- ===================================================================
-- Configure bell and visual notifications
config.audible_bell = "Disabled"    -- Disable annoying audio bell

-- Configure visual bell (screen flash)
config.visual_bell = {
  fade_in_function = "EaseIn",       -- Smooth fade in
  fade_in_duration_ms = 150,         -- Fade in duration
  fade_out_function = "EaseOut",     -- Smooth fade out
  fade_out_duration_ms = 150,        -- Fade out duration
}

-- ===================================================================
-- Hyperlink Detection
-- ===================================================================
-- Configure URL and file path detection
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Add custom rule for detecting URLs
table.insert(config.hyperlink_rules, {
  regex = [[\b\w+://(?:[\w.-]+)\.[a-z]{2,15}\S*\b]],  -- Match URLs
  format = '$0',                                        -- Use the whole match
})

-- ===================================================================
-- Return Configuration
-- ===================================================================
-- Return the complete configuration to WezTerm
return config

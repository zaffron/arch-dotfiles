-- Pull the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9
config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.enable_wayland = true

config.font_size = 12
config.font = wezterm.font("MonoLisa Nerd Font")
config.color_scheme = "Catppuccin Macchiato"
config.max_fps = 144
config.harfbuzz_features = { "ss02", "ss08", "zero", "ss11", "ss14" }

config.window_padding = {
	top = 5,
	right = 5,
	bottom = 5,
	left = 5,
}

return config

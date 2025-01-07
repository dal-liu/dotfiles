local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
config.enable_scroll_bar = true

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _, _, tab_config, hover, _)
	local edge_background = "#1e1e1e"
	local background = "#1e1e1e"
	local foreground = "#98989d"

	if tab.is_active then
		background = "#464646"
		foreground = "#ffffff"
	elseif hover then
		background = "#464646"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	local max = tab_config.tab_max_width - 8
	if #title > max then
		title = ".." .. wezterm.truncate_left(title, max)
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = (tab.tab_index + 1) .. ": " .. title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
	}
end)

config.color_scheme = "Apple System Colors"
config.colors = {
	tab_bar = {
		background = "#1e1e1e",
		inactive_tab_hover = {
			bg_color = "#3c3c3c",
			fg_color = "#b1b1b5",
			italic = false,
		},
	},
}

config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.25cell",
	bottom = "0.25cell",
}

wezterm.on("update-status", function(window, _)
	local overrides = window:get_config_overrides() or {}
	local is_single_tab = #window:mux_window():tabs() == 1

	overrides.window_frame = {
		border_top_height = is_single_tab and "0cell" or "0.25cell",
	}

	window:set_config_overrides(overrides)
end)

config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 16
config.harfbuzz_features = { "zero" }
config.line_height = 1.1

return config

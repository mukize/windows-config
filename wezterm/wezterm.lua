local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

--- font
config.font_size = 13
config.font = wezterm.font_with_fallback { "IosevkaTerm NF" }
-- config.line_height = 0.95
---

--- appearance
config.audible_bell = "Disabled"
config.color_scheme = "Tokyo Night"

config.front_end = "OpenGL"
config.prefer_egl = true
config.window_background_opacity = 0.9

config.window_decorations = "RESIZE"
config.window_padding = {
	bottom = 0,
	top = 0,
	left = 2,
	right = 2,
}
config.adjust_window_size_when_changing_font_size = false
---

--- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 50
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
wezterm.on("update-right-status", function(window)
	local date = wezterm.strftime("%Y-%m-%d %H:%M")
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Half" } },
		{ Foreground = { AnsiColor = "Grey" } },
		{ Text = date },
	}))
end)
wezterm.on("format-tab-title", function(tab)
	local prefix = "|" .. tab.tab_index + 1 .. "|"
	if string.sub(tab.active_pane.title, 1, 1) ~= " " then
		prefix = prefix .. " "
	end
	return prefix .. tab.active_pane.title .. " "
end)
---

--- keys
config.keys = {
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
}
config.send_composed_key_when_left_alt_is_pressed = false -- allows <A-key> maps
config.allow_win32_input_mode = false                     -- allows <C-Space> map
config.enable_csi_u_key_encoding = true                   -- fixes <C-a> issue in mprocs
---

--- windows
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Debian"
	config.default_cwd = "/home/mukii"
	config.quick_select_patterns = {
		"[cC]\\:\\\\[A-Za-z\\\\_.]*", -- windows file links
	}
	config.launch_menu = {
		{
			label = "Clink",
			args = { "cmd.exe", "/s", "/k", "c:/tools/clink/clink_x64.exe", "inject", "-q" },
			domain = { DomainName = "local" },
			set_environment_variables = {
				CLINK_PROFILE = "c:/tools/clink/session",
				CLINK_PATH = os.getenv("USERPROFILE") .. "\\.config\\clink\\scripts ;"
				    .. os.getenv("USERPROFILE") .. "\\.config\\clink\\completions",
				PATH = os.getenv("PATH") .. ";C:\\Program Files\\Git\\usr\\bin",
				prompt = "$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ",
			},
		},
	}
end
---

return config

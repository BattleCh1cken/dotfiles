local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "Twitter Color Emoji" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrains Mono Nerd Font"
return {
	-- Font Stuff
	--font = font_with_fallback(font_name),
	font_rules = {
		{ italic = true, font = font_with_fallback(font_name, { italic = true }) },
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true, italic = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true }),
		},
		{ intensity = "Half", font = font_with_fallback(font_name .. " Light") },
	},
	font_size = 12.0,
	line_height = 1.0,
	font = wezterm.font("JetBrains Mono Nerd Font"),
	color_scheme = "Oxocarbon Dark",
	hide_tab_bar_if_only_one_tab = true,
	custom_block_glyphs = true,
	audible_bell = "Disabled",

	-- Get rid of close prompt
	window_close_confirmation = "NeverPrompt",
}

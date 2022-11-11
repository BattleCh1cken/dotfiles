local bufferline = require("bufferline")
local signs = require("ui.icons").lsp
local pad = require("core.utils").pad
local colors = require("ui.theme").colors

bufferline.setup({
	highlights = require("catppuccin.groups.integrations.bufferline").get({
		custom = {
			mocha = {
				-- Errors
				error = { fg = colors.red },
				error_visible = { fg = colors.red },
				error_selected = { fg = colors.red },
				error_diagnostic = { fg = colors.red },
				error_diagnostic_visible = { fg = colors.red },
				error_diagnostic_selected = { fg = colors.red },
				-- Warnings
				warning = { fg = colors.yellow },
				warning_visible = { fg = colors.yellow },
				warning_selected = { fg = colors.yellow },
				warning_diagnostic = { fg = colors.yellow },
				warning_diagnostic_visible = { fg = colors.yellow },
				warning_diagnostic_selected = { fg = colors.yellow },
				-- Infos
				info = { fg = colors.sky },
				info_visible = { fg = colors.sky },
				info_selected = { fg = colors.sky },
				info_diagnostic = { fg = colors.sky },
				info_diagnostic_visible = { fg = colors.sky },
				info_diagnostic_selected = { fg = colors.sky },
				-- Hint
				hint = { fg = colors.teal },
				hint_visible = { fg = colors.teal },
				hint_selected = { fg = colors.teal },
				hint_diagnostic = { fg = colors.teal },
				hint_diagnostic_visible = { fg = colors.teal },
				hint_diagnostic_selected = { fg = colors.teal },
				-- Diagnostics
				diagnostic = { fg = colors.subtext0 },
				diagnostic_visible = { fg = colors.subtext0 },
				diagnostic_selected = { fg = colors.subtext0 },
			},
		},
	}),

	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and pad(signs.Error) or (e == "warning" and pad(signs.Warn) or pad(signs.Hint))
				s = s .. n .. sym
			end
			return s
		end,
	},
})

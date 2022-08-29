local ok_feline, feline = pcall(require, "feline")

if not ok_feline then
	return
end

local ok_ctp_feline, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")

if not ok_ctp_feline then
	return
end
local icons = require("ui.icons")

ctp_feline.setup({
	assets = {
		left_separator = "",
		right_separator = "",
		bar = "█",
		mode_icon = "",
		dir = "  ",
		file = "   ",
		lsp = {
			server = "  ",
			error = icons.lsp.Error,
			warning = icons.lsp.Warn,
			info = icons.lsp.Info,
			hint = icons.lsp.Hint,
		},
		git = {
			branch = "  ",
			added = "  ",
			changed = "  ",
			removed = "  ",
		},
	},
})

feline.setup({
	components = ctp_feline.get(),
})

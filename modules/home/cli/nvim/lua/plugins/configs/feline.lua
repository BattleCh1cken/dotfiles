local ok_feline, feline = pcall(require, "feline")

if not ok_feline then
	return
end

local ok_ctp_feline, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")

if not ok_ctp_feline then
	return
end
local symbols = {}
symbols.lsp = require("utils").signs
symbols.git = require("utils").git


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
			error = symbols.lsp.Error,
			warning = symbols.lsp.Warn,
			info = symbols.lsp.Info,
			hint = symbols.lsp.Hint,
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

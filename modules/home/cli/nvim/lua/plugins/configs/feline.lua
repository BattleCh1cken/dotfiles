local ok_feline, feline = pcall(require, "feline")

if not ok_feline then
	return
end

local ok_ctp_feline, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")

if not ok_ctp_feline then
	return
end
local icons = require("ui.icons")
local utils = require("core.utils")

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
			error = utils.pad(icons.lsp.Error),
			warning = utils.pad(icons.lsp.Warn),
			info = utils.pad(icons.lsp.Info),
			hint = utils.pad(icons.lsp.Hint),
		},
		git = {
			branch = "  ",
			added = utils.pad(icons.git.added),
			changed = utils.pad(icons.git.modified),
			removed = utils.pad(icons.git.removed),
		},
	},
})

feline.setup({
	components = ctp_feline.get(),
})

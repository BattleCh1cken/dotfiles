local bufferline = require("bufferline")
local signs = require("ui.icons").lsp
local pad = require("core.utils").pad
local colors = require("ui.theme").colors

bufferline.setup({
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

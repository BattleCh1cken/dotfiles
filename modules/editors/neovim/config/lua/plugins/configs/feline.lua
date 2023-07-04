local ok_feline, feline = pcall(require, "feline")

if not ok_feline then
	return
end

--local ok_ctp_feline, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")


local icons = require("ui.icons")
local utils = require("core.utils")

feline.setup({

})

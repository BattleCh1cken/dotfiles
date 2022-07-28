local ok_feline, feline = pcall(require, "feline")

if not ok_feline then
	return
end

local ok_ctp_feline, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")

if not ok_ctp_feline then
	return
end

ctp_feline.setup({})

feline.setup({
	components = ctp_feline.get(),
})

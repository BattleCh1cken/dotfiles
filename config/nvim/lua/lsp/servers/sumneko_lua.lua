local M = {}

M.setup = function(on_attach, capabilities)
	require("lspconfig").sumneko_lua.setup({
		on_attach = on_attach,
		settings = {
			prefer_null_ls = true,
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
				},
				format = {
					enable = false,
				},
				diagnostics = {
					enable = true,
					globals = {
						"vim",
						"awesome",
					},
				},
			},
		},
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	})
end

return M

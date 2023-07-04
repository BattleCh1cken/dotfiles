require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	--ensure_installed = { "cpp", "lua", "rust", "nix" },

	-- Install parsers synchronously (only applied to `ensure_installed`)

	-- Automatically install missing parsers when entering buffer

	-- List of parsers to ignore installing (for "all")
	--ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

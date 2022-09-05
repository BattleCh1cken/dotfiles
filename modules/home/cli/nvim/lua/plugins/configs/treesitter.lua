--local ok, treesitter = pcall(require, "nvim-treesitter.configs")

--if not ok then
--print("treesitter missing")
--return
--end

<<<<<<< HEAD
require("nvim-treesitter.configs").setup({
=======
treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = {  "cpp", "lua", "rust", "nix"},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	--ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
>>>>>>> b146603 (changed boxie system config)

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
})

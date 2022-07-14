local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
	return
end

-- local colors = require("theme").colors

treesitter.setup({
	autotag = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	ensure_installed = { "lua", "rust", "cpp", "python", "nix" },
	highlight = {
		enable = true,
	},
	rainbow = {
		colors = {
			-- colors.magenta,
			-- colors.cyan,
			-- colors.yellow,
			-- colors.orange,
			-- colors.red,
			-- colors.blue,
			-- colors.green,
		},
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})

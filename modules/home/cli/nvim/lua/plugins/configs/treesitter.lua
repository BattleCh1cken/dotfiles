--local ok, treesitter = pcall(require, "nvim-treesitter.configs")

--if not ok then
--print("treesitter missing")
--return
--end

require("nvim-treesitter.configs").setup({

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
})

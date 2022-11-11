local M = {}

M.colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	saphire = "#74c7ec",
	blue = "#87b0f9",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}
M.init = function()
	local isExistCatppuccin, catppuccin = pcall(require, "catppuccin")
	if isExistCatppuccin then
		catppuccin.setup({
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			transparent_background = false,
			term_colors = true,
			compile = {
				enabled = false,
				path = vim.fn.stdpath("cache") .. "/catppuccin",
			},
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
				coc_nvim = false,
				lsp_trouble = false,
				cmp = true,
				lsp_saga = false,
				gitgutter = false,
				gitsigns = true,
				leap = false,
				telescope = true,
				nvimtree = {
					enabled = true,
					show_root = true,
					transparent_panel = false,
				},
				neotree = {
					enabled = false,
					show_root = true,
					transparent_panel = false,
				},
				dap = {
					enabled = false,
					enable_ui = false,
				},
				which_key = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				dashboard = true,
				neogit = false,
				vim_sneak = false,
				fern = false,
				barbar = false,
				bufferline = false,
				markdown = true,
				lightspeed = true,
				ts_rainbow = false,
				hop = false,
				notify = true,
				telekasten = true,
				symbols_outline = true,
				mini = false,
				aerial = false,
				vimwiki = true,
				beacon = true,
			},
			color_overrides = {},
			highlight_overrides = {
				mocha = {
					--Telescope Stuff
					TelescopePromptPrefix = { bg = M.colors.crust },
					TelescopePromptNormal = { bg = M.colors.crust },
					TelescopeResultsNormal = { bg = M.colors.mantle },
					TelescopePreviewNormal = { bg = M.colors.crust },
					TelescopePromptBorder = { bg = M.colors.crust, fg = M.colors.crust },
					TelescopeResultsBorder = { bg = M.colors.mantle, fg = M.colors.crust },
					TelescopePreviewBorder = { bg = M.colors.crust, fg = M.colors.crust },
					TelescopePromptTitle = { fg = M.colors.crust },
					TelescopeResultsTitle = { fg = M.colors.text },
					TelescopePreviewTitle = { fg = M.colors.crust },
					--Floating Stuff & CMP
					CmpBorder = { fg = M.colors.surface0 },
					CmpDocBorder = { fg = M.colors.surface0 },
					FloatBorder = { fg = M.colors.surface0 },
					NormalFloat = { fg = M.colors.text, bg = M.colors.base }, -- Normal text in floating windows.
				},
			},
		})
		-- Lua
		vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		vim.cmd([[colorscheme catppuccin]])
	end
end
return M

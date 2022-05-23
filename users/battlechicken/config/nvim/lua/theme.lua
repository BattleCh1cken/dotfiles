local M = {}

M.colors = {
  bg = "#1E1E2E",
  fg = "#D9E0EE",
  red = "#F28FAD",
  orange = "#E8A2AF",
  yellow = "#FAE3B0",
  blue = "#96CDFB",
  green = "#ABE9B3",
  cyan = "#89DCEB",
  magenta = "#DDB6F2",
  black0 = "#161320",
  black1 = "#1A1826",
  black2 = "#1E1E2E",
  black3 = "#302D41",
  black4 = "#575268",
  grey0 = "#6E6C7E",
  grey1 = "#988BA2",
  grey2 = "#C3BAC6",
  white = "#D9E0EE",
  white1 = "#C9CBFF",
  white2 = "#F5E0DC"
}

M.init = function()
  local isExistCatppuccin, catppuccin = pcall(require, "catppuccin")
  if isExistCatppuccin then
  print("Catppuccin activated")
  catppuccin.setup({
    transparent_background = false,
term_colors = false,
styles = {
	comments = "italic",
	functions = "italic",
	keywords = "italic",
	strings = "NONE",
	variables = "italic",
},
integrations = {
	treesitter = true,
	native_lsp = {
		enabled = true,
		virtual_text = {
			errors = "italic",
			hints = "italic",
			warnings = "italic",
			information = "italic",
		},
		underlines = {
			errors = "underline",
			hints = "underline",
			warnings = "underline",
			information = "underline",
		},
	},
	lsp_trouble = false,
	cmp = true,
	lsp_saga = false,
	gitgutter = false,
	gitsigns = true,
	telescope = true,
	nvimtree = {
		enabled = true,
		show_root = false,
		transparent_panel = false,
	},
	neotree = {
		enabled = false,
		show_root = false,
		transparent_panel = false,
	},
	which_key = false,
	indent_blankline = {
		enabled = true,
		colored_indent_levels = false,
	},
	dashboard = true,
	neogit = false,
	vim_sneak = false,
	fern = false,
	barbar = false,
	bufferline = true,
	markdown = true,
	lightspeed = false,
	ts_rainbow = false,
	hop = false,
	notify = true,
	telekasten = true,
	symbols_outline = true,
}
  })
  vim.cmd[[colorscheme catppuccin]]
end

end

return M

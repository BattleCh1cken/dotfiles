local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

local normalOpts = {
	mode = "n",
	prefix = "",
	silent = true,
	noremap = true,
	nowait = true,
}

wk.register({
	["<c-n>"] = { "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle" },
	["<leader>/"] = {
		"<Plug>(comment_toggle_current_linewise)' : '<Plug>(comment_toggle_linewise_count)'",
		"[COMMENT] Toggle",
	},
	-- cycle through buffers
	["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "[BUFFERLINE] cycle next buffer" },
	["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "[BUFFERLINE] cycle prev buffer" },

	--Toggleterm with NvChad mappings
	["<A-i>"] = { "<cmd>ToggleTerm direction=float<cr>", "[TOGGLE] floating term" },

	["<A-h>"] = { "<cmd>ToggleTerm direction=horizontal<cr>", "[TOGGLE] horizontal term" },

	["<A-v>"] = { "<cmd>ToggleTerm direction=vertical<cr>", "[TOGGLE] vertical term" },

	["<leader>f"] = {
		name = "[TELESCOPE]",
		f = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },
		g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by grep" },
		b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
		m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
	},

	["<leader>g"] = {
		name = "[GIT]",
		s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
		h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
		d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
		n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
		p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
	},
}, normalOpts)

local visualOpts = {
	mode = "v",
	prefix = "",
	silent = true,
	noremap = true,
	nowait = true,
}
wk.register({
	["<leader>/"] = { "<Plug>(comment_toggle_blockwise_visual)", "[COMMENT] Toggle block" },
}, visualOpts)
wk.setup({})

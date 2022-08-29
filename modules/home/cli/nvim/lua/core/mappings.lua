local ok, wk = pcall(require, "which-key")
if not ok then
	return
end
-- Shorten function name
local keymap = vim.keymap.set

--Set options
local opts = { silent = true }
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Normal --

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Visual --

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Plugins --

-- NvimTree
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files hidden=true no_ignore=true<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current(nil, {cfg})<CR>", opts)
keymap("x", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current(nil, {cfg})<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", opts)
keymap("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>gj", "<cmd>Gitsigns next_hunk<cr>", opts)
keymap("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts)

keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", opts)
wk.register({
	-- cycle through buffers
	-- ["<TAB>"] = { "<cmd>BufferLineCycleNext<CR>", "[BUFFERLINE] cycle next buffer" },
	-- ["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<CR>", "[BUFFERLINE] cycle prev buffer" },
})
-- Visual Mappings
wk.setup({})

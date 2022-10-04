local theme = require("ui.theme")
local mappings = require("core.mappings")

local options = {
	termguicolors = true,
	fileencoding = "utf-8",
	autoread = true,
	wrap = false,
	backup = false,
	swapfile = false,
	hlsearch = false,
	incsearch = true,
	showmode = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	scrolloff = 999,
	autoindent = true,
	smartindent = true,
	sidescrolloff = 999,
	signcolumn = "yes",
	hidden = true,
	ignorecase = true,
	timeoutlen = 1000,
	shiftround = true,
	smartcase = true,
	splitbelow = true,
	splitright = true,
	number = true,
	relativenumber = true,
	clipboard = "unnamedplus",
	cursorline = true,
	mouse = "a",
	cmdheight = 1,
	undofile = true,
	pumheight = 10,
	laststatus = 3,
	updatetime = 250,
	background = "dark",
	foldmethod = "marker",
}

vim.opt.shortmess:append("c")
vim.cmd("filetype on")
vim.opt.shortmess:append("sI")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
for key, value in pairs(options) do
	vim.opt[key] = value
end

theme.init()

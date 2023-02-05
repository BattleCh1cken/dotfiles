local icons = require("ui.icons")

local servers = {
	"null_ls",
	"bashls",
	"sumneko_lua",
	"rnix",
	"clangd",
	"rust_analyzer",
	"pyright",
}

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- Make the floating borders rounded.
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--Keymaps
local opts = { silent = true }
vim.api.nvim_set_keymap("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lb", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>lr",
		"<cmd>lua require('telescope.builtin').lsp_references()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lrn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end
-- Call the servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
local _cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if _cmp_nvim_lsp then
	capabilities = cmp_nvim_lsp.default_capabilities()
end

local _lspconfig = pcall(require, "lspconfig")
if _lspconfig then
	for _, server in ipairs(servers) do
		require("lsp.servers." .. server).setup(on_attach, capabilities)
	end
end

for type, icon in pairs(icons.lsp) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- Config for diagnostic text
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
})

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

-- better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- Neo Tree
keymap("n", "<leader>n", ":Neotree reveal toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files hidden=true no_ignore=true<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>ft", ":TodoTelescope<CR>", opts)


-- Comment
keymap("n", "<leader>/", "<CMD>lua require('Comment.api').toggle.linewise.current(nil, {cfg})<CR>", opts)
keymap("x", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise.current(nil, {cfg})<CR>", opts)

-- Git
--keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", opts)
keymap("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>gj", "<cmd>Gitsigns next_hunk<cr>", opts)
keymap("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts)

keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", opts)

-- LSP
vim.keymap.set('n', '<space>le', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>lb', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>lf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

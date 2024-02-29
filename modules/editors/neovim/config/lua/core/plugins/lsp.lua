return {
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "onsails/lspkind-nvim" },
    { "folke/neodev.nvim",   config = true, lazy = true, ft = "lua" },
  },

  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = false,
      update_in_insert = true,
    })
    local lspconfig = require('lspconfig')

    local servers = {
      "rust_analyzer",
      "bashls",
      "lua_ls",
      "rnix",
      "clangd",
      "pyright",
      "tsserver",
      "typst_lsp",
      "svelte",
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local on_attach = function()
    end


    for _, server in ipairs(servers) do
      -- FIXME: make a better way to pass settings to language servers
      if server == "typst_lsp" then
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            exportPdf = "never"
          }
        })
      else
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach
        })
      end
    end
  end,

}

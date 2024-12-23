return {
  "neovim/nvim-lspconfig",
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

    local lspconfig = require("lspconfig")

    lspconfig.tinymist.setup({
      settings = {
        formatterMode = "typstyle",
        formatterPrintWidth = 80,
      },
    })

    lspconfig.nil_ls.setup({
      settings = {
        ["nil"] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      },
    })

    -- these servers require no extra config
    local servers = {
      "rust_analyzer",
      "bashls",
      "lua_ls",
      "clangd",
      "ts_ls",
      "svelte",
      "ruff",
    }

    for _, server in ipairs(servers) do
      lspconfig[server].setup({})
    end
  end,
}

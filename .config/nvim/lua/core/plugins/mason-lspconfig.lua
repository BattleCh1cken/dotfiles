return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason-lspconfig").setup {
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "jedi_language_server",
      },
    }
  end
}

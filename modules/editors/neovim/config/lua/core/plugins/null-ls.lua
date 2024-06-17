-- TODO: deprecated https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.black,
        formatting.prettier,
        formatting.shfmt,
      },
    })
  end,
}

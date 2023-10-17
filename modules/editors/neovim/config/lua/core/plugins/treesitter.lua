return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require 'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autopairs = { enable = true },
      ensure_installed = "all",

      auto_install = true,
    }
  end
}

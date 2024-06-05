return {
  'akinsho/bufferline.nvim',
  dependencies = { "catppuccin/nvim", "kyazdani42/nvim-web-devicons", lazy = true },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}

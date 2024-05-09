return {
  'akinsho/bufferline.nvim',
  dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup {}
  end
}

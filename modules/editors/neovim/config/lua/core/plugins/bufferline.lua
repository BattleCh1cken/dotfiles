return {
  'akinsho/bufferline.nvim',
  dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
      },
      highlights = {
        background = {
          fg = '#ffffff',
        },
        buffer_selected = {
          fg = '#33b1ff',
        },


      },
    }
  end
}

-- Just an example, supposed to be placed in /lua/custom/
local userPlugins = require "custom.plugins"

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.plugins = {
  user = userPlugins,
  options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
},
}

M.ui = {
   theme = "catppuccin",
}

M.options = {
  user = function()
    vim.opt.relativenumber = true
  end,
}


return M


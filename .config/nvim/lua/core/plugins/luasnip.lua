return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local vsc = require("luasnip.loaders.from_vscode")
    local lua = require("luasnip.loaders.from_lua")

    ls.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
    vsc.lazy_load()

    -- TODO: add bindings for things
  end
}

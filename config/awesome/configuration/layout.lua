local gears = require("gears")
local awful = require("awful")

local bling = require("module.bling")



tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        bling.layout.centered,
        awful.layout.suit.tile,
        awful.layout.suit.spiral,
    })
end)

awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

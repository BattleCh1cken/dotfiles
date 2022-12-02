-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- @DOC_REQUIRE_SECTION@
-- Standard awesome library
local gears = require("gears")
require("awful.autofocus")
-- Widget and layout library
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- Declarative object management
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- @DOC_DEFAULT_APPLICATIONS@
-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

require("config.tag")
require("config.bindings")
require("config.rules")
require("config.mouse")

--ui
require("ui.bar")
require("ui.notifications")
require("ui.titlebars")
--require("ui.wallpaper")

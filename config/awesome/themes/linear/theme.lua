local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful").xresources.apply_dpi
local colors = require("themes.colors.catppuccin.init")
local gears = require("gears")
local theme_path = require("gears").filesystem.get_configuration_dir() .. "themes/linear/"
local icon_path = theme_path .. "icons/"
local theme = {}

-- Default
theme.font = colors.font

theme.bg_normal = colors.bg
theme.bg_focus = colors.bg_alt
theme.bg_urgent = colors.urgent
theme.bg_minimize = colors.bg_alt

theme.fg_normal = colors.fg
theme.fg_focus = colors.fg
theme.fg_urgent = colors.urgent
theme.fg_minimize = colors.bg_alt

-- Titlebar
theme.titlebar_bg_normal = colors.bg_alt
theme.titlebar_bg_focus = colors.bg_alt
theme.titlebar_bg_urgent = colors.bg_alt
theme.titlebar_bg_minimize = colors.bg_alt

theme.titlebar_fg_normal = colors.bg_alt
theme.titlebar_fg_focus = colors.fg
theme.titlebar_fg_urgent = colors.urgent
theme.titlebar_fg_minimize = colors.bg_alt

-- Tasklist
theme.tasklist_bg_normal = colors.bg
theme.tasklist_bg_focus = colors.bg
theme.tasklist_bg_urgent = colors.bg
theme.tasklist_bg_minimize = colors.bg

theme.tasklist_fg_normal = colors.fg .. "25"
theme.tasklist_fg_focus = colors.fg
theme.tasklist_fg_urgent = colors.urgent
theme.tasklist_fg_minimize = colors.fg .. "25"

theme.tasklist_font_minimized = colors.font_alt
theme.tasklist_plain_task_name = true

-- Taglist
theme.taglist_bg_normal = colors.bg
theme.taglist_bg_focus = colors.bg
theme.taglist_bg_urgent = colors.bg
theme.taglist_bg_minimize = colors.bg
theme.taglist_bg_empty = colors.bg
theme.taglist_bg_occupied = colors.bg

theme.taglist_fg_normal = colors.bg_alt
theme.taglist_fg_focus = colors.fg
theme.taglist_fg_urgent = colors.urgent
theme.taglist_fg_minimize = colors.fg
theme.taglist_fg_empty = colors.fg .. "25"
theme.taglist_fg_occupied = colors.fg .. "75"

theme.taglist_spacing = dpi(10)

-- Menu
theme.menu_submenu_icon = gears.color.recolor_image(icon_path .. "submenu.png", colors.fg)
theme.menu_font = colors.font
theme.menu_bg_normal = colors.bg
theme.menu_bg_focus = colors.bg_alt
theme.menu_fg_normal = colors.fg
theme.menu_fg_focus = colors.fg
theme.menu_height = dpi(38)
theme.menu_width = dpi(150)

-- Misc
theme.useless_gap = dpi(2)
theme.border_width = dpi(0)
theme.bg_systray = colors.bg
theme.systray_icon_spacing = dpi(18)
theme.systray_max_rows = 3

-- Notification spacing
theme.notification_spacing = dpi(10)

-- Disable tooltips
theme.tooltip_opacity = 0

-- Wallpaper
--theme.wallpaper = colors.wall

-- Layout icons
theme.layout_floating = gears.color.recolor_image(icon_path .. "floating.png", colors.fg)
theme.layout_max = gears.color.recolor_image(icon_path .. "max.png", colors.fg)
theme.layout_tile = gears.color.recolor_image(icon_path .. "tile.png", colors.fg)

-- Titlebar icons
theme.close = gears.color.recolor_image(icon_path .. "close.png", colors.fg)
theme.minimize = gears.color.recolor_image(icon_path .. "minimize.png", colors.fg)
theme.maximize = gears.color.recolor_image(icon_path .. "maximize.png", colors.fg)

-- Systray icon
theme.systray = gears.color.recolor_image(icon_path .. "systray.png", colors.fg)

-- Awesome icon
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, colors.fg, colors.bg)

-- Icon theme
theme.icon_theme = nil

return theme

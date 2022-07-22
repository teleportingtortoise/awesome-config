---------------------------------------
--  "Irixium" awesome theme          --
--  Inspired by the KDE colorscheme  --
---------------------------------------
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local themes_path = require("gears.filesystem").get_themes_dir()
local gears = require("gears")
-- Simple drawing library
local drawing = require("lib.drawing")
local common = require("themes.Irixium.settings")

--------------
--  BASICS  --
--------------
local theme = {}

theme.wallpaper     = "~/.config/awesome/background.svg"
theme.font          = "Iosevka Medium " .. dpi(9)
theme.taglist_font  = "Symbols Nerd Font " .. dpi(10)
theme.calendar_font = "Iosevka " .. dpi(10)


-- UI Scaling
theme.useless_gap   = common.scales.useless_gap
theme.menu_height   = common.scales.menu_height
theme.menu_width    = common.scales.menu_width
theme.border_width  = common.scales.border_width
theme.taglist_shape_border_width = common.scales.border_width
theme.taglist_shape_border_width_empty = 0
theme.bev_width     = common.scales.border_width
--theme.systray_icon_spacing = dpi(4)
theme.wibar_height  = common.scales.wibar_size
theme.wibar_width   = common.scales.wibar_size

-- Other basics
theme.hotkeys_modifiers_fg = common.colors.focused

theme.taglist_squares       = "false"
theme.titlebar_close_button = "true"

theme.border_normal = common.colors.text_body
theme.border_focus  = common.colors.hover
theme.border_marked = common.colors.white

theme.prompt_bg     = common.colors.text_body

-- WiBar
theme.wibar_bgimage = common.images.wibar_horizontal
theme.bg_normal     = common.colors.bevel_body
theme.bg_focus      = common.colors.grey
theme.bg_urgent     = common.colors.urgent

theme.bg_minimize   = theme.bg_normal

theme.bg_systray    = theme.bg_normal

theme.fg_normal     = common.colors.black
theme.fg_focus      = common.colors.black
theme.fg_urgent     = common.colors.black
theme.fg_minimize   = common.colors.grey

-- Taglist
theme.taglist_shape = common.shapes.rounded_rect

theme.taglist_shape_border_color = common.colors.grey
theme.taglist_shape_border_color_focus = common.colors.focus

-- Tasklist
theme.tasklist_fg_normal   = common.colors.black
theme.tasklist_fg_focus    = common.colors.white
theme.tasklist_bg_normal   = common.colors.bevel_body

theme.tasklist_bg_focus    = common.colors.focused
theme.bev_highlight_focus  = common.colors.focused_light
theme.bev_shadow_focus     = common.colors.focused_shadow

theme.tasklist_bg_urgent   = common.colors.urgent
theme.bev_highlight_urgent = common.colors.urgent_light
theme.bev_shadow_urgent    = common.colors.urgent_shadow

-- Titlebars
theme.titlebar_bg_focus    = common.colors.hover
theme.titlebar_bg_normal   = common.colors.grey
theme.titlebar_bg_urgent   = common.colors.urgent

theme.titlebar_fg_normal   = common.colors.white
theme.titlebar_fg_focus    = common.colors.white
theme.titlebar_fg_urgent   = common.colors.black
theme.titlebar_fg_minimize = common.colors.grey

-- Notifications
theme.notification_margin  = dpi(16)
theme.notification_shape   = common.shapes.rounded_rect
theme.notification_max_width = dpi(320)
theme.notification_border_width = dpi(1.25)
theme.notification_icon_size = dpi(128)
theme.notification_bg      = common.colors.text_body
theme.notification_fg      = common.colors.black
theme.notification_border_color = common.colors.black

-- IMAGES --

-- Taglist

-- Tasklist
theme.tasklist_bg_image_normal = common.images.tasklist_horizontal_normal
theme.tasklist_bg_image_focus = common.images.tasklist_horizontal_focus

theme.tasklist_bg_image_urgent = drawing.beveled_bar( nil, nil, 1080, theme.wibar_height,  false, theme.bev_width, theme.bg_urgent, theme.bev_highlight_urgent, theme.bev_shadow_urgent)
theme.tasklist_capstart_urgent = drawing.barcap( nil, nil, theme.wibar_height, "west", theme.bev_width, theme.bev_highlight_urgent, theme.bev_shadow_urgent, theme.bev_highlight_urgent)
theme.tasklist_capend_focus = drawing.barcap( nil, nil, theme.wibar_height, "east", theme.bev_width, theme.bev_highlight_urgent, theme.bev_shadow_urgent, theme.bev_shadow_urgent)

theme.tasklist_bg_image_minimize = common.images.tasklist_horizontal_normal


-- Titlebar background images
theme.titlebar_bg_image_focus = function(context, cr, width, height) drawing.beveled_rect( context, cr, width, height, dpi(1.25), "#eda771" )  end


-- Layout image definitions
theme.layout_fairh           = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv           = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating        = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier       = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max             = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen      = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom      = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft        = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile            = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop         = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral          = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle         = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw        = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne        = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw        = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse        = themes_path .. "default/layouts/cornersew.png"

theme.awesome_icon           = themes_path .. "default/awesome-icon.png"

-- from default for now...
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

return theme

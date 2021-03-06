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

--------------
--  BASICS  --
--------------

local theme = {}
theme.wallpaper     = "~/.config/awesome/background.svg"
theme.font          = "Iosevka Medium " .. dpi(9)
theme.taglist_font  = "Symbols Nerd Font " .. dpi(10)
theme.calendar_font = "Iosevka " .. dpi(10)

theme.colors = {
    black           = "#000000",
    grey            = "#7f7f7f",
    white           = "#f8f8f8",
    text_body       = "#9ebdbd",
    hover           = "#ffaa00",
    focus           = "#ff00ff",

    bevel_body      = "#c1c1c1",
    bevel_light     = "#efefef",
    bevel_shadow    = "#7f7f7f",

    focused         = "#9b7777",
    focused_light   = "#eda771",
    focused_shadow  = "#553a3f",

    urgent          = "#8a5e83",
    urgent_light    = "#ed71a1",
    urgent_shadow   = "#553a3f",
}

theme.shapes = {
    rounded_rect    = function(cr, width, height)
        gears.shape.rounded_rect( cr, width, height, dpi(2.6) ) end,
}

-- Other basics
theme.hotkeys_modifiers_fg = theme.colors.focused

theme.useless_gap   = dpi(0)
theme.menu_height   = dpi(24)
theme.menu_width    = dpi(180)
theme.border_width  = dpi(1.3)
theme.bev_width     = dpi(1.3)
--theme.systray_icon_spacing = dpi(4)
theme.taglist_squares       = "false"
theme.titlebar_close_button = "true"

theme.border_normal = theme.colors.grey
theme.border_focus  = theme.colors.hover
theme.border_marked = theme.colors.white

-- WiBar
theme.wibar_height  = dpi(32)
theme.wibar_width   = dpi(32)

theme.bg_normal     = theme.colors.bevel_body
theme.bev_highlight = theme.colors.bevel_light
theme.bev_shadow    = theme.colors.bevel_shadow

theme.bg_focus      = theme.colors.grey

theme.bg_urgent     = theme.colors.urgent

theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.colors.black
theme.fg_focus      = theme.colors.black
theme.fg_urgent     = theme.colors.black
theme.fg_minimize   = theme.colors.grey

-- Taglist
theme.taglist_shape = theme.shapes.rounded_rect
theme.taglist_shape_border_width = dpi(1.3)
theme.taglist_shape_border_color = theme.colors.grey
theme.taglist_shape_border_color_focus = theme.colors.focus
theme.taglist_shape_border_width_empty = 0

-- Tasklist
theme.tasklist_fg_normal   = theme.colors.black
theme.tasklist_fg_focus    = theme.colors.white
theme.tasklist_bg_normal   = theme.bg_normal

theme.tasklist_bg_focus    = theme.colors.focused
theme.bev_highlight_focus  = theme.colors.focused_light
theme.bev_shadow_focus     = theme.colors.focused_shadow

theme.tasklist_bg_urgent   = theme.colors.urgent
theme.bev_highlight_urgent = theme.colors.urgent_light
theme.bev_shadow_urgent    = theme.colors.urgent_shadow

-- Titlebars
theme.titlebar_bg_focus    = theme.colors.hover
theme.titlebar_bg_normal   = theme.colors.grey
theme.titlebar_bg_urgent   = theme.colors.urgent

theme.titlebar_fg_normal   = theme.colors.white
theme.titlebar_fg_focus    = theme.colors.white
theme.titlebar_fg_urgent   = theme.colors.black
theme.titlebar_fg_minimize = theme.colors.grey

-- Notifications
theme.notification_margin  = dpi(16)
theme.notification_shape   = theme.shapes.rounded_rect
theme.notification_max_width = dpi(320)
theme.notification_border_width = dpi(1.25)
theme.notification_icon_size = dpi(128)
theme.notification_bg      = theme.colors.text_body
theme.notification_fg      = theme.colors.black
theme.notification_border_color = theme.colors.black

-- IMAGES --

-- Wibar
local wibar_bg = function(context, cr, width, height, orientation)
    drawing.beveled_bar(
        context,
        cr,
        width,
        height,
        orientation,
        theme.bev_width,
        theme.bg_normal,
        theme.bev_highlight,
        theme.bev_shadow
    )
end

theme.wibar_bgimage = wibar_bg

-- Taglist

-- Tasklist
local task_bg_normal = drawing.beveled_bar( nil, nil, 1080, theme.wibar_height, "horizontal", theme.bev_width, theme.tasklist_bg_normal, theme.bev_highlight, theme.bev_shadow)
local task_capstart = drawing.barcap_start( nil, nil, theme.wibar_height, theme.bev_width, theme.bev_highlight, theme.bev_shadow, theme.bev_highlight)
local task_capend = drawing.barcap_end( nil, nil, theme.wibar_height, theme.bev_width, theme.bev_highlight, theme.bev_shadow, theme.bev_shadow)

local task_bg_focus = drawing.beveled_bar( nil, nil, 1080, theme.wibar_height,  "horizontal", theme.bev_width, theme.tasklist_bg_focus, theme.bev_highlight_focus, theme.bev_shadow_focus)
local task_capstart_focus = drawing.barcap_start( nil, nil, theme.wibar_height, theme.bev_width, theme.bev_highlight_focus, theme.bev_shadow_focus, theme.bev_highlight_focus)
local task_capend_focus = drawing.barcap_end( nil, nil, theme.wibar_height, theme.bev_width, theme.bev_highlight_focus, theme.bev_shadow_focus, theme.bev_shadow_focus)

local task_bg_urgent = drawing.beveled_bar( nil, nil, 1080, theme.wibar_height,  "horizontal", theme.bev_width, theme.bg_urgent, theme.bev_highlight_urgent, theme.bev_shadow_urgent)
local task_capstart_urgent = drawing.barcap_start( nil, nil, theme.wibar_height, theme.bev_width, theme.bev_highlight_urgent, theme.bev_shadow_urgent, theme.bev_highlight_urgent)
local task_capend_urgent = drawing.barcap_end( nil, nil, theme.wibar_height, theme.bev_width, theme.bev_highlight_urgent, theme.bev_shadow_urgent, theme.bev_shadow_urgent)

theme.tasklist_bg_image_normal = task_bg_normal
theme.tasklist_bg_image_minimize = task_bg_normal
theme.tasklist_capstart = task_capstart
theme.tasklist_capend = task_capend

theme.tasklist_bg_image_focus = task_bg_focus
theme.tasklist_capstart_focus = task_capstart_focus
theme.tasklist_capend_focus = task_capend_focus

theme.tasklist_bg_image_urgent = task_bg_urgent
theme.tasklist_capstart_urgent = task_capstart_urgent
theme.tasklist_capend_focus = task_capend_urgent

-- Titlebar background images
local titlebar_bg_focus = function(context, cr, width, height) drawing.beveled_rect( context, cr, width, height, dpi(1.25), "#eda771" )  end

theme.titlebar_bg_image_focus = titlebar_bg_focus

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

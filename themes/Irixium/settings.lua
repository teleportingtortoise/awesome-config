local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
-- Simple drawing library
local drawing = require("lib.drawing")

local common = {}

common.scales = {
    useless_gap     = dpi(0),

    border_width    = dpi(1.3),
    wibar_size      = dpi(32),

    menu_height     = dpi(24),
    menu_width      = dpi(180),
}

common.colors = {
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
    focused_shadow  = "#724d4d",

    urgent          = "#8a5e83",
    urgent_light    = "#ed71a1",
    urgent_shadow   = "#6B4772",
}

common.shapes = {
    rounded_rect    = function(cr, width, height)
        gears.shape.rounded_rect(
            cr, width, height,
            common.scales.border_width * 2
        ) end,
}

common.images = {
    wibar_horizontal = function(context, cr, width, height)
        drawing.beveled_bar(
            context, cr, width, height,
            false,
            common.scales.border_width,
            common.colors.bevel_body,
            common.colors.bevel_light,
            common.colors.bevel_shadow
        ) end,
    wibar_vertical = function(context, cr, width, height)
        drawing.beveled_bar(
            context, cr, width, height,
            true,
            common.scales.border_width,
            common.colors.bevel_body,
            common.colors.bevel_light,
            common.colors.bevel_shadow
        ) end,

    tasklist_horizontal_normal = drawing.beveled_bar(
        nil, nil, 1080,
        common.scales.wibar_size,
        false,
        common.scales.border_width,
        common.colors.bevel_body,
        common.colors.bevel_light,
        common.colors.bevel_shadow),
    tasklist_cap_west_normal = drawing.barcap(
        nil, nil,
        common.scales.wibar_size,
        "start",
        common.scales.border_width,
        common.colors.bevel_light,
        common.colors.bevel_shadow,
        common.colors.bevel_light),
    tasklist_cap_east_normal = drawing.barcap(
        nil, nil,
        common.scales.wibar_size,
        "end",
        common.scales.border_width,
        common.colors.bevel_light,
        common.colors.bevel_shadow,
        common.colors.bevel_shadow),

    tasklist_horizontal_focus = drawing.beveled_bar(
        nil, nil, 1080,
        common.scales.wibar_size,
        false,
        common.scales.border_width,
        common.colors.focused,
        common.colors.focused_light,
        common.colors.focused_shadow),
    tasklist_cap_west_focus = drawing.barcap(
        nil, nil,
        common.scales.wibar_size,
        "start",
        common.scales.border_width,
        common.colors.focused_light,
        common.colors.focused_shadow,
        common.colors.focused_light),
    tasklist_cap_east_focus = drawing.barcap(
        nil, nil,
        common.scales.wibar_size,
        "end",
        common.scales.border_width,
        common.colors.focused_light,
        common.colors.focused_shadow,
        common.colors.focused_shadow),
}

return common

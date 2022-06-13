-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- For drawing custom cairo shapes
local cairo = require("lgi").cairo
-- Gears shapes
local color = require("gears.color")


-- Beveled bar
local function beveled_bar(context, cr, width, height, orientation, thickness, bg_color, north_color, south_color)
    local context = context or cairo.ImageSurface.create(cairo.Format.ARGB32, width, height)
    local cr = cr or cairo.Context(context)
    local width = width or 32
    local height = height or 32
    local orientation = orientation or "horizontal"
    local thickness = thickness or 1
    local bg_color = bg_color or "#808080"
    local north_color = north_color or "#ffffff"
    local south_color = south_color or "#000000"

    -- Background
    cr:set_source(color(bg_color))
    cr:rectangle(0, 0, width, height)
    cr:fill()

    -- North
    cr:set_source(color(north_color))
    cr:rectangle(0, 0, width, thickness)
    cr:fill()

    -- South
    cr:set_source(color(south_color))
    cr:rectangle(0, height - thickness, width, thickness)
    cr:fill()

    if orientation == "vertical" then
        cr:translate( width/2, height/2 )
        cr:rotate( -90 )
        cr:translate( -width/2, -height/2 )
    end

    return context
end

-- Bar cap start
local function barcap_start(context, cr, height, thickness, top, bottom, cap)
    local context = context or cairo.ImageSurface.create(cairo.Format.ARGB32, thickness, height)
    local cr = cr or cairo.Context(context)
    local height = height or 32
    local thickness = thickness or 1
    local top = top or "#ffffff"
    local bottom = bottom or "#000000"
    local cap = cap or "#ffffff"

    -- Top
    cr:set_source(color(top))
    cr:rectangle(0, 0, thickness, thickness)
    cr:fill()

    -- Bottom
    cr:set_source(color(bottom))
    cr:rectangle(0, height - thickness, thickness, thickness)
    cr:fill()

    -- Cap
    cr:set_source(color(cap))
    cr:move_to(0, 0)
    cr:line_to(thickness, thickness)
    cr:line_to(thickness, height - thickness)
    cr:line_to(0, height)
    cr:close_path()
    cr:fill()

    return context
end

-- Bar cap end
local function barcap_end(context, cr, height, thickness, top, bottom, cap)
    local context = context or cairo.ImageSurface.create(cairo.Format.ARGB32, thickness, height)
    local cr = cr or cairo.Context(context)
    local height = height or 32
    local thickness = thickness or 1
    local top = top or "#ffffff"
    local bottom = bottom or "#000000"
    local cap = cap or "#000000"

    -- Top
    cr:set_source(color(top))
    cr:rectangle(0, 0, thickness, thickness)
    cr:fill()

    -- Bottom
    cr:set_source(color(bottom))
    cr:rectangle(0, height - thickness, thickness, thickness)
    cr:fill()

    -- Cap
    cr:set_source(color(cap))
    cr:move_to(thickness, 0)
    cr:line_to(0, thickness)
    cr:line_to(0, height - thickness)
    cr:line_to(thickness, height)
    cr:close_path()
    cr:fill()

    return context
end

-- Beveled rounded rectangle


-- Beveled divider
local function beveled_divider(height, thickness, west, east)
    local height = height or 32
    local thickness = thickness or 1
    local west = west or "#000000"
    local east = east or "#ffffff"

    local surface = cairo.ImageSurface.create(cairo.Format.ARGB32, thickness * 2, height)
    local cr = cairo.Context(surface)

    -- West
    cr:set_source(color(west))
    cr:move_to(0, thickness)
    cr:line_to(thickness, 0)
    cr:line_to(thickness, height)
    cr:line_to(0, height - thickness)
    cr:close_path()
    cr:fill()

    -- East
    cr:set_source(color(east))
    cr:move_to(thickness, 0)
    cr:line_to(thickness * 2, thickness)
    cr:line_to(thickness * 2, height - thickness)
    cr:line_to(thickness, height)
    cr:close_path()
    cr:fill()

    return surface
end

-- Return functions
return {
    beveled_rect = beveled_rect,
    beveled_bar = beveled_bar,
    barcap_start = barcap_start,
    barcap_end = barcap_end,
    beveled_divider = beveled_divider,
}
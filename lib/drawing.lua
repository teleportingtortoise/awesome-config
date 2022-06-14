-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- For drawing custom cairo shapes
local cairo = require("lgi").cairo
-- Gears
local gears = require("gears")


-- Beveled bar
local function beveled_bar(context, cr, width, height, vertical, thickness, bg_color, north_color, south_color)
    local context = context or cairo.ImageSurface.create(cairo.Format.ARGB32, width, height)
    local cr = cr or cairo.Context(context)
    local width = width or 32
    local height = height or 32
    local vertical = vertical or false
    local thickness = thickness or 1
    local bg_color = bg_color or "#808080"
    local north_color = north_color or "#ffffff"
    local south_color = south_color or "#000000"

    -- Background
    cr:set_source(gears.color(bg_color))
    cr:rectangle(0, 0, width, height)
    cr:fill()

    -- North
    cr:set_source(gears.color(north_color))
    cr:rectangle(0, 0, width, thickness)
    cr:fill()

    -- South
    cr:set_source(gears.color(south_color))
    cr:rectangle(0, height - thickness, width, thickness)
    cr:fill()

    if vertical == true then
        cr:translate( width/2, height/2 )
        cr:rotate( -90 )
        cr:translate( -width/2, -height/2 )
    end

    return context
end

-- Bar cap
local function barcap(context, cr, height, facing, thickness, top, bottom, cap)
    local context = context or cairo.ImageSurface.create(cairo.Format.ARGB32, thickness, height)
    local cr = cr or cairo.Context(context)
    local height = height or 32
    local facing = facing or "west"
    local thickness = thickness or 1
    local top = top or "#ffffff"
    local bottom = bottom or "#000000"
    local cap = cap or "#ffffff"

    -- Top
    cr:set_source(gears.color(top))
    cr:rectangle(0, 0, thickness, thickness)
    cr:fill()

    -- Bottom
    cr:set_source(gears.color(bottom))
    cr:rectangle(0, height - thickness, thickness, thickness)
    cr:fill()

    -- Cap
    cr:set_source(gears.color(cap))
    cr:move_to(0, 0)
    cr:line_to(thickness, thickness)
    cr:line_to(thickness, height - thickness)
    cr:line_to(0, height)
    cr:close_path()
    cr:fill()

    if facing == "west" then
        return context
    elseif facing == "east" then
        local matrix = gears.matrix.create(
            -1,  0,  1,
             0,  1,  0,
             0,  0,  1)
        matrix = matrix:to_cairo_matrix()
        cr:transform(matrix)
    end

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
    cr:set_source(gears.color(west))
    cr:move_to(0, thickness)
    cr:line_to(thickness, 0)
    cr:line_to(thickness, height)
    cr:line_to(0, height - thickness)
    cr:close_path()
    cr:fill()

    -- East
    cr:set_source(gears.color(east))
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
    beveled_bar = beveled_bar,
    barcap = barcap,
    beveled_divider = beveled_divider,
}
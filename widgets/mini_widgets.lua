-- For basic widgets
-- Make something seperate for anything complicated

local wibox     = require("wibox")
local awful     = require("awful")

-- Wibox full seperator
full_spacer = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "vertical",
    forced_width = 16,
    color = "#000000"
}
-- Wibox half seperator
half_spacer = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "vertical",
    forced_width = 8,
    color = "#000000"
}
-- Panther launcher
panther_launcher = awful.widget.launcher({ 
    image = "/usr/share/icons/breeze/actions/24/application-menu.svg",
    command = "panther_launcher"
})

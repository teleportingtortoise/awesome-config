local awful = require("awful")
local wibox = require("wibox")
local gt = require("gears.timer")
local beautiful = require("beautiful")
local overview = require("overview")

beautiful.init("/home/trysta/.config/awesome/theme.lua")

local clock_extend_timeout = 5
local clock_widget = wibox.widget.textclock(" 🏠 %a %l:%M %p ")
local clock_widget_calendar = awful.widget.calendar_popup.month({position = "tr"})

clock_widget.extended = false

clock_widget.restore = function()
	clock_widget.extended = false
	clock_widget.format = " 🏠 %a %l:%M %p "
	clock_widget.timezone = "-07:00"
	clock_widget_calendar:toggle()
end

clock_widget.extend = function()
	clock_widget.extended = true
	clock_widget.format = " 🇦🇺 %a %l:%M %p "
	clock_widget.timezone = "+10:00"
	gt.start_new(clock_extend_timeout, clock_widget.restore)
end

clock_widget.toggle = function()
	if clock_widget.extended then
		clock_widget.restore()
	else
		clock_widget.extend()
	end
end

clock_widget:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		clock_widget.toggle()
		overview:toggle()
		--clock_widget_calendar.screen = awful.screen.focused()
		--clock_widget_calendar:toggle()
	-- elseif button == 3 then
		-- Activate calendar widget
	end
end)

return clock_widget

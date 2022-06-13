local awful = require( "awful" )
local wibox = require( "wibox" )
local beautiful = require( "beautiful" )
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
beautiful.init("/home/trysta/.config/awesome/theme.lua")


local mytextclock = wibox.widget.textclock(" %a %d, %l:%M%p ")

local overview = awful.popup {
	widget = {
		{	
			{
				font = beautiful.calendar_font,
				spacing = beautiful.calendar_spacing,
				refresh = 60 * 12,
				widget = wibox.widget.calendar.month(os.date('*t')),
			},
			{

				{
					{
						markup = "<span foreground='cyan' weight='bold'>Noah</span>",
						widget = wibox.widget.textbox(),
					},
					{
						font = "sf pro display 11",
						align = "right",
						format = "<span foreground='cyan' weight='bold'>%a, %d</span>",
						timezone = "+10:00",
						refresh = 60,
						widget = wibox.widget.textclock(),
					},
					{
						font = "sf pro display 11",
						align = "right",
						format = "<span foreground='cyan' weight='bold'>%l:%M%p</span>",
						timezone = "+10:00",
						refresh = 60,
						widget = wibox.widget.textclock(),
					},
					layout = wibox.layout.flex.horizontal,
				},
				{
					{
						text = "MST",
						widget = wibox.widget.textbox(),
					},
					{
						font = "sf pro display 11",
						align = "right",
						widget = wibox.widget.textclock("%a, %d", 60, "-06:00"),
					},
					{
						font = "sf pro display 11",
						align = "right",
						widget = wibox.widget.textclock("%l:%M%p", 60, "-06:00"),
					},
					layout = wibox.layout.flex.horizontal,
				},
				{
					{
						text = "CST",
						widget = wibox.widget.textbox(),
					},
					{
						font = "sf pro display 11",
						align = "right",
						widget = wibox.widget.textclock("%a, %d", 60, "-05:00"),
					},
					{
						font = "sf pro display 11",
						align = "right",
						widget = wibox.widget.textclock("%l:%M%p", 60, "-05:00"),
					},
					layout = wibox.layout.flex.horizontal,
				},
				{
					{
						text = "EST",
						widget = wibox.widget.textbox(),
					},
					{
						font = "sf pro display 11",
						align = "right",
						widget = wibox.widget.textclock("%a, %d", 60, "-04:00"),
					},
					{
						font = "sf pro display 11",
						align = "right",
						widget = wibox.widget.textclock("%l:%M%p", 60, "-04:00"),
					},
					layout = wibox.layout.flex.horizontal,
				},
				{
					forced_height = dpi(24),
					opacity = 0,
					widget = wibox.widget.separator(),
				},
				{
					{
						text = "Master Volume",
						widget = wibox.widget.textbox(),
					},
					widget = wibox.container.margin,
				},
				{
					{
						bar_height = dpi(2),
						value = 34,
						widget = wibox.widget.slider(),
					},
					{
						forced_width = dpi(36),
						markup = "<span>34%</span>",
						align = "right",
						widget = wibox.widget.textbox(),
					},
					forced_height = dpi(24),
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.place,
				layout = wibox.layout.fixed.vertical,
			},
			layout = wibox.layout.fixed.vertical,
		},
		--forced_height = screen.workarea.height,
		forced_width = dpi(240),
		margins = dpi(10),
		widget = wibox.container.margin,
	},
	type = dropdown_menu,
	bg = beautiful.bg_focus,
	preferred_positions = v,
	screen = awful.screen.focused(),
	visible = false,
	ontop = true,
}

function overview:toggle()
	if( self.visible == false ) then
		self.screen = awful.screen.focused()
		awful.placement.top_right(self, { honor_workarea = true })
		self.visible = true
	elseif ( self.screen ~= awful.screen.focused() ) then
		self.screen = awful.screen.focused()
		awful.placement.top_right(self, { honor_workarea = true })
	else
		self.visible = false
	end
end

return overview

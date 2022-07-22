-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local common = require("themes.Irixium.settings")
-- Notification library
--local naughty = require("naughty")
--local menubar = require("menubar")

-- For allowing use of dpi based sizes
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 320 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    local layouts = awful.layout.layouts
    local tags = {
        settings = {
            {
                names = { "", "", ""},
                icons = { "/usr/share/icons/breeze/actions/24/qa.svg",
                          "/usr/share/icons/breeze/places/24/folder-build.svg",
                          "/usr/share/icons/breeze/devices/24/input-gamepad.svg"},
                layout = { layouts[10], layouts[4], layouts[4]}
            },
            {
                names = { "", "", "" },
                icons = { "/usr/share/icons/breeze/places/24/folder-videos.svg",
                          "/usr/share/icons/breeze/places/24/folder-build.svg",
                          "/usr/share/icons/breeze/devices/24/input-gamepad.svg"},
                layout = { layouts[2], layouts[2], layouts[11] }
            },
            {
                names = { "", "", "", ""},
                icons = { "/usr/share/icons/breeze/actions/24/story-editor.svg",
                          "/usr/share/icons/breeze/actions/24/globe.svg",
                          "/usr/share/icons/breeze/actions/24/photo.svg",
                          "/usr/share/icons/breeze/actions/24/scriptnew.svg"},
                layout = { layouts[4], layouts[4], layouts[4], layouts[4]}
            },
            {
                names = { "", "", "" },
                icons = { "/usr/share/icons/breeze/actions/24/oilpaint.svg",
                          "/usr/share/icons/breeze/actions/24/oilpaint.svg",
                          "/usr/share/icons/breeze/actions/24/oilpaint.svg"},
                layout = { layouts[2], layouts[2], layouts[2] }
           },
        }
    }

    for tag in pairs(tags.settings[s.index].names) do
        local first
        if tag == 1 then
            first = true
        else
            first = false
        end
        awful.tag.add(tags.settings[s.index].names[tag], {
            icon = tags.settings[s.index].icons[tag],
            layout = tags.settings[s.index].layout[tag],
            screen = s,
            selected = first,
        })
    end


    -- Set wibar orientation based on display orientation
    if s.geometry.width > s.geometry.height then
        s.wibar_position = "left"
        s.widget_rotation = "east"
        s.layout_fixed_orientation = wibox.layout.fixed.vertical
        s.layout_flex_orientation = wibox.layout.flex.vertical
        s.layout_align_orientation = wibox.layout.align.vertical
        s.bar_orientation = common.images.wibar_vertical
        s.task_cap_start = common.images.tasklist_cap_east_normal
        s.task_cap_end = common.images.tasklist_cap_west_normal
        s.task_cap_start_focus = common.images.tasklist_cap_east_focus
        s.task_cap_end_focus = common.images.tasklist_cap_west_focus
    end

    if s.geometry.width < s.geometry.height then
        s.wibar_position = "top"
        s.widget_rotation = "north"
        s.layout_fixed_orientation = wibox.layout.fixed.horizontal
        s.layout_flex_orientation = wibox.layout.flex.horizontal
        s.layout_align_orientation = wibox.layout.align.horizontal
        s.bar_orientation = common.images.wibar_horizontal
        s.task_cap_start = common.images.tasklist_cap_west_normal
        s.task_cap_end = common.images.tasklist_cap_east_normal
        s.task_cap_start_focus = common.images.tasklist_cap_west_focus
        s.task_cap_end_focus = common.images.tasklist_cap_east_focus
    end


    -- Create a textclock widget and connect it with latte panel
    s.mytextclock = wibox.widget.textclock(" %a %d, %l:%M%p ")
    s.mytextclock:connect_signal("button::press", function(_, _, _, button)
        if button == 1 then
            local sidebar = function (c)
                return awful.rules.match(c, {name = "#view#25"})
            end
            
            local temp
            
            for c in awful.client.iterate(sidebar) do
                    temp = c
            end

            if temp and temp.hidden == false then
                temp.hidden = true
            elseif temp then
                temp:move_to_screen(awful.screen.focused())
                temp.hidden = false
                temp.placement = awful.placement.right,
                temp:raise()
            else
                awful.spawn("latte-dock")
            end
        end    
    end)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt {
        prompt = " > "
    }
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout  = {
            layout  = s.layout_fixed_orientation,
	    },
        widget_template = {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                id     = 'background_role',
                widget = wibox.container.background,
            },
            margins = dpi(5),
            widget = wibox.container.margin,
        },
        buttons = taglist_buttons,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
	    layout  = {
            layout  = s.layout_flex_orientation,
        },
        widget_template = {
            {
                {
                    id = 'cap_start',
                    widget = wibox.widget.imagebox,
                    forced_width = beautiful.bev_width,
                    forced_height = beautiful.wibar_height,
                },
                {
                    {

                        {
                            {
                                id     = 'icon_role',
                                widget = wibox.widget.imagebox,
                                opacity = 1,
                            },
                            id         = 'icon_margin_role',
                            margins = dpi(4),
                            widget  = wibox.container.margin,
                        },
                        {
                            {
                                id     = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            id         = 'text_margin_role',
                            margins = dpi(4),
                            widget  = wibox.container.margin,
                        },
                        {
                            {
                                id     = 'close_button',
                                widget = wibox.widget.imagebox,
                                image = '/home/trysta/.config/awesome/images/close.svg',
                            },
                            id         = 'close_button_margin',
                            margins = dpi(4),
                            widget  = wibox.container.margin,
                            visible = false
                        },
                        layout = wibox.layout.align.horizontal,
                    },
                    id     = 'background_role',
                    widget = wibox.container.background,
                },
                {
                    id = 'cap_end',
                    widget = wibox.widget.imagebox,
                    forced_width = beautiful.bev_width,
                    forced_height = beautiful.wibar_height,
                },
                layout = wibox.layout.align.horizontal,
            },
            direction = s.widget_rotation,
            widget = wibox.container.rotate,

            -- Change graphics as needed
            create_callback = function(self, c)
                if c == client.focus then
                    self:get_children_by_id('cap_start')[1].image = s.task_cap_start_focus
                    self:get_children_by_id('cap_end')[1].image = s.task_cap_end_focus
                    self:get_children_by_id('close_button_margin')[1].visible = true
                    return
                end
                if c == client.urgent then
                    self:get_children_by_id('cap_start')[1].image = beautiful.tasklist_capstart_urgent
                    self:get_children_by_id('cap_end')[1].image = beautiful.tasklist_capend_urgent
                end   
                self:get_children_by_id('cap_start')[1].image = s.task_cap_start
                self:get_children_by_id('cap_end')[1].image = s.task_cap_end
                self:get_children_by_id('close_button_margin')[1].visible = false
            end,
            update_callback = function(self, c)
                if c == client.focus then
                    self:get_children_by_id('cap_start')[1].image = s.task_cap_start_focus
                    self:get_children_by_id('cap_end')[1].image = s.task_cap_end_focus
                    self:get_children_by_id('close_button_margin')[1].visible = true
                    return
                end
                if c == client.urgent then
                    self:get_children_by_id('cap_start')[1].image = beautiful.tasklist_capstart_urgent
                    self:get_children_by_id('cap_end')[1].image = beautiful.tasklist_capend_urgent
                end
                self:get_children_by_id('cap_start')[1].image = s.task_cap_start
                self:get_children_by_id('cap_end')[1].image = s.task_cap_end
                self:get_children_by_id('close_button_margin')[1].visible = false
            end,
        },
        buttons = tasklist_buttons,
    }

    -- Wibar
    s.mywibox = awful.wibar({
        position = s.wibar_position,
        screen = s,
        bgimage = s.bar_orientation,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        {
            layout = s.layout_align_orientation,
            { -- Left widgets
                layout = s.layout_fixed_orientation,
                {
                    {
                        widget = wibox.widget.imagebox,
                        forced_width = beautiful.bev_width,
                        forced_height = beautiful.wibar_height,
                        image = common.images.tasklist_cap_west_normal,
                    },
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
                panther_launcher,
                s.mytaglist,
                {
                    {
                        widget = wibox.widget.imagebox,
                        forced_width = beautiful.bev_width,
                        forced_height = beautiful.wibar_height,
                        image = common.images.tasklist_cap_east_normal,
                    },
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
                { -- Rotate widget
                    s.mypromptbox,
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
                {
                    {
                        id = "taskless",
                        widget = wibox.widget.imagebox,
                        forced_width = beautiful.bev_width,
                        forced_height = beautiful.wibar_height,
                        image = common.images.tasklist_cap_west_normal,
                        visible = true,
                    },
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = s.layout_fixed_orientation,
                --mykeyboardlayout,
                {
                    {
                        id = "taskless",
                        widget = wibox.widget.imagebox,
                        forced_width = beautiful.bev_width,
                        forced_height = beautiful.wibar_height,
                        image = common.images.tasklist_cap_east_normal,
                        visible = true,
                    },
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
                {
                    {
                        widget = wibox.widget.imagebox,
                        forced_width = beautiful.bev_width,
                        forced_height = beautiful.wibar_height,
                        image = common.images.tasklist_cap_west_normal,
                    },
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
                { -- Rotate clock
                    s.mytextclock,
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
                s.mylayoutbox,
                --mylauncher
                {
                    {
                        widget = wibox.widget.imagebox,
                        forced_width = beautiful.bev_width,
                        forced_height = beautiful.wibar_height,
                        image = common.images.tasklist_cap_east_normal,
                    },
                    direction = s.widget_rotation,
                    widget = wibox.container.rotate,
                },
            },
        },
        widget = wibox.container.margin,
        update_callback = function(self)
            self:get_children_by_id('taskless')[1].visible = false
        end
    }
end)
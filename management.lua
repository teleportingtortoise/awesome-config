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


-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     maximized_vertical = false,
                     maximized_horizontal = false,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"
        },
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
	      "XPaint / Color and Pattern Selector", -- xpaint brush and pattern editor
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }}, properties = { floating = true, } },

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
     }, properties = { titlebars_enabled = true }
    },
 
    -- Remove titlebars from fullscreen clients
    { rule_any = {type = { "fullscreen" }
      }, properties = { titlebars_enabled = false }
    },

    -- Force panther_launcher to be maximized
    { rule = { class = "Panther_launcher" },
      properties = {
        maximized = true,
        border_none = true,
        titlebars_enabled = false,
      }
    },

    -- Plasma and Lattedock fixes
    { rule_and = {
        type = {
            "notification",
        },
        class = {
            "plasmashell",
        },
    }, properties = {
        floating = true,
        border_none = true,
        placement = awful.placement.centered,
        above = true,
        focusable = false,
    }},

    { rule_any = {
        role = {
            --"pop-up",
            "task_dialog",
        },
        name = {
            "win7",
            "Latte Dock",
        },
        class = {
            "plasmashell",
            "Plasma",
            --"latte-dock",
            --"lattedock",
            "krunner",
            "Kmix",
            "Klipper",
            "Plasmoidviewer",
        },
    }, properties = {
        floating = true,
        placement = awful.placement.top_right(client.focus),
        honor_workarea = true,
        titlebars_enabled = false,
        border_none = true,
    }},

    { rule_any = {
		name = { "TestWin" },
		class = { "TestWin" }
	}, properties = {
		floating = false,
		focusable = true,
		above = false,
		placement = awful.placement.bottom,
	}
    },

    -- Hacky side bar mover, no idea if the name will change
    { rule = { name = "#view#25" },
        properties = {
            maximized_vertical = true,
            size_hints_honor = false,
            focusable = true,
            hidden = true,
            titlebars_enabled = false,
    }},
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Prevent plasma desktop from loading

    if c.name == "Desktop — Plasma" then
        c:kill()
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      or not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Titlebars only on floating windows, and skip fullscreen windows because they're considered floating
client.connect_signal("property::floating", function(c)
    if c.floating == true
      and c.titlebars_enabled ~= false
      and c.fullscreen == false
      and c.requests_no_titlebar ~= true then      
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

function dynamic_title(c)
      if c.floating == true
      and c.titlebars_enabled ~= false
      and c.fullscreen == false
      and c.requests_no_titlebar ~= true
      or c.first_tag.layout.name == "floating" then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end

tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for _, c in pairs(clients) do
        if c.floating == true
          and c.titlebars_enabled ~= false
          and c.fullscreen == false
          and c.requests_no_titlebar ~= true
          or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end
    end
end)

-- Borders only if more than one tiled client (fullscreen clients are technically floating)
screen.connect_signal("arrange", function(s)
    for _, c in pairs(s.clients) do
        if #s.tiled_clients == 1
          or c.first_tag.layout.name == "max"
          or c.fullscreen == true
          or c.maximized == true
          or c.border_none == true
          or c.floating == true then
            c.border_width = 0
        elseif #s.tiled_clients > 1 then
            c.border_width = beautiful.border_width
        else
            c.border_width = 0
        end
    end
end)

client.connect_signal("manage", dynamic_title)
client.connect_signal("tagged", dynamic_title)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Hide mouse on pen display using unclutter
-- screen.connect_signal("mouse::enter", function(s)
--     if awful.screen.focused
-- end)
-- }}}

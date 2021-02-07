-- 
-- Athena & Zeus AwesomeWM Setup
--

-- Current Path
local currentPath = os.getenv("HOME") .. "/coding/dotfiles/awesome"

-- External Packages
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local common = require("awful.widget.common")
local calendar = require("calendar")

-- Personal Modules
local keybings = dofile(currentPath .. "/src/keybings.lua")
local widgets = dofile(currentPath .. "/src/widgets.lua")

-- Theme
local theme = dofile(currentPath .. "/themes/joaopaulo/theme.lua")

-- Autofocus
require("awful.autofocus")

local separators = lain.util.separators
local arrow   = separators.arrow_left
local markup = lain.util.markup

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        
        in_error = false
    end )
end

-- Theming
beautiful.init(os.getenv("HOME") .. "/coding/dotfiles/awesome/themes/joaopaulo/theme.lua")

-- Envoriment variables
terminal = "tilix"
editor = os.getenv("EDITOR") or "code"
editor_cmd = terminal .. " -e " .. editor

-- Default mod key - Windows
modkey = "Mod4"

-- Default layout selector
mylayoutbox = {}

-- Layouts available
awful.layout.layouts = {
	awful.layout.suit.tile,
}

-- Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

local function list_update(w, buttons, label, data, objects)
    common.list_update(w, buttons, label, data, objects)
    w:set_max_widget_size(300)
end

-- Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "manual", terminal .. " -x man awesome" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
 
mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

-- Keyboard Layout
mykeyboardlayout = awful.widget.keyboardlayout()

-- Wibar
-- Create a textclock widget
textClock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglistButtons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, 
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklistButtons = gears.table.join(
    awful.button(
        { }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end

                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end
    ),

    awful.button({ }, 3, client_menu_toggle_fn()),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Set the calendar
calendar({}):attach(textClock)

awful.screen.connect_for_each_screen(
    function (s)
        local systray = wibox.layout.margin(wibox.widget.systray(), 3, 3, 3, 3)

        -- Wallpaper
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            
            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end

            gears.wallpaper.maximized(wallpaper, s, false)
        end

        -- Each screen has its own tag table.                            
        awful.tag({ " WWW ", " DEV ", " SYS ", " CHT ", " SND " }, s, awful.layout.layouts[1])
        
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglistButtons)

        -- Create a tasklist widget
        s.activeTaskList = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklistButtons, nil, list_update, wibox.layout.flex.horizontal())

        -- Create the wibox
        s.topBar = awful.wibar({ position = "top", height = 30, screen = s })
        
        s.topBar:setup {
            layout = wibox.layout.align.horizontal,
            {
                -- Left Widgets
                layout = wibox.layout.align.horizontal,
                s.mytaglist
            },
            {
                -- Center Widgets
                s.activeTaskList,
                layout = wibox.layout.align.horizontal,
            },
            {
                -- Right Widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.container.margin(systray, 0, 5),
                wibox.container.margin(widgets.mem.widget, 0, 5),
                wibox.container.margin(widgets.cpu.widget, 0, 5),
                wibox.container.margin(widgets.temp.widget, 0, 5),
                wibox.container.margin(widgets.bat.widget, 0, 5),
                textClock,
                s.mylayoutbox
            },
        }
    end
)

-- Mouse bindings
root.buttons(
    gears.table.join(
        awful.button( { }, 3, function () mymainmenu:toggle() end ),
        awful.button( { }, 4, awful.tag.viewnext ),
        awful.button( { }, 5, awful.tag.viewprev )
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
    keybings.globalKeys = gears.table.join(
        keybings.globalKeys,

        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #"..i, group = "tag" }
        ),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #"..i, group = "tag" }
        ),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" }
        )
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1,
        function (c)
            client.focus = c
            c:raise()
        end
    ),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(keybings.globalKeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            keys = keybings.clientKeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = { class = { "Arandr" } },
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = { type = { "normal", "dialog" }},
        properties = { titlebars_enabled = false }
    },
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage",
    function (c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button(
                { }, 1,
                
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end
            ),

            awful.button(
                { }, 3,
                
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end
            )
        )

        awful.titlebar(c) : setup {
            {
                awful.titlebar.widget.iconwidget(c),
                layout  = wibox.layout.fixed.horizontal
            },
            {
                { align  = "center", widget = awful.titlebar.widget.titlewidget(c) },

                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { layout = wibox.layout.align.horizontal },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
    function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end
)

-- Better Spotify Notifications.
naughty.config.presets.small_notification = { callback = function(args) return true end, height = 100,width = 400, icon_size = 90 }

table.insert(naughty.dbus.config.mapping, { { appname = "Spotify" }, naughty.config.presets.small_notification } )
table.insert(naughty.dbus.config.mapping, { { appname = "Google Chrome" }, naughty.config.presets.small_notification } )

-- Startup commands
awful.spawn.with_shell("~/coding/dotfiles/awesome/autorun.sh")

local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Default mod key - Windows
modkey = "Mod4"

globalKeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description="show help", group="awesome" }),
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
    awful.key({ modkey }, "j", function () awful.client.focus.byidx(1) end, { description = "focus next by index", group = "client" }),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1) end, { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1) end, { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),

    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump tc urgent client", group = "client" }),
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey }, "l", function () awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h",  function () awful.tag.incnmaster( 1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l",  function () awful.tag.incnmaster(-1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),

    awful.key({ modkey, "Control" }, "h",  function () awful.tag.incncol( 1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l",  function () awful.tag.incncol(-1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),

    awful.key(
        { modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()

            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        { description = "restore minimized", group = "client" }
    ),

    awful.key({ modkey }, "d", function () awful.spawn("rofi -show drun -display-drun '> ' -modi drun") end, { description = "run rofi", group = "launcher" }),
    awful.key({ modkey }, "w", function () awful.spawn("rofi -show window -display-window '> ' -modi window") end, { description = "run rofi window", group = "launcher" }),

    awful.key({ modkey, "Shift" }, "p", function () awful.spawn("sh -c '~/coding/dotfiles/scripts/docked_mode.sh'") end, { description = "docked mode", group = "display" }),
    awful.key({ modkey, "Shift" }, "s", function () awful.spawn("sh -c '~/coding/dotfiles/scripts/standalone_mode.sh'") end, { description = "standalone mode", group = "display" }),

    awful.key({ modkey, "Control" }, "s", function () client.sticky = not client.sticky end),

    -- Personal
    awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("dm-tool lock") end,{ description = "locks the screen", group = "personal" }), 
    awful.key({ modkey }, "e", function () awful.util.spawn("thunar") end,{ description = "launches thunar file manager", group = "personal" }),

    -- Brigthness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end,{ description = "raises the brightness", group = "screen" }),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end,{ description = "raises the brightness", group = "screen" }),

    -- Media
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -D pulse sset Master 10%+") end,{ description = "raises the volume", group = "personal-media" }),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -D pulse sset Master 10%-") end,{ description = "decreases the volume", group = "personal-media" }),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse sset Master toggle") end,{ description = "mute audio", group = "personal-media" }),
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end,{ description = "play/pause song", group = "personal-media" }),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("playerctl next") end,{ description = "next song", group = "personal-media" }),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end,{ description = "previous song", group = "personal-media" })
)

clientKeys = gears.table.join(
    awful.key(
        { modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),
    
    awful.key(
        { modkey }, "q",
        function (c) c:kill() end,
        { description = "close", group = "client" }
    ),

    awful.key(
        { modkey, "Control" }, "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),

    awful.key(
        { modkey, "Control" }, "Return",
        function (c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }
    ),

    awful.key(
        { modkey }, "o",
        function (c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }
    ),

    awful.key(
        { modkey }, "t",
        function (c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }
    ),

    awful.key(
        { modkey }, "n",
        function (c) c.minimized = true end,
        { description = "minimize", group = "client"} ),

    awful.key(
        { modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        { description = "(un)maximize", group = "client" }
    ),

    awful.key(
        { modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        { description = "(un)maximize vertically", group = "client" }
    ),

    awful.key(
        { modkey, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        { description = "(un)maximize horizontally", group = "client" }
    )
)

return {
    globalKeys = globalKeys,
    clientKeys = clientKeys
}

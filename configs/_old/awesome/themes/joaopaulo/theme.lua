local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")

local dpi = xresources.apply_dpi
local themes_path = os.getenv("HOME") .. "/coding/dotfiles/awesome/themes/joaopaulo"

-- Most used colors
local fg_normal = "#FFFFFF"
local bg_black = "#000000"
local bg_normal = "#1d1f21"
local bg_focus = "#0c0d0c88"
local bg_urgent = "#34353488"
local border_normal = "#3F3F3F"
local border_focus = "#6F6F6F"
local border_marked = "#CC9393"
local taglist_square_size = dpi(4)

return {
    -- Font Properties
    font                  = "Ahamono 8",
    icon_theme            = "Papirus-Dark",

    -- Theme colors
    fg_normal             = fg_normal,
    fg_focus              = fg_normal,
    fg_urgent             = fg_normal,
    bg_normal             = bg_normal,
    bg_focus              = bg_focus,
    bg_urgent             = bg_urgent,
    bg_systray            = bg_normal,
    taglist_fg_focus      = fg_normal,
    tasklist_bg_focus     = bg_focus,
    tasklist_fg_focus     = fg_normal,
    border_width          = 1,
    border_normal         = border_normal,
    border_focus          = border_focus,
    border_marked         = border_marked,
    titlebar_bg_focus     = bg_focus,
    titlebar_bg_normal    = bg_normal,
    titlebar_fg_focus     = fg_focus,

    -- A black bg for the hotkeys_popup is better than
    -- to be related with the current theme.
    hotkeys_bg            = bg_black,

    -- Icon
    widget_ac             = themes_path .. "/icons/ac.png",
    widget_battery        = themes_path .. "/icons/battery.png",
    widget_battery_low    = themes_path .. "/icons/battery_low.png",
    widget_battery_empty  = themes_path .. "/icons/battery_empty.png",
    widget_mem            = themes_path .. "/icons/mem.png",
    widget_cpu            = themes_path .. "/icons/cpu.png",
    widget_temp           = themes_path .. "/icons/temp.png",
    widget_net            = themes_path .. "/icons/net.png",

    -- Layout icons
    -- You can use your own layout icons like this:
    layout_fairh          = themes_path .. "/layouts/fairhw.png",
    layout_fairv          = themes_path .. "/layouts/fairvw.png",
    layout_floating       = themes_path .. "/layouts/floatingw.png",
    layout_magnifier      = themes_path .. "/layouts/magnifierw.png",
    layout_max            = themes_path .. "/layouts/maxw.png",
    layout_fullscreen     = themes_path .. "/layouts/fullscreenw.png",
    layout_tilebottom     = themes_path .. "/layouts/tilebottomw.png",
    layout_tileleft       = themes_path .. "/layouts/tileleftw.png",
    layout_tile           = themes_path .. "/layouts/tilew.png",
    layout_tiletop        = themes_path .. "/layouts/tiletopw.png",
    layout_spiral         = themes_path .. "/layouts/spiralw.png",
    layout_dwindle        = themes_path .. "/layouts/dwindlew.png",
    layout_cornernw       = themes_path .. "/layouts/cornernww.png",
    layout_cornerne       = themes_path .. "/layouts/cornernew.png",
    layout_cornersw       = themes_path .. "/layouts/cornersww.png",
    layout_cornerse       = themes_path .. "/layouts/cornersew.png",

    -- Taglist Icons
    taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, fg_normal),
    taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, fg_normal),

    -- Gap between windows
    useless_gap           = dpi(0),
    border_width          = dpi(0),

    -- Tasklist
    tasklist_disable_icon = false,
    tasklist_disable_task_name = false,

    -- Little Hack to hide the titlebar text
    -- titlebar_fg = bg_normal

    -- Systray
    systray_icon_spacing  = dpi(4),
    taglist_square_size = taglist_square_size,

    -- Wallpaper
    wallpaper             = themes_path .. "/awesome-wallpaper.jpg"
}

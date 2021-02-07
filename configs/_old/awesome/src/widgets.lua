local currentPath = os.getenv("HOME") .. "/coding/dotfiles/awesome"

local lain  = require("lain")
local wibox = require("wibox")
local theme = dofile(currentPath .. "/themes/joaopaulo/theme.lua")

local markup = lain.util.markup

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "MEM: " .. mem_now.used .. "MB |"))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, "CPU: " .. cpu_now.usage .. "% |"))
    end
})

-- TEMP
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    tempfile = "/sys/class/thermal/thermal_zone9/temp",
    settings = function()
        widget:set_markup(markup.font(theme.font, "TEMP: " .. coretemp_now .. "°C |"))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, "BAT: AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, "BAT: " .. bat_now.perc .. "% |"))
        else
            widget:set_markup(markup.font(theme.font, "BAT: AC |"))
            baticon:set_image(theme.widget_ac)
        end
    end
})

return {
    baticon = baticon,
    bat = bat,
    tempicon = tempicon,
    temp = temp,
    cpuicon = cpuicon,
    cpu = cpu,
    memicon = memicon,
    mem = mem
}
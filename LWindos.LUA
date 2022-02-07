--[[
@title LWinDOS
@chdk_version 1.4.1
--]]

local LWinCore = require("MIN") --Or "RUNTIME"
local draw = require("libs.drawlib")

AppList = {}

EXIT = false

local Background = draw:Add("rectf",0,0,360,240,"blue","white",7)

local function Init()
    set_console_layout(0,0,45,14)
    AppList = LWinCore:LoadApp("A/CHDK/SCRIPTS", AppList)
    draw:Redraw()
end

Init()
repeat
    wait_click(0)
    draw:Redraw()
    if is_key("set") then
        if AppList and type(AppList[0]) == "table" then
            AppList[0]:Run()
        end
    end
    wait_click(0)
    if is_key("playback") then
        wait_click(0)
        if is_key("playback") then
            EXIT = true
        end
    end
    print(LWinCore:GC())
until EXIT == true

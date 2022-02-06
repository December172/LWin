--[[
@title LWinDOS
@chdk_version 1.4.1
--]]
--[[
function import(str)
    str = string.gsub(str,"%.","%/")
    local path = "A/CHDK/LUALIB/"..str..".lua"
    local file = io.open(path,"r")
    if path then
         rawblock,cblock = file:read("*a"),""
        for i in string.gmatch(rawblock,"(%d%s)(%d%d%s)(%d%d%d%s)") do
            print(i)
            cblock = cblock..string.char(string.gsub(i," ",""))
        end
--        print(cblock)
        file:close()
    end
    return loadstring(cblock)
end
--]]
local LWinCore = require("runtime") --import("runtime")
local draw = require("project.drawlib")

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
--            LWinCore:ShowWnd()
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

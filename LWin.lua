LWin = { Version = "1.0.1 Debug" }

--External Libraies.
local Stack = require("stack")

--Basic Runnable Support.
local InstanceTable = { __mode = "kv"}
local function _CreateInstance()
    local InstanceCounter = 0
    return function(self,MainClass)
               InstanceCounter = InstanceCounter + 1
               InstanceTable[InstanceCounter] = {}
               for k,v in pairs(MainClass) do
                    rawset(InstanceTable[InstanceCounter],k,v)
               end
               if type(MainClass.Type) == "string" and MainClass.Type == "Win" then
                   InstanceTable[InstanceCounter].WndStack = Stack:new()
                   InstanceTable[InstanceCounter].MsgStack = Stack:new()
                end
               InstanceTable[InstanceCounter].HInstance = InstanceCounter
               return InstanceCounter
           end
end

LWin.CreateInstance = _CreateInstance()

function LWin:GetInstance(hInstance)
    return InstanceTable[hInstance]
end

--Message functions.
LWin.KEYS_TABLE = {"set","playback","video","menu"}
LWin.DefinedMsg = { ["set"] = "WM_KEY_SET", 
                    ["playback"] = "WM_KEY_PLAYBACK",
                    ["video"] = "WM_KEY_VIDEO",
                    ["menu"] = "WM_KEY_MENU",
                    ["paint"] = "WM_PAINT",
                    ["destory"] = "WM_DESTORY",
                    ["quit"] = "WM_QUIT"
                  }

function LWin:GetMsg(hInstance)
    if not InstanceTable[hInstance].MsgStack:IsEmpty() then
        if InstanceTable[hInstance].MsgStack:Top() == self.DefinedMsg["quit"] then
            return self.DefinedMsg["quit"]
        else
            return true
        end
    else
        for i = 1,#(self.KEYS_TABLE) do
            if is_key(self.KEYS_TABLE[i]) then
                InstanceTable[hInstance].MsgStack:Push(self.DefinedMsg[self.KEYS_TABLE[i]])
                return true
            end
        end
    end
    return false
end

function LWin:DispatchMsg(hInstance)
    InstanceTable[hInstance].WndStack:Top().WndClass._Callback(InstanceTable[hInstance])
    local status = ""
    repeat
        if not InstanceTable[hInstance].MsgStack:IsEmpty() then
            if InstanceTable[hInstance].MsgStack:Top() == self.DefinedMsg["quit"] then
                status = "quit"
            elseif InstanceTable[hInstance].MsgStack:Top() == self.DefinedMsg["destory"] then
                status = "destory"
            end
            InstanceTable[hInstance].MsgStack:Pop()
        end
    until InstanceTable[hInstance].MsgStack:IsEmpty()
    if status == "quit" then
        return self:PostMsg(hInstance,self.DefinedMsg["quit"])
    elseif status == "destory" then
        return self:PostMsg(hInstance,self.DefinedMsg["destory"])
    end
end

function LWin:RemoveTopMsg(hInstance)
    return InstanceTable[hInstance].MsgStack:Pop()
end

function LWin:PostMsg(hInstance,Msg)
    return InstanceTable[hInstance].MsgStack:Push(Msg)
end

--Windows functions.
local draw = require("drawlib")

local WindowFunc = {}
local WndCounter = 0
local WndTable = { __mode = "kv"}

function LWin:CreateHWnd()
    WndCounter = WndCounter + 1
    local Wnd = {
                    WndClass = { x = 50,
                                 y = 50,
                                 len = 150,
                                 wid = 100,
                                 cf = "blue",
                                 cb = "white",
                                 border = 7,
                                 sytle = ""
                               },
                    DC = { __mode = "kv"},
                    _Callback = function(self) end,
                    Proxy = newproxy(true)
                 }
    setmetatable(Wnd,
                { __gc = function()
                             print("gc")
                         end,
                  __index = WindowFunc
                }
                )
    WndTable[WndCounter] = Wnd
    WndTable.Wnd = WndCounter
    return WndCounter
end

function LWin:RegisterWnd(hWnd,Callback)
    WndTable[hWnd].WndClass._Callback = Callback
end

function LWin:GetWnd(hWnd)
    return WndTable[hWnd]
end

function LWin:GetHWnd(Wnd)
    return WndTable.Wnd
end

function LWin:CreateWnd(hWnd,hInstance)
    local Wnd = WndTable[hWnd]
    Wnd.DC[1] = draw:Add("rectf", assert(tonumber(Wnd.WndClass.x)), assert(tonumber(Wnd.WndClass.y)), assert(tonumber(Wnd.WndClass.len + Wnd.WndClass.x)), assert(tonumber(Wnd.WndClass.wid + Wnd.WndClass.y)), assert(tostring(Wnd.WndClass.cf)), assert(tostring(Wnd.WndClass.cb)), assert(tonumber(Wnd.WndClass.border)))
    if InstanceTable[hInstance].WndStack then
        InstanceTable[hInstance].WndStack:Push(Wnd)
        return self:PostMsg(hInstance,"WM_CREATE_"..hWnd)
    end
end

function LWin:ShowWnd(hWnd)
    Wnd = WndTable[hWnd]
    if Wnd then
        local Array = {}
        Array[1] = Wnd.WndClass.x
        Array[2] = Wnd.WndClass.y
        Array[3] = Wnd.WndClass.len
        Array[4] = Wnd.WndClass.wid
        Array[5] = Wnd.WndClass.cf
        Array[6] = Wnd.WndClass.cb
        Array[7] = Wnd.WndClass.border
        Wnd.DC[1] = draw:Replace(Wnd.DC[1],"rectf", assert(tonumber(Array[1])), assert(tonumber(Array[2])), assert(tonumber(Array[3] + Array[1])),assert(tonumber(Array[4] + Array[2])),assert(tostring(Array[5])),assert(tostring(Array[6])),assert(tonumber(Array[7])))
        if Wnd.DC[2] then
            for i = 2 ,#(Wnd.DC) do
                if type(Wnd.DC[i]) == "nil" then
                    break
                else
                    if Wnd.DC[i]._lable == "string" then
                        Wnd:TextOut(Wnd.DC[i].x,Wnd.DC[i].y,Wnd.DC[i].text,Wnd.DC[i].cf,Wnd.DC[i].cb,Wnd.DC[i].scalex,Wnd.DC[i].scaley,i)
                    end
                end
            end
        end
    end
    return draw:Redraw()
end

function LWin:UnloadWnd(hWnd,hInstance)
    local Wnd = WndTable[hWnd]
    for i = 1,#(Wnd.DC) do
        if type(Wnd.DC[i]) == "number" then
            draw:Remove(Wnd.DC[i])
        elseif type(Wnd.DC[i]) == "table" then
            draw:Remove(Wnd.DC[i].id)
        end
    end
    return InstanceTable[hInstance].WndStack:Pop()
end

--Draw functions.

function WindowFunc.TextOut(self, x, y, Text, FrontColor, BackColor, Scalex, Scaley, place)
    local _DC = self.DC
    place = place or #_DC + 1
    _DC[place] = 
            { id = 0,
              _lable = "text",
              x = x + self.WndClass.border,
              y = y + self.WndClass.border,
              text = Text,
              cf = FrontColor,
              cb = BackColor,
              scalex = Scalex,
              scaley = Scaley
            }
    _DC[place].id = draw:Add("string",_DC[place].x,_DC[place].y,_DC[place].text,_DC[place].cf,_DC[place].cb,_DC[place].scalex,_DC[place].scaley)
    return place
end

function WindowFunc.RemoveElement(self,hElement)
    draw:Remove(self.DC[hElement].id)
    if hElement == #(self.DC) then
        self.DC[hElement] = nil
    else
        for i = 1,#(self.DC) do
            self.DC[hElement] = self.DC[hElement + 1]
        end
    end
end

--Other functions.

function LWin:LoadApp(Path, AppList)
    assert(type(Path) == "string", "Not a vaild path!")
    local AppPath = file_browser(Path)
    if type(AppPath) == "nil" or string.match(AppPath, Path) ~= Path then
        return nil
    end
    AppPath = string.gsub(AppPath, Path.."/", "", 1)
    AppPath = string.gsub(AppPath, ".LUA", "", 1)
    local AppName = string.gsub(AppPath, ".lua", "", 1)
    AppList[#AppList] = require(AppName)
    AppList[#AppList].LWinLib = self
    return AppList
end

function LWin:GC()
    collectgarbage("collect")
    return collectgarbage("count")
end

return LWin

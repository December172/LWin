LWin = { Version = "1.0.1 Debug" }

--External Libraies.
local Stack = loadstring([[local Stack = {}
		Stack.__index = Stack
		function Stack:new()
    			local temp = {_Stack = {__mode = "kv"} }
    			setmetatable(temp,self)
    			return temp
		end
		function Stack:Pop()
    			if #(self._Stack) == 0 then
        				error("Stack is empty.",2)
    			end
    			return table.remove(self._Stack,#self._Stack)
		end
		function Stack:Push(t)
   			table.insert(self._Stack,t)
		end
		function Stack:Count()
    			return #self._Stack
		end

		function Stack:IsEmpty()
   			if self:Count() == 0 then
        				return true
    			else
        				return false
   		 	end
		end
		function Stack:Top()
			if #(self._Stack)==0 then
      				error("Stack is empty.",2)
   			end
   			return self._Stack[#self._Stack]
		end
		return Stack]])()
local draw = loadstring([[local draw = { Version = "1.1"}
		    local SCREEN_DRAWINGS={__mode = "kv"}
		    function draw:Add( d_type, p1, p2, p3, p4, p5, p6, p7 )
    		    	local n = #SCREEN_DRAWINGS + 1
		    	if d_type=="pixel" then
        				SCREEN_DRAWINGS[n]={"p",p1,p2,p3}--x,y,cl
        				return n
    			elseif d_type=="line" then
        				SCREEN_DRAWINGS[n]={"l",p1,p2,p3,p4,p5}--x1,y1,x2,y2,cl
        				return n
    			elseif d_type=="rect" then
        				SCREEN_DRAWINGS[n]={"r",p1,p2,p3,p4,p5,p6}--x1,y1,x2,y2,cl,th
        				return n
    			elseif d_type=="rectf" then
        				SCREEN_DRAWINGS[n]={"rf",p1,p2,p3,p4,p5,p6,p7}--x1,y1,x2,y2,clf,clb,th
        				return n
    			elseif d_type=="elps" then
        				SCREEN_DRAWINGS[n]={"e",p1,p2,p3,p4,p5}--x,y,a,b,cl
       				return n
    			elseif d_type=="elpsf" then
        				SCREEN_DRAWINGS[n]={"ef",p1,p2,p3,p4,p5}--x,y,a,b,clf
        				return n
    			elseif d_type=="string" then
        				SCREEN_DRAWINGS[n]={"s",p1,p2,p3,p4,p5,p6,p7} --x,y,string,foreg_cl,backgr_cl,fontsizeX,fontsizeY
        				return n
    			end
    		    return false
		end
        function draw:Replace( n, d_type, p1, p2, p3, p4, p5, p6, p7 )
            self:Remove(n)
            if d_type=="pixel" then
                SCREEN_DRAWINGS[n]={"p",p1,p2,p3}--x,y,cl
                return n
            elseif d_type=="line" then
                SCREEN_DRAWINGS[n]={"l",p1,p2,p3,p4,p5}--x1,y1,x2,y2,cl
                return n
            elseif d_type=="rect" then
                SCREEN_DRAWINGS[n]={"r",p1,p2,p3,p4,p5,p6}--x1,y1,x2,y2,cl,th
                return n
            elseif d_type=="rectf" then
                SCREEN_DRAWINGS[n]={"rf",p1,p2,p3,p4,p5,p6,p7}--x1,y1,x2,y2,clf,clb,th
                return n
            elseif d_type=="elps" then
                SCREEN_DRAWINGS[n]={"e",p1,p2,p3,p4,p5}--x,y,a,b,cl
                return n
            elseif d_type=="elpsf" then
                SCREEN_DRAWINGS[n]={"ef",p1,p2,p3,p4,p5}--x,y,a,b,cl
                return n
            elseif d_type=="string" then
                SCREEN_DRAWINGS[n]={"s",p1,p2,p3,p4,p5,p6,p7}--x,y,string,foreg_cl,backgr_cl,fontsizeX,fontsizeY
                return n
            end
            return false
        end
--[
    function draw:GetParam(n)
        local out={nil}
        if SCREEN_DRAWINGS[n][1] == "p" then out[1]="pixel"
        elseif SCREEN_DRAWINGS[n][1] == "l" then out[1]="line"
        elseif SCREEN_DRAWINGS[n][1] == "r" then out[1]="rect"
        elseif SCREEN_DRAWINGS[n][1] == "rf" then out[1]="rectf"
        elseif SCREEN_DRAWINGS[n][1] == "e" then out[1]="elps"
        elseif SCREEN_DRAWINGS[n][1] == "ef" then out[1]="elpsf"
        elseif SCREEN_DRAWINGS[n][1] == "s" then out[1]="string"
        end
        if (out[1]~=nil) then
            for i=2, table.getn(SCREEN_DRAWINGS[n]) do
                out[i]=SCREEN_DRAWINGS[n][i]
            end
        end
        return out
    end
--]
    function draw:Overdraw()
        for i=1,table.getn(SCREEN_DRAWINGS) do
            local d_type=SCREEN_DRAWINGS[i][1]
            if d_type=="p" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local c=SCREEN_DRAWINGS[i][4]
                draw_pixel(x,y,self:MakeColor(c))
            elseif d_type=="l" then
                local x1=SCREEN_DRAWINGS[i][2]
                local y1=SCREEN_DRAWINGS[i][3]
                local x2=SCREEN_DRAWINGS[i][4]
                local y2=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                draw_line(x1,y1,x2,y2,self:MakeColor(c))
            elseif d_type=="r" then
                local x1=SCREEN_DRAWINGS[i][2]
                local y1=SCREEN_DRAWINGS[i][3]
                local x2=SCREEN_DRAWINGS[i][4]
                local y2=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                local t=SCREEN_DRAWINGS[i][7]
                draw_rect(x1,y1,x2,y2,self:MakeColor(c),t)
            elseif d_type=="rf" then
                local x1=SCREEN_DRAWINGS[i][2]
                local y1=SCREEN_DRAWINGS[i][3]
                local x2=SCREEN_DRAWINGS[i][4]
                local y2=SCREEN_DRAWINGS[i][5]
                local cf=SCREEN_DRAWINGS[i][6]
                local cb=SCREEN_DRAWINGS[i][7]
                local t=SCREEN_DRAWINGS[i][8]
                draw_rect_filled(x1,y1,x2,y2,self:MakeColor(cf),self:MakeColor(cb),t)
            elseif d_type=="e" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local a=SCREEN_DRAWINGS[i][4]
                local b=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                draw_ellipse(x,y,a,b,self:MakeColor(c))
            elseif d_type=="ef" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local a=SCREEN_DRAWINGS[i][4]
                local b=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                draw_ellipse_filled(x,y,a,b,self:MakeColor(c))
            elseif d_type=="s" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local s=SCREEN_DRAWINGS[i][4]
                local cf=SCREEN_DRAWINGS[i][5]
                local cb=SCREEN_DRAWINGS[i][6]
                local fontx=SCREEN_DRAWINGS[i][7]
                local fonty=SCREEN_DRAWINGS[i][8]
                if fontx then
                    draw_string(x,y,s,self:MakeColor(cf),self:MakeColor(cb)) -- faster if no scaling
                else
                    draw_string(x,y,s,self:MakeColor(cf),self:MakeColor(cb),fontx,fonty)
                end
            end
        end
    end
    function draw:Redraw()
        draw_clear()  --note: it's not "draw.clear()" from this module but "draw_clear()" - a lua command!
        self:Overdraw()
    end
    function draw:MakeColor(c)
        --note - c variable changes type if it's a correct string!
        if (c=="trans")         then c=255+1 end
        if (c=="black")         then c=255+2 end
        if (c=="white")         then c=255+3 end
        if (c=="red")           then c=255+4 end
        if (c=="red_dark")      then c=255+5 end
        if (c=="red_light")     then c=255+6 end
        if (c=="green")         then c=255+7 end
        if (c=="green_dark")    then c=255+8 end
        if (c=="green_light")   then c=255+9 end
        if (c=="blue")          then c=255+10 end
        if (c=="blue_dark")     then c=255+11 end
        if (c=="blue_light")    then c=255+12 end
        if (c=="grey")          then c=255+13 end
        if (c=="grey_dark")     then c=255+14 end
        if (c=="grey_light")    then c=255+15 end
        if (c=="yellow")        then c=255+16 end
        if (c=="yellow_dark")   then c=255+17 end
        if (c=="yellow_light")  then c=255+18 end
        if (c=="grey_trans")    then c=255+19 end
        return c
    end
    function draw:Remove(n)
        if (n<=table.getn(SCREEN_DRAWINGS)) then
            for i=1,table.getn(SCREEN_DRAWINGS[n]) do
                SCREEN_DRAWINGS[n][i]=nil
            end
        end
    end
    function draw:Clear()
        for i=1, table.getn(SCREEN_DRAWINGS) do
            self:Remove(i)
        end
        draw_clear()
    end
    return draw
]])()

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

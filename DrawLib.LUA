--[[
Special Lua module that makes drawing much more usefull and easy-to-use.
This module requires function such as: draw_pixel(), draw_rect() and others to be present

LWin needs this module!
 <Not drawings.lua>

Author:  Outslider
Modder:  December172
License: GPL all versions

Changelog:
2022/2/3 Formatted codes,Some changes in code
--]]

local draw = { Version = "1.1"}

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

function draw:GetParam(n)
    local out={nil}
    if SCREEN_DRAWINGS[n][1] == "p" then out[1]="pixel"
    elseif SCREEN_DRAWINGS[n][1] == "l" then out[1]="line"
    elseif SCREEN_DRAWINGS[n][1] == "r" then out[1]="rect"
    elseif SCREEN_DRAWINGS[n][1] == "rf" then out[1]="rectf"
    elseif SCREEN_DRAWINGS[n][1] == "e" then out[1]="elps"
    elseif SCREEN_DRAWINGS[n][1] == "ef" then out[1]="elpsf"
    elseif SCREEN_DRAWINGS[n][1] == "s" then out[1]="string" end
    if (out[1]~=nil) then
        for i=2, table.getn(SCREEN_DRAWINGS[n]) do
            out[i]=SCREEN_DRAWINGS[n][i]
        end
    end
    return out
end

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

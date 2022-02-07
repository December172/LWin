--Complied Lua Generateor
--note: Some file needn't to compile,like LWindos.lua(Main LWin Shell) and already compiled codes.
local function LuaG(i,o)
       assert(i,"Must have a input file!")
       o = o or "A/a.out"
       f = assert(io.open(o,"wb"))
       f:write(string.dump(loadfile(i)))
       f:close()
end

local scriptsdir = "A/CHDK/SCRIPTS/"
local libsdir = "A/CHDK/LUALIB/"
--If you use the "dev" version 
--If you don't use "dev" version ,you neen't run this script.
LuaG(libsdir.."LWin.lua",libsdir.."RUNTIME.lua")
LuaG(libsdir.."MinLWin.lua",libsdir.."MIN.lua")
--TODO: you can easliy add lines to compile lua scripts here
--for example,LuaG(libsdir.."example.lua",scriptsdir.."TestApp.lua"
--note: Recommend to put the compiled Application to SCRIPTS/LWinApp folder
--[[
declare global var
--]]

command = Command.new()

--[[
Initial System
]] --
OpenFolder('LuaSystem')
OpenFolder('Utils')
OpenFolder('Configs\\Commands')
OpenFolder('Configs')
OpenFolder('Character')
OpenFolder('Systems')
OpenFolder('Commands')

function GameServer()
	DataBase.Connect(3, "MuOnline", "sa", "123")
end

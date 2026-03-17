cannons = {}
cannons.MODPATH = core.modpath(core.get_current_modname())
local worldpath = core.get_worldpath()
cannons.config = Settings(worldpath.."/cannons.conf")

local conf_table = cannons.config:to_table()

--look into readme.txt how to change settings
local defaults = {
	enable_explosion = "true",
	enable_fire = "true",
	convert_old_nodes = "false",
}

for k, v in pairs(defaults) do
	if conf_table[k] == nil then
		cannons.config:set(k, v)
	end
end

dofile(cannons.MODPATH .."/functions.lua")
dofile(cannons.MODPATH .."/items.lua")
dofile(cannons.MODPATH .."/cannonballs.lua")

if cannons.config:get_bool("convert_old_nodes") then
	dofile(cannons.MODPATH .."/convert.lua")
end

if core.get_modpath("tnt") then
	core.log("info","TNT mod is aviable. registering some TNT stuff")
	dofile(cannons.MODPATH .."/tnt.lua")
end

if core.get_modpath("locks") then
	core.log("warning","locks mod enabled. dont execute locks.lua because this is an unstable beta version!")
	--dofile(cannons.MODPATH .."/locks.lua")--if the locks mod is installed execute this file
end
if core.get_modpath("moreores") then
core.log("info","moreores mod enabled. execute moreores.lua")
	dofile(cannons.MODPATH .."/moreores.lua")--if the moreores mod is installed execute this file
end
core.log("info", "[MOD]"..core.get_current_modname().." -- loaded from "..core.get_modpath(core.get_current_modname()))


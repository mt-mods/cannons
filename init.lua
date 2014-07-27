


cannons = {}
cannons.MODPATH = minetest.get_modpath(minetest.get_current_modname())
local worldpath = minetest.get_worldpath()
cannons.config = Settings(worldpath.."/cannons.conf")

local conf_table = cannons.config:to_table()

--look into readme.txt how to change settings
local defaults = {
enable_explosion = "true",
enable_fire = "true",
}

for k, v in pairs(defaults) do
if conf_table[k] == nil then
cannons.config:set(k, v)
end
end

dofile(cannons.MODPATH .."/print_r.lua")
dofile(cannons.MODPATH .."/functions.lua")
dofile(cannons.MODPATH .."/items.lua")
dofile(cannons.MODPATH .."/cannonballs.lua")

if minetest.get_modpath("locks") ~=nil then
minetest.log("locks mod enabled. execute locks.lua")
	dofile(cannons.MODPATH .."/locks.lua")--if the locks mod is installed execute this file
end
if minetest.get_modpath("moreores") ~=nil then
minetest.log("info","moreores mod enabled. execute moreores.lua")
	dofile(cannons.MODPATH .."/moreores.lua")--if the moreores mod is installed execute this file
end
minetest.log("info", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))


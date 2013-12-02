


cannons = {}
cannons.MODPATH = minetest.get_modpath(minetest.get_current_modname())


dofile(cannons.MODPATH .."/settings.txt")
dofile(cannons.MODPATH .."/print_r.lua")
dofile(cannons.MODPATH .."/functions.lua")
dofile(cannons.MODPATH .."/items.lua")
dofile(cannons.MODPATH .."/cannonballs.lua")

if minetest.get_modpath("locks") ~=nil then
minetest.log("locks mod enabled. execute locks.lua")
	dofile(cannons.MODPATH .."/locks.lua")--if the locks mod is installed execute this file
end

minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))


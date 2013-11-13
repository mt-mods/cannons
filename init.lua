


cannons = {}
local MODPATH = minetest.get_modpath(minetest.get_current_modname())


dofile(MODPATH .."/settings.txt")
dofile(MODPATH .."/print_r.lua")
dofile(MODPATH .."/functions.lua")
dofile(MODPATH .."/items.lua")
dofile(MODPATH .."/cannonballs.lua")


minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))


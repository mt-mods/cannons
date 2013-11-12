


canons = {}
local MODPATH = minetest.get_modpath(minetest.get_current_modname())

enable_fire = canons.enable_fire
enable_explosion = canons.enable_explosion

dofile(MODPATH .."/settings.txt")
dofile(MODPATH .."/print_r.lua")
dofile(MODPATH .."/functions.lua")
dofile(MODPATH .."/items.lua")
dofile(MODPATH .."/canonballs.lua")


minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))


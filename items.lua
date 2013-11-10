minetest.register_craftitem("canons:gunpowder", {
	groups = {gunpowder=1},
	description = "Gunpowder",
	inventory_image = "canons_gunpowder.png"
})

minetest.register_craftitem("canons:salt", {
	description = "Salt",
	inventory_image = "canons_salt.png"
})

minetest.register_craftitem("canons:bucket_salt", {
	description = "Bucket with salt",
	inventory_image = "canons_bucket_salt.png",
	stack_max = 300
})

minetest.register_craft({
    type = "shapeless",
	output = 'canons:salt 12',
	recipe = {
		"canons:bucket_salt"
	},
	replacements = {
		{"canons:bucket_salt", "bucket:bucket_empty"}
	}
})

minetest.register_craft({
	type = "cooking",
	output = 'canons:bucket_salt',
	recipe = 'bucket:bucket_water',
	cooktime = 15
})

minetest.register_craftitem("canons:iron_barrel", {
	groups = {canonbarrel=1},
	description = "Iron Cannonbarrel",
	inventory_image = "canons_barrel_iron.png",
	stack_max = 10
})
minetest.register_craftitem("canons:copper_barrel", {
	groups = {canonbarrel=1},
	description = "copper Cannonbarrel",
	inventory_image = "canons_barrel_copper.png",
	stack_max = 10
})
minetest.register_craftitem("canons:mithrill_barrel", {
	groups = {canonbarrel=1},
	description = "mithrill Cannonbarrel",
	inventory_image = "canons_barrel_mithrill.png",
	stack_max = 10
})

minetest.register_craft({
	type = "shapeless",
	output = 'canons:gunpowder',
	recipe = {
		"default:coal_lump", "default:mese_crystal", "canons:salt"
	},
})

minetest.register_craft({
	output = 'canons:iron_barrel',
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock"},
		{"", "default:mese_block", ""},
		{"default:steelblock", "default:steelblock", "default:steelblock"}
	},
})
minetest.register_craft({
	output = 'canons:canon',
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"", "group:canonbarrel", ""},
		{"default:cobble", "default:cobble", "default:cobble"}
	},
})


minetest.register_craftitem("canons:stone_bullet", {
	Description = "Stone Bullet",
	inventory_image = "canons_bullet.png"
})

canons.formspec =
	"size[8,9]"..
	"list[current_name;gunpowder;2,3;1,1;]"..
	"list[current_name;muni;2,1;1,1;]"..
	"list[current_player;main;0,5;8,4;]"

minetest.register_node("canons:canon", {
	description = "Canon",
	tiles = {"default_furnace_top.png", "default_furnace_bottom.png", "default_furnace_side.png",
		 "default_furnace_side.png","cannon_back.png", "cannon_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2,canon=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_punch = canons.punched,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", canons.formspec)
		meta:set_string("infotext", "Canon has no muni and no gunpowder")
		local inv = meta:get_inventory()
		inv:set_size("gunpowder", 1)
		inv:set_size("muni", 1)
		
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("gunpowder") then
			return false
		elseif not inv:is_empty("muni") then
			return false
		else
			return true
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		stack = stack:to_table()
		if listname == "gunpowder" and stack.name == "canons:gunpowder" then	
			return stack.count
		elseif listname == "muni" and canons.is_muni(stack.name) then	
			return stack.count
		else return 0
		end

	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		stack = stack:to_table()
		if to_list == "gunpowder" and stack.name == "canons:gunpowder" then
			return count
		
		elseif to_list == "muni" and  canons.is_muni(stack.name) then
			return count
		else
			return 0
		end
		
	end,
	on_metadata_inventory_put = canons.inventory_modified,
	
	on_metadata_inventory_take = canons.inventory_modified,
	
	on_metadata_inventory_move = canons.inventory_modified,
	
})



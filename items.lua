--++++++++++++++++++++++++++++++++++++
--+ Craft Items                      +
--++++++++++++++++++++++++++++++++++++

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

minetest.register_craftitem("canons:stone_bullet", {
	Description = "Stone Bullet",
	inventory_image = "canons_bullet.png"
})


--++++++++++++++++++++++++++++++++++++
--+ crafts                           +
--++++++++++++++++++++++++++++++++++++

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

minetest.register_craft({
	type = "shapeless",
	output = 'canons:gunpowder',
	recipe = {
		"default:coal_lump", "default:mese_crystal", "canons:salt"
	},
})

-- not needed --
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
-- new crafts --

minetest.register_craft({
	output = 'canons:canon',
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock"},
		{"canons:gunpowder", "default:mese_block", ""},
		{"default:steelblock", "default:steelblock", "default:steelblock"}
	},
})

minetest.register_craft({
	output = 'canons:bronze_canon',
	recipe = {
		{"default:bronzeblock", "default:bronzeblock", "default:bronzeblock"},
		{"canons:gunpowder", "default:mese_block", ""},
		{"default:bronzeblock", "default:bronzeblock", "default:bronzeblock"}
	},
})

minetest.register_craft({
	output = 'canons:canon_stand',
	recipe = {
		{"default:wood", "", "default:wood"},
		{"default:wood", "default:steelblock", "default:wood"},
		{"default:wood", "default:wood", "default:wood"}
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'canons:canon_ball_steel_stack',
	recipe = {
		"canons:canon_ball_steel", "canons:canon_ball_steel", "canons:canon_ball_steel", "canons:canon_ball_steel"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'canons:canon_ball_stone_stack',
	recipe = {
		"canons:canon_ball_stone", "canons:canon_ball_stone", "canons:canon_ball_stone", "canons:canon_ball_stone"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'canons:canon_ball_wood_stack',
	recipe = {
		"canons:canon_ball_wood", "canons:canon_ball_wood", "canons:canon_ball_wood", "canons:canon_ball_wood"
	},
})

minetest.register_craft({
	output = 'canons:canon_ball_wood 2',
	recipe = {
		{"default:wood","default:wood"},
	},
})

minetest.register_craft({
	output = 'canons:canon_ball_stone',
	recipe = {
		{"default:stone"},
	},
})

minetest.register_craft({
	output = 'canons:canon_ball_steel',
	recipe = {
		{"default:steelblock"}
	},
})

-- silly crafts --


--++++++++++++++++++++++++++++++++++++
--+ cannon stuff                     +
--++++++++++++++++++++++++++++++++++++
canons.formspec =
	"size[8,9]"..
	"list[current_name;gunpowder;2,3;1,1;]"..
	"list[current_name;muni;2,1;1,1;]"..
	"list[current_player;main;0,5;8,4;]"
-- classic cannon --
minetest.register_node("canons:canon", {
		description = "Cannon",
	stack_max = 1,
	tiles = {"cannon_cannon_top.png","cannon_cannon_top.png","cannon_cannon_side.png","cannon_cannon_side.png","cannon_cannon_top.png^canons_canons_rim.png","cannon_cannon_side.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, 0.2, -0.7, 0.2, -0.2, 0.9}, -- barrle --
			{0.53, -0.1, 0.1, -0.53, 0.1, -0.1}, -- plinth --
			
			-- side , top hight , depth , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, 0.2, -0.7, 0.2, -0.2, 0.9},
			{0.53, -0.1, 0.1, -0.53, 0.1, -0.1},
		},
	},
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
	allow_metadata_inventory_put = canons.allow_metadata_inventory_put,
	allow_metadata_inventory_move = canons.allow_metadata_inventory_move,
	on_metadata_inventory_put = canons.inventory_modified,
	
	on_metadata_inventory_take = canons.inventory_modified,
	
	on_metadata_inventory_move = canons.inventory_modified,
	
})

-- bronze cannon --
minetest.register_node("canons:bronze_canon", {
		description = "Cannon (bronze)",
	stack_max = 1,
	tiles = {"cannon_bronze_cannon_top.png","cannon_bronze_cannon_top.png","cannon_bronze_cannon_side.png","cannon_bronze_cannon_side.png","cannon_bronze_cannon_top.png^canons_canons_rim.png","cannon_bronze_cannon_side.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, 0.2, -0.7, 0.2, -0.2, 0.9}, -- barrle --
			{0.53, -0.1, 0.1, -0.53, 0.1, -0.1}, -- plinth --
			
			-- side , top hight , depth , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, 0.2, -0.7, 0.2, -0.2, 0.9},
			{0.53, -0.1, 0.1, -0.53, 0.1, -0.1},
		},
	},
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
	allow_metadata_inventory_put = canons.allow_metadata_inventory_put,

	allow_metadata_inventory_move = canons.allow_metadata_inventory_move,
	
	on_metadata_inventory_put = canons.inventory_modified,
	
	on_metadata_inventory_take = canons.inventory_modified,
	
	on_metadata_inventory_move = canons.inventory_modified,
	
})

minetest.register_node("canons:canon_stand", {
	description = "Cannon Stand",
	stack_max = 99,
	tiles = {"default_junglewood.png","default_junglewood.png^canons_canons_rim.png","default_junglewood.png^canons_canons_rim.png","default_junglewood.png^canons_canons_rim.png","default_cobble.png","default_junglewood.png^canons_canons_rim.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- bottom --
			{-0.5, -0.5, -0.5, -0.35, 1.0, 0.5}, -- side left --
			{0.35, -0.5, -0.5, 0.5, 1.0, 0.5}, -- side right --
			{0.35, -0.5, -0.2, 0.5, 1.2, 0.5}, -- side right --
			{-0.5, -0.5, -0.2, -0.35, 1.2, 0.5}, -- side left --
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})	
minetest.register_node("canons:canon_ball_wood", {
	description = "Cannon Ball Wood",
	stack_max = 99,
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
		},
	},
})

minetest.register_node("canons:canon_ball_stone", {
	description = "Cannon Ball Stone",
	stack_max = 99,
	tiles = {"default_stone.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
		},
	},
})

minetest.register_node("canons:canon_ball_steel", {
	description = "Cannon Ball Steel",
	stack_max = 99,
	tiles = {"cannon_cannon_top.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
		},
	},
})
	
minetest.register_node("canons:canon_ball_wood_stack", {
	description = "Cannon Ball Wood Stack",
	stack_max = 99,
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	drop = 'canons:canon_ball_wood 4',
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.1, -0.2, 0.2, 0.3, 0.2}, -- ball top
			{0.1, -0.5, -0.2, 0.2, -0.1, 0.2}, -- ball left
			{0.5, -0.5, -0.2, 0.2, -0.1, 0.2}, -- ball left
			{-0.2, -0.5, 0.5, 0.0, -0.1, 0.2},-- ball back
			{0.0, -0.5, 0.1, -0.4, -0.1, 0.2},--ball back
			{-0.2, -0.5, 0.5, -0.4, -0.1, 0.2},-- ball back
			{-0.2, -0.5, 0.1, -0.4, -0.1, 0.2},-- ball back
			{-0.2, -0.5, -0.1, -0.4, -0.1, -0.5},
			{0.0, -0.5, -0.1, -0.4, -0.1, -0.5},
			
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.5, 0.3, 0.5},
		},
	},
})
	

minetest.register_node("canons:canon_ball_stone_stack", {
	description = "Cannon Ball Stone Stack",
	stack_max = 99,
	tiles = {"default_stone.png"},
	drawtype = "nodebox",
	drop = 'canons:canon_ball_stone 4',
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.1, -0.2, 0.2, 0.3, 0.2}, -- ball top
			{0.1, -0.5, -0.2, 0.2, -0.1, 0.2}, -- ball left
			{0.5, -0.5, -0.2, 0.2, -0.1, 0.2}, -- ball left
			{-0.2, -0.5, 0.5, 0.0, -0.1, 0.2},-- ball back
			{0.0, -0.5, 0.1, -0.4, -0.1, 0.2},--ball back
			{-0.2, -0.5, 0.5, -0.4, -0.1, 0.2},-- ball back
			{-0.2, -0.5, 0.1, -0.4, -0.1, 0.2},-- ball back
			{-0.2, -0.5, -0.1, -0.4, -0.1, -0.5},
			{0.0, -0.5, -0.1, -0.4, -0.1, -0.5},
			
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.5, 0.3, 0.5},
		},
	},
})

minetest.register_node("canons:canon_ball_steel_stack", {
	description = "Cannon Ball Steel Stack",
	stack_max = 99,
	tiles = {"cannon_cannon_top.png"},
	drawtype = "nodebox",
	drop = 'canons:canon_ball_steel 4',
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.1, -0.2, 0.2, 0.3, 0.2}, -- ball top
			{0.1, -0.5, -0.2, 0.2, -0.1, 0.2}, -- ball left
			{0.5, -0.5, -0.2, 0.2, -0.1, 0.2}, -- ball left
			{-0.2, -0.5, 0.5, 0.0, -0.1, 0.2},-- ball back
			{0.0, -0.5, 0.1, -0.4, -0.1, 0.2},--ball back
			{-0.2, -0.5, 0.5, -0.4, -0.1, 0.2},-- ball back
			{-0.2, -0.5, 0.1, -0.4, -0.1, 0.2},-- ball back
			{-0.2, -0.5, -0.1, -0.4, -0.1, -0.5},
			{0.0, -0.5, -0.1, -0.4, -0.1, -0.5},
			
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.5, 0.3, 0.5},
		},
	},
})




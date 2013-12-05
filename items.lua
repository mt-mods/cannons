--++++++++++++++++++++++++++++++++++++
--+ Craft Items                      +
--++++++++++++++++++++++++++++++++++++

minetest.register_craftitem("cannons:gunpowder", {
	groups = {gunpowder=1},
	description = "Gunpowder",
	inventory_image = "cannons_gunpowder.png"
})

minetest.register_craftitem("cannons:salt", {
	description = "Salt",
	inventory_image = "cannons_salt.png"
})

minetest.register_craftitem("cannons:bucket_salt", {
	description = "Bucket with salt",
	inventory_image = "cannons_bucket_salt.png",
	stack_max = 300
})


--++++++++++++++++++++++++++++++++++++
--+ crafts                           +
--++++++++++++++++++++++++++++++++++++

minetest.register_craft({
    type = "shapeless",
	output = 'cannons:salt 12',
	recipe = {
		"cannons:bucket_salt"
	},
	replacements = {
		{"cannons:bucket_salt", "bucket:bucket_empty"}
	}
})

minetest.register_craft({
	type = "cooking",
	output = 'cannons:bucket_salt',
	recipe = 'bucket:bucket_water',
	cooktime = 15
})

minetest.register_craft({
	type = "shapeless",
	output = 'cannons:gunpowder',
	recipe = {
		"default:coal_lump", "default:mese_crystal", "cannons:salt"
	},
})


-- new crafts --

minetest.register_craft({
	output = 'cannons:cannon',
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock"},
		{"cannons:gunpowder", "default:mese_block", ""},
		{"default:steelblock", "default:steelblock", "default:steelblock"}
	},
})

minetest.register_craft({
	output = 'cannons:bronze_canon',
	recipe = {
		{"default:bronzeblock", "default:bronzeblock", "default:bronzeblock"},
		{"cannons:gunpowder", "default:mese_block", ""},
		{"default:bronzeblock", "default:bronzeblock", "default:bronzeblock"}
	},
})

minetest.register_craft({
	output = 'cannons:stand',
	recipe = {
		{"default:wood", "", "default:wood"},
		{"default:wood", "default:steelblock", "default:cobble"},
		{"default:wood", "default:wood", "default:cobble"}
	},
})

minetest.register_craft({
	output = 'cannons:stand_wood',
	recipe = {
		{"default:wood", "", "default:wood"},
		{"default:wood", "default:steelblock", "default:wood"},
		{"default:wood", "default:wood", "default:wood"}
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'cannons:ball_steel_stack',
	recipe = {
		"cannons:ball_steel", "cannons:ball_steel", "cannons:ball_steel", "cannons:ball_steel"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'cannons:ball_stone_stack',
	recipe = {
		"cannons:ball_stone", "cannons:ball_stone", "cannons:ball_stone", "cannons:ball_stone"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'cannons:ball_wood_stack',
	recipe = {
		"cannons:ball_wood", "cannons:ball_wood", "cannons:ball_wood", "cannons:ball_wood"
	},
})

minetest.register_craft({
	output = 'cannons:ball_wood 5',
	recipe = {
		{"","default:wood",""},
		{"default:wood","default:wood","default:wood"},
		{"","default:wood",""},
	},
})

minetest.register_craft({
	output = 'cannons:ball_stone',
	recipe = {
		{"default:stone"},
	},
})

minetest.register_craft({
	output = 'cannons:ball_steel',
	recipe = {
		{"default:steelblock"}
	},
})
if cannons.enable_explosion then
minetest.register_craft({
	output = 'cannons:ball_exploding 2',
	recipe = {
		{"","default:mese",""},
		{"default:mese","cannons:gunpowder","default:mese"},
		{"","default:mese",""},
	},
})
end
if cannons.enable_fire then
minetest.register_craft({
	output = 'cannons:ball_fire 2',
	recipe = {
		{"","default:wood",""},
		{"default:wood","default:torch","default:wood"},
		{"","default:wood",""},
	},
})
end
--++++++++++++++++++++++++++++++++++++
--+ cannon stuff                     +
--++++++++++++++++++++++++++++++++++++

-- classic cannon --
minetest.register_node("cannons:cannon", {
	description = "Cannon",
	stack_max = 1,
	tiles = {"cannon_cannon_top.png","cannon_cannon_top.png","cannon_cannon_side.png","cannon_cannon_side.png","cannon_cannon_top.png^cannons_rim.png","cannon_cannon_side.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1,cannon=1},
	sounds = cannons.sound_defaults(),
	node_box = cannons.nodeboxes.cannon,
	on_punch = cannons.punched,
	mesecons = cannons.supportMesecons,
	on_construct = cannons.on_construct,
	can_dig = cannons.can_dig,
	allow_metadata_inventory_put = cannons.allow_metadata_inventory_put,	
	allow_metadata_inventory_move = cannons.allow_metadata_inventory_move,	
	on_metadata_inventory_put = cannons.inventory_modified,	
	on_metadata_inventory_take = cannons.inventory_modified,	
	on_metadata_inventory_move = cannons.inventory_modified,
	
})

-- bronze cannon --
minetest.register_node("cannons:bronze_canon", {
	description = "Cannon (bronze)",
	stack_max = 1,
	tiles = {"cannon_bronze_cannon_top.png","cannon_bronze_cannon_top.png","cannon_bronze_cannon_side.png","cannon_bronze_cannon_side.png","cannon_bronze_cannon_top.png^cannons_rim.png","cannon_bronze_cannon_side.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1,cannon=1},
	sounds = cannons.sound_defaults(),
	node_box = cannons.nodeboxes.cannon,
	on_punch = cannons.punched,
	mesecons = cannons.supportMesecons,
	on_construct = cannons.on_construct,
	can_dig = cannons.can_dig,
	allow_metadata_inventory_put = cannons.allow_metadata_inventory_put,
	allow_metadata_inventory_move = cannons.allow_metadata_inventory_move,	
	on_metadata_inventory_put = cannons.inventory_modified,	
	on_metadata_inventory_take = cannons.inventory_modified,	
	on_metadata_inventory_move = cannons.inventory_modified,
	
})

minetest.register_node("cannons:stand", {
	description = "stone cannon stand",
	stack_max = 99,
	tiles = {"default_junglewood.png","default_cobble.png","default_junglewood.png^cannons_rim.png","default_junglewood.png^cannons_rim.png","default_cobble.png","default_junglewood.png^cannons_rim.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2,cannonstand=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = cannons.nodeboxes.stand,
	selection_box = {
	type = "fixed",
	fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	}
})	

minetest.register_node("cannons:stand_wood", {
	description = "wooden cannon stand",
	stack_max = 99,
	tiles = {"default_junglewood.png","default_wood.png","default_junglewood.png^cannons_rim.png","default_junglewood.png^cannons_rim.png","default_wood.png","default_junglewood.png^cannons_rim.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2,cannonstand=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = cannons.nodeboxes.stand,
	selection_box = {
	type = "fixed",
	fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	}
})	
--++++++++++++++++++++++++++++++++++++
--+ cannon balls                     +
--++++++++++++++++++++++++++++++++++++

--wood ball
minetest.register_node("cannons:ball_wood", {
	description = "Cannon Ball Wood",
	stack_max = 99,
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = cannons.nodeboxes.ball,
})

--stone ball
minetest.register_node("cannons:ball_stone", {
	description = "Cannon Ball Stone",
	stack_max = 99,
	tiles = {"default_stone.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	node_box = cannons.nodeboxes.ball,
})

--steel ball
minetest.register_node("cannons:ball_steel", {
	description = "Cannon Ball Steel",
	stack_max = 99,
	tiles = {"cannon_cannon_top.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = cannons.sound_defaults(),
	node_box = cannons.nodeboxes.ball,
})

--explosion cannon ball
if cannons.enable_explosion then
minetest.register_node("cannons:ball_exploding", {
	description = "Exploding Cannon Ball",
	stack_max = 99,
	tiles = {"default_mese_block.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = cannons.nodeboxes.ball,
})
end

--fire cannon ball
if cannons.enable_fire then
minetest.register_node("cannons:ball_fire", {
	description = "Burning Cannon Ball",
	stack_max = 99,
	tiles = {"default_tree.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = cannons.nodeboxes.ball,
})
end	

--ball wood stack
minetest.register_node("cannons:ball_wood_stack", {
	description = "Cannon Ball Wood Stack",
	stack_max = 99,
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	drop = 'cannons:ball_wood 4',
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = cannons.nodeboxes.ball_stack,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.5, 0.3, 0.5},
		},
	},
})
	
--ball stone stack
minetest.register_node("cannons:ball_stone_stack", {
	description = "Cannon Ball Stone Stack",
	stack_max = 99,
	tiles = {"default_stone.png"},
	drawtype = "nodebox",
	drop = 'cannons:ball_stone 4',
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	node_box = cannons.nodeboxes.ball_stack,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.5, 0.3, 0.5},
		},
	},
})

--ball steel stack
minetest.register_node("cannons:ball_steel_stack", {
	description = "Cannon Ball Steel Stack",
	stack_max = 99,
	tiles = {"cannon_cannon_top.png"},
	drawtype = "nodebox",
	drop = 'cannons:ball_steel 4',
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = cannons.sound_defaults(),
	node_box = cannons.nodeboxes.ball_stack,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.5, 0.3, 0.5},
		},
	},
})
minetest.register_alias("cannons:canon_ball_steel_stack", "cannons:ball_steel_stack")



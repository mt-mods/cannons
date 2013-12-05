minetest.register_node("cannons:mithril_cannon", {
	description = "Cannon (mithril)",
	stack_max = 1,
	tiles = {"cannon_mithril_cannon_top.png","cannon_mithril_cannon_top.png","cannon_mithril_cannon_side.png","cannon_mithril_cannon_side.png","cannon_mithril_cannon_top.png^cannons_rim.png","cannon_mithril_cannon_side.png"},
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
--craft reziep mithrill cannon
minetest.register_craft({
	output = 'cannons:mithril_cannon',
	recipe = {
		{"moreores:mithril_block", "moreores:mithril_block", "moreores:mithril_block"},
		{"cannons:gunpowder", "default:mese_block", ""},
		{"moreores:mithril_block", "moreores:mithril_block", "moreores:mithril_block"}
	},
})

--mithrill ball
minetest.register_node("cannons:ball_mithril", {
	description = "Cannon Ball mithril",
	stack_max = 9,
	tiles = {"cannon_mithril_cannon_top.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	sounds = cannons.sound_defaults(),
	node_box = cannons.nodeboxes.ball,
})
minetest.register_craft({
	output = 'cannons:ball_mithril',
	recipe = {
		{"moreores:mithril_block"}
	},
})

--ball mithril stack
minetest.register_node("cannons:ball_mithril_stack", {
	description = "Cannon Ball mithril Stack",
	stack_max = 9,
	tiles = {"cannon_mithril_cannon_top.png"},
	drawtype = "nodebox",
	drop = 'cannons:ball_mithril 4',
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
minetest.register_craft({
	type = "shapeless",
	output = 'cannons:ball_mithril_stack',
	recipe = {
		"cannons:ball_mithril", "cannons:ball_mithril", "cannons:ball_mithril", "cannons:ball_mithril"
	},
})

--mithril ball
cannons.register_muni("cannons:ball_mithril",{
	physical = false,
	timer=0,
	textures = {"cannons_ball_mithril.png"},
	lastpos={},
	damage=60,
	range=3,
	gravity=5,
	velocity=45,
	collisionbox = {-0.25,-0.25,-0.25, 0.25,0.25,0.25},
	on_player_hit = function(self,pos,player)
		local playername = player:get_player_name()
		player:punch(self.object, 1.0, {
			full_punch_interval=1.0,
			damage_groups={fleshy=self.damage},
			}, nil)
		self.object:remove()
		minetest.chat_send_all(playername .." tried to catch a canonball")
	end,
	on_mob_hit = function(self,pos,mob)
		mob:punch(self.object, 1.0, {
			full_punch_interval=1.0,
			damage_groups={fleshy=self.damage},
			}, nil)
		self.object:remove()
	end,
	on_node_hit = function(self,pos,node)
	cannons.nodehitparticles(pos,node)
		if node.name == "default:dirt_with_grass" then			
			minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="default:dirt"})
			minetest.sound_play("cannons_hit",
				{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		elseif node.name == "default:water_source" then
		minetest.sound_play("cannons_splash",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		else
		minetest.sound_play("cannons_hit",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		end
	end,

})
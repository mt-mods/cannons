--++++++++++++++++++++++++++++++++++++
--+ Stoneball                        +
--++++++++++++++++++++++++++++++++++++
local stone={
	physical = false,
	timer=0,
	textures = {"canons_bullet.png"},
	lastpos={},
	damage=20,
	range=2,
	gravity=10,
	velocity=40,
	name="canons:stone_bullet",
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
		if node.name == "default:dirt_with_grass" then			
			minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="default:dirt"})
			minetest.sound_play("canons_hit",
				{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		elseif node.name == "default:water_source" then
		minetest.sound_play("canons_splash",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		else
		minetest.sound_play("canons_hit",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		end
	end,

}
canons.register_muni("default:stone",stone)


--++++++++++++++++++++++++++++++++++++
--+ Meseball                         +
--++++++++++++++++++++++++++++++++++++
local mese={
	physical = false,
	timer=0,
	textures = {"default_mese_block.png","default_mese_block.png","default_mese_block.png","default_mese_block.png","default_mese_block.png","default_mese_block.png"},
	lastpos={},
	damage=15,
	visual = "cube",
	visual_size = {x=0.5, y=0.5},
	range=1,
	gravity=10,
	velocity=30,
	name="canons:mese",
	collisionbox = {-0.25,-0.25,-0.25, 0.25,0.25,0.25},
	on_player_hit = function(self,pos,player)
		local playername = player:get_player_name()
		player:punch(self.object, 1.0, {
			full_punch_interval=1.0,
			damage_groups={fleshy=self.damage},
			}, nil)
		self.object:remove()
	end,
	on_mob_hit = function(self,pos,mob)
		mob:punch(self.object, 1.0, {
			full_punch_interval=1.0,
			damage_groups={fleshy=self.damage},
			}, nil)
		self.object:remove()
	end,
	on_node_hit = function(self,pos,node)
		canons.destroy({x=pos.x, y=pos.y, z=pos.z},self.range)
		minetest.sound_play("canons_shot",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
		self.object:remove()
	end,

}
if enable_explosion then
	canons.register_muni("default:mese",mese)
end

local tree={
	physical = false,
	timer=0,
	textures = {"default_tree.png","default_tree.png","default_tree.png","default_tree.png","default_tree.png","default_tree.png"},
	lastpos={},
	damage=10,
	visual = "cube",
	visual_size = {x=0.5, y=0.5},
	range=2,
	gravity=8,
	velocity=35,
	name="canons:tree",
	collisionbox = {-0.25,-0.25,-0.25, 0.25,0.25,0.25},
	on_player_hit = function(self,pos,player)
		local playername = player:get_player_name()
		player:punch(self.object, 1.0, {
			full_punch_interval=1.0,
			damage_groups={fleshy=self.damage},
			}, nil)
		self.object:remove()
	end,
	on_mob_hit = function(self,pos,mob)
		self.object:remove()
	end,
	on_node_hit = function(self,pos,node)
		pos = self.lastpos
		minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="fire:basic_flame"})
		minetest.sound_play("default_break_glass",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
		self.object:remove()
	end,

}
if enable_fire then
	canons.register_muni("default:tree",tree)
end

--++++++++++++++++++++++++++++++++++++
--+ Stone Cannon ball                +
--++++++++++++++++++++++++++++++++++++


local ball_wood={
	physical = false,
	timer=0,
	textures = {"canons_bullet.png"},
	lastpos={},
	damage=20,
	range=1,
	gravity=10,
	velocity=40,
	name="canons:stone_bullet",
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
		if node.name == "default:dirt_with_grass" then			
			minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="default:dirt"})
			minetest.sound_play("canons_hit",
				{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		elseif node.name == "default:water_source" then
		minetest.sound_play("canons_splash",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		else
		minetest.sound_play("canons_hit",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		end
	end,

}
canons.register_muni("canons:canon_ball_wood",ball_wood)

--++++++++++++++++++++++++++++++++++++
--+ Stone Cannon ball                +
--++++++++++++++++++++++++++++++++++++


local ball_stone={
	physical = false,
	timer=0,
	textures = {"canons_bullet.png"},
	lastpos={},
	damage=20,
	range=2,
	gravity=10,
	velocity=40,
	name="canons:stone_bullet",
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
		if node.name == "default:dirt_with_grass" then			
			minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="default:dirt"})
			minetest.sound_play("canons_hit",
				{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		elseif node.name == "default:water_source" then
		minetest.sound_play("canons_splash",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		else
		minetest.sound_play("canons_hit",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		end
	end,

}
canons.register_muni("canons:canon_ball_stone",ball_stone)

--++++++++++++++++++++++++++++++++++++
--+ Steel Cannon ball                +
--++++++++++++++++++++++++++++++++++++


local ball_steel={
	physical = false,
	timer=0,
	textures = {"canons_bullet_iron.png"},
	lastpos={},
	damage=30,
	range=2,
	gravity=5,
	velocity=50,
	name="canons:stone_bullet",
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
		if node.name == "default:dirt_with_grass" then			
			minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="default:dirt"})
			minetest.sound_play("canons_hit",
				{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		elseif node.name == "default:water_source" then
		minetest.sound_play("canons_splash",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		else
		minetest.sound_play("canons_hit",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		end
	end,

}
canons.register_muni("canons:canon_ball_steel",ball_steel)
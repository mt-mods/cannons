
function cannons.destroy(pos,range)
	for x=-range,range do
	for y=-range,range do
	for z=-range,range do
		if x*x+y*y+z*z <= range * range + range then
			local np={x=pos.x+x,y=pos.y+y,z=pos.z+z}
			local n = minetest.env:get_node(np)
			if n.name ~= "air" then
				minetest.env:remove_node(np)
			end
		end
	end
	end
	end
end

function cannons.sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="cannons_walk", gain=1.0}
	table.dig = table.dig or
			{name="cannons_dig", gain=0.5}
	table.dug = table.dug or
			{name="default_dug_node", gain=0.5}
	table.place = table.place or
			{name="default_place_node_hard", gain=1.0}
	return table
end
function cannons.inventory_modified(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack("muni", 1)
	local muni = stack:to_table()
	local addition = ""
	if  meta:get_string("owner") ~="" then
		addition = " (owned by "..meta:get_string("owner")..")"
	end
	if muni == nil then
		muni = false
	else
		muni = cannons.is_muni(muni.name)
	end
	
	local gunpowder = inv:contains_item("gunpowder","cannons:gunpowder 1")
	if not muni and not gunpowder then
		meta:set_string("infotext","Cannon has no muni and no gunpowder"..addition)
	
	elseif not muni then
		meta:set_string("infotext","Cannon has no muni"..addition)
	
	elseif not gunpowder then
		meta:set_string("infotext","Cannon has no gunpowder"..addition)
		
	else
		meta:set_string("infotext","Cannon is ready"..addition)
	end		
end

cannons.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		
		local meta = minetest.get_meta(pos)
		if(meta:get_string("owner") ~="" and not( locks:lock_allow_use( pos, player ))) then
		   return 0;
		end
		local inv = meta:get_inventory()
		stack = stack:to_table()
		if listname == "gunpowder" and stack.name == "cannons:gunpowder" then	
			return stack.count
		elseif listname == "muni" and cannons.is_muni(stack.name) then	
			return stack.count
		else return 0
		end

	end
	
cannons.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)

		local meta = minetest.get_meta(pos)
		if(meta:get_string("owner") ~="" and not( locks:lock_allow_use( pos, player ))) then
		   return 0;
		end
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		stack = stack:to_table()
		if to_list == "gunpowder" and stack.name == "cannons:gunpowder" then
			return count
		
		elseif to_list == "muni" and  cannons.is_muni(stack.name) then
			return count
		else
			return 0
		end
	end
	
cannons.can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("gunpowder") then
			return false
		elseif not inv:is_empty("muni") then
			return false
		else
			return true
		end
	end
	
cannons.formspec =
	"size[8,9]"..
	"list[current_name;muni;0,1;1,1;] label[0,0.5;Muni:]"..
	"list[current_name;gunpowder;0,3;1,1;] label[0,2.5;Gunpowder:]"..
	"list[current_player;main;0,5;8,4;]"
	
cannons.disabled_formspec =
	"size[8,9]"..
	"label[2,0.5;Cannon is Disabled. Place it on a cannonstand to activate it]"..
	"list[current_player;main;0,5;8,4;]"
	
cannons.on_construct = function(pos)
	local node = minetest.get_node({x = pos.x ,y = pos.y-1, z = pos.z})
	if minetest.registered_nodes[node.name].groups.cannonstand then
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", cannons.formspec)
		meta:set_string("infotext", "Cannon has no muni and no gunpowder")
		local inv = meta:get_inventory()
		inv:set_size("gunpowder", 1)
		inv:set_size("muni", 1)
	else
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", cannons.disabled_formspec)
		meta:set_string("infotext", "Cannon is out of order")
	end
end

cannons.on_construct_locks = function(pos)
	local node = minetest.get_node({x = pos.x ,y = pos.y-1, z = pos.z})
	if minetest.registered_nodes[node.name].groups.cannonstand then
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", cannons.formspec..
									"field[2,1.3;6,0.7;locks_sent_lock_command;Locked Cannon. Type /help for help:;]"..
									"button[6,2;1.7,0.7;locks_sent_input;Proceed]")
		meta:set_string("infotext", "Cannon has no muni and no gunpowder")
		local inv = meta:get_inventory()
		inv:set_size("gunpowder", 1)
		inv:set_size("muni", 1)
	else
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", cannons.disabled_formspec)
		meta:set_string("infotext", "Cannon is out of order")
	end
end

function cannons.nodehitparticles(pos,node)
if type(minetest.registered_nodes[node.name]) == "table" and type(minetest.registered_nodes[node.name].tiles) == "table" and type(minetest.registered_nodes[node.name].tiles[1])== "string" then
local texture = minetest.registered_nodes[node.name].tiles[1]
	minetest.add_particlespawner(
        30, --amount
        0.5, --time
        {x=pos.x-0.3, y=pos.y+0.3, z=pos.z-0.3}, --minpos
        {x=pos.x+0.3, y=pos.y+0.5, z=pos.z+0.3}, --maxpos
        {x=0, y=2, z=0}, --minvel
        {x=0, y=3, z=0}, --maxvel
        {x=-4,y=-4,z=-4}, --minacc
        {x=4,y=-4,z=4}, --maxacc
        0.1, --minexptime
        1, --maxexptime
        1, --minsize
        3, --maxsize
        false, --collisiondetection
        texture --texture
    )
	end
end
function cannons.fire(pos,node,puncher)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack("muni", 1)
	local muni = stack:to_table()
	if inv:contains_item("gunpowder","cannons:gunpowder 1") 
		and muni ~= nil 
		and cannons.is_muni(muni.name) 
		and inv:contains_item("muni",muni.name.." 1") 
	
	then 
		if puncher ~= nil then
			dir=puncher:get_look_dir()
			meta:set_string("dir", minetest.serialize(dir))
		else
			dir = {}
			dir = minetest.deserialize(meta:get_string("dir"));
			if dir == nil then
				return
			end
		end	
		minetest.sound_play("cannons_shot",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
		

		inv:remove_item("muni", muni.name.." 1")
		inv:remove_item("gunpowder", "cannons:gunpowder 1")
		cannons.inventory_modified(pos)


		local settings = cannons.get_settings(muni.name)
		local obj=minetest.env:add_entity(pos, cannons.get_entity(muni.name))
		obj:setvelocity({x=dir.x*settings.velocity, y=-1, z=dir.z*settings.velocity})
		obj:setacceleration({x=dir.x*-3, y=-settings.gravity, z=dir.z*-3})
		minetest.add_particlespawner(50,0.5,
    pos, pos,
    {x=dir.x*settings.velocity, y=-1, z=dir.z*settings.velocity}, {x=dir.x*settings.velocity/2, y=-1, z=dir.z*settings.velocity/2},
    {x=dir.x*-3/4, y=-settings.gravity*2, z=dir.z*-3/4}, {x=dir.x*-3/2, y=-settings.gravity, z=dir.z*-3/2},
    0.1, 0.5,--time
    0.5, 1,
    false, "cannons_gunpowder.png")
	end
end

function cannons.punched(pos, node, puncher)
	if not puncher or not node then
		return
	end
	local wield = puncher:get_wielded_item()
	if not wield then
		return
	end
	wield = wield:get_name()
	if wield and wield == 'default:torch' then
		cannons.fire(pos,node,puncher)
	end
end

--++++++++++++++++++++++++++++++++++++
--+ cannons.register_muni             +
--++++++++++++++++++++++++++++++++++++

cannons.registered_muni = {}

function cannons.register_muni(node,entity)
	cannons.registered_muni[node] = {}
	cannons.registered_muni[node].entity = entity
	local name = node:split(":")
	cannons.registered_muni[node].entity.name ="cannons:entity_"..name[1].."_"..name[2]
	cannons.registered_muni[node].entity.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer >= 0.3 then --easiesst less laggiest way to find out that it left his start position
			local pos = self.object:getpos()
			local node = minetest.env:get_node(pos)

			if node.name == "air" then
				local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, self.range)
				for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= self.name and obj:get_luaentity().name ~= "__builtin:item" then --something other found
						local mob = obj
						self.on_mob_hit(self,pos,mob)
						end
					elseif obj:is_player() then --player found
					local player = obj
						self.on_player_hit(self,pos,player)
					end		
				end
			elseif node.name ~=air  then
				self.on_node_hit(self,pos,node)
			end	
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end	
	end
	cannons.registered_muni[node].obj = entity.name
	minetest.register_entity(entity.name, cannons.registered_muni[node].entity)
end

function cannons.is_muni(node)
	return cannons.registered_muni[node] ~= nil		
end
function cannons.get_entity(node)
	return cannons.registered_muni[node].obj		
end
function cannons.get_settings(node)
	return cannons.registered_muni[node].entity		
end
--++++++++++++++++++++++++++++++++++++
--+ mesecons stuff                   +
--++++++++++++++++++++++++++++++++++++
cannons.rules ={
	{x = 1, y = 0, z = 0},
	{x =-1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z =-1}
 }
 
function cannons.meseconsfire(pos,node)
	cannons.fire(pos,node)
end

cannons.supportMesecons = {
	effector = {
		rules = cannons.rules,
		action_on = cannons.meseconsfire,
		}
}
	

--++++++++++++++++++++++++++++++++++++
--+ cannons.nodeboxes                +
--++++++++++++++++++++++++++++++++++++
cannons.nodeboxes = {}
cannons.nodeboxes.ball = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2},
			
			-- side , top , side , side , bottom, side,
				
		},
	}
cannons.nodeboxes.ball_stack = {
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
	}
cannons.nodeboxes.cannon = {
		type = "fixed",
		fixed = {
			{-0.2, 0.2, -0.7, 0.2, -0.2, 0.9}, -- barrle --
			{0.53, -0.1, 0.1, -0.53, 0.1, -0.1}, -- plinth --
			
			-- side , top hight , depth , side , bottom, side,
				
		}
	}
cannons.nodeboxes.stand = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- bottom --
			{-0.5, -0.5, -0.5, -0.35, 1.0, 0.5}, -- side left --
			{0.35, -0.5, -0.5, 0.5, 1.0, 0.5}, -- side right --
			{0.35, -0.5, -0.2, 0.5, 1.2, 0.5}, -- side right --
			{-0.5, -0.5, -0.2, -0.35, 1.2, 0.5}, -- side left --
			
			-- side , top , side , side , bottom, side,
				
		},
	}

local apple={
	physical = false,
	timer=0,
	textures = {"default_apple.png"},
	lastpos={},
	damage=-10,
	range=2,
	gravity=10,
	velocity=30,
	collisionbox = {-0.25,-0.25,-0.25, 0.25,0.25,0.25},
	on_player_hit = function(self,pos,player)
		local playername = player:get_player_name()
		player:punch(self.object, 1.0, {
			full_punch_interval=1.0,
			damage_groups={fleshy=self.damage},
			}, nil)
		self.object:remove()
		minetest.chat_send_player(playername ," this is not an easter egg!")
	end,
	on_mob_hit = function(self,pos,mob)
		self.object:remove()
	end,
	on_node_hit = function(self,pos,node)
		pos = self.lastpos
		minetest.env:set_node({x=pos.x, y=pos.y, z=pos.z},{name="default:apple"})
		minetest.sound_play("canons_hit",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
		self.object:remove()
	end,

}
cannons.register_muni("default:apple",apple)
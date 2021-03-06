minetest.register_craft({
	output = 'rangedweapons:ak47',
	recipe = {
		{'default:diamond', 'default:steel_ingot', 'default:tree'},
		{'default:tree', 'default:mese', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:tree'},
	}
})

	minetest.register_craftitem("rangedweapons:ak47", {
	stack_max= 1,
	wield_scale = {x=1.75,y=1.75,z=1.3},
		description = "" ..core.colorize("#35cdff","AK-47\n") ..core.colorize("#FFFFFF", "Ranged damage: 6-16\n") ..core.colorize("#FFFFFF", "Accuracy: 77%\n") ..core.colorize("#FFFFFF", "Mob knockback: 5\n")..core.colorize("#FFFFFF", "Critical chance: 16%\n") ..core.colorize("#FFFFFF", "Critical damage: 17-26\n")  ..core.colorize("#FFFFFF", "Ammunition: 7.26mm rounds\n") ..core.colorize("#FFFFFF", "Rate of fire: 0.165\n") ..core.colorize("#FFFFFF", "Gun type: Assault rifle\n") ..core.colorize("#FFFFFF", "Bullet velocity: 40"),
	range = 0,
	inventory_image = "rangedweapons_ak47.png",
})

local timer = 0
minetest.register_globalstep(function(dtime, player)
	timer = timer + dtime;
	if timer >= 0.165 then
	for _, player in pairs(minetest.get_connected_players()) do
			local inv = player:get_inventory()
			local controls = player:get_player_control()
			if controls.LMB then
			timer = 0
	local wielded_item = player:get_wielded_item():get_name()
		if wielded_item == "rangedweapons:ak47" then
			if not inv:contains_item("main", "rangedweapons:726mm") then
minetest.sound_play("rangedweapons_empty", {object=player})
		else
		if wielded_item == "rangedweapons:ak47" then
		inv:remove_item("main", "rangedweapons:726mm")
		local pos = player:getpos()
		local dir = player:get_look_dir()
		local yaw = player:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:ak47shot")
			if obj then
				minetest.sound_play("rangedweapons_ak", {object=obj})
				obj:setvelocity({x=dir.x * 40, y=dir.y * 40, z=dir.z * 40})
				obj:setacceleration({x=dir.x * math.random(-2.3,2.3), y=math.random(-2.3,2.3), z=dir.z * math.random(-2.3,2.3)})
				obj:setyaw(yaw + math.pi)
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:empty_shell")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * -10, y=dir.y * -10, z=dir.z * -10})
				obj:setacceleration({x=dir.x * -5, y= -10, z=dir.z * -5})
				obj:setyaw(yaw + math.pi)
	minetest.add_particle({
		pos = pos,
		velocity = {x=dir.x * 3, y=dir.y * 3, z=dir.z * 3} ,
          	acceleration = {x=dir.x * -4, y=2, z=dir.z * -4},
		expirationtime = 0.5,
		size = 4,
		collisiondetection = false,
		vertical = false,
		texture = "tnt_smoke.png",
		glow = 5,
	})

				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or player
				end
			end
		end
	end
end

end
	end
		end
			end
				end)

local rangedweapons_ak47shot = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons_invisible.png"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_ak47shot.on_step = function(self, dtime, node, pos)
	self.timer = self.timer + dtime
	local tiem = 0.002
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.08 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:ak47shot" and obj:get_luaentity().name ~= "__builtin:item" then
					if math.random(1, 100) <= 16 then
					local damage = math.random(17,26)
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage, knockback=10},
					}, nil)
					minetest.sound_play("crit", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
					else
					local damage = math.random(6,16)
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage, knockback = 5},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			end
			else
				if math.random(1, 100) <= 16 then
				local damage = math.random(17,26)
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("crit", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				else
				local damage = math.random(6,16)
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
				end
			end
		if timer >= 0.002 + tiem then
	minetest.add_particle({
		pos = pos,
		velocity = 0,
          acceleration = {x=0, y=0, z=0},
		expirationtime = 0.06,
		size = 3,
		collisiondetection = false,
		vertical = false,
		texture = "rangedweapons_bullet_fly.png",
		glow = 15,
	})
		tiem = tiem + 0.002 
			end
		if self.timer >= 4.0 then
		self.object:remove()
			end
	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
		if node.name == "rangedweapons:barrel" or
		node.name == "doors:door_glass_a" or
		node.name == "doors:door_glass_b" or
		node.name == "xpanes:pane" or
		node.name == "xpanes:pane_flat" or
		node.name == "vessels:drinking_glass" or
		node.name == "vessels:glass_bottle" or
		   node.name == "default:glass" then
		minetest.get_node_timer(pos):start(0)
		end
		self.object:remove()
	end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end
end
end



minetest.register_entity("rangedweapons:ak47shot", rangedweapons_ak47shot )
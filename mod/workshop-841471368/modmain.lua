---此Mod由RedPig的小红猪防熊锁重做而来---
---By GuardAngelY---2017-01-11
--GLOBAL.require "debugtools"
--modimport("scripts/player_server_shard.lua")
local _G = GLOBAL
local TheSim = _G.TheSim
local TheNet = _G.TheNet

local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()
local EQUIPSLOTS = _G.EQUIPSLOTS
if IsServer then
	modimport("scripts/gd_global.lua")
	modimport("scripts/manager_players.lua")
	modimport("scripts/manager_walls.lua")
	modimport("scripts/manager_beefalos.lua")
	modimport("scripts/manager_others.lua")
	modimport("scripts/manager_permission.lua")
	modimport("scripts/manager_stacks.lua")
	modimport("scripts/manager_shelters.lua")
	modimport("scripts/manager_clean.lua")
	modimport("scripts/player_start.lua")
	-- modimport("scripts/gd_mods.lua")
	-- modimport("scripts/item_show.lua")
	modimport("scripts/gd_speech.lua")

	local test_mode = GetModConfigData("test_mode")
	local admin_option = GetModConfigData("admin_option")
	local is_allow_build_near = GetModConfigData("is_allow_build_near")

	local cant_destroyby_monster = GetModConfigData("cant_destroyby_monster")
	local portal_clear = GetModConfigData("portal_clear")
	--背包拾取增强
	local pack_pickup = GetModConfigData("pack_pickup")
	--完整远古祭坛防拆毁
	local ancient_altar_no_destroy = GetModConfigData("ancient_altar_no_destroy")
	--犬牙陷阱攻击无权限玩家
	local trap_teeth_player = GetModConfigData("trap_teeth_player")
	--眼球塔攻击无权限玩家
	local eyeturret_player = GetModConfigData("eyeturret_player")
	-- 防止玩家破坏野外猪人房兔人房
	local house_plain_nodestroy = GetModConfigData("house_plain_nodestroy")
	-- local config_item = _G.require("config_item")

	-- 物品范围权限
	local item_ScopePermission = 12
	--local tile_map = {}

	--重要地点附近自动清理操作
	local function portalnearautodeletefn(inst)
		if _G.TheWorld.ismastersim then
			if not inst.components.near_autodelete then
				inst:AddComponent("near_autodelete")
				if trap_teeth_player then
					inst.components.near_autodelete:AddCustomPrefab("trap_teeth")
				end
				if eyeturret_player then
					inst.components.near_autodelete:AddCustomPrefab("eyeturret")
				end
				inst.components.near_autodelete:SetScope(portal_clear)
				inst.components.near_autodelete:start()
			end
		end
	end

	if portal_clear == true or (type(portal_clear) == "number" and portal_clear > 0) then
		for k, v in pairs(config_item.item_clear_auto) do
			AddPrefabPostInit(v, portalnearautodeletefn)
		end
		--AddPrefabPostInit("multiplayer_portal", portalnearautodeletefn)
	end

	--墙生命改变
	-- local comb_health = _G.require "components/health"
	-- local old_DoDelta = comb_health.DoDelta
	-- function comb_health:DoDelta(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
	-- 	if self.inst:HasTag("wall") then
	-- 		if test_mode then
	-- 			print(tostring(afflicter))
	-- 			print((afflicter and afflicter.name or "未知").."--healthchange--"..((self.inst.prefab and self.inst.prefab or "[无效的类名]")..("--生命变更--"..tostring(self.inst.ownerlist).." ownerlist数量:"..(self.inst.ownerlist and tablelength(self.inst.ownerlist) or "无效的对象")).."--["..(afflicter and afflicter.userid and afflicter.userid or "无效的ID").."]HasTag:"..(afflicter and afflicter.userid and tostring(self.inst:HasTag("userid_"..afflicter.userid)) or "false") or "target对象不存在"))
	-- 			print("IsPlayer:"..tostring(afflicter and afflicter:HasTag("player")))
	-- 			print("action:"..tostring(self.inst))
	-- 			print("amount:"..tostring(amount))
	-- 		end

	-- 		-- 主机或管理员直接可攻击
	-- 		if not ((_G.TheWorld.ismastersim == false) or (admin_option and afflicter and afflicter.Network:IsServerAdmin() and test_mode == false) or (self.inst and (self.inst.ownerlist == nil or tablelength(self.inst.ownerlist) == 0 or (afflicter and afflicter.userid and self.inst:HasTag("userid_"..afflicter.userid))))) and amount <= 0 then
	-- 			if afflicter and afflicter:HasTag("player") and afflicter.components.talker then
	-- 				afflicter:DoTaskInTime(0, function ()
	-- 					--worker.components.talker:Say("这是别人家的墙，我砸不动！")
	-- 					afflicter.components.talker:Say(get_msg(29))
	-- 				end)
	-- 			end
	-- 			return false
	-- 		end
	-- 	end
	-- 	return old_DoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
	-- end

	--设置不可烧物品
	-- for k,name in pairs(config_item.remove_burnable_from) do
	-- 	AddPrefabPostInit(name, RemoveBurnable)
	-- end

	--------------------添加Tag---------------------------
	-------------------------------------------------------
	--丢东西
	--[[
	local old_DROP = _G.ACTIONS.DROP.fn
	_G.ACTIONS.DROP.fn = function(act)

		if _G.TheWorld.ismastersim == false then return old_DROP(act) end
		
		local x = act.pos.x
		local y = act.pos.y
		local z = act.pos.z
		print("drop!!")
		act.doer:DoTaskInTime(0, function ()
			local ents = TheSim:FindEntities(x, y, z, 0)
			for g,obj in pairs(ents) do
				--print(act.doer.name.."--drop-->"..obj.prefab)
			end
		end)
		
		return old_DROP(act)
		
	end
	]]--

	--安置物品，为每个安置的新物品都添加Tag(种植物/墙)
	local old_DEPLOY = _G.ACTIONS.DEPLOY.fn 
	_G.ACTIONS.DEPLOY.fn = function(act)
		testActPrint(act)
		if _G.TheWorld.ismastersim == false then return old_DEPLOY(act) end

		if not is_allow_build_near and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
			if not CheckBuilderScopePermission(act.doer, act.target, "离别人建筑太近了，我做不到，需要权限！", item_ScopePermission) then return false end
		end

		if act.invobject.components.deployable and act.invobject.components.deployable:CanDeploy(act.pos) then
			local obj = (act.doer.components.inventory and act.doer.components.inventory:RemoveItem(act.invobject)) or 
			(act.doer.components.container and act.doer.components.container:RemoveItem(act.invobject))
			if obj then
				local prefab = obj.prefab
				-- 处理犬牙陷阱和蜜蜂地雷等
				testActPrint(nil, act.doer, obj, "deploy", "安置物品")
				SetItemPermission(obj, act.doer)
				local ret = obj.components.deployable:Deploy(act.pos, act.doer, act.rotation)
				if ret then
					local x, y, z = GetSplitPosition(act.pos)

					-- 安置物为墙
					if string.find(prefab, "wall_") or string.find(act.invobject.prefab, "fence_") then
						x = math.floor(x) + .5
						z = math.floor(z) + .5
					end
					--print(string.format("打印坐标: x:%s y:%s z:%s", x, y, z))
					--local ents = TheSim:FindEntities(x, y, z, 1, nil, { "INLIMBO" })
					local bSetItemPermission = false
					local ents = TheSim:FindEntities(x, y, z, 0.1, nil, { "INLIMBO" })

					for _,findobj in pairs(ents) do
						--if findobj.prefab ~= nil and not findobj:IsInLimbo() and findobj.components.deployable == nil then
						if findobj ~= nil and findobj.userid == nil and findobj.components.deployable == nil then
							testActPrint(nil, act.doer, findobj, "deploy", "安置物设置权限")
							SetItemPermission(findobj, act.doer)
							bSetItemPermission = true
						end
					end

					-- 未执行设置权限操作,进行增强处理
					if not bSetItemPermission then
						local prefab_words = {}
						for word in string.gmatch(prefab, "%a+") do
							table.insert(prefab_words, word) --分词
						end

						ents = TheSim:FindEntities(x, y, z, 1, nil, { "INLIMBO" })

						for _,findobj in pairs(ents) do
							if findobj.prefab then
								if findobj.prefab ~= nil and (string.find(prefab, findobj.prefab) or string.find(findobj.prefab, prefab) or (tablelength(prefab_words) > 1 and strFindInTable(findobj.prefab, prefab_words))) and findobj.components.deployable == nil then
									--print(string.format("%s find => %s deployable:%s", prefab, findobj.prefab and findobj.prefab or "nil", findobj.components.deployable and "true" or "false"))
									testActPrint(nil, act.doer, findobj, "deploy", "安置物设置权限(增强)")
									SetItemPermission(findobj, act.doer)
									bSetItemPermission = true
								end
							end
						end
					end
					return true
				else
					act.doer.components.inventory:GiveItem(obj)
				end
			end
		end
	end

	--放置物品(农场/圣诞树)
	local old_PLANT = _G.ACTIONS.PLANT.fn 
	_G.ACTIONS.PLANT.fn = function(act)
		testActPrint(act)
		if act.doer.components.inventory ~= nil then
			local seed = act.doer.components.inventory:RemoveItem(act.invobject)
			if seed ~= nil then
				--种植农场
				if act.target.components.grower ~= nil and act.target.components.grower:PlantItem(seed) then
					for obj,bValue in pairs(act.target.components.grower.crops) do
						if bValue then SetItemPermission(obj, nil, act.doer) end
					end
					return true
				elseif act.target:HasTag("winter_treestand")
					and act.target.components.burnable ~= nil
					and not (act.target.components.burnable:IsBurning() or
							act.target.components.burnable:IsSmoldering()) then
					--种植圣诞树
					--act.target:PushEvent("plantwintertreeseed", { seed = seed })
					local x, y, z = act.target.Transform:GetWorldPosition()
					--act.target:Remove()
					local tree = _G.SpawnPrefab(seed.components.winter_treeseed.winter_tree)
					-- tree.ownerlist = act.target.ownerlist
					if act.target.ownerlist ~= nil then
						SetItemPermission(tree, act.target.ownerlist.master)
					end
					act.target:Remove()
					tree.Transform:SetPosition(x, y, z)
					tree.components.growable:StartGrowing()

					act.doer:DoTaskInTime(0, function ()
						SetItemPermission(tree, act.doer)
					end)

					return true
				else
					act.doer.components.inventory:GiveItem(seed)
				end
			end
		end
		--print("打印对象PLANT")
		--_G.dumptable(act, 1, 10)
		--_G.ddump(act)
		-- if _G.TheWorld.ismastersim == false then return old_PLANT(act) end
	
		-- if  act.target and (act.target.ownerlist == nil or act.target:HasTag("userid_"..act.doer.userid) or (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin())) then
		--     return old_PLANT(act)
		-- else
		--     doer_num = ""
		--     for n,p in pairs(AllPlayers) do
		--         if act.doer.userid == p.userid then 
		--             doer_num = n
		--         end
		--     end

		-- 	local found = false
		--     for owner_userid,_ in pairs(act.target.ownerlist) do
		--         for _,p in pairs(AllPlayers) do
		--             if owner_userid == p.userid then
		-- 			    found = true
		-- 			    act.doer:DoTaskInTime(0, function ()
		-- 						act.doer.components.talker:Say(GetSayMsg("permission_no", p.name, GetItemOldName(act.target)))
		--                 end)
						
		--                 p.components.talker:Say(GetSayMsg("item_use", act.doer.name, GetItemOldName(act.target), doer_num))
		--             end
		--         end	
		--     end
		-- 	if not found then 
		--         act.doer.components.talker:Say(get_msg(22))
		--     end
		--     return false
		-- end
	end

	--用晾肉架
	local old_DRY = _G.ACTIONS.DRY.fn 
	_G.ACTIONS.DRY.fn = function(act)
		testActPrint(act)
		--_G.dumptable(act, 1, 10)
		if _G.TheWorld.ismastersim == false then return old_DRY(act) end
		--print(act.doer.name.."--dry--"..GetItemOldName(act.target))

		act.doer:DoTaskInTime(0, function ()
			SetItemPermission(act.target, nil, act.doer)
		end)
		return old_DRY(act)
	end

	--------------------检测Tag来防熊---------------------
	--------------------------------------------------------
	--防采肉架上的肉干和蜂箱蜂蜜
	local old_HARVEST = _G.ACTIONS.HARVEST.fn 
	_G.ACTIONS.HARVEST.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, nil, true) or act.target.prefab == "cookpot" then
			return old_HARVEST(act)
		elseif act.target == nil or (act.target.ownerlist == nil and true or act.target.ownerlist.master == nil) or tablelength(act.target.ownerlist) == 0 or act.doer:HasTag("player") == false then
			-- 不存在权限则判断周围建筑物
			if CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("buildings_get_cant")) then return old_HARVEST(act) end
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("item_get_cant", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("item_get", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	--防止玩家挖别人东西
	local old_DIG = _G.ACTIONS.DIG.fn 
	_G.ACTIONS.DIG.fn = function(act)
		testActPrint(act)

		local leader = GetItemLeader(act.doer)

		-- 有权限时直接处理/患病的植物直接处理
		if CheckItemPermission(leader, act.target) or (act.target and act.target.components.diseaseable and act.target.components.diseaseable:IsDiseased()) then
			return old_DIG(act)
		-- 普通树，判断周围建筑范围(12码)内是否有超过4颗属于同一主人的树
		elseif act.target and (act.target.prefab == "evergreen" or act.target.prefab == "deciduoustree" or act.target.prefab == "twiggytree" or act.target.prefab == "pinecone_sapling" or act.target.prefab == "acorn_sapling" or act.target.prefab == "twiggy_nut_sapling") then
			if act.target.ownerlist ~= nil and act.target.ownerlist.master ~= nil then
				local x, y, z = act.target.Transform:GetWorldPosition()
				local ents = TheSim:FindEntities(x, y, z, item_ScopePermission, { "tree" })
				local tree_num = 1
				if leader and leader.userid then
					for _,obj in pairs(ents) do
						if obj and obj ~= act.target and obj:HasTag("tree") and obj.ownerlist and obj.ownerlist.master == act.target.ownerlist.master then
							tree_num = tree_num + 1
						end
					end
				end

				if tree_num >= 5 then
					local doer_num = GetPlayerIndex(act.doer.userid)
					local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
					if master ~= nil then
						PlayerSay(leader, GetSayMsg("trees_dig_cant", master.name))
						PlayerSay(master, GetSayMsg("item_dig", act.doer.name, GetItemOldName(act.target), doer_num))
					else
						PlayerSay(leader, GetSayMsg("trees_dig_cant"))
					end

					return false
				end
			end
			
			return old_DIG(act)
		elseif act.target == nil or act.target.ownerlist == nil or tablelength(act.target.ownerlist) == 0 or (cant_destroyby_monster and leader:HasTag("player") == false) then
			return old_DIG(act)
			-- 不存在权限则判断周围建筑物
			--if CheckBuilderScopePermission(leader, act.target, GetSayMsg("buildings_dig_cant")) then return old_DIG(act) end
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("item_dig_cant", master.name))
				PlayerSay(master, GetSayMsg("item_dig", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	--防止玩家采别人东西(草/树枝/浆果/花)
	local old_PICK = _G.ACTIONS.PICK.fn 
	_G.ACTIONS.PICK.fn = function(act)
		testActPrint(act)

		if act.target and string.find(act.target.prefab, "flower") then
			-- 有权限时直接处理
			if CheckItemPermission(act.doer, act.target) then
				return old_PICK(act)
			elseif act.target == nil or act.target.ownerlist == nil or tablelength(act.target.ownerlist) == 0 or act.doer:HasTag("player") == false then
				return old_PICK(act)
				-- 不存在权限则判断周围建筑物
				--if CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("buildings_pick_cant")) then return old_PICK(act) end
			elseif act.doer:HasTag("player") then
				-- 主人不为自己并且物品受权限控制
				local doer_num = GetPlayerIndex(act.doer.userid)
				local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
				if master ~= nil then
					PlayerSay(act.doer, GetSayMsg("item_pick_cant", master.name, GetItemOldName(act.target)))
					PlayerSay(master, GetSayMsg("item_pick", act.doer.name, GetItemOldName(act.target), doer_num))
				else
					PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
				end
			end

			return false
		end

		return old_PICK(act)
	end

	--防止玩家开采别人东西(大理石树)
	local old_MINE = _G.ACTIONS.MINE.fn 
	_G.ACTIONS.MINE.fn = function(act)
		testActPrint(act)

		local leader = GetItemLeader(act.doer)

		-- 有权限时直接处理
		if CheckItemPermission(leader, act.target) then
			return old_MINE(act)
		elseif act.target == nil or act.target.ownerlist == nil or tablelength(act.target.ownerlist) == 0 or (cant_destroyby_monster and leader:HasTag("player") == false) then
			return old_MINE(act)
			-- 不存在权限则判断周围建筑物
			--if CheckBuilderScopePermission(leader, act.target, GetSayMsg("buildings_pick_cant")) then return old_MINE(act) end
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("item_pick_cant", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("item_pick", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	--防止玩家拿别人陷阱(狗牙/捕鸟器/蜜蜂地雷)
	local old_PICKUP = _G.ACTIONS.PICKUP.fn 
	_G.ACTIONS.PICKUP.fn = function(act)
		testActPrint(act)

		--防偷(狗牙/捕鸟器/蜜蜂地雷) - 暂时只防狗牙被偷
		-- or act.target.prefab == "beemine" or act.target.prefab == "birdtrap"
		if act.target and (act.target.prefab == "trap_teeth") then
			-- 有权限时直接处理
			if CheckItemPermission(act.doer, act.target, true) then
				return old_PICKUP(act)
			elseif act.doer:HasTag("player") then
				-- 主人不为自己并且物品受权限控制
				local doer_num = GetPlayerIndex(act.doer.userid)
				local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
				if master ~= nil then
					PlayerSay(act.doer, GetSayMsg("item_get_cant", master.name, GetItemOldName(act.target)))
					PlayerSay(master, GetSayMsg("item_get", act.doer.name, GetItemOldName(act.target), doer_num))
				else
					PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
				end
			end

			return false
		end

		--return old_PICKUP(act)
		if pack_pickup and act.doer.components.inventory ~= nil and
			act.target ~= nil and
			act.target.components.inventoryitem ~= nil and
			(act.target.components.inventoryitem.canbepickedup or
			(act.target.components.inventoryitem.canbepickedupalive and not act.doer:HasTag("player"))) and
			not (act.target:IsInLimbo() or
				(act.target.components.burnable ~= nil and act.target.components.burnable:IsBurning()) or
				(act.target.components.projectile ~= nil and act.target.components.projectile:IsThrown())) then

			act.doer:PushEvent("onpickupitem", { item = act.target })

			--special case for trying to carry two backpacks
			if not act.target.components.inventoryitem.cangoincontainer and act.target.components.equippable and act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot) then
				-- 背包拾取增强
				if pack_pickup and act.target.components.container ~= nil and act.doer.components.inventory.activeitem == nil then
					act.target.components.inventoryitem.cangoincontainer = true
					act.target.components.inventoryitem:OnPutInInventory(act.doer)
					act.doer.components.inventory:SetActiveItem(act.target)
					act.target.components.inventoryitem.cangoincontainer = false
				else
					local item = act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot)
					if item.components.inventoryitem and item.components.inventoryitem.cangoincontainer then
						--act.doer.components.inventory:SelectActiveItemFromEquipSlot(act.target.components.equippable.equipslot)
						act.doer.components.inventory:GiveItem(act.doer.components.inventory:Unequip(act.target.components.equippable.equipslot))
					else
						act.doer.components.inventory:DropItem(act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot))
					end
					act.doer.components.inventory:Equip(act.target)
				end
				return true
			end

			if act.doer:HasTag("player") and act.target.components.equippable and not act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot) then
				act.doer.components.inventory:Equip(act.target)
			else
				act.doer.components.inventory:GiveItem(act.target, nil, act.target:GetPosition())
			end
			return true
		else
			return old_PICKUP(act)
		end
	end

	--防止玩家重置别人陷阱(狗牙)
	local old_RESETMINE = _G.ACTIONS.RESETMINE.fn 
	_G.ACTIONS.RESETMINE.fn = function(act)
		testActPrint(act)

		--防重置(狗牙)
		-- or act.target.prefab == "beemine" or act.target.prefab == "birdtrap"
		if act.target and (act.target.prefab == "trap_teeth") then
			-- 有权限时直接处理
			if CheckItemPermission(act.doer, act.target, true) then
				return old_RESETMINE(act)
			elseif act.doer:HasTag("player") then
				-- 主人不为自己并且物品受权限控制
				local doer_num = GetPlayerIndex(act.doer.userid)
				local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
				if master ~= nil then
					PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
					PlayerSay(master, GetSayMsg("item_use", act.doer.name, GetItemOldName(act.target), doer_num))
				else
					PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
				end
			end

			return false
		end

		return old_RESETMINE(act)
	end

	--防砍别人家的树(圣诞树等)
	local old_CHOP = _G.ACTIONS.CHOP.fn 
	_G.ACTIONS.CHOP.fn = function(act)
		testActPrint(act)

		if act.target then
			-- 普通树，判断周围建筑范围(12码)内是否有超过4颗属于同一主人的树
			if act.target.prefab == "evergreen" or act.target.prefab == "deciduoustree" or act.target.prefab == "twiggytree" then
				local leader = GetItemLeader(act.doer)

				if CheckItemPermission(leader, act.target) then
					return old_CHOP(act)
				elseif act.target.ownerlist and act.target.ownerlist.master ~= nil then
					local x, y, z = act.target.Transform:GetWorldPosition()
					local ents = TheSim:FindEntities(x, y, z, item_ScopePermission, { "tree" })
					local tree_num = 1
					if leader and leader.userid then
						for _,obj in pairs(ents) do
							if obj and obj ~= act.target and obj:HasTag("tree") and obj.ownerlist and obj.ownerlist.master == act.target.ownerlist.master then
								tree_num = tree_num + 1
							end
						end
					end

					if tree_num >= 5 then
						local doer_num = GetPlayerIndex(act.doer.userid)
						local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
						if master ~= nil then
							PlayerSay(leader, GetSayMsg("trees_chop_cant", master.name))
							PlayerSay(master, GetSayMsg("item_chop", leader.name, GetItemOldName(act.target), doer_num))
						else
							PlayerSay(leader, GetSayMsg("trees_chop_cant"))
						end

						return false
					end
				end
			--防砍(圣诞树等)
			elseif act.target.prefab == "winter_tree" or act.target.prefab == "winter_deciduoustree" or act.target.prefab == "winter_twiggytree" then
				local leader = GetItemLeader(act.doer)

				-- 有权限时直接处理
				if CheckItemPermission(leader, act.target) then
					return old_CHOP(act)
				elseif act.target == nil or act.target.ownerlist == nil or tablelength(act.target.ownerlist) == 0 or (cant_destroyby_monster and leader:HasTag("player") == false) then
					return old_CHOP(act)
					-- 不存在权限则判断周围建筑物
					--if CheckBuilderScopePermission(leader, act.target, get_msg(28)) then return old_CHOP(act) end
				elseif act.doer:HasTag("player") then
					-- 主人不为自己并且物品受权限控制
					local doer_num = GetPlayerIndex(act.doer.userid)
					local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
					if master ~= nil then
						PlayerSay(act.doer, GetSayMsg("item_chop_cant", master.name, GetItemOldName(act.target)))
						PlayerSay(master, GetSayMsg("item_chop", act.doer.name, GetItemOldName(act.target), doer_num))
					else
						PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
					end
				end

				return false
			end
		end

		return old_CHOP(act)
	end

	--打开建筑容器函数
	local old_RUMMAGE = _G.ACTIONS.RUMMAGE.fn 
	_G.ACTIONS.RUMMAGE.fn = function(act)
		testActPrint(act)
		--防装饰(圣诞树等)
		if act.target and (act.target.prefab == "winter_tree" or act.target.prefab == "winter_deciduoustree" or act.target.prefab == "winter_twiggytree") then
			-- 有权限时直接处理
			if CheckItemPermission(act.doer, act.target) then
				return old_RUMMAGE(act)
			elseif act.target == nil or act.target.ownerlist == nil or tablelength(act.target.ownerlist) == 0 or act.doer:HasTag("player") == false then
				-- 不存在权限则判断周围建筑物
				if CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("tree_open_cant")) then return old_RUMMAGE(act) end
			elseif act.doer:HasTag("player") then
				-- 主人不为自己并且物品受权限控制
				local doer_num = GetPlayerIndex(act.doer.userid)
				local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
				if master ~= nil then
					PlayerSay(act.doer, GetSayMsg("tree_open_cant", master.name))
					PlayerSay(master, GetSayMsg("item_open", act.doer.name, GetItemOldName(act.target), doer_num))
				else
					PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
				end
			end

			return false
		end

		return old_RUMMAGE(act)
	end

	--防止玩家砸别人物品
	local old_HAMMER = _G.ACTIONS.HAMMER.fn
	_G.ACTIONS.HAMMER.fn = function(act)
		testActPrint(act)
		--print(act.doer.name.."--HAMMER--"..act.target.prefab)
		if act.doer:HasTag("beaver") then
			return false
		end

		-- 远古祭坛只有管理员能拆
		if ancient_altar_no_destroy and act.target and act.target.prefab == "ancient_altar" and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
			PlayerSay(act.doer, GetSayMsg("noadmin_hammer_cant", GetItemOldName(act.target)))
			return false
		end

		--  未开启墙增强..直接可砸
		-- if table.contains(walls_state_config.walls_normal, act.target and act.target.prefab or "") then
		if walls_state_config.walls_normal[act.target and act.target.prefab or ""] then
			return old_HAMMER(act)
		end

		-- 防止玩家拆毁野外的猪人房/兔人房
		if house_plain_nodestroy and act.target and (act.target.ownerlist == nil or act.target.ownerlist.master == nil) and (act.target.prefab == "rabbithouse" or act.target.prefab == "pighouse") and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
			PlayerSay(act.doer, GetSayMsg("noadmin_hammer_cant", GetItemOldName(act.target)))
			return false
		end
		
		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) then
			if cant_destroyby_monster and act.target.cant_destroyedby_monster then
				act.target.components.workable = act.target.components.hammerworkable
			end

			local ret = old_HAMMER(act)
			
			if cant_destroyby_monster and act.target.cant_destroyedby_monster then
				act.target.components.workable = act.target.components.gd_workable
			end
			return ret
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			--if not cant_destroyby_monster then
				if master ~= nil then
					PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
					PlayerSay(master, GetSayMsg("item_smash", act.doer.name, GetItemOldName(act.target), doer_num))
				else
					PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
				end
			--end
		end

		return false
	end

	--防止玩家作祟别人东西
	local old_HAUNT = _G.ACTIONS.HAUNT.fn
	_G.ACTIONS.HAUNT.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) then
			return old_HAUNT(act)
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("item_haunt", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	--防止玩家魔法攻击别人的建筑
	local old_CASTSPELL = _G.ACTIONS.CASTSPELL.fn
	_G.ACTIONS.CASTSPELL.fn = function(act)
		testActPrint(act, act.target, act.invobject)
		--For use with magical staffs
		local staff = act.invobject or act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

		if staff and staff.components.spellcaster and staff.components.spellcaster:CanCast(act.doer, act.target, act.pos) then
			if act.target then
				-- 有权限时直接处理
				if CheckItemPermission(act.doer, act.target, true) then
					staff.components.spellcaster:CastSpell(act.target, act.pos)
					return true
				elseif act.doer:HasTag("player") then
					-- 主人不为自己并且物品受权限控制
					local doer_num = GetPlayerIndex(act.doer.userid)
					local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
					if master ~= nil then
						PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
						PlayerSay(master, GetSayMsg("item_spell", act.doer.name, GetItemOldName(act.target), doer_num))
					else
						PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
					end
				end

				-- 不存在权限则判断周围6码内建筑物
				-- if CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("buildings_spell_cant"), 6, act.pos) then
				-- 	staff.components.spellcaster:CastSpell(act.target, act.pos)
				-- 	return true
				-- end
			else
				staff.components.spellcaster:CastSpell(act.target, act.pos)
				return true
			end
		end
		return false
	end

	--别人建筑附近不能建造建筑
	local old_BUILD = _G.ACTIONS.BUILD.fn
	_G.ACTIONS.BUILD.fn = function(act)
		testActPrint(act, act.doer, act.recipe)
		if _G.TheWorld.ismastersim == false then return old_BUILD(act) end

		if admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false then --管理员直接可造
			return old_BUILD(act)
		end
		
		if not table.contains(config_item.cant_destroy_buildings, act.recipe) then --非建筑的话直接可造
			--print(act.doer.name.."--BUILD--"..act.recipe)
			return old_BUILD(act)
		end
		
		if not is_allow_build_near then
			if not CheckBuilderScopePermission(act.doer, act.target, "离别人建筑太近了，不能建造，需要权限！", item_ScopePermission) then return false end
		end
		-- if not is_allow_build_near then 
		-- 	local cant_build_radius = 12
		-- 	if cant_build_radius > 0 then 
		-- 		local ents = {}
		-- 		local x, y, z = act.doer.Transform:GetWorldPosition()
		-- 		ents = TheSim:FindEntities(x, y, z, cant_build_radius)
		-- 		for _,obj in ipairs(ents) do
		-- 			if (obj and obj:IsValid() and obj.ownerlist ~= nil ) and obj:HasTag("structure") and (obj.ownerlist.master == act.doer.userid or CheckFriend(obj.ownerlist.master, act.doer.userid)) == false then
		-- 				PlayerSay(act.doer, "离别人建筑太近了，不能建造，需要权限！")
		-- 				return false
		-- 			end
		-- 		end
		-- 	end
		-- end
		return old_BUILD(act)
	end

	--防挖别人的地皮
	local old_TERRAFORM = _G.ACTIONS.TERRAFORM.fn
	_G.ACTIONS.TERRAFORM.fn = function(act)
		testActPrint(act)
		if _G.TheWorld.ismastersim == false then return old_TERRAFORM(act) end
		if admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false then return old_TERRAFORM(act) end

		if act.target and CheckItemPermission(act.doer, act.target) or act.doer:HasTag("player") == false then return old_TERRAFORM(act)
		-- 不存在权限则判断周围建筑物
		elseif CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("buildings_dig_cant")) then return old_TERRAFORM(act) end

		return false
	end

	--右键开锁控制
	local old_TURNON = _G.ACTIONS.TURNON.fn
	_G.ACTIONS.TURNON.fn = function(act)
		testActPrint(act)
		if _G.TheWorld.ismastersim == false then return old_TURNON(act) end

		if act.target then
			if act.target.prefab == "firesuppressor" then
				-- 有权限时直接处理
				if CheckItemPermission(act.doer, act.target, true) then
					return old_TURNON(act)
				elseif act.doer:HasTag("player") then
					-- 主人不为自己并且物品受权限控制
					local doer_num = GetPlayerIndex(act.doer.userid)
					local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
					if master ~= nil then
						PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
						PlayerSay(master, GetSayMsg("item_use", act.doer.name, GetItemOldName(act.target), doer_num))
					else
						PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
					end
				end

				return false
			elseif act.target.prefab == "treasurechest" or act.target.prefab == "icebox" or act.target.prefab == "dragonflychest" or act.target.prefab == "cellar" or act.target.prefab == "storeroom" then
				if act.target.ownerlist ~= nil and act.target.ownerlist.master == act.doer.userid then
					PlayerSay(act.doer, "已开锁！任何人都能打开")
					return old_TURNON(act)
				else
					PlayerSay(act.doer, "可惜，我不能给它上锁和开锁！")
					return false
				end
			end
		end
		
		return old_TURNON(act)
	end

	--右键上锁控制
	local old_TURNOFF = _G.ACTIONS.TURNOFF.fn
	_G.ACTIONS.TURNOFF.fn = function(act)
		testActPrint(act)
		if _G.TheWorld.ismastersim == false then return old_TURNOFF(act) end

		if act.target then
			if act.target.prefab == "firesuppressor" then
				-- 有权限时直接处理
				if CheckItemPermission(act.doer, act.target, true) then
					return old_TURNOFF(act)
				elseif act.doer:HasTag("player") then
					-- 主人不为自己并且物品受权限控制
					local doer_num = GetPlayerIndex(act.doer.userid)
					local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
					if master ~= nil then
						PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
						PlayerSay(master, GetSayMsg("item_use", act.doer.name, GetItemOldName(act.target), doer_num))
					else
						PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
					end
				end

				return false
			elseif act.target and (act.target.prefab == "treasurechest" or act.target.prefab == "icebox" or act.target.prefab == "dragonflychest" or act.target.prefab == "cellar" or act.target.prefab == "storeroom") then
				if act.target.saved_ownerlist ~= nil and act.target.saved_ownerlist.master == act.doer.userid then   
					PlayerSay(act.doer, "已上锁！只有自己能打开")
					return old_TURNOFF(act)
				else
					PlayerSay(act.doer, "可惜，我不能给它上锁和开锁！")
					return false
				end
			end
		end
	
		return old_TURNOFF(act)
	end

	--开关门
	local old_ACTIVATE = _G.ACTIONS.ACTIVATE.fn
	_G.ACTIONS.ACTIVATE.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) or CheckWallActionPermission(act.target and act.target.prefab, 3) then
			return old_ACTIVATE(act)
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("permission_no", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("item_use", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	--危险的书
	local old_READ = _G.ACTIONS.READ.fn
	_G.ACTIONS.READ.fn = function(act)
		testActPrint(act, act.doer, act.target or act.invobject)

		local targ = act.target or act.invobject
		if targ ~= nil and (targ.prefab =="book_brimstone" or targ.prefab =="book_tentacles") then
			if not is_allow_build_near and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
				if not CheckBuilderScopePermission(act.doer, targ, "我不能在别人建筑附近这么做，需要权限！", item_ScopePermission) then return false end
			end
		end
		return old_READ(act)
	end

	--危险的道具
	local old_FAN = _G.ACTIONS.FAN.fn
	_G.ACTIONS.FAN.fn = function(act)
		testActPrint(act, act.doer, act.invobject)

		-- 幸运风扇
		if act.invobject and act.invobject.prefab =="perdfan" then
			if not is_allow_build_near and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
				if not CheckBuilderScopePermission(act.doer, act.target, "我不能在别人建筑附近这么做，需要权限！", item_ScopePermission) then return false end
			end
		end
		return old_FAN(act)
	end

	--危险的道具
	local old_BLINK = _G.ACTIONS.BLINK.fn
	_G.ACTIONS.BLINK.fn = function(act)
		testActPrint(act, act.doer, act.invobject)

		-- 瞬移魔杖
		if act.invobject.prefab =="orangestaff" then
			if not is_allow_build_near and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
				if not CheckBuilderScopePermission(act.doer, act.target, "我不能在别人建筑附近这么做，需要权限！", item_ScopePermission) then return false end
			end
		end
		return old_BLINK(act)
	end

	--防捕别人家的虫
	local old_NET = _G.ACTIONS.NET.fn
	_G.ACTIONS.NET.fn = function(act)
		testActPrint(act)

		-- 萤火虫
		if act.invobject.prefab =="fireflies" then
			if not is_allow_build_near and not (admin_option and act.doer.Network and act.doer.Network:IsServerAdmin() and test_mode == false) then
				if not CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("buildings_net_cant", act.doer.name, GetItemOldName(act.target)), item_ScopePermission) then return false end
			end
		end

		return old_NET(act)
	end

	--检测点燃动作是否有效
	local old_LIGHT = _G.ACTIONS.LIGHT.fn 
	_G.ACTIONS.LIGHT.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) then
			return old_LIGHT(act)
		elseif act.target == nil or act.target.ownerlist == nil or tablelength(act.target.ownerlist) == 0 or (cant_destroyby_monster and act.doer:HasTag("player") == false) then
			-- 不存在权限则判断周围建筑物
			if CheckBuilderScopePermission(act.doer, act.target, GetSayMsg("buildings_light_cant")) then return old_LIGHT(act) end
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("item_light_cant", master.name))
				PlayerSay(master, GetSayMsg("item_light", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	-- --防止玩家采别人的花
	-- AddComponentPostInit("pickable", function(Pickable, target)
	--     Pickable.oldPickFn = Pickable.Pick
	--     --if _G.TheWorld.ismastersim == false then return Pickable:oldPickFn(doer) end
	-- 	if _G.TheWorld.ismastersim then
	-- 		function Pickable:Pick(doer)
	-- 			if target and target.prefab == "flower" then
	-- 				-- 有权限时直接处理
	-- 				if CheckItemPermission(doer, target) then
	-- 					return Pickable:oldPickFn(doer)
	-- 				elseif target == nil or target.ownerlist == nil or tablelength(target.ownerlist) == 0 or doer:HasTag("player") == false then
	-- 					-- 不存在权限则判断周围建筑物
	-- 					if CheckBuilderScopePermission(doer, target, get_msg(31)) then return Pickable:oldPickFn(doer) end
	-- 				elseif doer:HasTag("player") then
	-- 					-- 主人不为自己并且物品受权限控制
	-- 					local doer_num = GetPlayerIndex(doer.userid)
	-- 					local master = GetPlayerById(target.ownerlist and target.ownerlist.master or nil)
	-- 					if master ~= nil then
	-- 						PlayerSay(doer, "这是（"..master.name.."）的花，我不能采！")
	-- 						PlayerSay(master, get_msg(21,{doer.name,GetItemOldName(target),doer_num}))
	-- 					else
	-- 						PlayerSay(doer, get_msg(22))
	-- 					end
	-- 				end

	-- 				return false
	-- 			end
	-- 			return Pickable:oldPickFn(doer)
	-- 		end
	-- 	end
	-- end)

	--防止玩家打开别人的容器
	AddComponentPostInit("container", function(Container, target)
		local old_OpenFn = Container.Open
		function Container:Open(doer)
			testActPrint(nil, doer, target, "Open", "打开容器")

			-- 有权限时直接处理
			if CheckItemPermission(doer, target, true) or target.prefab == "cookpot" then
				return old_OpenFn(self, doer)
			elseif doer:HasTag("player") then
				-- 主人不为自己并且物品受权限控制
				local doer_num = GetPlayerIndex(doer.userid)
				local master = target.ownerlist and GetPlayerById(target.ownerlist.master) or nil
				if master ~= nil then
					PlayerSay(doer, GetSayMsg("permission_no", master.name, GetItemOldName(target)))
					PlayerSay(master, GetSayMsg("item_open", doer.name, GetItemOldName(target), doer_num))
				else
					PlayerSay(doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(target.ownerlist)))
				end
			end
		end
	end)

	-- 查看物品
	local old_LOOKAT = _G.ACTIONS.LOOKAT.fn 
	_G.ACTIONS.LOOKAT.fn = function(act)
		testActPrint(act)

		if act.target and act.target.prefab == "beefalo" and act.target.ownerlist ~= nil then
			-- PlayerSay(act.doer, "这头牛的当前状态: \n" .. GetBeefaloInfoString(act.target, act.target.components.rideable:IsBeingRidden()))
			local colour = {0.6, 0.9, 0.8, 1}
			-- colour[1],colour[2],colour[3] = _G.HexToPercentColor("#E80607")
			PlayerColorSay(act.doer, "这头牛的当前状态: \n" .. GetBeefaloInfoString(act.target, act.target.components.rideable:IsBeingRidden()), colour)
			return true
		end

		return old_LOOKAT(act)
	end
end
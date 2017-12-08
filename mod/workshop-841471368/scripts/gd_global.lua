local _G = GLOBAL
local TheSim = _G.TheSim
local TheNet = _G.TheNet
local TheShard = _G.TheShard
local TheInput = _G.TheInput
local getmetatable = _G.getmetatable

local SpawnPrefab = _G.SpawnPrefab
local FindValidPositionByFan = _G.FindValidPositionByFan

local ACTIONS = _G.ACTIONS
local FRAMES = _G.FRAMES
local PI = _G.PI
local GROUND = _G.GROUND
-- local GROUND_FLOORING = _G.GROUND_FLOORING

-- 测试模式
local test_mode = GetModConfigData("test_mode")
-- 权限模式
local permission_mode = GetModConfigData("permission_mode")
-- 管理员是否不受权限控制
local admin_option = GetModConfigData("admin_option")
-- 防止怪物摧毁建筑
local cant_destroyby_monster = GetModConfigData("cant_destroyby_monster")
-- 农作物防挖范围
local firesuppressor_dig = GetModConfigData("firesuppressor_dig")
--远古犀牛是否允许拆家
local minotaur_destroy = GetModConfigData("minotaur_destroy")
-- 保存权限的物品
local permission_prefabs = {}
config_item = _G.require("config_item")

-- 设置所有者名
function SetOwnerName(inst, master)
	if inst ~= nil and inst:IsValid() then
		local userid = inst.ownerlist ~= nil and inst.ownerlist.master or master
		if inst.components.named ~= nil then
			if userid ~= nil then
				local ownerName = GetPlayerNameByOwnerlist({ master = userid })
				if ownerName ~= nil then
					if inst.oldName == nil then
						inst.oldName = inst.name
					end
					inst.components.named:SetName((inst.oldName or inst.name or "") .. "\n" .. GetSayMsg("item_master_to", ownerName))
				end
			else
				inst.components.named:SetName(nil)
			end
		end
	end
end

-- 设置物品名称
function SetItemAppendName(inst, appendName)
	if inst ~= nil and inst:IsValid() then
		if inst.components.named == nil then
			inst:AddComponent("named")
			inst.oldName = inst.name
		end

		if appendName ~= nil then
			if inst.oldName == nil then
				inst.oldName = inst.name
			end
			inst.components.named:SetName((inst.oldName or inst.name or "") .. "\n" .. appendName)
		else
			inst.components.named:SetName(nil)
		end
	end
end

-- 获取物品原始名称
function GetItemOldName(inst)
	return inst.oldName or inst.name
end

-- 设置权限物品烧的权限和防摧毁等
function SetItemPermissionDestroy(item, master)
	if item ~= nil and item:IsValid() and not item:HasTag("tree") then
		local userid = item.ownerlist ~= nil and item.ownerlist.master or master
		if userid ~= nil then
			RemoveBurnable(item)
			if item.gd_superlevel == nil then
				local itemPrefab = item.prefab

				-- 安置物无敌(超级墙类)
				if walls_state_config.walls_power[itemPrefab] then
					makeDeployCantAttack(item)
				-- 普通墙什么也不做
				elseif cant_destroyby_monster and walls_state_config.walls_normal[itemPrefab] == nil then
					if item.components.health ~= nil or config_item.deploys_cant_table[itemPrefab] then
						-- 安置物无敌(有生命值的物体,列表中指定的物品,墙类)
						makeDeployCantAttack(item)
					elseif config_item.winter_trees_table[itemPrefab] then
						-- 树无敌
						makeWinterTreeCantAttack(item)
					elseif item.components.workable ~= nil then
						local workAction = item.components.workable:CanBeWorked() and item.components.workable:GetWorkAction()
						if workAction == ACTIONS.HAMMER then
							--设置不可被摧毁
							makeCantWorkale(item)
						else
							makeWinterTreeCantAttack(item)
						end
					end
				end
			end
		else
			AddBurnable(item)
			if cant_destroyby_monster then
				makeRemoveCantWorkale(item)
			end
		end
	end
end

-----权限保存与加载----
function SaveAndLoadChanged(inst)
	permission_prefabs[inst.prefab] = true

	if inst.components.named == nil and not inst:HasTag("player") then
		inst:AddComponent("named")
		inst.oldName = inst.name
	end

	local OldOnSave=inst.OnSave
	inst.OnSave = function(inst,data)
		if OldOnSave~=nil then
			OldOnSave(inst,data)
		end
		if inst.ownerlist ~= nil then
			data.ownerlist = inst.ownerlist
		end
		if inst.saved_ownerlist ~= nil then 
			data.saved_ownerlist = inst.saved_ownerlist
		end
	end
	
	local OldOnLoad=inst.OnLoad
	inst.OnLoad = function(inst,data)
		if OldOnLoad~=nil then
			OldOnLoad(inst,data)
		end
		if data ~= nil then 
			if data.ownerlist ~= nil then
				inst.ownerlist = data.ownerlist
				SetOwnerName(inst)
				SetItemPermissionDestroy(inst)
			end
			
			if data.saved_ownerlist ~= nil then
				inst.saved_ownerlist = data.saved_ownerlist
				SetOwnerName(inst, inst.saved_ownerlist.master)
				SetItemPermissionDestroy(inst, inst.saved_ownerlist.master)
			end
		end
	end
end

-- 对物品权限进行保存和加载
function SavePermission(inst)
	local prefab = type(inst) == "string" and inst or inst.prefab
	AddPrefabPostInit(prefab, function(inst)
		SaveAndLoadChanged(inst)
	end)
end

-- 为所有自定义物品加上权限
AddPrefabPostInitAny(function(inst)
	if _G.TheWorld.guard_authorization ~= nil and _G.TheWorld.guard_authorization.custom_prefabs ~= nil and _G.TheWorld.guard_authorization.custom_prefabs[inst.prefab] then
		SaveAndLoadChanged(inst)
	end
end)

-- 检查物品是否有进行保存和加载权限
function IsPermission(inst)
	if type(inst) == "string" then
		return permission_prefabs[inst]
	else
		return permission_prefabs[inst.prefab]
	end
end

-- 说话
function PlayerSay(player, msg, delay, duration, noanim, force, nobroadcast, colour)
	if player ~= nil and player.components.talker then
		player:DoTaskInTime(delay or 0.01, function ()
			player.components.talker:Say(msg, duration or 2.5, noanim, force, nobroadcast, colour)
		end)
	end
end

-- 带颜色渲染的话
function PlayerColorSay(player, msg, colour, delay, duration)
	PlayerSay(player, msg, delay, duration, nil, nil, nil, colour)
end

-- 将坐标点对象拆分成x y z返回
function GetSplitPosition(pos)
	return pos.x, pos.y, pos.z
end

-- 放置物体到指定位置
function ItemSetPosition(doer, x, y, z, isDoerNotSetPos, isAnim)
	if not isDoerNotSetPos then
		if doer.Physics ~= nil then
			doer.Physics:Teleport(x, y, z)
		else
			doer.Transform:SetPosition(x, y, z)
		end
	end

	if doer.components.leader ~= nil then
		for follower, v in pairs(doer.components.leader.followers) do
			if isAnim == false then
				ItemSetPosition(follower, x, y, z, false)
			else
				ItemAnimSetPosition(follower, x, y, z, false, false)
			end
		end
	end
end

-- 放置物体到指定位置(动画)
function ItemAnimSetPosition(doer, x, y, z, isDoerNotSetPos, isEndAnim)
	if not isDoerNotSetPos then
		local doX, doY, doZ = doer.Transform:GetWorldPosition()
		if doX ~= nil then
			local start_fx = SpawnPrefab("spawn_fx_medium")
			if start_fx ~= nil then
				start_fx.Transform:SetPosition(doX, doY, doZ)
			end
		end
		if doX ~= nil and doer.components.colourtweener then
			local colour_r, colour_g, colour_b, alpha = doer.AnimState:GetMultColour()
			doer.components.colourtweener:StartTween({ 0, 0, 0, 1 }, 19 * FRAMES, function()
				if isEndAnim then
					local end_fx = SpawnPrefab("spawn_fx_medium")
					if end_fx ~= nil then
						end_fx.Transform:SetPosition(x, y, z)
					end
				end
				doer.AnimState:SetMultColour(colour_r, colour_g, colour_b, alpha)
				ItemSetPosition(doer, x, y, z, isDoerNotSetPos, true)
			end)
		else
			if isEndAnim then
				local end_fx = SpawnPrefab("spawn_fx_medium")
				if end_fx ~= nil then
					end_fx.Transform:SetPosition(x, y, z)
				end
			end
			ItemSetPosition(doer, x, y, z, isDoerNotSetPos, true)
		end
	else
		ItemSetPosition(doer, x, y, z, isDoerNotSetPos, true)
	end
end

-- 获取物体周围一个随机范围内有效的地形
function GetFanValidPoint(position, minRadiu, maxRadiu, attempts)
	local theta = math.random() * 2 * PI
	local radius = math.random(minRadiu or 8, maxRadiu or 15)
	local attempts = attempts or 30
	local result_offset = FindValidPositionByFan(theta, radius, attempts, function(offset)
		local run_point = position+offset
		local tile = _G.TheWorld.Map:GetTileAtPoint(run_point.x, run_point.y, run_point.z)
		if tile == GROUND.IMPASSABLE or tile == GROUND.INVALID or tile >= GROUND.UNDERGROUND then
			return false
		end
		return true
	end)
	if result_offset ~= nil then
		local pos = position + result_offset
		return pos
	end
end

-- 检查是否为朋友
function CheckFriend(masterId, guestId)
	-- if type(master) == "string" then
	-- 	master = GetPlayerById(master)
	-- end
	-- return master and master.friends[guestId]
	if masterId == nil or guestId == nil then return false end

	-- _G.TheWorld.guard_authorization ~= nil and _G.TheWorld.guard_authorization[masterId] ~= nil
	--return _G.TheWorld.guard_authorization[masterId].friends and _G.TheWorld.guard_authorization[masterId].friends[guestId]
	return _G.TheWorld.guard_authorization ~= nil and _G.TheWorld.guard_authorization[masterId] ~= nil and _G.TheWorld.guard_authorization[masterId].friends and _G.TheWorld.guard_authorization[masterId].friends[guestId]
end

-- 设置物体权限
function SetItemPermission(item, player, forer)
	-- 处理mod物品等
	if not IsPermission(item) and _G.TheWorld.guard_authorization ~= nil and item.prefab ~= nil then
		if _G.TheWorld.guard_authorization.custom_prefabs == nil then
			_G.TheWorld.guard_authorization.custom_prefabs = {}
		end

		_G.TheWorld.guard_authorization.custom_prefabs[item.prefab] = true
		for _,v in pairs(_G.Ents) do
			if v.prefab == item.prefab then
				SaveAndLoadChanged(v)
			end
		end
	end

	--item.ownerlist = { friends = {} }
	if item.ownerlist == nil then
		item.ownerlist = {}
	else
		item.saved_ownerlist = nil
	end
	--item.saveTaglist = {}
	if player ~= nil or forer == nil then
		item.ownerlist.master = type(player) == "string" and player or (player ~= nil and player.userid or nil)
		SetOwnerName(item)
		SetItemPermissionDestroy(item)
	end
	if forer ~= nil then
		item.ownerlist.forer = type(forer) == "string" and forer or forer.userid
	end
	--item.ownerlist.friends = player.friends --不再需要这一步
	--item.ownerlist[player.userid] = 1
	--item:AddTag("userid_"..player.userid)
	--item.saveTaglist[player.userid] = 1
	
	-- if  player.friends ~= nil then --如果有盆友，则盆友也可使用
	-- 	for friend,_ in pairs(player.friends) do
	-- 		--item:AddTag("userid_"..friend)
	-- 		--item.saveTaglist[friend] = 1
	-- 		item.ownerlist.friends[friend] = 1
	-- 	end
	-- end
end

-- 获取物品主人
function GetItemLeader(item)
	--如果有主人,取主人的权限
	if item ~= nil then
		if item.components.follower ~= nil and item.components.follower.leader ~= nil and item.components.follower.leader:HasTag("player") then
			return item.components.follower.leader
		elseif item.ownerlist ~= nil and item.ownerlist.master ~= nil then
			return GetPlayerById(item.ownerlist.master) or item
		end
	end

	return item
end

-- 判断权限
function CheckPermission(ownerlist, guest, isForer)
	-- 关闭权限验证则直接返回true
	if permission_mode == false then return true end
	-- 目标没有权限直接返回true
	if ownerlist == nil or ownerlist.master == nil then return true end
	local guestId = type(guest) == "string" and guest or (guest and guest.userid or nil)
	-- 主人为自己时直接返回true
	if guestId and (ownerlist.master == guestId or CheckFriend(ownerlist.master, guestId) or (isForer and ownerlist.forer == guestId)) then return true end

	return false
end

-- 判断物品权限
function CheckItemPermission(player, target, isNoMaster, isForer)
	-- 主机直接返回true
	if _G.TheWorld.ismastersim == false then return true end
	-- 玩家不存在或目标不存在直接返回true
	if player == nil or target == nil then return true end
	-- 管理员直接返回true
	if admin_option and player.Network and player.Network:IsServerAdmin() and test_mode == false then return true end
	if target.ownerlist ~= nil and tablelength(target.ownerlist) > 0 then
		--主人为自己时直接返回true
		-- if player.userid and (target.ownerlist.master == player.userid or CheckFriend(target.ownerlist.master, player.userid) or target.ownerlist.forer == player.userid) then
		-- 	return true
		-- end

		-- 有权限则返回true
		if CheckPermission(target.ownerlist, player, isForer) then return true end
	else
		return isNoMaster ~= nil and isNoMaster or false
	end

	return false
end

-- 判断建筑范围内权限
function CheckBuilderScopePermission(player, item, msg, scopePermission, pos)
	-- 关闭权限验证则直接返回true
	if permission_mode == false then return true end
	if scopePermission == nil then
		scopePermission = firesuppressor_dig
	end
	
	--主人不为自己时，判断周围有无别人的建筑群，如果有则不可执行，否则可执行
	if scopePermission > 0 then 
		local ents = {}
		local x, y, z
		if pos ~= nil then
			x, y, z = GetSplitPosition(pos)
		else
			x, y, z = (item and item or player).Transform:GetWorldPosition()
		end
		ents = TheSim:FindEntities(x, y, z, scopePermission, nil, nil, { "structure", "wall" })
		local mystructure_num = 0
		local structure_num = 0
		if player and player.userid then
			for _,obj in pairs(ents) do
				--print("找到["..obj.name.."]")
				if obj and obj.ownerlist then
					if obj:HasTag("structure") or obj:HasTag("wall") then
						--print("找到["..obj.name.."]它属于:"..obj.ownerlist.master)
						if obj.ownerlist.master == player.userid or CheckFriend(obj.ownerlist.master, player.userid) then
							mystructure_num = mystructure_num + 1
						else
							--if obj and obj.ownerlist and obj:HasTag("structure") and player and player.userid and (obj:HasTag("userid_"..player.userid) == false) then
							structure_num = structure_num + 1
						end
					end
				end
			end
		end

		if structure_num >= 2 and structure_num > mystructure_num then 
			-- player:DoTaskInTime(0, function ()
			-- 	--player.components.talker:Say("在别人的建筑群范围内，我需要权限！")
			-- 	player.components.talker:Say(msg)
			-- end)
			PlayerSay(player, msg)
			return false
		end
	end

	return true
end

-- 移除指定文件监听方法并返回原始Fn
function RemoveEventCallbackEx(inst, event, filepath, source)
	source = source or inst
	local old_event_key, old_event = nil, nil

	-- 移除指定监听方法
	if source.event_listeners ~= nil and source.event_listeners[event] ~= nil and source.event_listeners[event][inst] ~= nil then
		--print("find event begin")
		for i, fn in ipairs(source.event_listeners[event][inst]) do
			local info = _G.debug.getinfo(fn,"LnS")
			if string.find(info.source, filepath) then
				old_event_key = i
				old_event = fn
				break
				--print(string.format("      %s = function - %s", i, info.source..":"..tostring(info.linedefined)))
			end
			
		end
		--print("find event end")
	end

	-- 移除指定监听方法
	if old_event ~= nil and source.event_listeners ~= nil and source.event_listeners[event] ~= nil and source.event_listeners[event][inst] ~= nil then
		-- source.event_listening[event][inst] = nil
		-- source.event_listeners[event][inst] = nil
		-- source.event_listening[event][inst][old_event_key] = OnEvent
		-- source.event_listeners[event][inst][old_event_key] = OnEvent
		inst:RemoveEventCallback(event, old_event, source)
	end

	return old_event
end

--移除可燃烧属性
function RemoveBurnable(inst)
	-- if _G.TheWorld.ismastersim then
		if inst and not inst.gd_lightremoved and inst.components.burnable ~= nil then
			inst.gd_lightremoved = true
			if inst:HasTag("canlight") then
				inst.canlight = true
				inst:RemoveTag("canlight")
			end
			if inst:HasTag("nolight") then
				inst.nolight = true
			else
				inst:AddTag("nolight")
			end
			if inst.components.fueled == nil then
				if inst:HasTag("fireimmune") then
					inst.fireimmune = true
				else
					inst:AddTag("fireimmune")
				end
			end
		end
	-- end
end

-- 添加可燃烧属性
function AddBurnable(inst)
	if inst and inst.gd_lightremoved and inst.components.burnable ~= nil then
		inst.gd_lightremoved = nil
		if inst.canlight then
			inst:AddTag("canlight")
		end
		if not inst.nolight then
			inst:RemoveTag("nolight")
		end
		if not inst.fireimmune then
			inst:RemoveTag("fireimmune")
		end
	end
end

--让物品不起作用的函数（用于防止怪物摧毁建筑）
function makeCantWorkale(inst)
	-- _G.TheWorld.ismastersim
	if inst.components.workable ~= nil then
	-- 	inst:DoTaskInTime(1, function()
			--inst:RemoveComponent("workable")
			--inst:AddTag("cant_destroyedby_monster")
			inst.gd_superlevel = 1
			inst.cant_destroyedby_monster = true
			if inst.components.gd_workable == nil then
				inst:AddComponent("gd_workable")
				if inst.components.workable then
					inst.components.gd_workable.maxwork = inst.components.workable.maxwork
					inst.components.gd_workable.workleft = inst.components.workable.workleft
				end
			end
			--print(tostring(inst.components.gd_workable))
			inst.components.hammerworkable = inst.components.workable
			inst.components.workable = inst.components.gd_workable
			-- if inst.components.workable then
			-- 	-- print("打印action")
			-- 	-- _G.dumptable(inst.components.workable.action, 1, 10)

			-- 	inst.iniworkleft = inst.components.workable.workleft
			-- 	inst.workleft = inst.iniworkleft
			-- 	inst.components.workable.old_onwork = inst.components.workable.onwork
			-- 	local function onwork(inst, worker, workleft)
			-- 		testActPrint(nil, worker, inst, "onwork", "工作")
					
			-- 		-- 有权限时直接处理..主机或管理员直接可工作
			-- 		if CheckItemPermission(worker, inst, true) then
			-- 			inst.islastworkvalid=true
			-- 			inst.components.workable.destroyed=true
			-- 			inst.workleft=workleft
			-- 		else
			-- 			inst.islastworkvalid=false
			-- 			inst.components.workable.destroyed=false
			-- 			inst.components.workable.workleft=inst.workleft
			-- 			if worker:HasTag("player") then
			-- 				local doer_num = GetPlayerIndex(worker.userid)
			-- 				local master = GetPlayerById(inst.ownerlist and inst.ownerlist.master or nil)
			-- 				if master ~= nil then
			-- 					PlayerSay(worker, get_msg(29,{master.name,inst.name}))
			-- 					PlayerSay(master, get_msg(17,{worker.name,inst.name,doer_num}))
			-- 				else
			-- 					PlayerSay(worker, get_msg(22))
			-- 				end
			-- 			end
			-- 		end
			-- 	end
			-- 	inst.components.workable:SetOnWorkCallback(onwork)
			-- end
	-- 	end)
	end
end

--使墙/栅栏/门/植物等被攻击无效
function makeDeployCantAttack(inst)
	-- _G.TheWorld.ismastersim
	if inst.components.workable ~= nil then
		-- inst:DoTaskInTime(1, function()
			inst.gd_superlevel = 2
			inst.iniworkleft = inst.components.workable.workleft
			inst.workleft = inst.iniworkleft
			inst.components.workable.old_onwork = inst.components.workable.onwork
			local function onwork(inst, worker, workleft)
				testActPrint(nil, worker, inst, "onwork", "工作")

				local leader = GetItemLeader(worker)
				
				-- 有权限时直接处理..主机或管理员直接可攻击
				if CheckItemPermission(leader, inst, true) or ((leader:HasTag("player") and CheckWallActionPermission(inst.prefab, 1)) or (leader:HasTag("player") == false and CheckWallActionPermission(inst.prefab, 2))) or (minotaur_destroy and worker.prefab == "minotaur") then
					inst.islastworkvalid=true
					inst.components.workable.destroyed=true
					if inst.avghealth == nil or inst.components.health == nil or inst.components.health.currenthealth == 0 then
						inst.workleft = workleft
						if inst.components.workable.old_onwork ~= nil then
							inst.components.workable.old_onwork(inst, worker, workleft)
						end
					else
						inst.workleft = math.max(1, workleft)
						inst.components.workable.workleft = inst.workleft
						if inst.components.health.currenthealth % inst.avghealth ~= 0 then
							inst.components.health.currenthealth = inst.components.health.currenthealth - inst.components.health.currenthealth % inst.avghealth
						else
							inst.components.health.currenthealth = inst.components.health.currenthealth - inst.avghealth
						end
						inst.components.health.old_ondelta(inst, inst.currenthealth / inst.components.health.maxhealth, inst.components.health:GetPercent())
						inst.currenthealth = inst.components.health.currenthealth
					end
				else
					inst.islastworkvalid=false
					inst.components.workable.destroyed=false
					inst.components.workable.workleft=inst.workleft
					if worker:HasTag("player") and inst:HasTag("wall") then
						local doer_num = GetPlayerIndex(worker.userid)
						local master = GetPlayerById(inst.ownerlist and inst.ownerlist.master or nil)
						if master ~= nil then
							PlayerSay(worker, GetSayMsg("item_smash_cant", master.name, GetItemOldName(inst)))
							PlayerSay(master, GetSayMsg("item_smash", worker.name, GetItemOldName(inst), doer_num))
						else
							PlayerSay(worker, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(inst.ownerlist)))
						end
					end
				end
			end
			inst.components.workable:SetOnWorkCallback(onwork)

			-- 墙体处理
			if inst.components["health"] and inst.components.health.ondelta then
				inst.maxhealth = inst.components.health.maxhealth
				inst.avghealth = 0.25 * inst.maxhealth
				inst.currenthealth = inst.components.health.currenthealth
				inst.components.health.old_ondelta = inst.components.health.ondelta
				inst.components.health.ondelta = function(inst, old_percent, new_percent)
					local worker = inst.components.combat and inst.components.combat.lastattacker
					testActPrint(nil, worker, inst, "ondelta", "生命值改变")

					local leader = GetItemLeader(worker)

					-- 无条件允许修补
					if inst.components.health.currenthealth > inst.currenthealth or ((leader ~= nil and leader:HasTag("player") and CheckWallActionPermission(inst.prefab, 1)) or ((leader == nil or leader:HasTag("player") == false) and CheckWallActionPermission(inst.prefab, 2))) then
						inst.currenthealth = inst.components.health.currenthealth
						if inst.components.health.old_ondelta ~= nil then
							inst.components.health.old_ondelta(inst, old_percent, new_percent)
						end
					end

					inst.components.health.currenthealth = inst.currenthealth

					-- -- 主机或管理员直接可攻击(此处有问题未完善..无法获得当前攻击对象和被攻击对象)
					-- if not ((_G.TheWorld.ismastersim == false) or (admin_option and worker.Network:IsServerAdmin() and test_mode == false) or (inst and (inst.ownerlist == nil or tablelength(inst.ownerlist) == 0 or (worker.userid and inst:HasTag("userid_"..worker.userid))))) then
					-- 	inst.components.health.currenthealth = inst.currenthealth
					-- 	if worker:HasTag("player") and worker.components.talker then
					-- 		worker:DoTaskInTime(0, function ()
					-- 			--worker.components.talker:Say("这是别人家的墙，我砸不动！")
					-- 			worker.components.talker:Say(get_msg(29))
					-- 		end)
					-- 	end
					-- end
					-- inst.components.health.old_ondelta(inst, old_percent, new_percent)
				end
			end
		-- end)
	end
end

--使盆栽攻击无效
function makeWinterTreeCantAttack(inst)
	-- if _G.TheWorld.ismastersim then
	-- 	inst:DoTaskInTime(1, function()
			inst.gd_superlevel = 3
			inst.iniworkleft = inst.components.workable.workleft
			inst.workleft = inst.iniworkleft
			inst.components.workable.old_onwork = inst.components.workable.onwork
			local function onwork(inst, worker, workleft)
				testActPrint(nil, worker, inst, "onwork", "工作")

				local leader = GetItemLeader(worker)
				
				--_G.dumptable(inst.components.workable, 1, 10)
				-- or not (inst.prefab == "winter_tree" or inst.prefab == "winter_deciduoustree" or inst.prefab == "winter_twiggytree")
				-- 有权限时直接处理..主机或管理员直接可攻击
				if CheckItemPermission(leader, inst, true) then
					if inst.components.workable.old_onwork ~= nil then
						inst.components.workable.old_onwork(inst, worker, workleft)
					end
					inst.workleft=inst.components.workable.workleft
				else
					inst.components.workable.workleft=inst.workleft
					-- if worker:HasTag("player") then
					-- 	local doer_num = GetPlayerIndex(worker.userid)
					-- 	local master = GetPlayerById(inst.ownerlist and inst.ownerlist.master or nil)
					-- 	if master ~= nil then
					-- 		PlayerSay(worker, "这是（"..master.name.."）的树，我不能砍！")
					-- 		PlayerSay(master, get_msg(34,{worker.name,inst.name,doer_num}))
					-- 	else
					-- 		PlayerSay(worker, get_msg(22,{GetPlayerNameByOwnerlist(inst.ownerlist)}))
					-- 	end
					-- end
				end
			end
			inst.components.workable:SetOnWorkCallback(onwork)
	-- 	end)
	-- end
end

function makeRemoveCantWorkale(inst)
	inst.gd_superlevel = nil
	inst.cant_destroyedby_monster = false
	if inst.components.hammerworkable ~= nil then
		inst.components.workable = inst.components.hammerworkable
	end

	if inst.components.workable ~= nil and inst.components.workable.old_onwork ~= nil then
		inst.components.workable.new_onwork = inst.components.workable.onwork
		inst.components.workable:SetOnWorkCallback(inst.components.workable.old_onwork)
	end

	if inst.components.health ~= nil and inst.components.health.old_ondelta ~= nil then
		inst.components.health.new_ondelta = inst.components.health.ondelta
		inst.components.health.ondelta = inst.components.health.old_ondelta
	end
end

function strFindInTable(str, T)
  for k,v in ipairs(T) do
  	if string.find(str, v) then
		return true
	end
  end
  return false
end

function FindTableValueIndex(tb, value)
	for k,v in ipairs(tb) do
		if v == value then 
			return n
		end
	end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function print_lua_table (lua_table, indent)
	indent = indent or 0
	for k, v in pairs(lua_table) do
		if type(k) == "string" then
			k = string.format("%q", k)
		end
		local szSuffix = ""
		if type(v) == "table" then
			szSuffix = "{"
		end
		local szPrefix = string.rep("	", indent)
		formatting = szPrefix.."["..tostring(k).."]".." = "..szSuffix
		if type(v) == "table" then
			print(formatting)
			print_lua_table(v, indent + 1)
			print(szPrefix.."},")
		else
			local szValue = ""
			if type(v) == "string" then
				szValue = string.format("%q", v)
			else
				szValue = tostring(v)
			end
			print(formatting..szValue..",")
		end
	end
end

function testActPrint(act, doer, target, actName, actDes)
	if test_mode then
		if act ~= nil then
			if doer == nil then
				doer = act.doer
			end

			if target == nil then
				target = act.target
			end

			if act.action ~= nil and act.action ~= nil then
				if actName == nil then
					actName = act.action.id
				end

				if actDes == nil then
					actDes = act:GetActionString()
				end
			end
		end

		if actName == nil then
			actName = "[未知操作id]"
		end

		if actDes == nil then
			actDes = "[未知操作]"
		end

		print((doer and doer.name .."(".. doer.prefab ..")" or "[未知]").."--"..actName.."--"..(target and (target.prefab and GetItemOldName(target) .."(".. target.prefab ..")" or "[无效的类名]")..("--"..actDes.."--ownerlist:"..tostring(target.ownerlist).." ownerlist数量:"..(target.ownerlist and tablelength(target.ownerlist) or "[无效的对象]")) or "target对象不存在"))
		--print("["..(doer and doer.userid and doer.userid or "无效的ID").."]HasTag:"..(doer and doer.userid and target and tostring(target:HasTag("userid_"..doer.userid)) or "false"))
		print("["..(doer and doer.userid and doer.userid or "无效的ID").."]HasTag:"..(doer and doer.userid and target and tostring(CheckItemPermission(doer, target)) or "false"))
		print("IsPlayer:"..tostring(doer and doer:HasTag("player")))
	end
end

if test_mode then
    print("打印TheSim函数")
	for k, v in pairs(getmetatable(TheSim).__index) do print(k, v) end

	print("打印TheNet函数")
	for k, v in pairs(getmetatable(TheNet).__index) do print(k, v) end

	print("打印TheShard函数")
	for k, v in pairs(getmetatable(TheShard).__index) do print(k, v) end

	print("打印TheInput函数")
	for k, v in pairs(getmetatable(TheInput).__index) do print(k, v) end
end
local _G = GLOBAL
local TheNet = _G.TheNet
local SpawnSaveRecord = _G.SpawnSaveRecord
local SpawnPrefab = _G.SpawnPrefab

local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local TUNING = _G.TUNING
local TENDENCY = _G.TENDENCY

local beefalo_power = GetModConfigData("beefalo_power")

if IsServer then
	if beefalo_power then
		-- 将牛抖落鞍的服从度从40%调整为1%
		TUNING.BEEFALO_KEEP_SADDLE_OBEDIENCE = 0.01
		-- 设置骑牛所需的最小服从度
		TUNING.BEEFALO_MIN_BUCK_OBEDIENCE = 0.01

		local Rideable = _G.require("components/rideable")
		local old_Buck = Rideable.Buck
		--在服从度大于0时防止玩家被自己的坐骑抖落
		function Rideable:Buck(gentle, isbuck)
			local obedience = 0
			if self.inst.components.domesticatable ~= nil and self.inst.components.domesticatable.GetObedience ~= nil then
				obedience = self.inst.components.domesticatable:GetObedience()
			end

			--print(string.format("onbuck 服从: %s", obedience))
			if self.rider ~= nil and self.rider.components.rider ~= nil and ((obedience == 0 or self.inst.ownerlist == nil) or self.inst.components.health:IsDead() or isbuck) then
				self.rider:PushEvent("bucked", { gentle = gentle })
			end
		end
		-- local old_SetSaddle = Rideable.SetSaddle
		-- function Rideable:SetSaddle(doer, newsaddle)
		-- 	--print("setting saddle to "..(newsaddle.prefab or 'nil'))
		-- 	local obedience = 0
		-- 	if self.inst.components.domesticatable ~= nil and self.inst.components.domesticatable.GetObedience ~= nil then
		-- 		obedience = self.inst.components.domesticatable:GetObedience()
		-- 	end
		-- 	--print(string.format("服从: %s", obedience))
		-- 	if self.saddle ~= nil and (obedience == 0 or self.inst.ownerlist == nil) then
		--         self.inst.AnimState:ClearOverrideSymbol("swap_saddle")

		--         self.inst:RemoveChild(self.saddle)
		--         self.saddle:ReturnToScene()

		--         local pt = self.inst:GetPosition()
		--         pt.y = 3

		--         self.inst.components.lootdropper:FlingItem(self.saddle, pt, doer == nil and self.saddle.components.saddler.discardedcb or nil)
		--         self.canride = false
		--         self.saddle = nil
		--         self.inst:PushEvent("saddlechanged", { saddle = nil })
		--     end

		--     if self.saddle == nil and newsaddle ~= nil then
		--         if self.saddleable then
		--             self.inst:AddChild(newsaddle)
		--             newsaddle.Transform:SetPosition(0,0,0) -- make sure we're centered, so poop lands in the right spot!
		--             newsaddle:RemoveFromScene()
		--             self.saddle = newsaddle
		--             self.inst:PushEvent("saddlechanged", { saddle = newsaddle })

		--             self.inst.AnimState:OverrideSymbol("swap_saddle", self.saddle.components.saddler.swapbuild, self.saddle.components.saddler.swapsymbol)
		--             self.canride = true
		--             if doer ~= nil then
		--                 self.inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")
		--             end
		--         else
		--             self.inst.components.lootdropper:FlingItem(newsaddle)
		--             if self.inst.components.combat then
		--                 self.inst.components.combat:SuggestTarget(doer)
		--             end
		--         end
		--     end
		-- end

		--防止有主的牛抖落鞍
		-- AddStategraphPostInit("beefalo", function(sg)
		-- 	print("in AddStategraphPostInit beefalo")
		-- 	if _G.TheWorld.ismastersim then
		-- 		local _TimeEvent24 = sg.states["shake_off_saddle"].timeline[1].fn
		-- 		sg.states["shake_off_saddle"].timeline[1].fn = function(inst)
		-- 			if inst.ownerlist ~= nil then
		-- 				local obedience = 0
		-- 				if inst.components.domesticatable ~= nil and inst.components.domesticatable.GetObedience ~= nil then
		-- 					obedience = inst.components.domesticatable:GetObedience()
		-- 				end
		-- 				print(string.format("服从: %s", obedience))

		-- 				if obedience ~= 0 then
		-- 					return
		-- 				end
		-- 			end

		-- 			_TimeEvent24(inst)
		-- 		end
		-- 	end
		-- end)
	end

	-- 修复官方读取存档时的一个bug
	local Rider = _G.require("components/rider")
	local old_OnLoad = Rider.OnLoad
	function Rider:OnLoad(data)
		if data and data.mount ~= nil then
			-- 这里什么也不做
			-- local mount = SpawnSaveRecord(data.mount)
			-- if mount.components.rideable:IsSaddled() then
			-- 	self:Mount(mount, true)
			-- else
			-- 	self.inst:DoTaskInTime(0, function()
			-- 		local fx = SpawnPrefab("spawn_fx_medium")
			-- 		if fx ~= nil then
			-- 			fx.Transform:SetPosition(mount.Transform:GetWorldPosition())
			-- 		end
			-- 	end)
			-- end
		end
	end

	local Teleporter = _G.require("components/teleporter")
	local old_Activate = Teleporter.Activate
	--跳虫洞时带走坐骑
	function Teleporter:Activate(doer)
		local ret = old_Activate(self, doer)

		if ret then
			local x,y,z = self.inst.Transform:GetWorldPosition()
			local beefalo = nil
			--local ents = TheSim:FindEntities(x, y, z, 20, {"beefalo"})
			local ents = TheSim:FindEntities(x, y, z, 20)
			for _,ent in pairs(ents) do
				if ent.components.domesticatable and ent.components.rideable and not ent.components.rideable:IsBeingRidden()
				and ent.ownerlist ~= nil and ent.ownerlist.master == doer.userid then
					beefalo = ent
					break
				end
			end

			if beefalo then
				self:Teleport(beefalo)
			end
		end

		return ret
	end

	local function FindToLeader(inst)
		local leader = inst.ownerlist and GetTheWorldPlayerById(inst.ownerlist.master) or nil
		if leader ~= nil and leader.beefalo_follow then
			local inst_pos = inst:GetPosition()
			local leader_pos = leader:GetPosition()

			if _G.distsq(leader_pos, inst_pos) > 1600 then
				if inst.components.combat ~= nil then
					inst.components.combat:SetTarget(nil)
				end

				if inst.components.follower and not leader.components.leader:IsFollower(inst) then
					leader.components.leader:AddFollower(inst)
				end

				-- local angle = leader:GetAngleToPoint(inst_pos)
				-- local offset = _G.FindWalkableOffset(leader_pos, angle * _G.DEGREES, 30, 10) or _G.Vector3(0, 0, 0)

				-- inst.porttask = inst:DoTaskInTime(0, function(inst, pos)
				-- 	print(pos)
				-- 	inst.porttask = nil
				-- 	if inst.Physics ~= nil then
				-- 		inst.Physics:Teleport(pos:Get())
				-- 	else
				-- 		inst.Transform:SetPosition(pos:Get())
				-- 	end
				-- end, leader_pos + offset)
				return true
			end
		end

		return false
	end

	--nice round function
	local round2 = function(num, idp)
		return _G.tonumber(string.format("%." .. (idp or 0) .. "f", num))
	end

	-- 获取牛的状态信息
	function GetBeefaloInfoString(inst, IsBeingRidden)
		local strDes = ""
		-- 生命
		local curhp = math.ceil(inst.components.health.currenthealth-inst.components.health.minhealth)
		local maxhp = math.ceil(inst.components.health.maxhealth-inst.components.health.minhealth)
		if curhp>maxhp then curhp=maxhp end
		strDes = strDes .. curhp .. " / " .. maxhp
		if not IsBeingRidden then
			-- 服从
			local obedience = inst.components.domesticatable:GetObedience()
			-- 驯化
			local domesticate = inst.components.domesticatable:GetDomestication()
			-- 倾向 - 战斗
			local orneryNum = inst.components.domesticatable.tendencies[TENDENCY.ORNERY] or 0
			-- 倾向 - 骑行
			local riderNum = inst.components.domesticatable.tendencies[TENDENCY.RIDER] or 0
			-- 倾向 - 宠物
			local pudgyNum = inst.components.domesticatable.tendencies[TENDENCY.PUDGY] or 0
			strDes = strDes .. "\n服从度: " .. round2(obedience*100, 0) .. "%"
			strDes = strDes .. "\n驯化度: " .. round2(domesticate * 100, 1) .. "%"
			strDes = strDes .. "\n战斗倾向: " .. round2(orneryNum*100,0)
			strDes = strDes .. "\n骑行倾向: " .. round2(riderNum*100,0)
			strDes = strDes .. "\n宠物倾向: " .. round2(pudgyNum*100,0)
		end

		return strDes
	end

	local function CanShareTarget(dude)
		return dude:HasTag("beefalo")
			and not dude:IsInLimbo()
			and not (dude.components.health:IsDead() or dude:HasTag("player"))
	end

	local old_attacked
	local function new_attacked(inst, data)
		if inst.components.rideable:IsBeingRidden() then
			if not inst.components.domesticatable:IsDomesticated() or not inst.tendency == TENDENCY.ORNERY then
				inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_ATTACKED_DOMESTICATION)
				inst.components.domesticatable:DeltaObedience(0.01)
			end
			inst.components.domesticatable:DeltaTendency(TENDENCY.ORNERY, TUNING.BEEFALO_ORNERY_ATTACKED)
		else
			if data.attacker ~= nil and data.attacker:HasTag("player") then
				--不掉驯化度
				--inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_ATTACKED_BY_PLAYER_DOMESTICATION)
				inst.components.domesticatable:DeltaObedience(0.1)

				if inst.ownerlist ~= nil and data.attacker.userid == inst.ownerlist.master then
					--主人攻击时停止攻击目标
					if inst.components.combat ~= nil then
						inst.components.combat:SetTarget(nil)
					end
					return
				end
			end
			
			if inst.ownerlist ~= nil and FindToLeader(inst) then
				return
			end
			inst.components.combat:SetTarget(data.attacker)
			inst.components.combat:ShareTarget(data.attacker, 30, CanShareTarget, 5)
		end
	end

	local function OnBeefaloAttacked(inst, data)
		if inst.components.rideable:IsSaddled() then
			new_attacked(inst, data)
			if inst.ownerlist ~= nil and inst.components.health then
				local player
				local strDes = ""
				if inst.components.rideable:IsBeingRidden() then
					player = inst.components.rideable:GetRider()
				elseif data.attacker ~= nil and data.attacker.components.talker then
					player = data.attacker
					strDes = strDes .. "这头牛的当前状态: \n"
				end

				if player and player:HasTag("player") then
					strDes = strDes .. GetBeefaloInfoString(inst, inst.components.rideable:IsBeingRidden())
					local colour = {0.6, 0.9, 0.8, 1}
					PlayerColorSay(player, strDes, colour)
				end
			end
		else
			old_attacked(inst, data)
		end
	end

	AddPrefabPostInit("beefalo", function(beefalo)
		-- 此功能仅服务端mod不能使用,其他人将不显示牛说的话
		-- beefalo:AddComponent("talker")
		-- beefalo.components.talker.fontsize = 30
		-- beefalo.components.talker.colour = _G.Vector3(0.6, 0.9, 0.8, 1)
		-- 用于玩家退出时播放牛的离开动画
		beefalo:AddComponent("colourtweener")
		-- 野牛鞍状态改变
		beefalo:ListenForEvent("saddlechanged", function(inst, data)
			if data.saddle == nil then
				if inst.ownerlist ~= nil then
					SetItemPermission(inst, nil)
					inst.components.health:SetAbsorptionAmount(0)
					inst.components.health:StartRegen(TUNING.BEEFALO_HEALTH_REGEN, TUNING.BEEFALO_HEALTH_REGEN_PERIOD)
					--inst:RemoveEventCallback("entitysleep", FindToLeader)
					-- if inst.porttask ~= nil then
					-- 	inst.porttask:Cancel()
					-- 	inst.porttask = nil
					-- end
					-- 停止跟随
					if inst.components.follower and inst.components.follower.leader then
						inst.components.follower:SetLeader(nil)
					end
				end
			else
				if beefalo_power then
					inst.components.health:SetAbsorptionAmount(0.2)
					inst.components.health:StartRegen(10, 1)
				end
				--inst:ListenForEvent("entitysleep", FindToLeader)
			end
		end)

		-- 重写被攻击后方法,上鞍的情况下被攻击不掉服从度
		if old_attacked == nil then
			old_attacked = RemoveEventCallbackEx(beefalo, "attacked", "scripts/prefabs/beefalo.lua")
		else
			beefalo:RemoveEventCallback("attacked", old_attacked)
		end

		beefalo:ListenForEvent("attacked", OnBeefaloAttacked)
		-- 空闲时寻找主人
		beefalo:ListenForEvent("entitysleep", FindToLeader)
	end)

	-- -- 保存牛
	-- function SaveBeefalo(inst)
	-- 	inst.beefalo = {}
	-- 	inst.beefalo.isRiding = inst.components.rider:IsRiding()
	-- 	local beefalo = nil
	-- 	if inst.beefalo.isRiding then
	-- 		beefalo = inst.components.rider:GetMount()
	-- 	else
	-- 		local x,y,z = inst.Transform:GetWorldPosition()
	-- 		local ents = _G.TheSim:FindEntities(x, y, z, 20, {"beefalo"})
	-- 		for _,ent in pairs(ents) do
	-- 			if ent.components.domesticatable and ent.components.rideable and not ent.components.rideable:IsBeingRidden()
	-- 			   and ent.ownerlist and ent.ownerlist.master == inst.userid then
	-- 				beefalo = ent
	-- 				--break
	-- 			end
	-- 		end	
	-- 	end
	-- 	if beefalo then
	-- 		--inst.beefalo.saved = beefalo
	-- 		inst.beefalo.save = beefalo:GetSaveRecord()
	-- 		beefalo.persists = false
	-- 		if not inst.beefalo.isRiding then
	-- 			local fx = SpawnPrefab("spawn_fx_medium")
	-- 			if fx ~= nil then
	-- 				fx.Transform:SetPosition(beefalo.Transform:GetWorldPosition())
	-- 			end
	-- 		end
	-- 		beefalo.components.colourtweener:StartTween({ 0, 0, 0, 1 }, 13 * _G.FRAMES, beefalo.Remove)
	-- 	end
	-- end

	-- local function PlayerPostInit(inst)
	-- 	local old_OnDespawn = inst._OnDespawn
	-- 	function inst._OnDespawn(inst, ...)
	-- 		if old_OnDespawn then
	-- 			_OnDespawn(inst, ...)
	-- 		end
	-- 		SaveBeefalo(inst)
	-- 	end

	-- 	local OldOnSave=inst.OnSave
	-- 	inst.OnSave = function(inst,data)
	-- 		if OldOnSave~=nil then
	-- 			OldOnSave(inst,data)
	-- 		end
	-- 		if inst.beefalo ~= nil then
	-- 			data.beefalo = inst.beefalo
	-- 		end
	-- 	end

	-- 	local OldOnLoad=inst.OnLoad
	-- 	inst.OnLoad = function(inst,data)
	-- 		--print("加载准备 - 坐骑")
	-- 		if OldOnLoad~=nil then
	-- 			OldOnLoad(inst,data)
	-- 		end
	-- 		if data ~= nil then 
	-- 			if data.beefalo ~= nil and data.beefalo.save then
	-- 				--print("加载坐骑")
	-- 				local beefalo = _G.SpawnSaveRecord(data.beefalo.save)
	-- 				if data.beefalo.isRiding then
	-- 					inst:DoTaskInTime(0, function()
	-- 						inst.components.rider:Mount(beefalo, true)
	-- 					end)
	-- 				else
	-- 					inst:DoTaskInTime(0, function()
	-- 						local fx = SpawnPrefab("spawn_fx_medium")
	-- 						if fx ~= nil then
	-- 							fx.Transform:SetPosition(beefalo.Transform:GetWorldPosition())
	-- 						end
	-- 					end)
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end

	local function PlayerPostInit(inst)
		inst:AddComponent("save_beefalo")
		local old_OnDespawn = inst._OnDespawn
		function inst._OnDespawn(inst, ...)
			if old_OnDespawn then
				old_OnDespawn(inst, ...)
			end
			inst.components.save_beefalo:SaveBeefalo()
		end
	end

	for k,prefabname in ipairs(_G.DST_CHARACTERLIST) do
		AddPrefabPostInit(prefabname, PlayerPostInit)
	end

	if _G.MODCHARACTERLIST then
		for k,prefabname in ipairs(_G.MODCHARACTERLIST) do
			AddPrefabPostInit(prefabname, PlayerPostInit)
		end
	end

	-- 为野牛上鞍
	local old_SADDLE = _G.ACTIONS.SADDLE.fn 
	_G.ACTIONS.SADDLE.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) then
			local ret = old_SADDLE(act)
			if act.target.components.rideable ~= nil and act.target.components.rideable.saddle ~= nil then
				SetItemPermission(act.target, act.doer)
				act.doer.beefalo = act.target
				act.doer.beefalo_follow = true
			end
			return ret
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("beefalo_saddle_cant", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("beefalo_saddle", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	-- 为野牛下鞍
	local old_UNSADDLE = _G.ACTIONS.UNSADDLE.fn 
	_G.ACTIONS.UNSADDLE.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) then
			return old_UNSADDLE(act)
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("beefalo_unsaddle_cant", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("beefalo_unsaddle", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end

	-- 骑乘
	local old_MOUNT = _G.ACTIONS.MOUNT.fn 
	_G.ACTIONS.MOUNT.fn = function(act)
		testActPrint(act)

		-- 有权限时直接处理
		if CheckItemPermission(act.doer, act.target, true) then
			-- act.doer.components.rider:Mount(act.target)
			-- return true
			--主人或有权限的人骑乘时停止攻击目标
			if act.target.components.combat ~= nil then
				act.target.components.combat:SetTarget(nil)
			end
			return old_MOUNT(act)
		elseif act.doer:HasTag("player") then
			-- 主人不为自己并且物品受权限控制
			local doer_num = GetPlayerIndex(act.doer.userid)
			local master = act.target.ownerlist and GetPlayerById(act.target.ownerlist.master) or nil
			if master ~= nil then
				PlayerSay(act.doer, GetSayMsg("beefalo_ride_cant", master.name, GetItemOldName(act.target)))
				PlayerSay(master, GetSayMsg("beefalo_ride", act.doer.name, GetItemOldName(act.target), doer_num))
			else
				PlayerSay(act.doer, GetSayMsg("player_leaved", GetPlayerNameByOwnerlist(act.target.ownerlist)))
			end
		end

		return false
	end
end
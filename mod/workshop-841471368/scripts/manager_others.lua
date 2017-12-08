local _G = GLOBAL
local TheSim = _G.TheSim
local TheNet = _G.TheNet
local TheShard = _G.TheShard
local worldShardId = TheShard:GetShardId()
local Vector3 = _G.Vector3
local SpawnPrefab = _G.SpawnPrefab
local ShakeAllCameras = _G.ShakeAllCameras
local FindEntity = _G.FindEntity

local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local STRINGS = _G.STRINGS
local ACTIONS = _G.ACTIONS
local FRAMES = _G.FRAMES
local CAMERASHAKE = _G.CAMERASHAKE

--防止火焰蔓延
local spreadFire = GetModConfigData("spread_fire")
local portal_clear = GetModConfigData("portal_clear")
--小偷包保鲜
local krampus_sack_ice = GetModConfigData("krampus_sack_ice")
--远古犀牛刷新时间,如果小于0则不刷新
local minotaur_regenerate = GetModConfigData("minotaur_regenerate")
--远古犀牛是否允许拆家
local minotaur_destroy = GetModConfigData("minotaur_destroy")
--完整远古祭坛防拆毁
--local ancient_altar_no_destroy = GetModConfigData("ancient_altar_no_destroy")
-- 世界连接通道
local connect_worlds = GetModConfigData("connect_worlds")
local formServerName = connect_worlds and connect_worlds[worldShardId] and connect_worlds[worldShardId].name or nil
--犬牙陷阱攻击无权限玩家
local trap_teeth_player = GetModConfigData("trap_teeth_player")
--眼球塔攻击无权限玩家
local eyeturret_player = GetModConfigData("eyeturret_player")

if IsServer then
	if spreadFire ~= 2 then
		local CurrentMakeSmallPropagator = _G.MakeSmallPropagator
		_G.MakeSmallPropagator = function(inst)
			CurrentMakeSmallPropagator(inst)
			if inst.components.propagator then
				if spreadFire == 1 then --Half range
					inst.components.propagator.propagaterange = inst.components.propagator.propagaterange/2.0
				else
					inst.components.propagator.propagaterange = 0
				end
			end
		end

		local CurrentMakeMediumPropagator = _G.MakeMediumPropagator
		_G.MakeMediumPropagator = function(inst)
			CurrentMakeMediumPropagator(inst)
			if inst.components.propagator then
				if spreadFire == 1 then --Half range
					inst.components.propagator.propagaterange = inst.components.propagator.propagaterange/2.0
				else
					inst.components.propagator.propagaterange = 0
				end
			end
		end
		
		local MakeLargePropagator = _G.MakeLargePropagator
		_G.MakeLargePropagator = function(inst)
			MakeLargePropagator(inst)
			if inst.components.propagator then
				if spreadFire == 1 then --Half range
					inst.components.propagator.propagaterange = inst.components.propagator.propagaterange/2.0
				else
					inst.components.propagator.propagaterange = 0
				end
			end
		end
	end

	---得到恶魔之门的坐标---
	AddPrefabPostInit("multiplayer_portal", function(inst)
		inst:DoTaskInTime(0, function()
			local pos = inst:GetPosition()
			if pos.x ~= nil and pos.y ~= nil and pos.z ~= nil then
				_G.TheWorld.multiplayer_portal_pos = pos
			end
		end)
	end)

	---防止炸药炸毁建筑---
	AddComponentPostInit("explosive", function(explosive, inst)
		inst.buildingdamage = 0
		explosive.CurrentOnBurnt = explosive.OnBurnt
		function explosive:OnBurnt()
			local x, y, z = inst.Transform:GetWorldPosition()
			--local ents2 = _G.TheSim:FindEntities(x, y, z, explosive.explosiverange, nil, { "INLIMBO" })
			local ents2 = _G.TheSim:FindEntities(x, y, z, 10)
			local nearbyStructure = false
			for k, v in ipairs(ents2) do
				if v.components.burnable ~= nil and not v.components.burnable:IsBurning() then
					if v:HasTag("structure") then
						nearbyStructure = true
					end
				end
			end
			--
			if nearbyStructure then  --Make sure structures aren't lit on fire (indirectly) from explosives
				--for k, v in ipairs(ents3) do
				--	if v:IsValid() and not v:IsInLimbo() and v.components.burnable ~= nil and v.components.burnable:IsBurning() then
				--		v.components.burnable:Extinguish(true, 100)
				--	end
				--end
				inst:RemoveTag("canlight")
			else
				inst:AddTag("canlight")
				explosive:CurrentOnBurnt()
			end
		end
	end)

	-- 小偷包保鲜
	if krampus_sack_ice then
		AddPrefabPostInit("krampus_sack", function (inst)
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end)
	end

	-- 远古犀牛
	AddPrefabPostInit("minotaur", function (inst)
		if _G.TheWorld:HasTag("cave") and minotaur_regenerate > 0 then
			local auth_minotaur = _G.TheWorld.guard_authorization.minotaur
			if auth_minotaur == nil then
				auth_minotaur = {}
				_G.TheWorld.guard_authorization.minotaur = auth_minotaur
			end
			if auth_minotaur.position == nil then
				inst:DoTaskInTime(0, function()
					local base_x, base_y, base_z = inst.Transform:GetWorldPosition()
					if base_x ~= nil and base_x ~= 0 then
						auth_minotaur.position = { x = base_x, y = base_y, z = base_z }
					end
				end)
			end
			if auth_minotaur.name == nil then
				auth_minotaur.name = inst.name or (STRINGS.NAMES[string.upper(inst.prefab)] or "远古守护者")
			end
			auth_minotaur.isSpawnPrefab = false
			inst:ListenForEvent("onremove", function()
				local lastattacker = inst.components.combat and inst.components.combat.lastattacker
				TheNet:Announce("〖 "..inst:GetDisplayName().." 〗".. (lastattacker and "被〖 "..lastattacker.name.." 〗击杀" or "") .."将在"..minotaur_regenerate.."天后刷新")
				auth_minotaur.isSpawnPrefab = true
				-- 仅仅记录下击杀时间
				auth_minotaur.lastDay = _G.tonumber(_G.TheWorld.state.cycles)
				auth_minotaur.generateDay = auth_minotaur.lastDay + minotaur_regenerate
				if auth_minotaur.position == nil then
					local x, y, z = inst.Transform:GetWorldPosition()
					auth_minotaur.position = x ~= nil and x ~= 0 and { x = x, y = y, z = z } or { x = 0, y = 0, z = 0 }
				end
			end)
		end

		if minotaur_destroy then
			local function ClearRecentlyCharged(inst, other)
				inst.recentlycharged[other] = nil
			end

			local function onothercollide(inst, other)
				if not other:IsValid() or inst.recentlycharged[other] then
					return
				elseif other:HasTag("smashable") and other.components.health ~= nil then
					--other.Physics:SetCollides(false)
					other.components.health:Kill()
				elseif other.components.workable ~= nil
					and other.components.workable:CanBeWorked()
					and other.components.workable.action ~= ACTIONS.NET then
					SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
					other.components.workable:Destroy(inst)
					if other:IsValid() and other.components.workable ~= nil and other.components.workable:CanBeWorked() then
						inst.recentlycharged[other] = true
						inst:DoTaskInTime(3, ClearRecentlyCharged, other)
					end
				elseif other.components.hammerworkable ~= nil
					and other.components.hammerworkable:CanBeWorked()
					and other.components.hammerworkable.action ~= ACTIONS.NET then
					SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
					other.components.hammerworkable:Destroy(inst)
					if other:IsValid() and other.components.hammerworkable ~= nil and other.components.hammerworkable:CanBeWorked() then
						inst.recentlycharged[other] = true
						inst:DoTaskInTime(3, ClearRecentlyCharged, other)
					end
				elseif other.components.health ~= nil and not other.components.health:IsDead() then
					inst.recentlycharged[other] = true
					inst:DoTaskInTime(3, ClearRecentlyCharged, other)
					SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
					inst.SoundEmitter:PlaySound("dontstarve/creatures/rook/explo")
					inst.components.combat:DoAttack(other)
				end

				-- 预留方法,用于摧毁额外的建筑
				if inst.onhxcollide ~= nil then
					inst.onhxcollide(inst, other)
				end
			end

			local function oncollide(inst, other)
				if not (other ~= nil and other:IsValid() and inst:IsValid())
					or inst.recentlycharged[other]
					or other:HasTag("player")
					or Vector3(inst.Physics:GetVelocity()):LengthSq() < 42 then
					return
				end
				ShakeAllCameras(CAMERASHAKE.SIDE, .5, .05, .1, inst, 40)
				inst:DoTaskInTime(2 * FRAMES, onothercollide, other)
			end

			inst.Physics:SetCollisionCallback(oncollide)
		end
	end)

	-- 远古犀牛刷新
	local function SpawnerMinotaurFn(inst)
		if inst.guard_authorization.minotaur.isSpawnPrefab then
			local new_minotaur = SpawnPrefab("minotaur")
			TheNet:Announce("〖 ".. inst.guard_authorization.minotaur.name .." 〗已刷新")
			--local position = _G.Vector3(inst.guard_authorization.minotaur.position.x, inst.guard_authorization.minotaur.position.y, inst.guard_authorization.minotaur.position.z)
			local newPos = GetFanValidPoint(inst.guard_authorization.minotaur.position)
			local setPos = newPos or inst.guard_authorization.minotaur.position
			-- print(string.format("打印坐标newPos: x:%s y:%s z:%s", newPos.x, newPos.y, newPos.z))
			-- print(string.format("打印坐标position: x:%s y:%s z:%s", inst.guard_authorization.minotaur.position.x, inst.guard_authorization.minotaur.position.y, inst.guard_authorization.minotaur.position.z))
			-- print(string.format("打印坐标setPos: x:%s y:%s z:%s", setPos.x, setPos.y, setPos.z))
			ItemAnimSetPosition(new_minotaur, setPos.x, setPos.y, setPos.z, false, true)
		end
	end

	-- 远古犀牛重生组件(蚁狮版本新加_当开启锁刷新时屏蔽系统犀牛重生)
	AddPrefabPostInit("minotaur_ruinsrespawner_inst", function (inst)
		if _G.TheWorld:HasTag("cave") and minotaur_regenerate > 0 then
			-- inst.resetruins = nil
			-- 移除刷新监听事件
			RemoveEventCallbackEx(inst, "resetruins", "scripts/prefabs/ruinsrespawner.lua", _G.TheWorld)
			inst:ListenForEvent("resetruins", SpawnerMinotaurFn, _G.TheWorld)
		end
	end)

	-- 使豪华大箱和大号华丽箱子可砸
	local caveChestTable = {
		-- "pandoraschest",   -- 豪华大箱
		"minotaurchest",   -- 大号华丽箱子
	}

	local function CaveChestWorkFn(inst)
		if inst.components.workable == nil and inst.gd_superlevel == nil then
			local function onhammered(inst, worker)
				if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
					inst.components.burnable:Extinguish()
				end
				inst.components.lootdropper:DropLoot()
				if inst.components.container ~= nil then
					inst.components.container:DropEverything()
				end
				local fx = SpawnPrefab("collapse_small")
				fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
				fx:SetMaterial("wood")
				inst:Remove()
			end

			local function onhit(inst, worker)
				if not inst:HasTag("burnt") then
					inst.AnimState:PlayAnimation("hit")
					inst.AnimState:PushAnimation("closed", false)
					if inst.components.container ~= nil then
						inst.components.container:DropEverything()
						inst.components.container:Close()
					end
				end
			end

			if inst.components.lootdropper == nil then
				inst:AddComponent("lootdropper")
			end
			inst:AddComponent("workable")
			inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
			inst.components.workable:SetWorkLeft(2)
			inst.components.workable:SetOnFinishCallback(onhammered)
			inst.components.workable:SetOnWorkCallback(onhit)

			if inst.components.burnable == nil then
				_G.MakeSmallBurnable(inst, nil, nil, true)
			end
			if inst.components.propagator == nil then
				_G.MakeMediumPropagator(inst)
			end

			-- 移除刷新监听事件
			RemoveEventCallbackEx(inst, "resetruins", "scripts/prefabs/treasurechest.lua", _G.TheWorld)
		end
	end

	for k,name in pairs(caveChestTable) do
		AddPrefabPostInit(name, CaveChestWorkFn)
	end

	-- if ancient_altar_no_destroy then
	-- 	-- 完整远古祭坛
	-- 	AddPrefabPostInit("ancient_altar", function (inst)
	-- 		RemoveBurnable(inst)
	-- 		makeCantWorkale(inst)
	-- 		inst.cant_destroyedby_monster = false
	-- 	end)
	-- end

	AddPrefabPostInit("world", function(inst)
		inst:ListenForEvent("cycleschanged", function(inst, data)
			if inst.guard_authorization and inst.guard_authorization.minotaur and inst.guard_authorization.minotaur.generateDay and inst.state.cycles >= inst.guard_authorization.minotaur.generateDay then
				SpawnerMinotaurFn(inst)
			end
		end)
	end)

	-- 犬牙陷阱增强
	AddPrefabPostInit("trap_teeth", function (inst)
		local mine_test_fn = function(dude, inst)
			local leader = GetItemLeader(dude)

			if leader.userid == nil and dude.ownerlist ~= nil then
				leader = { userid = dude.ownerlist.master }
			end

			return not (dude.components.health ~= nil and
						dude.components.health:IsDead())
				and dude.components.combat:CanBeAttacked(inst)
				and not CheckItemPermission(leader, inst)
		end

		local mine_test_tags = { "monster", "character", "animal" }
		-- See entityreplica.lua
		local mine_must_tags = { "_combat" }
		local notags = { "notraptrigger", "flying", "playerghost" }
		if inst.components.mine and not trap_teeth_player then
			table.insert(notags, inst.components.mine.alignment)
		end

		local function MineTest(inst, self)
			if self.radius ~= nil then
				local target = FindEntity(inst, self.radius, mine_test_fn, mine_must_tags, notags, mine_test_tags)
				if target ~= nil then
					self:Explode(target)
				end
			end
		end

		function inst.components.mine:StartTesting()
			if self.testtask ~= nil then
				self.testtask:Cancel()
			end
			self.testtask = self.inst:DoPeriodicTask(1 + math.random(), MineTest, math.random(.9, 1), self)
		end
	end)

	local old_eyeturret_attacked_key
	local old_eyeturret_attacked
	-- 眼球塔增强
	AddPrefabPostInit("eyeturret", function (inst)
		local notags = { "INLIMBO", "wall" }
		if not eyeturret_player then
			table.insert(notags, "player")
		end

		local function retargetfn(inst)
			local playertargets = {}
			for i, v in ipairs(_G.AllPlayers) do
				if CheckItemPermission(v, inst) then
					if v.components.combat.target ~= nil then
						playertargets[v.components.combat.target] = true
					end
				else
					playertargets[v] = true
				end
			end

			return FindEntity(inst, 20,
				function(guy)
					local leader = GetItemLeader(guy)

					if leader.userid == nil and guy.ownerlist ~= nil then
						leader = { userid = guy.ownerlist.master }
					end

					return inst.components.combat:CanTarget(guy)
						and (playertargets[guy] or
							(guy.components.combat.target ~= nil and (guy.components.combat.target == inst or CheckItemPermission(guy.components.combat.target, inst))))
						and not CheckItemPermission(leader, inst)
						--and not CheckPermission(guy.ownerlist, inst.ownerlist and inst.ownerlist.master or nil)
				end,
				{ "_combat" }, --see entityreplica.lua
				notags
			)
		end

		local function ShareEyeTurretTargetFn(dude)
			return dude:HasTag("eyeturret") and CheckPermission(dude.ownerlist, inst.ownerlist and inst.ownerlist.master or nil)
		end

		local function OnEyeTurretAttacked(inst, data)
			local attacker = data ~= nil and data.attacker or nil
			if attacker ~= nil then
				local leader = attacker
				if attacker.components.follower ~= nil and attacker.components.follower.leader ~= nil and attacker.components.follower.leader:HasTag("player") then
					leader = attacker.components.follower.leader
				elseif attacker.ownerlist ~= nil then
					leader = GetPlayerById(attacker.ownerlist.master) or { userid = attacker.ownerlist.master }
				end

				if not CheckItemPermission(leader, inst) then
					inst.components.combat:SetTarget(attacker)
					inst.components.combat:ShareTarget(attacker, 15, ShareEyeTurretTargetFn, 10)
				end
			end
		end
		
		inst.components.combat:SetRetargetFunction(1, retargetfn)
		-- 重写被攻击后方法
		if old_eyeturret_attacked == nil and inst.event_listeners ~= nil and inst.event_listeners["attacked"] ~= nil and inst.event_listeners["attacked"][inst] ~= nil then
			for i, fn in ipairs(inst.event_listeners["attacked"][inst]) do
				local info = _G.debug.getinfo(fn,"LnS")
				if string.find(info.source, "scripts/prefabs/eyeturret.lua") then
					old_eyeturret_attacked_key = i
					old_eyeturret_attacked = fn
					break
				end
				
			end
		end

		if inst.event_listeners ~= nil and inst.event_listeners["attacked"] ~= nil and inst.event_listeners["attacked"][inst] ~= nil then
			inst:RemoveEventCallback("attacked", old_eyeturret_attacked)
		end
		inst:ListenForEvent("attacked", OnEyeTurretAttacked)
	end)

	-- 配置世界通道
	local function LinkWorld(inst)
		local portalId = inst.components.worldmigrator.id
		if connect_worlds ~= nil and connect_worlds[worldShardId] ~= nil and connect_worlds[worldShardId].data ~= nil and connect_worlds[worldShardId].data[portalId] ~= nil then
			inst.components.worldmigrator.auto = false
			inst.components.worldmigrator.linkedWorld = connect_worlds[worldShardId].data[portalId]
			inst.components.worldmigrator.receivedPortal = portalId
			inst.components.worldmigrator:ValidateAndPushEvents()
		end
	end

	-- 地上洞口
	AddPrefabPostInit("cave_entrance_open", function(inst)
		if connect_worlds then
			inst:DoTaskInTime(1, LinkWorld)
		end

		inst:DoTaskInTime(1, function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = TheSim:FindEntities(x, y, z, 40, nil, { "INLIMBO" })
			if ents ~= nil then
				local multiplayer_portal = nil
				for _,obj in pairs(ents) do
					if obj and obj.prefab == "multiplayer_portal" then
						multiplayer_portal = obj
						break
					end
				end

				if multiplayer_portal ~= nil and inst.components.childspawner ~= nil then
					inst.components.childspawner.childname = "spore_tall"
				end
			end
		end)
	end)

	if connect_worlds then
		local WorldMigrator = _G.require("components/worldmigrator")
		local old_ValidateAndPushEvents = WorldMigrator.ValidateAndPushEvents
		--设置传送门时改变传送门名
		function WorldMigrator:ValidateAndPushEvents( ... )
			old_ValidateAndPushEvents(self, ...)

			if self.linkedWorld ~= nil  and connect_worlds[self.linkedWorld] ~= nil and connect_worlds[self.linkedWorld].name ~= nil then
				local toServerName = connect_worlds[self.linkedWorld].name
				SetItemAppendName(self.inst, GetSayMsg("item_server_to", formServerName, toServerName))
			end
		end

		-- 被堵住的洞口
		AddPrefabPostInit("cave_entrance", function(inst)
			inst:DoTaskInTime(1, LinkWorld)
		end)

		-- 地下阶梯
		AddPrefabPostInit("cave_exit", function(inst)
			inst:DoTaskInTime(1, LinkWorld)
		end)
	end
end
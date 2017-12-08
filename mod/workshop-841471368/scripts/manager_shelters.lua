local _G = GLOBAL
local TheNet = _G.TheNet
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

if IsServer then
	-- 防止怪物摧毁建筑
	local cant_destroyby_monster = GetModConfigData("cant_destroyby_monster")
	-- 防止玩家破坏野外猪人房兔人房
	local house_plain_nodestroy = GetModConfigData("house_plain_nodestroy")
	--------------------------------------- 防止摧毁野外猪人房/兔人房/完整的远古祭坛 ---------------------------------------
	local shelterTable = {
		"rabbithouse",     -- 兔人房
		"pighouse",        -- 猪人房
		"ancient_altar",   -- 完整的远古祭坛
	}

	local function ShelterFn(inst)
		if cant_destroyby_monster or house_plain_nodestroy then
			RemoveBurnable(inst)
		end
		if cant_destroyby_monster then
			makeCantWorkale(inst)
		end
	end

	for k,name in pairs(shelterTable) do
		AddPrefabPostInit(name, ShelterFn)
	end

	if cant_destroyby_monster  then
		-- --设置不可被怪物摧毁的建筑
		-- for k, v in pairs(config_item.cant_destroy_buildings) do
		-- 	AddPrefabPostInit(v, makeCantWorkale)
		-- end

		-- --安置物无敌
		-- for k, v in pairs(config_item.deploys_cant_table) do
		-- 	AddPrefabPostInit(v, makeDeployCantAttack)
		-- end

		-- --树无敌
		-- for k, v in pairs(config_item.winter_trees_table) do
		-- 	AddPrefabPostInit(v, makeWinterTreeCantAttack)
		-- end

		--------------------------------------- 防止摧毁残破的远古祭坛 ---------------------------------------
		AddPrefabPostInit("ancient_altar_broken", function (inst)
			makeCantWorkale(inst)
			local old_Repair = inst.components.repairable.Repair
			function inst.components.repairable:Repair(doer, repair_item)
				self.inst.components.workable = self.inst.components.hammerworkable

				local ret = old_Repair(self, doer, repair_item)

				self.inst.components.workable = self.inst.components.gd_workable
				return ret
			end
		end)
	end
end
--to configure basic statue
GLOBAL.TUNING.EYETURRET_DAMAGE = GetModConfigData("eyeturret_damage")
GLOBAL.TUNING.EYETURRET_HEALTH = GetModConfigData("eyeturret_health")
GLOBAL.TUNING.EYETURRET_REGEN = GetModConfigData("eyeturret_regen")
GLOBAL.TUNING.EYETURRET_RANGE = GetModConfigData("eyeturret_range")
GLOBAL.TUNING.EYETURRET_ATTACK_PERIOD = GetModConfigData("eyeturret_attack_period")

--to make Houndius Shootius movable
if GetModConfigData("movable") == 1 then
	AddPrefabPostInit("eyeturret", function(inst)
		local function turnon(inst)
	    	inst.on = true
	    	inst:Remove()
	    	GLOBAL.SpawnPrefab("eyeturret_item").Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
	    inst:AddComponent("machine")
	    inst.components.machine.turnonfn = turnon
	end)
end

--to make Houndius Shootius droppable
if GetModConfigData("droppable") == 1 then
	AddPrefabPostInit("eyeturret", function(inst)
	    inst.components.lootdropper:AddRandomLoot("eyeturret_item", 1)
	    inst.components.lootdropper.numrandomloot = 1
	end)
end

--[[

AddPrefabPostInit("eyeturret", function(inst)
	--to make Houndius Shootius movable
	if GetModConfigData("movable") == 1 then
		local function turnon(inst)
	    	inst.on = true
	    	inst:Remove()
	    	GLOBAL.SpawnPrefab("eyeturret_item").Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
	    inst:AddComponent("machine")
	    inst.components.machine.turnonfn = turnon
	end
	--to make Houndius Shootius droppable
	if GetModConfigData("droppable") == 1 then
	    inst.components.lootdropper:AddRandomLoot("eyeturret_item", 1)
	    inst.components.lootdropper.numrandomloot = 1
	ende
end)

]]
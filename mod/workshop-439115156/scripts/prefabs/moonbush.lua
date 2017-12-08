local assets =
    {
      --  Asset("ANIM", "anim/"..bushname..".zip"),
		Asset( "ANIM", "anim/moonbush.zip" ),
    }

    local prefabs =
    {
        "berries",
   --     "dug_"..bushname,
	--	"perd",
    --    "twigs",
	   }

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
end

local function makeemptyfn(inst)
 inst.AnimState:PlayAnimation("dead_to_empty")
        inst.AnimState:PushAnimation("empty")
	--[[
    if inst:HasTag("withered") then
        inst.AnimState:PlayAnimation("dead_to_empty")
        inst.AnimState:PushAnimation("empty")
    else
        inst.AnimState:PlayAnimation("empty")
    end]]
end

local function makebarrenfn(inst, wasempty)
    if inst:HasTag("withered") then
        inst.AnimState:PlayAnimation(wasempty and "empty_to_dead" or "full_to_dead")
        inst.AnimState:PushAnimation("idle_dead")
    else
        inst.AnimState:PlayAnimation("idle_dead")
    end
end

local function pickanim(inst)
    if inst.components.pickable == nil then
        return "idle"
    elseif not inst.components.pickable:CanBePicked() then
        return inst.components.pickable:IsBarren() and "idle_dead" or "idle"
    end

    --V2C: nil cycles_left means unlimited picks, so use max value for math
    local percent = inst.components.pickable.cycles_left ~= nil and inst.components.pickable.cycles_left / inst.components.pickable.max_cycles or 1
    return (percent >= .9 and "berriesmost")
        or (percent >= .33 and "berriesmore")
        or "berries"
end

local function shake(inst)
    if inst.components.pickable and inst.components.pickable:CanBePicked() then
        inst.AnimState:PlayAnimation("shake")
    else
        inst.AnimState:PlayAnimation("shake_empty")
    end
    inst.AnimState:PushAnimation(pickanim(inst), false)
end

local function spawnperd(inst)
    if inst:IsValid() then
        local perd = SpawnPrefab("perd")
        local spawnpos = Vector3(inst.Transform:GetWorldPosition() )
        spawnpos = spawnpos + TheCamera:GetDownVec()
        perd.Transform:SetPosition(spawnpos:Get() )
        perd.sg:GoToState("appear")
        perd.components.homeseeker:SetHome(inst)
        shake(inst)
    end
end

local function onpickedfn(inst, picker)
           inst.AnimState:PlayAnimation("idle_to_dead")
           inst.AnimState:PushAnimation("dead", false)

--[[
    if inst.components.pickable ~= nil then
        --V2C: nil cycles_left means unlimited picks, so use max value for math
        local old_percent = inst.components.pickable.cycles_left ~= nil and (inst.components.pickable.cycles_left + 1) / inst.components.pickable.max_cycles or 1
        inst.AnimState:PlayAnimation(
            (old_percent >= .9 and "berriesmost_picked") or
            (old_percent >= .33 and "berriesmore_picked") or
            "berries_picked")
        inst.AnimState:PushAnimation(
            inst.components.pickable:IsBarren() and
            "idle_dead" or
            "idle")
    end
	]]
end

local function getregentimefn(inst)
    if inst.components.pickable == nil then
        return TUNING.BERRY_REGROW_TIME
    end
    --V2C: nil cycles_left means unlimited picks, so use max value for math
    local max_cycles = inst.components.pickable.max_cycles
    local cycles_left = inst.components.pickable.cycles_left or max_cycles
    local num_cycles_passed = math.max(0, max_cycles - cycles_left)
    return TUNING.BERRY_REGROW_TIME
        + TUNING.BERRY_REGROW_INCREASE * num_cycles_passed
        + TUNING.BERRY_REGROW_VARIANCE * math.random()
end

local function makefullfn(inst)
inst.AnimState:PlayAnimation("shake")
inst:DoTaskInTime(1, function() inst.AnimState:PlayAnimation(pickanim(inst)) end)
end

local function dig_up(inst, chopper)
    if inst.components.pickable and inst.components.lootdropper then
        if inst.components.pickable:IsBarren() or inst:HasTag("withered") then
        --    inst.components.lootdropper:SpawnLootPrefab("twigs")
         --   inst.components.lootdropper:SpawnLootPrefab("twigs")
        else
            if inst.components.pickable and inst.components.pickable:CanBePicked() then
                inst.components.lootdropper:SpawnLootPrefab("berries")
				
            end

         --   inst.components.lootdropper:SpawnLootPrefab("dug_"..inst.bushname)
		end
    end
    inst:Remove() 
end



    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

      --  MakeSmallObstaclePhysics(inst, .1)

        inst:AddTag("bush")
		inst:AddTag("moonbush")
        inst:AddTag("renewable")

        --witherable (from witherable component) added to pristine state for optimization
        inst:AddTag("witherable")

     --   inst.MiniMapEntity:SetIcon(bushname..".png")

        inst.AnimState:SetBank("berrybush")
        inst.AnimState:SetBuild("moonbush")
        inst.AnimState:PlayAnimation("berriesmost", false)
 --inst.Transform:SetScale(0.75, 0.75, 0.75)
 
        --MakeDragonflyBait(inst, 1)
        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
        inst.components.pickable:SetUp("berries", TUNING.BERRY_REGROW_TIME)

        inst.components.pickable.getregentimefn = getregentimefn
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.makefullfn = makefullfn
        inst.components.pickable.ontransplantfn = ontransplantfn
        inst.components.pickable.max_cycles = TUNING.BERRYBUSH_CYCLES + math.random(2)
        inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

        inst:AddComponent("witherable")
		inst:AddComponent("follower")
        MakeLargeBurnable(inst)
        MakeMediumPropagator(inst)
local leader = inst.components.follower.leader
if not inst.components.follower.leader then
 inst:DoTaskInTime(2, function() if not inst.components.follower.leader then 
 inst.AnimState:PlayAnimation("shake")
 inst:DoTaskInTime(1.25, function() SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get()) inst:Remove() end)
 end end)
end 
        MakeHauntableIgnite(inst)
        AddHauntableCustomReaction(inst, function(inst, haunter)
            if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
                shake(inst)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_COOLDOWN_TINY
                return true
            end
            return false
        end, false, false, true)


     --   inst:AddComponent("lootdropper")
     --   inst:AddComponent("workable")
     --   inst.components.workable:SetWorkAction(ACTIONS.DIG)
     --   inst.components.workable:SetOnFinishCallback(dig_up)
     --   inst.components.workable:SetWorkLeft(1)

        inst:AddComponent("inspectable")
        inst.components.inspectable.nameoverride = "berrybush"

     --   inst:ListenForEvent("onwenthome", shake)
        MakeSnowCovered(inst)
     --   MakeNoGrowInWinter(inst)
        return inst
    end

    return Prefab("moonbush", fn, assets, prefabs)

--return createbush("moonbush"), 
local assets =
{
    Asset("ANIM", "anim/forest_ferns.zip"),
}

local prefabs =
{
    "foliage",
}

local NUM_VARIATIONS = 4

local function KillPlant(inst)
    inst._killtask = nil
--    inst.components.pickable.caninteractwith = false
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("wilt"..inst.variation)
end

local function OnBloomed(inst)
    inst:RemoveEventCallback("animover", OnBloomed)
    inst.AnimState:PlayAnimation("idle"..inst.variation, true)
--    inst.components.pickable.caninteractwith = true
    inst._killtask = inst:DoTaskInTime(TUNING.STALKER_BLOOM_DECAY + math.random(), KillPlant)
end

local function OnPicked(inst)--, picker, loot)
    if inst._killtask ~= nil then
        inst._killtask:Cancel()
        inst._killtask = nil
    end
    inst:RemoveEventCallback("animover", OnBloomed)
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("picked"..inst.variation)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("forest_fern")
    inst.AnimState:SetBuild("forest_ferns")
    inst.AnimState:PlayAnimation("bloom")

    inst:AddTag("stalkerbloom")
	inst:AddTag("NOCLICK")
    inst:SetPrefabNameOverride("cave_fern")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
  if math.random() < 0.2 then
inst.Transform:SetScale(0.65, 0.65, 0.65)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.9, 0.9, 0.9)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.7, 0.7, 0.7)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.55, 0.55, 0.55)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.6, 0.6, 0.6)
else
inst.Transform:SetScale(0.85, 0.85, 0.85)
end
    --inst.SoundEmitter:PlaySound("dontstarve/creatures/together/stalker/flowergrow")
	--inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")

    inst.variation = math.random(NUM_VARIATIONS)
    if inst.variation > 1 then
        inst.variation = tostring(inst.variation)
        inst.AnimState:PlayAnimation("bloom"..inst.variation)
    else
        inst.variation = ""
    end

--[[    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable.onpickedfn = OnPicked
    inst.components.pickable.quickpick = true
    inst.components.pickable.caninteractwith = false
    inst.components.pickable:SetUp("foliage", 1000000, inst.variation == "2" and 1 or 2)
    inst.components.pickable:Pause()
]]
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:ListenForEvent("animover", OnBloomed)

    ---------------------

    ---------------------

    

    inst.persists = false

    return inst
end

return Prefab("musha_fern", fn, assets, prefabs)

local assets =
{
	Asset("ANIM", "anim/apple_glowberry.zip"),
}

local prefabs =
{
    "green_fruit",
}

local FADE_FRAMES = 26
local FADE_INTENSITY = .8
local FADE_FALLOFF = .5
local FADE_RADIUS = 1.5

local function OnUpdateFade(inst)
    local k
    if inst._fade:value() <= FADE_FRAMES then
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES))
        k = inst._fade:value() / FADE_FRAMES
        k = k * k
    else
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES * 2 + 1))
        k = (FADE_FRAMES * 2 + 1 - inst._fade:value()) / FADE_FRAMES
    end

    inst.Light:SetIntensity(FADE_INTENSITY * k)
    inst.Light:SetRadius(FADE_RADIUS * k)
    inst.Light:SetFalloff(1 - (1 - FADE_FALLOFF) * k)

    if TheWorld.ismastersim then
        inst.Light:Enable(inst._fade:value() > 0 and inst._fade:value() <= FADE_FRAMES * 2)
    end

    if inst._fade:value() == FADE_FRAMES or inst._fade:value() > FADE_FRAMES * 2 then
        inst._fadetask:Cancel()
        inst._fadetask = nil
    end
end

local function OnFadeDirty(inst)
    if inst._fadetask == nil then
        inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
    end
    OnUpdateFade(inst)
end

local function FadeOut(inst, instant)
    if instant then
        inst._fade:set(FADE_FRAMES * 2 + 1)
        OnFadeDirty(inst)
    elseif inst._fade:value() <= FADE_FRAMES then
        inst._fade:set(FADE_FRAMES * 2 + 1 - inst._fade:value())
        if inst._fadetask == nil then
            inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
        end
    end
end

local function KillPlant(inst)
    inst._killtask = nil
    inst.components.pickable.caninteractwith = false
    FadeOut(inst)
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("wilt")
end

local function OnBloomed(inst)
    inst:RemoveEventCallback("animover", OnBloomed)
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.components.pickable.caninteractwith = true
    inst._killtask = inst:DoTaskInTime(TUNING.STALKER_BLOOM_DECAY + math.random(), KillPlant)
end

local function OnPicked(inst)--, picker, loot)
    if inst._killtask ~= nil then
        inst._killtask:Cancel()
        inst._killtask = nil
    end
    FadeOut(inst, true)
    inst:RemoveEventCallback("animover", OnBloomed)
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("picked_wilt")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.Light:SetFalloff(FADE_FALLOFF)
    inst.Light:SetIntensity(FADE_INTENSITY)
    inst.Light:SetRadius(FADE_RADIUS)
    inst.Light:SetColour(1, 1, 1)
    inst.Light:Enable(false)
    inst.Light:EnableClientModulation(true)

    inst.AnimState:SetBank("forest_glowberry")
    inst.AnimState:SetBuild("apple_glowberry")
    inst.AnimState:PlayAnimation("bloom")

    inst:AddTag("stalkerbloom")

    inst._fade = net_smallbyte(inst.GUID, "apple_berry._fade", "fadedirty")
    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)

    inst:SetPrefabNameOverride("wormlight_plant")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("fadedirty", OnFadeDirty)

        return inst
    end

    --inst.SoundEmitter:PlaySound("dontstarve/creatures/together/stalker/flowergrow")
	
  if math.random() < 0.2 then
inst.Transform:SetScale(0.75, 0.75, 0.75)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.9, 0.9, 0.9)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.95, 0.95, 0.95)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.8, 0.8, 0.8)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.85, 0.85, 0.85)
else
inst.Transform:SetScale(1, 1, 1)
end

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
    inst.components.pickable.onpickedfn = OnPicked
    inst.components.pickable.caninteractwith = false
    inst.components.pickable:SetUp("green_fruit", 1000000)
    inst.components.pickable:Pause()

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:ListenForEvent("animover", OnBloomed)

    ---------------------
    --MakeMediumBurnable(inst)
   -- MakeSmallPropagator(inst)
    --Clear default handlers so we don't stomp our .persists flag
  --  inst.components.burnable:SetOnIgniteFn(nil)
   -- inst.components.burnable:SetOnExtinguishFn(nil)
    ---------------------

    MakeHauntableIgnite(inst)

    inst.persists = false

    return inst
end

return Prefab("apple_berry", fn, assets, prefabs)

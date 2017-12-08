local assets=
{
	Asset("ANIM", "anim/glowdust.zip"),
  Asset("ATLAS", "images/inventoryimages/glowdust.xml"),
  Asset("IMAGE", "images/inventoryimages/glowdust.tex"),

}


local lightprefabs =
{
    "wormlight_light_fx",
}

local function OnPickup(inst)
    inst.components.disappears:StopDisappear()
end

local function OnDropped(inst)
    inst.components.disappears:PrepareDisappear()
end

local function OnHaunt(inst)
SpawnPrefab("musha_spore").Transform:SetPosition(inst:GetPosition():Get())
    inst.components.disappears:Disappear()
    return true
end
---------------------------
local function create_light(eater, lightprefab)
    if eater.wormlight ~= nil then
        if eater.wormlight.prefab == lightprefab then
            eater.wormlight.components.spell.lifetime = 0
            eater.wormlight.components.spell:ResumeSpell()
            return
        else
            eater.wormlight.components.spell:OnFinish()
        end
    end

    local light = SpawnPrefab(lightprefab)
    light.components.spell:SetTarget(eater)
    if light:IsValid() then
        if light.components.spell.target == nil then
            light:Remove()
        else
            light.components.spell:StartSpell()
        end
    end
end

local function item_oneaten(inst, eater)
if eater:HasTag("musha") and not eater.Sleep_Princess then
eater.stamina = eater.stamina + 10
eater.fatigue = eater.fatigue - 20
--eater.music = eater.music + 100  --test
if eater.fatigue <= 0 then
eater.fatigue = eater.fatigue *0
end
if eater.stamina > 120 then
eater.stamina = eater.stamina *0 +120
end
SpawnPrefab("musha_spore").Transform:SetPosition(eater:GetPosition():Get())
end
 
create_light(eater, "wormlight_light")
end

local function itemfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
  
	inst.AnimState:SetBank("ashes")
    inst.AnimState:SetBuild("glowdust")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryPhysics(inst)
   local light = inst.entity:AddLight()
    light:SetFalloff(0.7)
    light:SetIntensity(.5)
    light:SetRadius(0.5)
    light:SetColour(69/255, 131/255, 145/255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	inst.Transform:SetScale(0.7,0.7,0.7)
	
	inst.entity:SetPristine() 

          	if not TheWorld.ismastersim then
   return inst
end	
 
    inst:AddComponent("inspectable")
   inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
    inst.components.fuel.fueltype = FUELTYPE.CAVE
    inst:AddComponent("disappears")
    inst.components.disappears.sound = "dontstarve/common/dust_blowaway"
    inst.components.disappears.anim = "disappear"
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
	
    inst.components.inventoryitem.atlasname = "images/inventoryimages/glowdust.xml"
 
    inst:AddComponent("tradable")
    
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.healthvalue = 10
    inst.components.edible.hungervalue = 5
    inst.components.edible.sanityvalue = 30
    inst.components.edible:SetOnEatenFn(item_oneaten)

	  inst:ListenForEvent("ondropped", OnDropped)
    inst.components.disappears:PrepareDisappear()

    inst:AddComponent("hauntable")
    inst.components.hauntable.cooldown_on_successful_haunt = false
    inst.components.hauntable.usefx = false
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)
	
    return inst
end

local function light_resume(inst, time)
    inst.fx:setprogress(1 - time / inst.components.spell.duration)
end

local function light_start(inst)
    inst.fx:setprogress(0)
end

local function light_spellfn(inst, target, variables)
    if target then
        inst.Transform:SetPosition(target:GetPosition():Get())
    end
end


local function light_ontarget(inst, target)
    if target == nil or target:HasTag("playerghost") or target:HasTag("overcharge") then
        inst:Remove()
        return
    end

    local function forceremove()
        inst.components.spell:OnFinish()
    end

    target.wormlight = inst
    inst.Follower:FollowSymbol(target.GUID, "", 0, 0, 0)
    target:AddTag(inst.components.spell.spellname)
    inst.fx.entity:SetParent(target.entity)
    inst:ListenForEvent("onremove", forceremove, target)

    if target:HasTag("player") then
        inst:ListenForEvent("ms_becameghost", forceremove, target)
        if target:HasTag("electricdamageimmune") then
            inst:ListenForEvent("ms_overcharge", forceremove, target)
        end
     --   target.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.persists = false
    else
      --  target.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.persists = true
    end
end
	
local function light_onfinish(inst)
    local target = inst.components.spell.target
    if target ~= nil then
        target.wormlight = nil
        
    end
end

local light_variables = {
    radius = TUNING.WORMLIGHT_RADIUS,
}

local function light_onremove(inst)
    inst.fx:Remove()
end

local function light_commonfn(duration, fxprefab)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst:Hide()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]

    inst:AddComponent("spell")
    inst.components.spell.spellname = "wormlight"
    inst.components.spell.duration = duration
    inst.components.spell.ontargetfn = light_ontarget
    inst.components.spell.onstartfn = light_start
    inst.components.spell.onfinishfn = light_onfinish
    inst.components.spell.resumefn = light_resume
    inst.components.spell.removeonfinish = true

    inst.persists = false --until we get a target
    inst.fx = SpawnPrefab(fxprefab)
    inst.OnRemoveEntity = light_onremove

   return inst
end	

local function lightfn()
    return light_commonfn(TUNING.WORMLIGHT_DURATION, "wormlight_light_fx")
end
-----------------------------------------------------------------------
-----------------------------------------------------------------------

local function OnUpdateLight(inst, dframes)
    local frame =
        inst._lightdead:value() and
        math.ceil(inst._lightframe:value() * .9 + inst._lightmaxframe * .1) or
        (inst._lightframe:value() + dframes)

    if frame >= inst._lightmaxframe then
        inst._lightframe:set_local(inst._lightmaxframe)
        inst._lighttask:Cancel()
        inst._lighttask = nil
    else
        inst._lightframe:set_local(frame)
    end

    inst.Light:SetRadius(TUNING.WORMLIGHT_RADIUS * (1 - inst._lightframe:value() / inst._lightmaxframe))
end

local function OnLightDirty(inst)
    if inst._lighttask == nil then
        inst._lighttask = inst:DoPeriodicTask(FRAMES, OnUpdateLight, nil, 1)
    end
    OnUpdateLight(inst, 0)
end

local function setprogress(inst, percent)
    inst._lightframe:set(math.max(0, math.min(inst._lightmaxframe, math.floor(percent * inst._lightmaxframe + .5))))
    OnLightDirty(inst)
end

local function setdead(inst)
    inst._lightdead:set(true)
    inst._lightframe:set(inst._lightframe:value())
end

local function lightfx_commonfn(duration)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.Light:SetRadius(0)
    inst.Light:SetIntensity(.8)
    inst.Light:SetFalloff(.5)
    inst.Light:SetColour(169/255, 231/255, 245/255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    inst._lightmaxframe = math.floor(duration / FRAMES + .5)
    inst._lightframe = net_ushortint(inst.GUID, "wormlight_light_fx._lightframe", "lightdirty")
    inst._lightframe:set(inst._lightmaxframe)
    inst._lightdead = net_bool(inst.GUID, "wormlight_light_fx._lightdead")
    inst._lighttask = nil

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("lightdirty", OnLightDirty)

        return inst
    end

    inst.setprogress = setprogress
    inst.setdead = setdead
    inst.persists = false

    return inst
end


return Prefab( "common/inventory/glowdust", itemfn, assets),
       Prefab("common/inventory/wormlight_light", lightfn, nil, lightprefabs)
 
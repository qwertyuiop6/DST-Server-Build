local assets =
{
	Asset("ANIM", "anim/musha_oven_fire.zip"),
	Asset("SOUND", "sound/common.fsb"),
}

local heats = { 70, 85, 100, 115 }
local function GetHeatFn(inst)
	return heats[inst.components.firefx.level] or 20
end

local function fn(Sim)

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("chiminea_fire")
    inst.AnimState:SetBuild("musha_oven_fire")
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetFinalOffset(-1)
	
    inst:AddTag("fx")
	
   inst:AddTag("HASHEATER")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("heater")
    inst.components.heater.heatfn = GetHeatFn

    inst:AddComponent("firefx")
    inst.components.firefx.levels =
    {
        {anim="level1", sound="dontstarve/common/campfire", radius=2, intensity=.8, falloff=.33, colour = {255/255,255/255,192/255}, soundintensity=.1},
        {anim="level2", sound="dontstarve/common/campfire", radius=3, intensity=.8, falloff=.33, colour = {255/255,255/255,192/255}, soundintensity=.3},
        {anim="level3", sound="dontstarve/common/campfire", radius=4, intensity=.8, falloff=.33, colour = {255/255,255/255,192/255}, soundintensity=.6},
        {anim="level4", sound="dontstarve/common/campfire", radius=5, intensity=.8, falloff=.33, colour = {255/255,255/255,192/255}, soundintensity=1},
    }
    
    inst.components.firefx:SetLevel(1)
    inst.components.firefx.usedayparamforsound = true
    return inst
end

return Prefab( "common/fx/musha_ovenfire", fn, assets) 

local assets =
{
	Asset("ANIM", "anim/musha_oven_fire_cold.zip"),
	Asset("SOUND", "sound/common.fsb"),
}

local lightColour = {0, 183/255, 1}
local heats = {-10, -20, -30, -40}
local function GetHeatFn(inst)
	return heats[inst.components.firefx.level] or -20
end

local function fn(Sim)
   local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("chiminea_fire")
    inst.AnimState:SetBuild("musha_oven_fire_cold")
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
    inst.components.heater:SetThermics(false, true)

    inst:AddComponent("firefx")
    inst.components.firefx.levels =
    {
        {anim="level1", sound="dontstarve_DLC001/common/coldfire", radius=2, intensity=.8, falloff=.33, colour = lightColour, soundintensity=.1},
        {anim="level2", sound="dontstarve_DLC001/common/coldfire", radius=3, intensity=.8, falloff=.33, colour = lightColour, soundintensity=.3},
        {anim="level3", sound="dontstarve_DLC001/common/coldfire", radius=4, intensity=.8, falloff=.33, colour = lightColour, soundintensity=.6},
        {anim="level4", sound="dontstarve_DLC001/common/coldfire", radius=5, intensity=.8, falloff=.33, colour = lightColour, soundintensity=1},
    }
    
    
    inst.components.firefx:SetLevel(1)
    inst.components.firefx.usedayparamforsound = true
    return inst
end

return Prefab( "common/fx/musha_ovenfire_cold", fn, assets) 

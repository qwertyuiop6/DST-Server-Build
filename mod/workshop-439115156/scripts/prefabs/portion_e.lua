local assets=
{
	Asset("ANIM", "anim/portion_e.zip"),
  Asset("ATLAS", "images/inventoryimages/portion_e.xml"),
  Asset("IMAGE", "images/inventoryimages/portion_e.tex"),

}

local function item_oneaten(inst, eater)
if eater:HasTag("musha") then
eater.stamina = eater.stamina + 50
eater.fatigue = eater.fatigue - 100
if eater.fatigue < 0 then
eater.fatigue = eater.fatigue *0
end
if eater.stamina > 120 then
eater.stamina = eater.stamina *0 +120
end
end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("bulb")
    inst.AnimState:SetBuild("portion_e")
    inst.AnimState:PlayAnimation("idle")
	--inst:AddTag("portion_e")
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
	--inst.Transform:SetScale(1,1,1)  
    --inst:AddComponent("stackable")
	--inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	--inst:AddComponent("fuel")
    --inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
    --inst.components.fuel.fueltype = "CAVE"
	
     inst:AddComponent("tradable")
     inst:AddComponent("edible")
     --inst.components.edible.foodtype = "VEGGIE"
	 inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst.components.edible.sanityvalue = 45
    inst.components.edible.healthvalue = 45
    inst.components.edible.hungervalue = 1
	inst.components.edible:SetOnEatenFn(item_oneaten)
	inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
	inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_BRIEF

	
    local light = inst.entity:AddLight()
    light:SetFalloff(0.6)
    light:SetIntensity(.5)
    light:SetRadius(0.25)
    light:SetColour(69/255, 131/255, 145/255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	

    ---------------------       
    
    inst:AddComponent("inspectable")
	--inst.components.inspectable.getstatus = GetStatus
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/portion_e.xml"

		
    return inst
end

return Prefab( "portion_e", fn, assets)
		

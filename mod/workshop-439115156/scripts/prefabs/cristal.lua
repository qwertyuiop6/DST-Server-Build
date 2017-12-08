local assets=
{
  Asset("ANIM", "anim/cristal.zip"),
  Asset("ATLAS", "images/inventoryimages/cristal.xml"),
  Asset("IMAGE", "images/inventoryimages/cristal.tex"),
}
local CRY_NEAR_LEADER_DISTANCE = 8

local function item_oneaten(inst, eater)
if eater:HasTag("musha") then
--eater:AddTag("lucky")
--eater.components.talker:Say("[Buff]\nNext Lucky points x50 by repair")
end
if not eater:HasTag("yamche") then
local poopchance = 0.5

	local dark2 = SpawnPrefab("statue_transition_2")
	dark2.Transform:SetPosition(eater:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(eater:GetPosition():Get())
	--SpawnPrefab("orange_leaves").Transform:SetPosition(eater:GetPosition():Get())
	--SpawnPrefab("red_leaves").Transform:SetPosition(eater:GetPosition():Get())
      if math.random() < 0.6 then
		local poo = SpawnPrefab("wormlight_plant")
		poo.Transform:SetPosition(eater.Transform:GetWorldPosition())	
			SpawnPrefab("yellow_leaves").Transform:SetPosition(eater:GetPosition():Get())
    elseif math.random() < 0.3 then
		local poo = SpawnPrefab("flower_cave")
		poo.Transform:SetPosition(eater.Transform:GetWorldPosition())	
			SpawnPrefab("yellow_leaves").Transform:SetPosition(eater:GetPosition():Get())
    elseif math.random() < 0.4 then
		local poo = SpawnPrefab("flower_cave_double")
		poo.Transform:SetPosition(eater.Transform:GetWorldPosition())	
			SpawnPrefab("yellow_leaves").Transform:SetPosition(eater:GetPosition():Get())
    elseif math.random() < 0.5 then
		local poo = SpawnPrefab("flower_cave_triple")
		poo.Transform:SetPosition(eater.Transform:GetWorldPosition())	
			SpawnPrefab("yellow_leaves").Transform:SetPosition(eater:GetPosition():Get())
    else
		local poo = SpawnPrefab("apple_berry")
		poo.Transform:SetPosition(eater.Transform:GetWorldPosition())	
			SpawnPrefab("yellow_leaves").Transform:SetPosition(eater:GetPosition():Get())
	end	
end 
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    inst.AnimState:SetBank("bulb")
    inst.AnimState:SetBuild("cristal")
    inst.AnimState:PlayAnimation("idle")

      inst.entity:AddLight()
    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(1.5)
    inst.Light:SetColour(69/255, 180/255, 200/255)
    inst.Light:Enable(true)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "cristal.tex" )

		inst:AddComponent("edible")
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
		inst.components.edible:SetOnEatenFn(item_oneaten)	   
  inst.components.edible.hungervalue = 2
	inst.components.edible.healthvalue = 1000
	inst.components.edible.sanityvalue = 2
    inst:AddComponent("tradable")
	
 inst.entity:SetPristine()
 
   if not TheWorld.ismastersim then
        return inst
    end	
	  
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
inst.components.inventoryitem.atlasname = "images/inventoryimages/cristal.xml"

    return inst
end

return Prefab( "common/inventory/cristal", fn, assets) 


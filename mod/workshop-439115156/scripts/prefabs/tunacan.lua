local assets=
{
	Asset("ANIM", "anim/tuna.zip"),
	Asset("ANIM", "anim/swap_tunacan.zip"),
}


local prefabs =
{
 "fish_cooked"
 }    
 
local function Offuse(inst)

end

local function Open(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
  			local stacksize = 1 
	     			if inst.components.stackable then 
	     				stacksize = inst.components.stackable:StackSize()
	     			end 
	
					local fish = SpawnPrefab("fish_cooked")
	     			if fish.components.stackable then 
	     				fish.components.stackable:SetStackSize(stacksize)
	     			end 
					
	     			inst:Remove()
					local x,y,z = inst.Transform:GetWorldPosition()
					local ents = TheSim:FindEntities(x,y,z, 2, {"player"})
					for k,v in pairs(ents) do
					if v then
					v.components.inventory:GiveItem(fish)
					else
					fish.Transform:SetPosition(inst:GetPosition():Get())
					end
					end
end

local function Onuse(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
  			local stacksize = 1 
	     			if inst.components.stackable then 
	     				stacksize = inst.components.stackable:StackSize()
	     			end 
	
					local fish = SpawnPrefab("fish_cooked")
	     			if fish.components.stackable then 
	     				fish.components.stackable:SetStackSize(stacksize)
	     			end 
	     			--inst:Remove()
local player = inst.components.inventoryitem.owner

  if player and player.components.inventory then
  player.components.inventory:GiveItem(fish)
  else
  fish.Transform:SetPosition(inst:GetPosition():Get())
  end
  inst:Remove()			
				
	inst.components.useableitem:StopUsingItem()				
end

local function onequip(inst, owner)
 
	inst.components.weapon:SetDamage(10)
    owner.AnimState:OverrideSymbol("swap_object", "swap_tunacan", "swap_compass")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

end
local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
  
end
local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	 inst:AddTag("compass")
    inst.AnimState:SetBank("tuna")
    inst.AnimState:SetBuild("tuna")
    inst.AnimState:PlayAnimation("idle")
    
    MakeInventoryPhysics(inst)
	
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst:AddComponent("stackable")
	--inst.components.stackable.maxsize = 10
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM
	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/tunacan.xml"
	
   
    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 1
    

	inst:AddComponent("machine")
	inst.components.machine.turnonfn = Open
    inst.components.machine.turnofffn = Offuse
    inst.components.machine.cooldowntime = 0
	
	inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(Onuse)

	inst:AddComponent("weapon")
	
	MakeHauntableLaunch(inst)
	
    return inst
end

return Prefab("common/inventory/tunacan", fn, assets, prefabs)

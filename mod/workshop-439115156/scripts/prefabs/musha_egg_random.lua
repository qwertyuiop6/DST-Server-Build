require "prefabutil"
local assets=
{
	Asset("ANIM", "anim/musha_egg_random.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_random.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_random.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_random_cracked.tex"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_random_cracked.xml"),
--	Asset("ATLAS", "images/inventoryimages/musha_egg_cooked.xml"),

}

local prefabs = 
{
	"musha_small",
	"arong_baby",
	"moontree",
	"musha_egg_random_cracked",
}

local loot_hot = 
{
  --  "musha_egg",
}

local loot_cold = 
{
  --  "musha_egg",
}
----------------
local function Activateicon(inst)
local minimap = TheWorld.minimap.MiniMap
    --inst.activatetask = nil
	minimap:DrawForgottenFogOfWar(true)
	if not inst.components.maprevealer then
		inst:AddComponent("maprevealer")
	end
	inst.components.maprevealer.revealperiod = 1
	inst.components.maprevealer:Start()
		
end
 local function UpdatePositionYamche(inst)
	if inst and inst.owner then
		local x, y, z = inst.Transform:GetWorldPosition()
	
		inst.net_x:set(x)
		inst.net_y:set(z)
	end
end

local function Hatch(inst)
    --print("tallbirdegg - Hatch")
	local random1 = 0.15
	local random2 = 0.25	
	local random3 = 0.2	
	local last = 1
	
if math.random() < random1 then
    local smallbird = SpawnPrefab("musha_small")
    smallbird.Transform:SetPosition(inst.Transform:GetWorldPosition())
    smallbird.sg:GoToState("hatch")
    inst:Remove()
elseif math.random() < random2 then 	
	local smallcow1 = SpawnPrefab("arong_baby")
    smallcow1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    smallcow1.sg:GoToState("grow_up")
    inst:Remove()
elseif math.random() < random3 then 	
	local smalltree = SpawnPrefab("moontree")
    smalltree.Transform:SetPosition(inst.Transform:GetWorldPosition())
    smalltree.sg:GoToState("sleeping")
    inst:Remove()	
elseif math.random() <= last then 	
    local smallbird = SpawnPrefab("musha_teenice")
    smallbird.Transform:SetPosition(inst.Transform:GetWorldPosition())
    smallbird.sg:GoToState("hatch")
    inst:Remove()	
	end
end

local function CheckHatch(inst)
    --print("tallbirdegg - CheckHatch")
    if inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch(inst)
    end
end

local function PlayUncomfySound(inst)
    inst.SoundEmitter:KillSound("uncomfy")
    if inst.components.hatchable.toohot then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_steam_LP", "uncomfy")
    elseif inst.components.hatchable.toocold then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_cold_shiver_LP", "uncomfy")
    end
end

local function OnNear(inst)
    --print("tallbirdegg - OnNear")
    inst.playernear = true
    CheckHatch(inst)
end

local function OnFar(inst)
    --print("tallbirdegg - OnFar")
    inst.playernear = false
end

local function OnDropped(inst)
    --print("tallbirdegg - OnDropped")
    inst.components.hatchable:StartUpdating()
    CheckHatch(inst)
    PlayUncomfySound(inst)
end

local function OnPutInInventory(inst)
    --print("tallbirdegg - OnPutInInventory")
    inst.components.hatchable:StopUpdating()
    inst.SoundEmitter:KillSound("uncomfy")
end

local function GetStatus(inst)
    if inst.components.hatchable then
        local state = inst.components.hatchable.state
        if state == "uncomfy" then
            if inst.components.hatchable.toohot then
                return "HOT"
            elseif inst.components.hatchable.toocold then
                return "COLD"
            end
        end
    end
end

local function DropLoot(inst)
    --print("tallbirdegg - DropLoot")
    
    inst:AddComponent("lootdropper")
    if inst.components.hatchable.toohot then

        inst.components.lootdropper:SetLoot(loot_hot)
    else
        inst.components.lootdropper:SetLoot(loot_cold)
    end
    inst.components.lootdropper:DropLoot()
end

local function OnHatchState(inst, state)
    --print("tallbirdegg - OnHatchState", state)
    
    inst.SoundEmitter:KillSound("uncomfy")

    if state == "crack" then
        local cracked = SpawnPrefab("musha_egg_random_cracked")
        cracked.Transform:SetPosition(inst.Transform:GetWorldPosition())
        cracked.AnimState:PlayAnimation("crack")
        cracked.AnimState:PushAnimation("idle_happy", true)
        cracked.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hatch_crack")
        inst:Remove()
    elseif state == "uncomfy" then
        if inst.components.hatchable.toohot then
            inst.AnimState:PlayAnimation("idle_hot", true)
        elseif inst.components.hatchable.toocold then
            inst.AnimState:PlayAnimation("idle_cold", true)
        end
        PlayUncomfySound(inst)
    elseif state == "comfy" then
        inst.AnimState:PlayAnimation("idle_happy", true)
    elseif state == "hatch" then
        CheckHatch(inst)

    elseif state == "dead" then
        --print("   ACK! *splat*")
        if inst.components.hatchable.toohot then
            inst.AnimState:PlayAnimation("toohot")
        elseif inst.components.hatchable.toocold then
            inst.AnimState:PlayAnimation("toocold")
        end

--[[
    elseif state == "dead" then
        --print("   ACK! *splat*")
        if inst.components.hatchable.toohot then
            inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_jump")
            inst:DoTaskInTime(20*FRAMES, function() inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_explo") end)
            inst:DoTaskInTime(20*FRAMES, DropLoot)
            inst.AnimState:PlayAnimation("toohot")
        elseif inst.components.hatchable.toocold then
            inst:DoTaskInTime(15*FRAMES, function() inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_cold_freeze") end)
            inst:DoTaskInTime(30*FRAMES, DropLoot)
            inst.AnimState:PlayAnimation("toocold")
        end
]]--
        inst:ListenForEvent("animover", function(inst) inst:Remove() end)
    end
end
-----
local function onequip_mushaegg(inst) 
     inst.Light:Enable(true)
	 inst.playernear = true	 
end

local function onunequip_mushaegg(inst) 
    inst.Light:Enable(false)
    inst.playernear = false
end

local function onequip_mushaegg_cracked(inst) 
	inst.Light:Enable(true)
	 inst.playernear = true	
	 inst.components.hatchable:StartUpdating()
 end

local function onunequip_mushaegg_cracked(inst) 
	inst.Light:Enable(false)
    inst.playernear = true	
	inst.components.hatchable:StopUpdating()
 end

local function commonfn(inst)
local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
		inst.entity:AddLight()
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(125/255, 125/255, 125/255)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		
   MakeInventoryPhysics(inst)
   
    inst.AnimState:SetBank("egg")     
    inst.AnimState:SetBuild("musha_egg_random")
    inst.AnimState:PlayAnimation("egg")
	
    return inst
end

local function defaultfn()
		local inst = commonfn()
 
	inst.entity:AddSoundEmitter()
 
    inst.AnimState:PlayAnimation("egg")
    inst.Light:Enable(true)
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg_random.tex" )
	 
	inst.MiniMapEntity:SetPriority(10)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
    inst:AddComponent("hatchable")
    inst.components.hatchable:SetOnState(OnHatchState)
    inst.components.hatchable:SetCrackTime(TUNING.SMALLBIRD_HATCH_CRACK_TIME)
   -- inst.components.hatchable:SetHatchTime(TUNING.SMALLBIRD_HATCH_TIME)
    inst.components.hatchable:SetHatchTime(120)
    inst.components.hatchable:SetHatchFailTime(TUNING.SMALLBIRD_HATCH_TIME * 9999999999999999999)
   -- inst.components.hatchable:StartUpdating()
	inst.components.hatchable:StopUpdating()
	
	inst.playernear = false
	--inst.UpdatePositionYamche = UpdatePositionYamche	
	
	inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)
		
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
  	inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus	
	

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg_random.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
 

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = 0.7
    inst.components.equippable.runspeedmult = 0.7

        inst.components.equippable:SetOnEquip( onequip_mushaegg )
        inst.components.equippable:SetOnUnequip( onunequip_mushaegg )
inst.activatetask = inst:DoTaskInTime(0.1, Activateicon)
	return inst
end

local function crackedfn()
   -- local inst = defaultfn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
		inst.entity:AddLight()
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(125/255, 125/255, 125/255)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	inst.Light:Enable(true)
	
   MakeInventoryPhysics(inst)
   
    inst.AnimState:SetBank("egg")     
    inst.AnimState:SetBuild("musha_egg_random")
    inst.AnimState:PlayAnimation("egg")
	
    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg_random_cracked.tex" )
    inst.Light:Enable(false)
	 	inst.MiniMapEntity:SetPriority(10)
	
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
    inst:AddComponent("hatchable")
    inst.components.hatchable:SetOnState(OnHatchState)
    inst.components.hatchable:SetCrackTime(TUNING.SMALLBIRD_HATCH_CRACK_TIME)
   -- inst.components.hatchable:SetHatchTime(TUNING.SMALLBIRD_HATCH_TIME)
     inst.components.hatchable:SetHatchTime(120)
    inst.components.hatchable:SetHatchFailTime(TUNING.SMALLBIRD_HATCH_TIME * 9999999999999999999)
    inst.components.hatchable:StartUpdating()
	
	inst.components.hatchable.state = "comfy"
    inst.AnimState:PlayAnimation("idle_happy")
	
	inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)
			
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end		

		inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus	
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg_random_cracked.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
	inst.components.inventoryitem.cangoincontainer = false

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = 0.7
    inst.components.equippable.runspeedmult = 0.7

        inst.components.equippable:SetOnEquip( onequip_mushaegg )
        inst.components.equippable:SetOnUnequip( onunequip_mushaegg )
		
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 6)
    inst.components.playerprox:SetOnPlayerNear(OnNear)
    inst.components.playerprox:SetOnPlayerFar(OnFar)
    
------------------------
       inst.components.equippable:SetOnEquip( onequip_mushaegg_cracked )
       inst.components.equippable:SetOnUnequip( onunequip_mushaegg_cracked  )

    return inst
end

return Prefab( "common/inventory/musha_egg_random", defaultfn, assets, prefabs),
		Prefab( "common/inventory/musha_egg_random_cracked", crackedfn, assets)

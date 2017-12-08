local assets=
{
	Asset("ANIM", "anim/musha_egg8.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_egg8.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_egg8.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_cracked8.tex"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked8.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cooked.xml"),

}

local prefabs = 
{
	"musha_rp1",
	"musha_rp2",
	"musha_rp3",
	"musha_rp4",
	"musha_rp5",
	"musha_rp6",
	"musha_rp7",
	"musha_rpice",

	"musha_egg_cracked8",
	--"musha_egg_cooked",
	--"spoiled_food",
}

local loot_hot = 
{
   -- "musha_egg8",
}

local loot_cold = 
{
   -- "musha_egg8",
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
local function Hatch1(inst)
    
   
    local rp1= SpawnPrefab("musha_rp1")
    rp1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp1.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch2(inst)
    
   
    local rp2= SpawnPrefab("musha_rp2")
    rp2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp2.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch3(inst)
    
   
    local rp3= SpawnPrefab("musha_rp3")
    rp3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp3.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch4(inst)
    
   
    local rp4= SpawnPrefab("musha_rp4")
    rp4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp4.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch5(inst)
    
   
    local rp5= SpawnPrefab("musha_rp5")
    rp5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp5.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch6(inst)
    
   
    local rp6= SpawnPrefab("musha_rp6")
    rp6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp6.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch7(inst)
    
   
    local rp7= SpawnPrefab("musha_rp7")
    rp7.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp7.sg:GoToState("hatch")

    inst:Remove()
end
local function Hatch8(inst)
    
   
    local rp8= SpawnPrefab("musha_rpice")
    rp8.Transform:SetPosition(inst.Transform:GetWorldPosition())
    rp8.sg:GoToState("hatch")

    inst:Remove()
end

local function CheckHatch(inst)
    --print("tallbirdegg - CheckHatch")
local random = 0.1
local last = 1

    if math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch1(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch8(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch2(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch3(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch4(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch5(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch6(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch6(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch7(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch8(inst)

    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch5(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch4(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch3(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch2(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch1(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch8(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch2(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch3(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch4(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch5(inst)
    elseif math.random() < last and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch6(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch7(inst)
    elseif math.random() < random and inst.playernear and inst.components.hatchable.state == "hatch" then
        Hatch8(inst)

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
inst:RemoveTag("rp1")
inst:RemoveTag("rp2")
inst:RemoveTag("rp3")
inst:RemoveTag("rp4")
inst:RemoveTag("rp5")

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
        local cracked = SpawnPrefab("musha_egg_cracked8")
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
	 inst.playernear = false	 
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
    inst.AnimState:SetBuild("musha_egg8")
    inst.AnimState:PlayAnimation("egg")
	
    return inst
end

local function defaultfn()
		local inst = commonfn()
 
	inst.entity:AddSoundEmitter()
 
    inst.AnimState:PlayAnimation("egg")
    inst.Light:Enable(true)
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg8.tex" )
	inst.MiniMapEntity:SetPriority(10)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	--inst.UpdatePositionYamche = UpdatePositionYamche
	
    inst:AddComponent("hatchable")
    inst.components.hatchable:SetOnState(OnHatchState)
    inst.components.hatchable:SetCrackTime(TUNING.SMALLBIRD_HATCH_CRACK_TIME)
   -- inst.components.hatchable:SetHatchTime(TUNING.SMALLBIRD_HATCH_TIME)
    inst.components.hatchable:SetHatchTime(120)
    inst.components.hatchable:SetHatchFailTime(TUNING.SMALLBIRD_HATCH_TIME * 9999999999999999999)
    inst.components.hatchable:StopUpdating()
	
	inst.playernear = false
	
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg8.xml"
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
    inst.AnimState:SetBuild("musha_egg8")
    inst.AnimState:PlayAnimation("egg")
	
    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg_cracked8.tex" )
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg_cracked8.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
	inst.components.inventoryitem.cangoincontainer = false

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = 0.7
    inst.components.equippable.runspeedmult = 0.7
		
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 6)
    inst.components.playerprox:SetOnPlayerNear(OnNear)
    inst.components.playerprox:SetOnPlayerFar(OnFar)
    
------------------------
       inst.components.equippable:SetOnEquip( onequip_mushaegg_cracked )
       inst.components.equippable:SetOnUnequip( onunequip_mushaegg_cracked  )

    return inst
end


return Prefab( "common/inventory/musha_egg8", defaultfn, assets, prefabs),
		Prefab( "common/inventory/musha_egg_cracked8", crackedfn, assets)

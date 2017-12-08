local assets=
{
	Asset("ANIM", "anim/exp.zip"),
  Asset("ATLAS", "images/inventoryimages/exp.xml"),
  Asset("IMAGE", "images/inventoryimages/exp.tex"),

}

local function OnPutInInventory(inst)
   inst:AddTag("invexp")
end

local function OnDropped(inst,data)
   inst:RemoveTag("invexp")
end

local function close(inst)
local player = GetPlayer()

    if not inst:HasTag("invexp") and not player:HasTag("valkyrieh") and player:HasTag("easyd") then
        local fx2 = SpawnPrefab("sparklefx")
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 1, 1)
        fx2.Transform:SetPosition(0, 0, 0)
player.components.health:DoDelta(1000)
player.components.sanity:DoDelta(1000)
	player.level = player.level + 500
	player.components.talker:Say("extra [EXP]+0 \ndo not getting in easy mode.")
    inst:Remove()

    elseif not inst:HasTag("invexp") and not player:HasTag("valkyrieh") and player:HasTag("normald") then
        local fx2 = SpawnPrefab("sparklefx")
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 1, 1)
        fx2.Transform:SetPosition(0, 0, 0)
player.components.health:DoDelta(1000)
player.components.sanity:DoDelta(1000)
	player.level = player.level + 500
	player.components.talker:Say("extra [EXP](+1) \n".. (player.level))
    inst:Remove()
    elseif not inst:HasTag("invexp") and not player:HasTag("valkyrieh") and player:HasTag("hardd") then
        local fx2 = SpawnPrefab("sparklefx")
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 1, 1)
        fx2.Transform:SetPosition(0, 0, 0)
player.components.health:DoDelta(1000)
player.components.sanity:DoDelta(1000)
	player.level = player.level + 500
	player.components.talker:Say("extra [EXP](+2) \n".. (player.level))
    inst:Remove()
    elseif not inst:HasTag("invexp") and not player:HasTag("valkyrieh") and player:HasTag("hardcored") then
        local fx2 = SpawnPrefab("sparklefx")
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 1, 1)
        fx2.Transform:SetPosition(0, 0, 0)
player.components.health:DoDelta(1000)
player.components.sanity:DoDelta(1000)
	player.level = player.level + 500
	player.components.talker:Say("extra [EXP](+3) \n".. (player.level))
    inst:Remove()
    elseif not inst:HasTag("invexp") and not player:HasTag("valkyrieh") and player:HasTag("helld") then
        local fx2 = SpawnPrefab("sparklefx")
        fx2.entity:SetParent(player.entity)
	fx2.Transform:SetScale(1, 1, 1)
        fx2.Transform:SetPosition(0, 0, 0)
player.components.health:DoDelta(1000)
player.components.sanity:DoDelta(1000)
	player.level = player.level + 500
	player.components.talker:Say("extra [EXP](+4) \n".. (player.level))
    inst:Remove()

end
end

local function far(inst)
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
 	inst.entity:AddNetwork()

        	if not TheWorld.ismastersim then
   return inst
end	

    inst.entity:AddSoundEmitter()
    
    inst.AnimState:SetBank("bulb")
    inst.AnimState:SetBuild("exp")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetMultColour(1, 1, 1, 0.3)

    local light = inst.entity:AddLight()
    light:SetFalloff(0.3)
    light:SetIntensity(.3)
    light:SetRadius(0.3)
    light:SetColour(120/255, 120/255, 150/255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    inst:AddComponent("edible")
--    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.foodtype = "EXP2"

    inst.components.edible.sanityvalue = 0
    inst.components.edible.healthvalue = 15
    inst.components.edible.hungervalue = 0
    inst:AddComponent("tradable")
        inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "exp.tex" )

    --inst:AddComponent("stackable")
	--inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = 100000000
    inst.components.fuel.fueltype = "CHEMICAL"
    
    inst:AddComponent("inspectable")

    inst:AddComponent("bait")
    inst:AddTag("molebait")
    
    inst:AddComponent("inventoryitem")
inst.components.inventoryitem.atlasname = "images/inventoryimages/exp.xml"

        inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 5)
    inst.components.playerprox:SetOnPlayerNear(close)
    inst.components.playerprox:SetOnPlayerFar(far)

    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)

    return inst
end

return Prefab( "common/inventory/exp1000cheat", fn, assets) 


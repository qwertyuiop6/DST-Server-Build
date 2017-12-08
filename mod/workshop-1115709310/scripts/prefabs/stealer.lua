local assets=
{
	Asset("ANIM", "anim/stealer.zip"),
	Asset("ATLAS", "images/inventoryimages/stealer.xml"),
}

local prefabs = {
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "stealer", "swap")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")

    owner.workgetcoin = function(inst, data)
        local chance = 25
        if data.target then
            if data.target.prefab == "livingtree" or (data.target.prefab == "deciduoustree" and data.target.monster) then
                chance = 100
                data.target.components.workable.workleft = data.target.components.workable.workleft + 0.4
            end
            if data.target.components.lootdropper and math.random(0,100) <= chance then
                local item = data.target.components.lootdropper:SpawnLootPrefab("secoin")
                item.components.secoin.amount = math.random(1,5)
                owner:DoTaskInTime(.3, function()
                    owner.components.seplayerstatus:givesecoin(item)
                end)
            end
        end
    end

    owner:ListenForEvent("working", owner.workgetcoin, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")

    owner:RemoveEventCallback("working", owner.workgetcoin, owner)
end

local function onattack(inst, attacker, target, skipsanity)
    local chance = 50
    if target then
        if target.components.health then
            chance = chance*(1-target.components.health.absorb)
        end
        if target.prefab == "krampus" or target.prefab == "klaus" then
            chance = 100
        end
        if chance < 0 then chance = 0 elseif chance > 100 then chance = 100 end
    end
    if attacker and target and not target:HasTag("wall") and target:IsValid() and target.components.lootdropper and math.random(0,100) <= chance and target.components.health and not target.components.health.invincible then
        local item = target.components.lootdropper:SpawnLootPrefab("secoin")
        item.components.secoin.amount = math.random(1,5)
        attacker:DoTaskInTime(.3, function()
            attacker.components.seplayerstatus:givesecoin(item, item:GetPosition(), nil)
        end)
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork() 
    inst.entity:AddSoundEmitter()
	
    anim:SetBank("stealer")
    anim:SetBuild("stealer")
    anim:PlayAnimation("idle")
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP, 0.5)
    inst.components.tool:SetAction(ACTIONS.MINE, 0.5)
    inst.components.tool:SetAction(ACTIONS.HAMMER, 0.5)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetOnAttack(onattack)

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/stealer.xml"

	inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
    
    return inst
end


return Prefab( "stealer", fn, assets, prefabs) 
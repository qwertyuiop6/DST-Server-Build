local assets=
{
	Asset("ANIM", "anim/secoin.zip"),
	Asset("ATLAS", "images/inventoryimages/secoin.xml"),
}

local function shine(inst)
    if not inst.AnimState:IsCurrentAnimation("sparkle") then
        inst.AnimState:PlayAnimation("sparkle")
        inst.AnimState:PushAnimation("idle", false)
    end
    inst:DoTaskInTime(4 + math.random() * 5, shine)
end

local function PutIn(inst, owner)
    if owner and owner.components.seplayerstatus then
        owner.components.seplayerstatus:DoDeltaCoin(inst.components.secoin.amount)
        owner:DoTaskInTime(0.1, function()
            if owner and owner.components.seplayerstatus and inst then
                owner.components.inventory:RemoveItem(inst)
                inst:Remove()
            end
        end)
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
	
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    anim:SetBank("secoin")
    anim:SetBuild("secoin")
    anim:PlayAnimation("idle")

    inst:AddTag("molebait")
    inst:AddTag("quakedebris")

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/secoin.xml"
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem:SetOnPutInInventoryFn(PutIn)

    inst:AddComponent("secoin")

    shine(inst)
    
    return inst
end

return Prefab( "secoin", fn, assets) 

local assets=
{
	Asset("ANIM", "anim/arrowm.zip"),
    Asset("ATLAS", "images/inventoryimages/arrowm_broken.xml"),
    Asset("IMAGE", "images/inventoryimages/arrowm_broken.tex"),

}
 
 
local function arrowm_broken()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_red")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("arrowm_broken")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/arrowm_broken.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
    return inst
end

return Prefab( "common/inventory/arrowm_broken", arrowm_broken, assets)

	
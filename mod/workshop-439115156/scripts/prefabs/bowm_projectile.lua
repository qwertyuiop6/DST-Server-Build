local assets=
{
	Asset("ANIM", "anim/arrowm.zip"),
    Asset("ATLAS", "images/inventoryimages/bowm.xml"),
    Asset("IMAGE", "images/inventoryimages/bowm.tex"),
}

local function onhit(inst, attacker, target)
	local impactfx = SpawnPrefab("impact")
	if impactfx and attacker then
		local follower = impactfx.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		impactfx:FacePoint(attacker.Transform:GetWorldPosition())
	end
if target:HasTag("bird") or target:HasTag("rabbit") or target:HasTag("butterfly") then
		inst.target_prey = true

end

if math.random() <= 0.9 and not inst.target_prey then
if math.random() < 0.6 and not target.components.health:IsDead() then
	if target.components.inventory then
	target.components.inventory:GiveItem(SpawnPrefab("arrowm"))
	elseif not target.components.inventory then
	target:AddComponent("inventory")
	target.components.inventory:GiveItem(SpawnPrefab("arrowm"))
	end
else
	SpawnPrefab("arrowm").Transform:SetPosition(target:GetPosition():Get())
end
else
	SpawnPrefab("arrowm_broken").Transform:SetPosition(target:GetPosition():Get())
end	
	
	inst:Remove()
end

local function onthrown(inst, data)
	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
end

local function commonfn(anim, tags, removephysicscolliders)
 	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("dart_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
    inst:AddTag("projectile")
	
     if tags ~= nil then
        for i, v in ipairs(tags) do
            inst:AddTag(v)
        end
    end

    if removephysicscolliders then
        RemovePhysicsColliders(inst)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(45)
    inst.components.projectile:SetOnHitFn(onhit)
	inst.components.projectile:SetLaunchOffset(Vector3(0,1.1,0))
	
	inst:ListenForEvent("onthrown", onthrown)
	
    return inst
end

return 
Prefab( "common/inventory/bowm_projectile", commonfn, assets)

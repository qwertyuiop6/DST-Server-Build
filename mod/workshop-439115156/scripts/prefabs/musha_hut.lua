require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/musha_hut.zip"),
	Asset("ANIM", "anim/musha_hut.zip"),
}

local prefabs =
{
	"musha_hut_shadow",
}

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("idle", true)

		if inst.shadow then
			inst.shadow.AnimState:PlayAnimation("hit")
			inst.shadow.AnimState:PushAnimation("idle", true)
		end
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle", true)

	if inst.shadow then
		inst.shadow.AnimState:PlayAnimation("place")
		inst.shadow.AnimState:PushAnimation("idle", true)
	end

	inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_pre")
	inst:DoTaskInTime(23*FRAMES, function() inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_twirl") end)
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
		data.burnt = true
	end
end

local function onload(inst, data)
	if data and data.burnt then
		inst.components.burnable.onburnt(inst)
	end
end

local function onremove(inst)
	if inst.shadow then
		inst.shadow:Remove()
	end
end

local function comfortable_test(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 2, {"musha"})
for k,v in pairs(ents) do
if inst.warm_tent then
v.warm_tent = true
elseif inst.warm_tent_out then
v.warm_tent = false
end
end
end

local function on_close(inst)
inst.warm_tent = true
inst.warm_tent_out = false
comfortable_test(inst)
end   

local function far(inst)
inst.warm_tent_out = true
inst.warm_tent = false
comfortable_test(inst)
end 

local function fn(Sim)

local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
	inst.entity:AddSoundEmitter()
  	MakeSnowCoveredPristine(inst)
	inst:AddTag("shelter")
	--inst:AddTag("dryshelter")
	
	inst:AddTag("structure")
	inst.AnimState:SetBank("hut")
	inst.AnimState:SetBuild("musha_hut")
	inst.AnimState:PlayAnimation("idle", true)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "musha_hut.tex" )

	 inst.entity:SetPristine()
  if not TheWorld.ismastersim then
        return inst
    end	
	inst:AddComponent("inspectable")

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	
	inst.shadow = SpawnPrefab("musha_hut_shadow")
	inst:DoTaskInTime(0, function()
		inst.shadow.Transform:SetPosition(inst:GetPosition():Get())
	end)
	--inst:AddChild(inst.shadow)
		inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(1, 1)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
	
	--[[if inst.components.sheltered then
	inst.components.sheltered.waterproofness = (1)
	end]]
	
	MakeSnowCovered(inst, .01)
	inst:ListenForEvent( "onbuilt", onbuilt)

	MakeLargeBurnable(inst, nil, nil, true)
	MakeLargePropagator(inst)

	inst.OnSave = onsave 
	inst.OnLoad = onload

	inst.OnRemoveEntity = onremove

	return inst
end

local function shadowfn()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst.AnimState:SetBank("musha_hut_shdw")
	inst.AnimState:SetBuild("musha_hut_shdw")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("NOCLICK")
	inst:AddTag("FX")

	inst.persists = false
	
	 inst.entity:SetPristine()
  if not TheWorld.ismastersim then
        return inst
    end	
	
	return inst
end

return Prefab( "common/objects/musha_hut", fn, assets, prefabs),
MakePlacer( "common/musha_hut_placer", "hut", "musha_hut", "idle" ),
Prefab("musha_hut_shadow", shadowfn, assets)
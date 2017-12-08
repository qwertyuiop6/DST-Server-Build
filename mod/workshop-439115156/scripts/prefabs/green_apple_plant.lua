local assets =
{
    Asset("ANIM", "anim/green_apple.zip"),
    Asset("SOUND", "sound/common.fsb"),
}

local prefabs =
{
    "green_fruit",
}

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("berry_idle", true)
    inst:DoTaskInTime(8*FRAMES, function()
        --inst.Light:Enable(true)
		inst.picked = false
    end)
end

local function makeemptyfn(inst)
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked")
    --inst.Light:Enable(false)
	inst.picked = true
end

local function onpickedfn(inst)
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked")
    --inst.Light:Enable(false)
	inst.picked = true
end
local function dig_up(inst, chopper)
inst.components.lootdropper:SpawnLootPrefab("green_fruit")
		
		inst:Remove()
	end
	
local function fn()
    local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    --inst.entity:AddLight()

       inst.Transform:SetTwoFaced()

    inst.AnimState:SetBank("worm")
    inst.AnimState:SetBuild("green_apple")
if not inst.picked then	
inst.AnimState:PlayAnimation("berry_idle", true)	
end
   -- inst.AnimState:PlayAnimation("berry_idle", true)
		
   --[[ inst.Light:SetRadius(0.25)
    inst.Light:SetIntensity(0.5)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetColour(1,1,1)]]
    --inst.Light:Enable(true)
	--inst:AddTag("moonlight")
   
 	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
    inst.Transform:SetRotation(math.random()*360)
	if math.random() < 0.2 then
inst.Transform:SetScale(1, 1, 1)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.7, 0.7, 0.7)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.8, 0.8, 0.8)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.9, 0.9, 0.9)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.85, 0.85, 0.85)
else
inst.Transform:SetScale(1, 1, 1)
end

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

    inst.components.pickable:SetUp("green_fruit", TUNING.TOTAL_DAY_TIME*8)
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")

inst:AddComponent("workable")
		    inst.components.workable:SetWorkAction(ACTIONS.DIG)
		    inst.components.workable:SetOnFinishCallback(dig_up)
		    inst.components.workable:SetWorkLeft(1)

    ---------------------

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
 
    ---------------------

    return inst
end

return Prefab("green_apple_plant", fn, assets, prefabs)


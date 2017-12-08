local assets =
{
    Asset("ANIM", "anim/treedrake.zip"),
    Asset("ANIM", "anim/moondrake_build.zip"),
}

local prefabs =
{
 --   "acorn",
  --  "twigs",
}

local brain = require("brains/moonnutdrakebrain")


local function RetargetFn(inst)
     local dist = 15
	 local leader = inst.components.follower.leader
    if inst.components.follower and inst.components.follower.leader then
    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
      {"musha","player","wall","houndmound","structure","companion","yamche","arongb","pig","bee","rocky","webber","bird","koalefant","beefalo","companion","moondrake","moondrake2","butterfly","prey","cavedweller","statue","character","abigail","smashable","veggie","shadowminion","catcoon"})

	end
end 	

local function KeepTargetFn(inst, target)
    return not inst.sg:HasStateTag("exit")
        and (inst.sg:HasStateTag("hidden")
            or (target ~= nil and
                not target.components.health:IsDead() and
                inst.components.combat:CanTarget(target) and
                inst:IsNear(target, 20)
                )
            )
end

local function CanShareTarget(dude)
    return (dude:HasTag("moondrake") ) and not dude.components.health:IsDead()
end

local function OnHitfreeze(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.25)
        --other.components.freezable:SpawnShatterFX()
elseif other and other:HasTag("musha") then
	inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
end
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 15, CanShareTarget, 10)
	
	if data.attacker and data.attacker:HasTag("musha") or data.attacker:HasTag("player") then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
    end
end

local function OnLostTarget(inst)
    if not inst.sg:HasStateTag("hidden") and inst:GetTimeAlive() > 5 then
        inst.sg:GoToState("exit")
    end
end

local function Exit(inst)
    if not inst.sg:HasStateTag("hidden") then
        inst.sg:GoToState("exit")
    end
end

local function Enter(inst)
    if not inst.sg:HasStateTag("hidden") then
        inst.sg:GoToState("enter")
    end
end

local function SleepTest()
    return false
end

local function OnDeath(inst, data, immediate)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        if immediate then
            inst.components.burnable:Extinguish()
        else
            inst:DoTaskInTime(.5, OnDeath, nil, true)
        end
    end
end

local function on_follow(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 30, {"musha"})
for k,v in pairs(ents) do
if v:HasTag("musha") and not inst.components.follower.leader then
inst.components.follower:SetLeader(v)
inst.exit = false
end end
inst:DoTaskInTime(2, function() if not inst.components.follower.leader and not inst.exit then
 inst.sg:GoToState("exit") inst.exit = true end end)
end  

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(1.25, .75)

    inst.Transform:SetFourFaced()
    MakeCharacterPhysics(inst, 1, .25)

    inst.AnimState:SetBank("treedrake")
    inst.AnimState:SetBuild("moondrake2_build")
    inst.AnimState:PlayAnimation("enter")

  --  inst:AddTag("beaverchewable")
  --  inst:AddTag("birchnutdrake")
   -- inst:AddTag("monster")
   inst:AddTag("companion")
   inst:AddTag("moondrake2")
    inst:AddTag("scarytoprey")
	
if math.random() < 0.2 then
inst.Transform:SetScale(0.6, 0.6, 0.6)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.4, 0.4, 0.4)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.8, 0.8, 0.8)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.7, 0.7, 0.7)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.5, 0.5, 0.5)
elseif math.random() < 0.2 then
inst.Transform:SetScale(0.85, 0.85, 0.85)
elseif math.random() <= 1 then
inst.Transform:SetScale(0.6, 0.6, 0.6)
end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper.numrandomloot = 1
   -- inst.components.lootdropper:AddRandomLoot("acorn", .1)
  

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 6

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(5)
    inst.components.combat:SetRange(2.5, 3)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRetargetFunction(1, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    --inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/decidous/drake_hit")
	inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/deciduous/drake_hit")
    inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("onhitother", OnHitfreeze)
		inst.components.combat.playerdamagepercent = 0
    inst:DoTaskInTime(5, inst.ListenForEvent, "losttarget", OnLostTarget)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(50)
	
    --inst:AddComponent("leader")
    inst:AddComponent("follower")
	
    inst:AddComponent("sleeper")
    inst.components.sleeper.sleeptestfn = SleepTest

    inst:AddComponent("knownlocations")

    inst:SetStateGraph("SGmoonnutdrake2")
    inst:SetBrain(brain)
inst.on_follow = inst:DoPeriodicTask(0, on_follow)
    MakeSmallBurnableCharacter(inst, "treedrake_root", Vector3(0, -1, .1))
    inst.components.burnable:SetBurnTime(10)
    inst.components.health.fire_damage_scale = 2
    inst:ListenForEvent("death", OnDeath)
    inst.components.propagator.flashpoint = 5 + math.random() * 3
    MakeSmallFreezableCharacter(inst)
inst:DoTaskInTime( 120, function() inst.slave = false end)
    inst.Exit = Exit
    inst.Enter = Enter

    -- Enter(inst)

    return inst
end

return Prefab("moonnutdrake2", fn, assets, prefabs)

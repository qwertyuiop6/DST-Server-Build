local assets =
{
     Asset("ANIM", "anim/mushroom_spore_blue.zip"),
}

local data =
{
     tall =
    { --Red
        build = "mushroom_spore_red",
   
    },
}

local brain = require "brains/musha_sporebrain"

local function depleted(inst)
    if inst:IsInLimbo() then
	    inst:Remove()
    else
       -- inst.components.workable:SetWorkable(false)
        inst:PushEvent("death")
        inst:RemoveTag("spore") -- so crowding no longer detects it
		SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("musha_spore").Transform:SetPosition(inst:GetPosition():Get())
        inst.persists = false
        -- clean up when offscreen, because the death event is handled by the SG
        inst:DoTaskInTime(3, inst.Remove)
    end
end

local function OnFire(attacked, data)
if data and data.attacker and data.attacker.components.burnable and not data.attacker:HasTag("musha") and not data.attacker:HasTag("molebait") and data.attacker.components.health and not data.attacker.components.health:IsDead() then
			 data.attacker.components.burnable:IsBurning()
            data.attacker.components.burnable:Ignite(true)
			data.attacker.components.health:DoDelta(-10)
			end
 
  if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
    end
    end

local function taunting(inst, data)
local leader = inst.components.follower.leader
if leader then

	local x,y,z = inst.Transform:GetWorldPosition()	
	local enemy = TheSim:FindEntities(x, y, z, 20)
	for k,v in pairs(enemy) do
	if v and v.components.combat and v.components.health and not v.components.health:IsDead() and leader.components.combat.target == v then
	if not ( v:HasTag("shadowcreature") or v:HasTag("butterfly") or v:HasTag("bird") or v:HasTag("prey") or v:HasTag("structure")) then
		v.components.combat.target = inst
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_warmer_loop").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_hot_loop").Transform:SetPosition(v:GetPosition():Get())
		end
			if v.components.burnable and not v:HasTag("structure") and not v:HasTag("companion") and v.components.health and not v.components.health:IsDead() then
			v.components.burnable:IsBurning()
            v.components.burnable:Ignite(true)
			v.components.health:DoDelta(-4)
			end
			if v.components.burnable and v.components.burnable:IsBurning() then
			v.components.burnable:Extinguish()
			end
		end
	end
end
 
if leader --[[and inst.components.health:GetPercent() < .5]] then
	local x,y,z = inst.Transform:GetWorldPosition()	
	local enemy = TheSim:FindEntities(x, y, z, 15)
	for k,v in pairs(enemy) do
	if v and v.components.combat and v.components.combat.target == leader then
		if not ( v:HasTag("shadowcreature") or v:HasTag("butterfly") or v:HasTag("bird") or v:HasTag("prey") or v:HasTag("companion") or v:HasTag("player") --[[or v:HasTag("character")]]) then
		v.components.combat.target = inst	
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_warmer_loop").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_hot_loop").Transform:SetPosition(v:GetPosition():Get())
		end
			if v.components.burnable and not ( v:HasTag("structure") or v:HasTag("butterfly") or v:HasTag("bird") or v:HasTag("prey") or v:HasTag("player") or v:HasTag("companion")) and  v.components.health and not v.components.health:IsDead() then
			v.components.burnable:IsBurning()
            v.components.burnable:Ignite(true)
			v.components.health:DoDelta(-2)
			end
			if v.components.burnable and v.components.burnable:IsBurning() then
			v.components.burnable:Extinguish()
			end
		end
	end
	end
end 
	
local function on_close(inst)
inst.components.locomotor.walkspeed = 2
end

local function far(inst)
if inst.components.follower.leader then
inst.components.locomotor.walkspeed = 7
end end

local function checkforcrowding(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local spores = TheSim:FindEntities(x,y,z, TUNING.MUSHSPORE_MAX_DENSITY_RAD, {"spore"})
    if #spores > TUNING.MUSHSPORE_MAX_DENSITY then
        inst.components.perishable:SetPercent(0)
    else
        inst.crowdingtask = inst:DoTaskInTime(TUNING.MUSHSPORE_DENSITY_CHECK_TIME + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)
    end
end

local function onload(inst)
    -- If we loaded, then just turn the light on
    inst.Light:Enable(true)
    inst.DynamicShadow:Enable(true)
end

local function makespore(data)

 	local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
    	inst.entity:AddDynamicShadow()
        inst.entity:AddLight()
        inst.entity:AddNetwork()

    	MakeCharacterPhysics(inst, 1, .5)
		RemovePhysicsColliders(inst)
		
        inst.AnimState:SetBuild(data.build)
        inst.AnimState:SetBank("mushroom_spore")
        inst.AnimState:PlayAnimation("flight_cycle", true)

        inst.DynamicShadow:Enable(false)

	    inst.Light:SetColour(250/255,190/255,185/255)
	    inst.Light:SetIntensity(0.75)
	    inst.Light:SetFalloff(0.65)
	    inst.Light:SetRadius(3.2)
	    inst.Light:Enable(false)
		inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		if TheWorld.state.iswinter then	
		inst:AddTag("HASHEATER")
		inst:AddComponent("heater")	
		inst.components.heater.heat = 20
		end		
		inst:AddComponent("sanityaura")
        inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL
		
	    inst.DynamicShadow:SetSize(.8, .5)

        --inst:AddTag("show_spoilage")
        inst:AddTag("spore")
		inst:AddTag("musha_light")
		--inst:AddTag("noclick")
		--inst:AddTag("character")
		inst:AddTag("companion")
		
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end
		inst:AddComponent("follower")
        inst:AddComponent("inspectable")

        inst:AddComponent("knownlocations")

	    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	    inst.components.locomotor:SetTriggersCreep(false)
	    inst.components.locomotor.walkspeed = 2
  	--------------------
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(6, 7)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
	--------------------
        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(240)
        inst.components.perishable:StartPerishing()
        inst.components.perishable:SetOnPerishFn(depleted)

	inst:AddComponent("health")
	inst:AddComponent("combat")
	
	if math.random() < 0.3 then
inst.Transform:SetScale(0.75, 0.75, 0.75)
inst.components.health:SetMaxHealth(230)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.9, 0.9, 0.9)
inst.components.health:SetMaxHealth(260)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.8, 0.8, 0.8)
inst.components.health:SetMaxHealth(240)
elseif math.random() < 0.3 then
inst.Transform:SetScale(1.2, 1.2, 1.2)
inst.components.health:SetMaxHealth(320)
elseif math.random() < 0.3 then
inst.Transform:SetScale(1.4, 1.4, 1.4)
inst.components.health:SetMaxHealth(360)
elseif math.random() < 0.3 then
inst.Transform:SetScale(0.85, 0.85, 0.85)
inst.components.health:SetMaxHealth(240)
else
inst.Transform:SetScale(1, 1, 1)
inst.components.health:SetMaxHealth(280)
end

	
	inst.components.health.fire_damage_scale = 0
	inst:ListenForEvent("attacked", OnFire)

inst.taunt = inst:DoPeriodicTask(4,taunting)
	
 --[[
        inst:AddComponent("burnable")
        inst.components.burnable:SetFXLevel(1)
        inst.components.burnable:SetBurnTime(1)
        inst.components.burnable:AddBurnFX("fire", Vector3(0, 0, 0), "spore")
        inst.components.burnable:SetOnIgniteFn(DefaultBurnFn)
        inst.components.burnable:SetOnBurntFn(DefaultBurntFn)
        inst.components.burnable:SetOnExtinguishFn(DefaultExtinguishFn)

        inst:AddComponent("propagator")
        inst.components.propagator.acceptsheat = true
        inst.components.propagator:SetOnFlashPoint(DefaultIgniteFn)
        inst.components.propagator.flashpoint = 1
        inst.components.propagator.decayrate = 0.5
        inst.components.propagator.damages = false
]]
        MakeHauntablePerish(inst, .5)
 
	    inst:SetStateGraph("SGmushaspore")
	    inst:SetBrain(brain)

        -- note: the first check is faster, because this might be from dropping a stack
        inst.crowdingtask = inst:DoTaskInTime(1 + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)

        inst.OnLoad = onload

        return inst
	end

	return fn
end

return Prefab("musha_spore_fire", makespore(data.tall), assets)
 

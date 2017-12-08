local assets =
{
     Asset("ANIM", "anim/mushroom_spore_blue.zip"),
}

local data =
{
     tall =
    { --Blue
        build = "mushroom_spore_blue",
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
        inst.persists = false
        -- clean up when offscreen, because the death event is handled by the SG
       inst:DoTaskInTime(3, function() if math.random() < 0.3 then
		SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("flower").Transform:SetPosition(inst:GetPosition():Get())
		end end)
	   inst:DoTaskInTime(3,	inst.Remove	)
    end
end

local function on_close(inst)
inst.components.locomotor.walkspeed = 2
inst.components.perishable:SetPerishTime(1)
	end

local function far(inst)
if inst.components.follower.leader then
inst.components.locomotor.walkspeed = 6
	end
end

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

	    inst.Light:SetColour(185/255,190/255,250/255)
	    inst.Light:SetIntensity(0.75)
	    inst.Light:SetFalloff(0.65)
	    inst.Light:SetRadius(2)
	    inst.Light:Enable(false)
		inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

	    inst.DynamicShadow:SetSize(.8, .5)

        --inst:AddTag("show_spoilage")
        inst:AddTag("spore")
		inst:AddTag("musha_light")
		inst:AddTag("noclick")
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
 
        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(150)
		
		if math.random() < 0.2 then
		inst.Transform:SetScale(0.5, 0.5, 0.5)
		inst.components.perishable:SetPerishTime(130)
		elseif math.random() < 0.2 then
		inst.Transform:SetScale(0.3, 0.3, 0.3)
		inst.components.perishable:SetPerishTime(100)
		elseif math.random() < 0.2 then
		inst.Transform:SetScale(0.8, 0.8, 0.8)
		inst.components.perishable:SetPerishTime(150)
		elseif math.random() < 0.2 then
		inst.Transform:SetScale(0.7, 0.7, 0.7)
		inst.components.perishable:SetPerishTime(140)
		elseif math.random() < 0.2 then
		inst.Transform:SetScale(0.4, 0.4, 0.4)
		inst.components.perishable:SetPerishTime(110)
		elseif math.random() < 0.2 then
		inst.Transform:SetScale(0.85, 0.85, 0.85)
		inst.components.perishable:SetPerishTime(155)
		else
		inst.Transform:SetScale(0.55, 0.55, 0.55)
		inst.components.perishable:SetPerishTime(135)
		end
	
        inst.components.perishable:StartPerishing()
        inst.components.perishable:SetOnPerishFn(depleted)

	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(1, 1)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
		
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

return Prefab("musha_spore", makespore(data.tall), assets)
 

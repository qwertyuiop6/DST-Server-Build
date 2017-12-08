local assets =
{
     Asset("ANIM", "anim/mushroom_spore_blue.zip"),
	  Asset("ANIM", "anim/mushroom_spore_red.zip"),
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
		SpawnPrefab("musha_spore").Transform:SetPosition(inst:GetPosition():Get())
        -- clean up when offscreen, because the death event is handled by the SG
        inst:DoTaskInTime(3, inst.Remove)
    end
end

local function on_close(inst)
inst.components.locomotor.walkspeed = 1.5
	end

local function far(inst)
if inst.components.follower.leader then
inst.components.locomotor.walkspeed = 4
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

local function light_orb(data)
 
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
    	inst.entity:AddDynamicShadow()
        inst.entity:AddLight()
        inst.entity:AddNetwork()
		inst.Light:Enable(true)
		inst.DynamicShadow:Enable(true)
		
    	MakeCharacterPhysics(inst, 1, .5)
		RemovePhysicsColliders(inst)
		
		if TheWorld.state.iswinter then
        inst.AnimState:SetBuild("mushroom_spore_red")
		else
		inst.AnimState:SetBuild("mushroom_spore_blue")
		end
        inst.AnimState:SetBank("mushroom_spore")
        inst.AnimState:PlayAnimation("flight_cycle", true)

        --inst.DynamicShadow:Enable(false)

	    inst.Light:SetColour(220/255,240/255,250/255)
	    inst.Light:SetIntensity(0.75)
	    inst.Light:SetFalloff(0.55)
	    inst.Light:SetRadius(4.5)
	    --inst.Light:Enable(false)
		inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

	    inst.DynamicShadow:SetSize(.8, .5)

        --inst:AddTag("show_spoilage")
        --inst:AddTag("spore")
		inst:AddTag("musha_light2")
		inst:AddTag("noclick")
		--inst:AddTag("character")
		inst:AddTag("companion")
	    --inst:AddTag("daylight")
		--inst:AddTag("HASHEATER")
		
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
	    inst.components.locomotor.walkspeed = 1.5
 	--------------------
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(6, 7)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
	-------------------- 
        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(500)
        inst.components.perishable:StartPerishing()
        inst.components.perishable:SetOnPerishFn(depleted)
        inst:AddComponent("sanityaura")
        inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL

       inst:AddComponent("heater")
        if TheWorld.state.iswinter then
            inst.components.heater.heat = 100
        elseif TheWorld.state.issummer then
            inst.components.heater.heat = -100
            inst.components.heater:SetThermics(false, true)
        end

		
		inst.Transform:SetScale(1.85, 1.85, 1.85)
		inst:DoPeriodicTask(1, function()
if inst.components.perishable:GetPercent() >= 0.8 then
inst.Transform:SetScale(1.85, 1.85, 1.85)
elseif inst.components.perishable:GetPercent() < 0.8 and inst.components.perishable:GetPercent() >= 0.6 then
inst.Transform:SetScale(1.65, 1.65, 1.65)
elseif inst.components.perishable:GetPercent() < 0.6 and inst.components.perishable:GetPercent() >= 0.4 then
inst.Transform:SetScale(1.45, 1.45, 1.45)
elseif inst.components.perishable:GetPercent() < 0.4 and inst.components.perishable:GetPercent() >= 0.2 then
inst.Transform:SetScale(1.25, 1.25, 1.25)
elseif inst.components.perishable:GetPercent() < 0.2 then
inst.Transform:SetScale(1, 1, 1)
end
		end)
		
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
 
	    inst:SetStateGraph("SGmushaspore2")
	    inst:SetBrain(brain)

        -- note: the first check is faster, because this might be from dropping a stack
        inst.crowdingtask = inst:DoTaskInTime(1 + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)

        inst.OnLoad = onload

        return inst
	end


return Prefab("musha_spore2", light_orb, assets)
 

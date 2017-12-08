local assets =
{
	Asset("ANIM", "anim/debuff_spark.zip"),
	Asset("ANIM", "anim/debuff_frozen.zip"),
	Asset("ANIM", "anim/debuff_blood.zip"),
	Asset("ANIM", "anim/debuff_spark_0.zip"),
	--Asset("SOUND", "sound/common.fsb"),
}

local function kill(inst)
	--inst.SoundEmitter:KillSound("poisoned")
	inst:Remove()
end

local function StopBubbles(inst)
	inst.AnimState:PushAnimation("level"..inst.level.."_pst", false)
	inst:RemoveEventCallback("animqueueover", StopBubbles)
	inst:ListenForEvent("animqueueover", kill)
end

local function common(Sim, level, loop)

	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("poison")
	inst.AnimState:SetBuild("debuff_spark")

	if loop == nil then
		inst.loop = true
	else
		inst.loop = loop
	end
	inst.level = level or 2
	if inst.loop then
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", true) -- Let this loop until something externally calls StopBubbles
	else
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", false)
		inst:ListenForEvent("animqueueover", StopBubbles)
	end

	--inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/poisoned", "poisoned")

	inst:AddTag("fx")
inst.Transform:SetScale(0.5,0.9,0.5)
	inst.StopBubbles = StopBubbles
	
	inst.AnimState:SetFinalOffset(2)

	return inst
end

local function shock_0(Sim, level, loop)

	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("poison")
	inst.AnimState:SetBuild("debuff_spark_0")

	if loop == nil then
		inst.loop = true
	else
		inst.loop = loop
	end
	inst.level = level or 2
	if inst.loop then
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", true) -- Let this loop until something externally calls StopBubbles
	else
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", false)
		inst:ListenForEvent("animqueueover", StopBubbles)
	end

	--inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/poisoned", "poisoned")

	inst:AddTag("fx")
inst.Transform:SetScale(0.5,0.9,0.5)
	inst.StopBubbles = StopBubbles
	
	inst.AnimState:SetFinalOffset(2)

	return inst
end

local function frozen(Sim, level, loop)

	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("poison")
	inst.AnimState:SetBuild("debuff_frozen")
	
	if loop == nil then
		inst.loop = true
	else
		inst.loop = loop
	end
	inst.level = level or 2
	if inst.loop then
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", true) -- Let this loop until something externally calls StopBubbles
	else
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", false)
		inst:ListenForEvent("animqueueover", StopBubbles)
	end

	--inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/poisoned", "poisoned")

	inst:AddTag("fx")
inst.Transform:SetScale(0.5,0.9,0.5)
	inst.StopBubbles = StopBubbles
	
	inst.AnimState:SetFinalOffset(2)

	return inst
end

local function blood(Sim, level, loop)

	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("poison")
	inst.AnimState:SetBuild("debuff_blood")

	
	if loop == nil then
		inst.loop = true
	else
		inst.loop = loop
	end
	inst.level = level or 2
	if inst.loop then
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", true) -- Let this loop until something externally calls StopBubbles
	else
		inst.AnimState:PlayAnimation("level"..inst.level.."_pre")
		inst.AnimState:PushAnimation("level"..inst.level.."_loop", false)
		inst:ListenForEvent("animqueueover", StopBubbles)
	end

	--inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/poisoned", "poisoned")

	inst:AddTag("fx")
inst.Transform:SetScale(0.5,0.55,0.5)
	inst.StopBubbles = StopBubbles
	
	inst.AnimState:SetFinalOffset(2)

	return inst
end

function MakeBubble(name, level, loop)
	local function fn(Sim)
		local inst = common(Sim, 2, true)
		return inst
	end

	local function shortfn(Sim)
		local inst = common(Sim, 2, true)
		inst:DoTaskInTime(15, StopBubbles)
		return inst
	end
	
	local function frozenfn(Sim)
		local inst = frozen(Sim, 2, true)
		inst:DoTaskInTime(5, StopBubbles)
		return inst
	end
	
	local function bloodfn(Sim)
		local inst = blood(Sim, 2, true)
		inst:DoTaskInTime(15, StopBubbles)
		return inst
	end

	local function bloodlpfn(Sim)
		local inst = blood(Sim, 2, true)
		inst:DoTaskInTime(30, StopBubbles)
		return inst
	end	
		local function shockFn(Sim)
		local inst = shock_0(Sim, 2, true)
		inst:DoTaskInTime(6, StopBubbles)
		return inst
	end	
	
	local myFn = fn
	if level == 0 then
		myFn = shortfn
		
		local frostFn = fn
	elseif level == 1 then
		myFn = frozenfn
	
		local bloodlpFn = fn
	elseif level == 3 then
		myFn = bloodlpfn
	
		local bloodFn = fn
	elseif level == 2 then
		myFn = bloodfn	
	
			local shockFn = fn
	elseif level == 4 then
		myFn = shockFn		
	end
	
	return Prefab( "common/fx/"..name, myFn, assets)
end

return MakeBubble("debuff"),
	   MakeBubble("debuff_short", 0, true),
	   MakeBubble("debuff_frozen", 1, true),
	   MakeBubble("debuff_bloodlp", 3, true),
	   MakeBubble("debuff_blood", 2, true),
		MakeBubble("debuff_short_0", 4, true)
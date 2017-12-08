local assets =
{
	Asset("ANIM", "anim/poison.zip"),
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
	inst.AnimState:SetBuild("poison")

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

	inst.StopBubbles = StopBubbles
	
	inst.AnimState:SetFinalOffset(2)
	
		inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end

	return inst
end

function MakeBubble(name, level, loop)
	local function fn(Sim)
		local inst = common(Sim, 2, true)
		return inst
	end

	local function shortfn(Sim)
		local inst = common(Sim, 2, true)
		inst:DoTaskInTime(14, StopBubbles)
		return inst
	end

	local function lvl1(Sim)
		local inst = common(Sim, 1, false)
		return inst
	end

	local function lvl1_loop(Sim)
		local inst = common(Sim, 1, true)
		return inst
	end

	local function lvl2(Sim)
		local inst = common(Sim, 2, false)
		return inst
	end

	local function lvl2_loop(Sim)
		local inst = common(Sim, 2, true)
		return inst
	end

	local function lvl3(Sim)
		local inst = common(Sim, 3, false)
		return inst
	end

	local function lvl3_loop(Sim)
		local inst = common(Sim, 3, true)
		return inst
	end

	local function lvl4(Sim)
		local inst = common(Sim, 4, false)
		return inst
	end

	local function lvl4_loop(Sim)
		local inst = common(Sim, 4, true)
		return inst
	end

	local myFn = fn
	if level == 0 then
		myFn = shortfn
	--[[elseif level == 1 then
		if loop then
			myFn = lvl1_loop
		else
			myFn = lvl1
		end
	elseif level == 2 then
		if loop then
			myFn = lvl2_loop
		else
			myFn = lvl2
		end
	elseif level == 3 then
		if loop then
			myFn = lvl3_loop
		else
			myFn = lvl3
		end
	elseif level == 4 then
		if loop then
			myFn = lvl4_loop
		else
			myFn = lvl4
		end]]
	end

	return Prefab( "common/fx/"..name, myFn, assets)
end

return MakeBubble("poisonbubble2"),
	   MakeBubble("poisonbubble_short2", 0, true)--[[,
	   MakeBubble("poisonbubble_level1", 1, false),
	   MakeBubble("poisonbubble_level1_loop", 1, true),
	   MakeBubble("poisonbubble_level2", 2, false),
	   MakeBubble("poisonbubble_level2_loop", 2, false),
	   MakeBubble("poisonbubble_level3", 3, false),
	   MakeBubble("poisonbubble_level3_loop", 3, true),
	   MakeBubble("poisonbubble_level4", 4, false),
	   MakeBubble("poisonbubble_level4_loop", 4, true)]]

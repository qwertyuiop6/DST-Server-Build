require "prefabutil"

local tent_assets =
{
    Asset("ANIM", "anim/forge_musha.zip"),
	Asset("ANIM", "anim/forge_musha_on.zip"),
	Asset("ANIM", "anim/forge_musha_broken.zip"),
}

local function duration_light(inst, data)
 	local max_duration = 100
	local min_duration = 0	
	local mxx=math.floor(max_duration-min_duration)
	local curr=math.floor(inst.duration-min_duration)
	local duration = ""..math.floor(curr*100/mxx).."%"
if not inst.using_on then
	if inst.warm_tent then
 inst.components.talker:Say("[Forge]-(On)\n"..(duration))
 elseif inst.warm_tent_out then
 inst.components.talker:Say("[Forge]-(Off)\n"..(duration))
 end
 end end
   
 local function forgelab_gas(inst, data)
if inst.warm_tent and inst.active_forge then
   inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
   inst.AnimState:PlayAnimation("hit")
  SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get()) 
SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get()) 
inst.duration = inst.duration - 4
duration_light(inst)
inst.active_forge = false
 --   inst.AnimState:PushAnimation("idle", true)
  end
end 
 
 local function forgelab(inst, data)
 if inst.broken and inst.components.container then
 inst.components.container.canbeopened = false
 elseif not inst.broken and inst.components.container then
 inst.components.container.canbeopened = true
 end
 if inst.active_forge then
 forgelab_gas(inst) end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 5, {"musha_items"})
for k,v in pairs(ents) do
if inst.warm_tent and not inst.broken then
if not v.forgelab_on then
 v.forgelab_on = true end
elseif inst.warm_tent_out then
if v.forgelab_on then
 v.forgelab_on = false end
end 
if inst.broken then
v.forgelab_on = false
end
end
end
  
local function musha_sleep(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 6, {"musha"})
for k,v in pairs(ents) do
if inst.warm_tent then
v.warm_tent = true
elseif inst.warm_tent_out then
v.warm_tent = false
end
	if v.sleep_on or v.tiny_sleep and v.sg:HasStateTag("tent") and inst.duration >=0 then
	local max_stamina = 100	local min_stamina = 0
	local max_fatigue = 100	local min_fatigue = 0	
	local max_music = 100	local min_music = 0	
			local mx=math.floor(max_stamina-min_stamina)
			local cur=math.floor(v.stamina-min_stamina)
			local mx2=math.floor(max_fatigue-min_fatigue)
			local cur2=math.floor(v.fatigue-min_fatigue)
			local mxx=math.floor(max_music-min_music)
			local curr=math.floor(v.music-min_music)
			local sleep = ""..math.floor(cur*100/mx).."%"
			local sleepy = ""..math.floor(cur2*100/mx2).."%"
			local music = ""..math.floor(curr*100/mxx).."%"
	local max_duration = 100 local min_duration = 0	
	local mxx=math.floor(max_duration-min_duration)
	local curr=math.floor(inst.duration-min_duration)
	local duration = ""..math.floor(curr*100/mxx).."%"	
	inst.components.talker:Say("[Forge]: "..(duration).. "\n[Sleep]: "..(sleep).."   [Tired]: "..(sleepy).."\n[Performance]:"..(music))
	elseif v.sg:HasStateTag("tent") and inst.duration <=0 then
	inst.duration = inst.duration *0
	v.sleep_on = false
	v.sleepcheck = false
	v.sg:GoToState("wakeup")

	end end 
end 


local function onhammered(inst, worker)
 --   if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
 --       inst.components.burnable:Extinguish()
 --   end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", true)
    end
--    if inst.components.sleepingbag ~= nil and inst.components.sleepingbag.sleeper ~= nil then
 --       inst.components.sleepingbag:DoWakeUp()
   -- end
end

local function onfinishedsound(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_twirl")
end

local function OnDurability(inst,sleeper)
    if not inst.broken and not inst:HasTag("burnt") then
--inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
	inst.broken = true
inst.Light:Enable(false)
inst.light_on = false
inst.using_on = false
inst.components.machine:TurnOff()
inst.Light:Enable(false)
inst.light_on = false
	if inst.broken and inst.components.container then
	inst.components.container:DropEverything() 
	inst.components.container:Close() end

	    inst.AnimState:PlayAnimation("destroy")
   --     inst:ListenForEvent("animover", inst.Remove)
		--inst:RemoveComponent("sleepingbag")
        inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_pre")
       -- inst.persists = false
        inst:DoTaskInTime(16 * FRAMES, onfinishedsound)
		scheduler:ExecuteInTime(2, function()
		SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
		  inst.AnimState:SetBuild("forge_musha_broken")
		  inst.AnimState:PlayAnimation("place") inst.AnimState:PushAnimation("idle", true)
	end)
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end

local function onignite(inst)
 --   inst.components.sleepingbag:DoWakeUp()
end

local function wakeuptest(inst, phase)
 --   if phase ~= inst.sleep_phase then
 --       inst.components.sleepingbag:DoWakeUp()
--	end
end

local function on_close(inst)
if inst.light_on then
inst.warm_tent = true
inst.warm_tent_out = false
elseif not inst.light_on then
inst.warm_tent = false
inst.warm_tent_out = true
end  
 musha_sleep(inst)
 forgelab(inst)
end

local function far(inst)
inst.warm_tent = false
inst.warm_tent_out = true
 musha_sleep(inst)
 forgelab(inst)
end

 local function on_light_tent(inst, data)
 inst.AnimState:PlayAnimation("hit")
 if not inst.broken then
  inst.AnimState:SetBuild("forge_musha_on")
inst.Light:Enable(true)
inst.light_on = true
on_close(inst)
 musha_sleep(inst)
 forgelab(inst)
if inst.duration <= 0 then
inst.components.machine:TurnOff()
inst.Light:Enable(false)
inst.light_on = false
OnDurability(inst)
end
if not inst.using_on then
inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
inst:DoPeriodicTask(2.5, function() if inst.light_on and inst.duration > 0 then
inst.duration = inst.duration - 0.01
duration_light(inst) 
elseif inst.light_on and inst.duration <= 0 then
OnDurability(inst)
end
 end) end end end
 -----------
local function off_light_tent(inst, data)
inst.AnimState:PlayAnimation("idle") 
 if not inst.broken and not inst.using_on then
 --inst.AnimState:SetBuild("forge_musha")
inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
inst.Light:Enable(false)
inst.light_on = false
inst.warm_tent = false
inst.warm_tent_out = true
on_close(inst)
 musha_sleep(inst)
 forgelab(inst)
 inst.AnimState:SetBuild("forge_musha")
end end 
-------- --------
		
local function OnOpen(inst)
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
if not inst.broken and not inst.light_on then
inst.components.machine:TurnOn()
end
	if inst.broken and inst.components.container then
	inst.components.container:DropEverything() 
	inst.components.container:Close() end
	if inst.broken and inst.light_on then
inst.components.machine:TurnOff()
end
end 

local function OnClose(inst) 
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
if inst.light_on and not TheWorld.state.isnight then
inst.components.machine:TurnOff()
end end
 
local function TakeItem(inst, item, data)
	inst.components.fueled:DoDelta(1)
	SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
	--SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())
    if inst.duration < 100 then
	inst.duration = inst.duration + 20
	duration_light(inst)
	if inst.duration > 100 then
	inst.duration = inst.duration * 0 +100
	duration_light(inst)
	end    end
	
	if inst.broken then 
	inst.AnimState:PlayAnimation("destroy")
	inst.broken = false
   		scheduler:ExecuteInTime(2, function()
		SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
		  inst.AnimState:SetBuild("forge_musha")

		  inst.AnimState:PlayAnimation("place") inst.AnimState:PushAnimation("idle", true)	end)
	   end 
	   end
 
local function onpreload(inst, data)
	if data then
		if data.duration then
		inst.duration = data.duration
			duration_light(inst)
end
	end
		end
		
local function onsave(inst, data)
	data.duration = inst.duration
   -- if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
   --     data.burnt = true
   -- end
end

local function onload(inst, data)
  --  if data ~= nil and data.burnt then
  --      inst.components.burnable.onburnt(inst)
  --  end
end

local function fn(Sim)
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst:AddTag("forge_musha")
    inst:AddTag("structure")
	  inst:AddTag("fridge")
	  
         inst:AddTag("prototyper")
       -- inst:AddTag("giftmachine")
         inst:AddTag("level2")
		
    inst.AnimState:SetBank("tent")
    inst.AnimState:SetBuild("forge_musha")
 --   inst.AnimState:PlayAnimation("idle", true)  
inst.AnimState:PlayAnimation("hit") 
    inst.MiniMapEntity:SetIcon( "forge_musha.tex" )

    MakeSnowCoveredPristine(inst)
	
	inst.entity:AddLight()
	inst.Light:SetRadius(5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.8)
    inst.Light:SetColour(180/255,180/255,180/255)	
	inst.Light:Enable(false)
	inst.light_on = false
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = on_light_tent
    inst.components.machine.turnofffn = off_light_tent
    inst.components.machine.cooldowntime = 0	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 21
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(0,-780,0)
    inst.components.talker.symbol = "swap_object"
    inst:AddComponent("fueled")
	inst.duration = 100  
	inst:ListenForEvent("duration", duration_light)	
 --   inst:AddComponent("playerprox")
--    inst.components.playerprox:SetDist(15, 15)
  	
    inst.entity:SetPristine()

  	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	
       inst._activecount = 0
        inst._activetask = nil
    inst:AddComponent("inspectable")
		
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
	

inst.forgelab = inst:DoPeriodicTask(0.5,forgelab)  	

--inst.forgelab_gas = inst:DoPeriodicTask(8, forgelab_gas)  

  --  MakeSnowCovered(inst)
    inst:ListenForEvent("onbuilt", onbuilt)

  --  MakeLargeBurnable(inst, nil, nil, true)
 --   MakeMediumPropagator(inst)
	
	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 4)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
	
--    inst.sleep_phase = "night"
 --   inst.sleep_anim = "sleep_loop"
 --   inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
	--inst.is_cooling = true
    --inst.is_cooling = false
	
       inst.components.fueled.fueltype = "BURNABLE"
       inst.components.fueled:InitializeFuelLevel(100)
        inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
		inst.components.fueled:StopConsuming() 	
		
 if not inst.broken and not inst.using_on then
 inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
inst.Light:Enable(false)
inst.light_on = false
inst.warm_tent = false
inst.warm_tent_out = true
on_close(inst)
 musha_sleep(inst)
 forgelab(inst)
 inst.AnimState:SetBuild("forge_musha")
end  

    inst.OnSave = onsave 
    inst.OnLoad = onload
	inst.OnPreLoad = onpreload

    MakeHauntableWork(inst)

    return inst
end
 
return Prefab("common/objects/forge_musha", fn, tent_assets),
    MakePlacer("common/forge_musha_placer", "tent", "forge_musha", "idle")
 

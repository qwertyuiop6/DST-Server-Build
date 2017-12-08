local assets =
{
    Asset("ANIM", "anim/beefalo_basic.zip"),
    Asset("ANIM", "anim/beefalo_actions.zip"),
    Asset("ANIM", "anim/beefalo_baby_build.zip"),
    Asset("SOUND", "sound/beefalo.fsb"),
	
 	Asset("ANIM", "anim/arong_baby_build.zip"),
	Asset("ANIM", "anim/arong_mini1_build.zip"),
	Asset("ANIM", "anim/arong_mini2_build.zip"),
	Asset("ANIM", "anim/arong_mini3_build.zip"),
	Asset("ANIM", "anim/arong_mini4_build.zip"),
	Asset("ANIM", "anim/arong_mini4_v_build.zip"),
	Asset("ANIM", "anim/arong_grow1_v_build.zip"),
	Asset("ANIM", "anim/arong_grow1_build.zip"),
	
}

local prefabs =
{
 
    "meat",
    "poop",
    "beefalowool",
    "beefalo",
}

local sounds =
{
    walk = "dontstarve/creatures/beefalo_baby/walk",
    grunt = "dontstarve/creatures/beefalo_baby/grunt",
    yell = "dontstarve/creatures/beefalo_baby/yell",
    swish = "dontstarve/creatures/beefalo_baby/tail_swish",
    curious = "dontstarve/creatures/beefalo_baby/curious",
    angry = "dontstarve/creatures/beefalo_baby/angry",
}

local brain = require "brains/arongbabybrain"

----------------
local function Activateicon(inst)
local minimap = TheWorld.minimap.MiniMap
    --inst.activatetask = nil
	minimap:DrawForgottenFogOfWar(true)
	if not inst.components.maprevealer then
		inst:AddComponent("maprevealer")
	end
	inst.components.maprevealer.revealperiod = 0.5
	inst.components.maprevealer:Start()
		
end
local function ondeath(inst)
local dark2 = SpawnPrefab("statue_transition_2")
local pos = Vector3(inst.Transform:GetWorldPosition())
local poo = SpawnPrefab("musha_egg_arong")
dark2.Transform:SetPosition(pos:Get())
if inst.components.container then
inst.components.container:DropEverything() 
	end 
poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
	end
	
local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, function(dude)
        return dude:HasTag("musha") and not dude.components.health:IsDead()
    end, 5)
end

local function FollowGrownArong(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20, {"arong"})
for k,v in pairs(ents) do
    if not inst.components.follower.leader and v.components.leader and not (inst.mount or v.mount) then
        v.components.leader:AddFollower(inst)
		elseif v.mount and v.components.leader:AddFollower(inst) then
		inst.components.follower:SetLeader(nil)
		elseif v.components.rideable and v.components.rideable:GetRider() ~= nil then
		inst.components.follower:SetLeader(nil)
    end
end end
--[[
local function FollowGrownBeefalo(inst)
    local nearest = FindEntity(inst, 30, function(guy)
        return guy.components.leader --and guy.components.leader:CountFollowers() < 1
    end,
    
    {"arong"},
	{"yamche"}
    )
    if nearest and nearest.components.leader then
        nearest.components.leader:AddFollower(inst)
    end
end]]

local function InShadow(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 15)
for k,v in pairs(ents) do
if inst.sleep_on and v.components.combat and v.components.combat.target == inst and not (v:HasTag("berrythief") or v:HasTag("prey") or v:HasTag("bird") or v:HasTag("butterfly")) then
		v.components.combat.target = nil
 end
 end end
 
local function on_follow(inst, data)
if inst.yamche then
if inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp() end
--inst.sg:GoToState("matingcall")
inst.sg:GoToState("bellow")
    if inst.components.health:GetPercent() >= .8 then
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())	
    elseif inst.components.health:GetPercent() < .8 and inst.components.health:GetPercent() >= .6 then
	SpawnPrefab("yellow_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .6 and inst.components.health:GetPercent() >= .4 then
	SpawnPrefab("orange_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .4 then
	SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get())
	end	
inst.yamche = false
end
if inst.sleep_on then
inst:AddTag("notarget")
InShadow(inst)
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
elseif not inst.sleep_on then
inst:RemoveTag("notarget")
end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20, {"musha"})
for k,v in pairs(ents) do
v.arong_follow = true
 end 
 end 

local function flower_shield(inst, attacked, data) 
 	if not inst.components.health:IsDead() then
    if inst.components.health:GetPercent() >= .8 then
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())	
    elseif inst.components.health:GetPercent() < .8 and inst.components.health:GetPercent() >= .6 then
	SpawnPrefab("yellow_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .6 and inst.components.health:GetPercent() >= .4 then
	SpawnPrefab("orange_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .4 then
	SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get())
	end	end
end

local function OnEat(inst, food)
  --inst.sg:GoToState("eat")
  inst.sg:GoToState("graze")
  inst.components.hunger:DoDelta(5)
 inst.SoundEmitter:PlaySound("dontstarve/beefalo/chew")

 if inst.components.hunger:GetPercent() >= 1 then
 	local fx = SpawnPrefab("poopcloud")
	fx.Transform:SetScale(0.7, 0.7, 0.7)
	fx.Transform:SetPosition(inst:GetPosition():Get())
 	local poo = SpawnPrefab("poop")
	poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
	 inst.components.hunger:DoDelta(-49) 
	-- inst.fastgrowup = true
end

    -- food heal
    if inst:HasTag("companion") then
        inst.components.health:DoDelta(inst.components.health.maxhealth * .2, nil, food.prefab)
        inst.components.combat:SetTarget(nil)
    else
        inst.components.health:DoDelta(inst.components.health.maxhealth, nil, food.prefab)
    end
 	end	
		
local function ShouldAcceptItem(inst, item)
    return inst.components.eater:CanEat(item)
        and not inst.components.combat:HasTarget()
end

local function OnGetItemFromPlayer(inst, giver, item)
    if inst.components.eater:CanEat(item) then
        inst.components.eater:Eat(item)
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function BreedArong(inst)
end 

local function MountSleepTest(inst)
    return DefaultSleepTest(inst)
	--return inst.sleep_on
end

local function Grow(inst)
    if inst.components.sleeper:IsAsleep() then
        inst.growUpPending = true
        inst.sg:GoToState("wake")
    else
        inst.sg:GoToState("grow_up")
    end
end

local function GetGrowTime()
    return GetRandomWithVariance(TUNING.BABYBEEFALO_GROW_TIME.base, TUNING.BABYBEEFALO_GROW_TIME.random)
	--return 1  --test
end

local function SetBaby(inst)
   local scale = 0.16
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(100)
    inst.components.sleeper:SetResistance(5)
end

local function SetLV1(inst)
    local scale = 0.16
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(100)
    inst.components.sleeper:SetResistance(5)
end

local function SetLV2(inst)
inst.AnimState:SetBuild("arong_mini1_build")
    local scale = 0.2
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(200)
    inst.components.sleeper:SetResistance(5)
end

local function SetLV3(inst)
inst.AnimState:SetBuild("arong_mini2_build")
    local scale = 0.25
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(300)
    inst.components.sleeper:SetResistance(5)
end

local function SetLV4(inst)
inst.AnimState:SetBuild("arong_mini3_build")
    local scale = 0.3
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(400)
    inst.components.sleeper:SetResistance(5)
end

local function SetLV5(inst)
inst.AnimState:SetBuild("arong_mini4_build")
    local scale = 0.35
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(500)
    inst.components.sleeper:SetResistance(5)
end

local function SetLV6(inst)
inst.AnimState:SetBuild("arong_grow1_build")
    local scale = 0.45
    inst.Transform:SetScale(scale, scale, scale)
   inst.components.health:SetMaxHealth(600)
    inst.components.sleeper:SetResistance(5)
end

local function SetFullyGrown(inst)
local green = 0.8
if math.random() < green then
    local grown = SpawnPrefab("arong")
    grown.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    grown.Transform:SetRotation(inst.Transform:GetRotation() )
    grown.sg:GoToState("grow_up_pop")
else
	local grown2 = SpawnPrefab("arom")
    grown2.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    grown2.Transform:SetRotation(inst.Transform:GetRotation() )
    grown2.sg:GoToState("grow_up_pop")
end
    inst:Remove()
end

local growth_stages =
{
    {name="Baby", time = GetGrowTime, fn = SetBaby},
	{name="LV_1", time = GetGrowTime, fn = SetLV1, growfn = Grow},
    {name="LV_2", time = GetGrowTime, fn = SetLV2, growfn = Grow},
    {name="LV_3", time = GetGrowTime, fn = SetLV3, growfn = Grow},
	{name="LV_4", time = GetGrowTime, fn = SetLV4, growfn = Grow},
	{name="LV_5", time = GetGrowTime, fn = SetLV5, growfn = Grow},
	{name="LV_6", time = GetGrowTime, fn = SetLV6, growfn = Grow},
	{name="growup", time = GetGrowTime, fn = SetFullyGrown, growfn = Grow},
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.Transform:SetSixFaced()
    inst.Transform:SetScale(0.25, 0.25, 0.25)

    inst.DynamicShadow:SetSize(2.5, 1.25)

    inst.AnimState:SetBank("beefalo")
    inst.AnimState:SetBuild("arong_baby_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
	
 	 inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "arongbaby.tex" )
	inst.MiniMapEntity:SetPriority(10)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
    inst:AddTag("beefalo")
    inst:AddTag("baby")
    inst:AddTag("animal")
	inst:AddTag("companion")
   inst:AddTag("notraptrigger")	
	inst:AddTag("arongb")
	inst:AddTag("arongbaby")
	--inst:AddTag("yamche")
	
    --herdmember (from herdmember component) added to pristine state for optimization
   -- inst:AddTag("herdmember")

    MakeCharacterPhysics(inst, 100, .75)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
---name
--
    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.ARONG
    inst.components.named:PickNewName()
	
    inst.sounds = sounds

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE }, { FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE })
    inst.components.eater:SetOnEatFn(OnEat)
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false
	
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
	inst:ListenForEvent("attacked", flower_shield)
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(100)
    inst:AddComponent("hunger")
    inst.components.hunger:SetMax(50)
    inst.components.hunger:SetRate(0)
	inst.components.hunger:SetPercent(0.1)
	-- inst.BreedArong = inst:DoPeriodicTask(0, BreedArong) 
	 
	 inst:AddComponent("maprevealer")
	inst.components.maprevealer.revealperiod = 0.25
	inst.components.maprevealer:Start()
	
    inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")
    inst:AddComponent("sleeper")
  inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.sleeptestfn = MountSleepTest
	
    inst:AddComponent("knownlocations")
  --  inst:AddComponent("herdmember")
    inst:AddComponent("follower")
    inst.components.follower.canaccepttarget = true

  --[[  inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
    inst.components.periodicspawner:SetRandomTimes(80, 110)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()]]

    inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable.growonly = true
    inst.components.growable:SetStage(1)
    inst.components.growable:StartGrowing()
	inst:ListenForEvent("death", ondeath)
    MakeMediumBurnableCharacter(inst, "beefalo_body")

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 2
    inst.components.locomotor.runspeed = 9
	inst.activatetask = inst:DoTaskInTime(0.1, Activateicon)
    MakeHauntablePanic(inst)

   -- inst:DoTaskInTime(1, FollowGrownBeefalo)
	inst.on_follow = inst:DoPeriodicTask(1, on_follow)  
	inst.FollowGrownBeefalo = inst:DoPeriodicTask(1, FollowGrownArong)  
    inst:SetBrain(brain)

    inst:SetStateGraph("SGArong")

    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab("arong_baby", fn, assets, prefabs)

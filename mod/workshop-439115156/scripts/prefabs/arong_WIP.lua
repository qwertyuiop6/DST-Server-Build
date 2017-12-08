local assets =
{
    Asset("ANIM", "anim/beefalo_basic.zip"),
	Asset("ANIM", "anim/arong_build.zip"),

    Asset("ANIM", "anim/beefalo_actions.zip"),
    Asset("ANIM", "anim/beefalo_actions_domestic.zip"),
	Asset("ANIM", "anim/beefalo_actions_quirky.zip"),
  --  Asset("ANIM", "anim/beefalo_shaved_build.zip"),
	Asset("ANIM", "anim/arong_baby_build.zip"),

  -- Asset("ANIM", "anim/beefalo_domesticated.zip"),
 	Asset("ANIM", "anim/arong_personality_docile.zip"),
    Asset("ANIM", "anim/arong_personality_ornery.zip"),
    Asset("ANIM", "anim/arong_personality_pudgy.zip"),
	
    Asset("ANIM", "anim/beefalo_fx.zip"),
    Asset("SOUND", "sound/beefalo.fsb"),
}

local prefabs =
{
    "poop",
    "beefalowool",
    "horn",
}

local brain = require("brains/arongbrain")

SetSharedLootTable( 'arong',
{
    {'beefalowool',     1.00},
    {'beefalowool',     1.00},
    {'beefalowool',     1.00},
	{'beefalowool',     1.00},
	{'beefalowool',     1.00},
	{'beefalowool',     1.00},
    {'horn',            1.00},
})

local sounds = 
{
    walk = "dontstarve/beefalo/walk",
    grunt = "dontstarve/beefalo/grunt",
    yell = "dontstarve/beefalo/yell",
    swish = "dontstarve/beefalo/tail_swish",
    curious = "dontstarve/beefalo/curious",
    angry = "dontstarve/beefalo/angry",
    sleep = "dontstarve/beefalo/sleep",
}

local tendencies =
{
    DEFAULT =
    {
    },

    ORNERY =
    {
        build = "arong_personality_ornery",
    },

    RIDER =
    {
        build = "arong_personality_docile",
    },

    PUDGY =
    {
        build = "arong_personality_pudgy",
        customactivatefn = function(inst)
            --inst:AddComponent("sanityaura")
            inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL
        end,
        customdeactivatevn = function(inst)
            --inst:RemoveComponent("sanityaura")
			inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY
        end,
    },
}


 ---------------------------
local function levelexp(inst,data)

	local max_exp = 99999999999999993000
	local exp = math.min(inst.level, max_exp)
	local health_percent = inst.components.health:GetPercent()

inst.components.health.maxhealth = math.ceil (600 + exp* 1)
inst.components.talker:Say("[Max Health]\n".. (inst.level +600))
inst.components.health:SetPercent(health_percent)
	end
 
--level?
local function Checklevel(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, {"musha"})
for k,v in pairs(ents) do
if inst.yamcheinfo then
inst.components.talker:Say("[Max Health]\n".. (inst.level +600))
    inst.yamcheinfo = false 
end end 
end
----------

local function on_close(inst)
inst.MiniMapEntity:SetIcon( "" )
local leader = inst.components.follower.leader
if inst.components.follower.leader then
inst.follow = false
end
end
local function on_far(inst)
if inst.components.follower:IsNearLeader(100) then
inst.MiniMapEntity:SetIcon( "arong.tex" )
local leader = inst.components.follower.leader
elseif not inst.components.follower:IsNearLeader(100) then
inst.MiniMapEntity:SetIcon( "arong.tex" )
end
if inst.components.follower.leader then
inst.follow = true
end  
end

local function OnOpen(inst)
    if not inst.components.health:IsDead() then
	inst.components.domesticatable:DeltaObedience(0.2)
		inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()

if not inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("pleased")
elseif inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("shaved")
end
inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/shake_off")
end
if inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
end
if inst.components.freezable:IsFrozen() then
        inst.components.freezable:Unfreeze()
    end
end 

local function OnClose(inst) 
    if not inst.components.health:IsDead() then
inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/shake_off")
    if inst.AnimState:IsCurrentAnimation("alert_idle") then
        inst.AnimState:PlayAnimation("alert_pre") end
	if not inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("refuse")
elseif inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("shaved")
end
    end
end 

local function ClearBuildOverrides(inst, animstate)
    if animstate ~= inst.AnimState then
        animstate:ClearOverrideBuild("arong_build")
    end
    -- this presumes that all the face builds have the same symbols
    animstate:ClearOverrideBuild("arong_personality_docile")
end

-- This takes an anim state so that it can apply to itself, or to its rider
local function ApplyBuildOverrides(inst, animstate)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    local basebuild = (inst:HasTag("baby") and "arong_baby_build")
            --or (inst.components.beard.bits == 0 and "beefalo_shaved_build")
            --or (inst.components.domesticatable:IsDomesticated() and "beefalo_domesticated")
            or "arong_build"
    if animstate ~= nil and animstate ~= inst.AnimState then
        animstate:AddOverrideBuild(basebuild)
    else
        animstate:SetBuild(basebuild)
    end

    if (herd and herd.components.mood and herd.components.mood:IsInMood())
        or (inst.components.mood and inst.components.mood:IsInMood()) then
        animstate:Show("HEAT")
    else
        animstate:Hide("HEAT")
    end

    if tendencies[inst.tendency].build ~= nil then
        animstate:AddOverrideBuild(tendencies[inst.tendency].build)
    elseif animstate == inst.AnimState then
        -- this presumes that all the face builds have the same symbols
        animstate:ClearOverrideBuild("arong_personality_docile")
    end
end

local function OnEnterMood(inst)
    --inst:AddTag("scarytoprey")
    inst:ApplyBuildOverrides(inst.AnimState)
    if inst.components.rideable and inst.components.rideable:GetRider() ~= nil then
        inst:ApplyBuildOverrides(inst.components.rideable:GetRider().AnimState)
    end
end

local function OnLeaveMood(inst)
    --inst:RemoveTag("scarytoprey")
    inst:ApplyBuildOverrides(inst.AnimState)
    if inst.components.rideable ~= nil and inst.components.rideable:GetRider() ~= nil then
        inst:ApplyBuildOverrides(inst.components.rideable:GetRider().AnimState)
    end
end

--[[local function Retarget(inst)
    local herd = inst.components.herdmember ~= nil and inst.components.herdmember:GetHerd() or nil
    return herd ~= nil
        and herd.components.mood ~= nil
        and herd.components.mood:IsInMood()
        and FindEntity(
                inst,
                TUNING.BEEFALO_TARGET_DIST,
                function(guy)
                    return inst.components.combat:CanTarget(guy)
                        and (guy.components.rider == nil
                            or guy.components.rider:GetMount() == nil
                            or not guy.components.rider:GetMount():HasTag("beefalo"))
                end,
                { "_combat" }, --See entityreplica.lua (re: "_combat" tag)
                { "beefalo", "wall", "INLIMBO" }
            )
        or nil
end]]

local function Retarget(inst)
     local dist = 6
	 local leader = inst.components.follower.leader
    if inst.components.follower and inst.components.follower.leader and leader.components.health:GetPercent() < .25 and inst.components.health:GetPercent() > 0.2 then
    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
      {"musha","player","wall","houndmound","structure","companion","yamche","arongb","pig","bee","rocky","webber","bird","koalefant","beefalo","companion","moondrake","moondrake2","butterfly","prey","cavedweller","statue","character","abigail","smashable","veggie","catcoon"})
	end
end 

local function KeepTarget(inst, target)
    local herd = inst.components.herdmember ~= nil and inst.components.herdmember:GetHerd() or nil
    return herd == nil
        or herd.components.mood == nil
        or not herd.components.mood:IsInMood()
        or inst:IsNear(herd, TUNING.BEEFALO_CHASE_DIST)
end

local function musha(dude)
    return dude:HasTag("musha")
end
local function OnNewTarget(inst, data)
local MAX_TARGET_SHARES = 1
local SHARE_TARGET_DIST = 15
    local leader = inst.components.follower.leader
    if inst.mount and inst.components.follower and inst.components.follower.leader then
        inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, musha, MAX_TARGET_SHARES)
    end
	if other and other:HasTag("musha") then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
	end
end

local function CanShareTarget(dude)
	return (dude:HasTag("musha") or dude:HasTag("companion") )
        and not dude:IsInLimbo()
        and not (dude.components.health:IsDead())
end

local function flower_shield(inst, attacked, data) 
 	if not inst.components.health:IsDead() then
	--inst.fight_on = true
    if inst.components.health:GetPercent() >= .8 then
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())	
    elseif inst.components.health:GetPercent() < .8 and inst.components.health:GetPercent() >= .6 then
	SpawnPrefab("yellow_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .6 and inst.components.health:GetPercent() >= .4 then
	SpawnPrefab("orange_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .4 then
	SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get())
	elseif inst.components.health:GetPercent() < .2 then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
	
	end	end
end

local function OnAttacked(inst, data)
    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end
    inst._ridersleep = nil
    if inst.components.rideable:IsBeingRidden() then
        if not inst.components.domesticatable:IsDomesticated() or not inst.tendency == TENDENCY.ORNERY then
            inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_ATTACKED_DOMESTICATION)
            inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_ATTACKED_OBEDIENCE)
        end
        inst.components.domesticatable:DeltaTendency(TENDENCY.ORNERY, TUNING.BEEFALO_ORNERY_ATTACKED)
    else
        if data.attacker ~= nil and data.attacker:HasTag("player") then
            --inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_ATTACKED_BY_PLAYER_DOMESTICATION)
            --inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_ATTACKED_BY_PLAYER_OBEDIENCE)
			inst.components.combat:SetTarget(nil)
			inst.components.combat:GiveUp()
        else
        inst.components.combat:SetTarget(data.attacker)
        inst.components.combat:ShareTarget(data.attacker, 30, CanShareTarget, 5)
		end
    end
end

local function GetStatus(inst)
    return (inst.components.follower.leader ~= nil and "FOLLOWER")
        or (inst.components.beard ~= nil and inst.components.beard.bits == 0 and "NAKED")
        or (inst.components.domesticatable ~= nil and
            inst.components.domesticatable:IsDomesticated() and
            (inst.tendency == TENDENCY.DEFAULT and "DOMESTICATED" or inst.tendency))
        or nil
end

local function OnResetBeard(inst)
    inst.sg:GoToState("shaved")
    inst.components.brushable:SetBrushable(false)
    inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_SHAVED_OBEDIENCE)
end

local function CanShaveTest(inst)
    if inst.components.sleeper:IsAsleep() then
        return true
    else
        return false, "AWAKEBEEFALO"
    end
end

local function OnShaved(inst)
    inst:ApplyBuildOverrides(inst.AnimState)
end

local function OnHairGrowth(inst)
    if inst.components.beard.bits == 0 then
        inst.hairGrowthPending = true
        if inst.components.rideable ~= nil then
            inst.components.rideable:Buck()
        end
    end
end

local function OnBrushed(inst, doer, numprizes)
    if numprizes > 0 and inst.components.domesticatable ~= nil then
        inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_BRUSHED_DOMESTICATION)
        inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_BRUSHED_OBEDIENCE)
    end
end

local function ShouldAcceptItem(inst, item)
    return inst.components.eater:CanEat(item)
        and not inst.components.combat:HasTarget()
end

local function OnGetItemFromPlayer(inst, giver, item)
    if inst.components.eater:CanEat(item) then
        inst.components.eater:Eat(item, giver)
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnDomesticated(inst, data)
    inst.components.rideable:Buck()
    inst.domesticationPending = true
end

local function DoDomestication(inst)
    inst.components.herdmember:Enable(false)
    inst.components.mood:Enable(true)
    inst.components.mood:ValidateMood()

    inst:SetTendency("domestication")
end

local function OnFeral(inst, data)
    inst.components.rideable:Buck()
    if inst.components.domesticatable:IsDomesticated() then
        inst.domesticationPending = true
    end
end

local function DoFeral(inst)
    inst.components.herdmember:Enable(true)
    inst.components.mood:Enable(false)
    inst.components.mood:ValidateMood()

    inst:SetTendency("feral")
end

local function UpdateDomestication(inst)
    if inst.components.domesticatable:IsDomesticated() then
        DoDomestication(inst)
    else
        DoFeral(inst)
    end
end

local function SetTendency(inst, changedomestication)
    -- tendency is locked in after we become domesticated
    local tendencychanged = false
    local oldtendency = inst.tendency
    if not inst.components.domesticatable:IsDomesticated() then
        local tendencysum = 0
        local maxtendency = nil
        local maxtendencyval = 0
        for k, v in pairs(inst.components.domesticatable.tendencies) do
            tendencysum = tendencysum + v
            if v > maxtendencyval then
                maxtendencyval = v
                maxtendency = k
            end
        end
        inst.tendency = (tendencysum < .1 or maxtendencyval * 2 < tendencysum) and TENDENCY.DEFAULT or maxtendency
        tendencychanged = inst.tendency ~= oldtendency
    end

    if changedomestication == "domestication" then
        if tendencies[inst.tendency].customactivatefn ~= nil then
            tendencies[inst.tendency].customactivatefn(inst)
        end
    elseif changedomestication == "feral"
        and tendencies[oldtendency].customdeactivatefn ~= nil then
        tendencies[oldtendency].customdeactivatefn(inst)
    end

    if tendencychanged or changedomestication ~= nil then
        if inst.components.domesticatable:IsDomesticated() then
            inst.components.domesticatable:SetMinObedience(TUNING.BEEFALO_MIN_DOMESTICATED_OBEDIENCE[inst.tendency])

            inst.components.combat:SetDefaultDamage(TUNING.BEEFALO_DAMAGE[inst.tendency])
            inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED[inst.tendency]
        else
            inst.components.domesticatable:SetMinObedience(0)

            inst.components.combat:SetDefaultDamage(TUNING.BEEFALO_DAMAGE.DEFAULT)
            inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT
        end

        inst:ApplyBuildOverrides(inst.AnimState)
        if inst.components.rideable and inst.components.rideable:GetRider() ~= nil then
            inst:ApplyBuildOverrides(inst.components.rideable:GetRider().AnimState)
        end
    end
end

local function ShouldBeg(inst)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    return inst.components.domesticatable ~= nil
        and inst.components.domesticatable:GetDomestication() > 0.0
        and inst.components.hunger ~= nil
        and inst.components.hunger:GetPercent() < TUNING.BEEFALO_BEG_HUNGER_PERCENT
        and (herd and herd.components.mood ~= nil and herd.components.mood:IsInMood() == false)
        and (inst.components.mood ~= nil and inst.components.mood:IsInMood() == false)
end

local function CalculateBuckDelay(inst)
    local domestication =
        inst.components.domesticatable ~= nil
        and inst.components.domesticatable:GetDomestication()
        or 0

    local moodmult =
        (   (inst.components.herdmember ~= nil and inst.components.herdmember.herd ~= nil and inst.components.herdmember.herd.components.mood ~= nil and inst.components.herdmember.herd.components.mood:IsInMood()) or
            (inst.components.mood ~= nil and inst.components.mood:IsInMood())   )
        and TUNING.BEEFALO_BUCK_TIME_MOOD_MULT
        or 1

    local beardmult =
        (inst.components.beard ~= nil and inst.components.beard.bits == 0)
        and TUNING.BEEFALO_BUCK_TIME_NUDE_MULT
        or 1

    local domesticmult =
        inst.components.domesticatable:IsDomesticated()
        and 1
        or TUNING.BEEFALO_BUCK_TIME_UNDOMESTICATED_MULT

    local basedelay = Remap(domestication, 0, 1, TUNING.BEEFALO_MIN_BUCK_TIME, TUNING.BEEFALO_MAX_BUCK_TIME)

    return basedelay * moodmult * beardmult * domesticmult
end

local function OnBuckTime(inst)
    --V2C: reschedule because :Buck() is not guaranteed!
    inst._bucktask = inst:DoTaskInTime(1 + math.random(), OnBuckTime)
    inst.components.rideable:Buck()
end

local function OnObedienceDelta(inst, data)
    inst.components.rideable:SetSaddleable(data.new >= TUNING.BEEFALO_SADDLEABLE_OBEDIENCE)

    if data.new > data.old and inst._bucktask ~= nil then
        --Restart buck timer if we gained obedience!
        inst._bucktask:Cancel()
        inst._bucktask = inst:DoTaskInTime(CalculateBuckDelay(inst), OnBuckTime)
    end
end

local function OnDeath(inst, data)
    if inst.components.rideable:IsBeingRidden() then
        --SG won't handle "death" event while we're being ridden
        --SG is forced into death state AFTER dismounting (OnRiderChanged)
        inst.components.rideable:Buck(true)
    end
end

local function DomesticationTriggerFn(inst)
    return inst.components.hunger:GetPercent() > 0
        or inst.components.rideable:IsBeingRidden() == true
end

local function OnStarving(inst, dt)
    -- apply no health damage; the stomach is just used by domesticatable
    inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_STARVE_OBEDIENCE * dt)
    --inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_STARVE_DOMESTICATION * dt)
end

local function OnHungerDelta(inst, data)
    if data.oldpercent > 0 and data.delta < 0 then
        -- basically, give domestication while we are digesting
        --inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_WELLFED_DOMESTICATION * -data.delta)
        if data.oldpercent > 0.5 then
            inst.components.domesticatable:DeltaTendency(TENDENCY.PUDGY, TUNING.BEEFALO_PUDGY_WELLFED * -data.delta)
        end
    end
end

local function OnEat(inst, food)
inst.components.domesticatable:DeltaObedience(0.2)
    local full = inst.components.hunger:GetPercent() >= 1
    if not full then
        inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_FEED_OBEDIENCE)

        inst.components.domesticatable:TryBecomeDomesticated()
    else
        inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_OVERFEED_OBEDIENCE)
        inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_OVERFEED_DOMESTICATION)
        inst.components.domesticatable:DeltaTendency(TENDENCY.PUDGY, TUNING.BEEFALO_PUDGY_OVERFEED)
    end
    inst:PushEvent("eat", { full = full, food = food })
    inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
	
	if food.components.edible.hungervalue == 150 and food.components.edible.healthvalue == 100 then 
	inst.level = inst.level + 80
	levelexp(inst)
inst.components.health:DoDelta(300)
inst.components.hunger:DoDelta(100)
inst.components.talker:Say(" !!!!!!!!!! \n[Max Health] + 80 ")

end

    -- food heal
local poopchance2 = 0.6
local poopchance = 0.4
local rebackchance = 0.2
local tynychance = 0.1
local eggchance = 1.0	
  
        inst.components.health:DoDelta(inst.components.health.maxhealth * .05, nil, food.prefab)
        inst.components.combat:SetTarget(nil)
      
    if food.components.edible and (food.components.edible.hungervalue > 100 and food.components.edible.healthvalue > 91) then
inst.components.health:DoDelta(150)
inst.components.hunger:DoDelta(50)
inst.level = inst.level + 15
levelexp(inst)

	end

    if food.components.edible and (food.components.edible.hungervalue > 49 or food.components.edible.healthvalue > 39) then
inst.components.health:DoDelta(100)
inst.components.hunger:DoDelta(30)
		inst.level = inst.level + 8
		levelexp(inst)

	end

    if food.components.edible and (food.components.edible.hungervalue > 24 or food.components.edible.healthvalue > 29 or food.components.edible.sanityvalue > 14) then
inst.components.health:DoDelta(50)
inst.components.hunger:DoDelta(15)
    if math.random() < poopchance then
		inst.level = inst.level + 4
		levelexp(inst)
	end
	end

    if food.components.edible and food.components.edible.hungervalue > 9 or food.components.edible.healthvalue > 9 or food.components.edible.sanityvalue > 4 then
inst.components.health:DoDelta(15)
inst.components.hunger:DoDelta(10)
    if math.random() < rebackchance then
		inst.level = inst.level + 2
		levelexp(inst)	
  	end
	end
	
	if math.random() < poopchance2 then
	local fx = SpawnPrefab("poopcloud")
	fx.Transform:SetScale(0.5, 0.5, 0.5)
	fx.Transform:SetPosition(inst:GetPosition():Get())
    if math.random() < poopchance then
		local poo = SpawnPrefab("seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("carrot_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("pumpkin_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("dragonfruit_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("watermelon_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())			
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("pomegranate_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("corn_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("eggplant_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())			
    else
		local poo = SpawnPrefab("seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
	end
	if food.components.edible and food.components.edible.hungervalue > 20 then
		local poo = SpawnPrefab("poop")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())	
	end
	end
	
end

local function InShadow(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 15)
for k,v in pairs(ents) do
if inst.sleep_on and v.components.combat and v.components.combat.target == inst and not (v:HasTag("berrythief") or v:HasTag("prey") or v:HasTag("bird") or v:HasTag("butterfly")) then
		v.components.combat.target = nil
 end
 end end
 
local function anti_monkey(inst)
if inst.anti_monkey then
inst:DoTaskInTime(9, function() inst.anti_monkey = false inst.components.container.canbeopened = true end)

end end
local function BreedArong (inst)

if inst.follow then
 inst.components.domesticatable:DeltaObedience(0.01)
 
elseif not inst.follow and inst.components.rideable and inst.components.rideable:GetRider() then
 inst.components.domesticatable:DeltaObedience(0.01)

end

if inst.components.hunger:GetPercent() >= 0.1 and not inst.fast then
inst.fast = true
inst.slow = false
inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT * 1.9
elseif inst.components.hunger:GetPercent() < 0.1 and not inst.slow then
inst.fast = false
inst.slow = true
inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT * 1.25
end
 
if inst.components.health:GetPercent() < 0.1 or inst.components.hunger:GetPercent() < 0.1 then
if inst.components.rideable and inst.components.rideable:GetRider() ~= nil then
inst.components.rideable:Buck(true)	
end
end

if inst.components.rideable and inst.components.rideable:GetRider() ~= nil then
inst.components.hunger:SetRate(TUNING.BEEFALO_HUNGER_RATE*1.5)
elseif inst.components.rideable and not inst.components.rideable:GetRider() then
inst.components.hunger:SetRate(0)
--inst.components.hunger:DoDelta(0.5)
end
--anti monkey
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 2, {"monkey"})
for k,v in pairs(ents) do
if not inst.sleep_on and not inst.anti_monkey and not v:HasTag("nightmare")then
local random = 0.2
if math.random() < random then
inst.components.talker:Say("[ Don't touch me..]")
elseif math.random() < random then
inst.components.talker:Say("[ Go away..]")
elseif math.random() < random then
inst.components.talker:Say("[ Monkey..]")
elseif math.random() < random then
inst.components.talker:Say("[ Thief..]")
end
inst.anti_monkey = true
inst.yamche = true
inst.components.container.canbeopened = false
anti_monkey(inst)
end end
 --sleep change
  if TheWorld.state.isday and not inst.force_sleep then
  inst.digest = true
	inst.onsleep = false
  elseif TheWorld.state.isdusk and not inst.force_sleep then
  inst.digest = true
	inst.onsleep = false
  elseif TheWorld.state.isnight then
	inst.onsleep = true
	if inst.digest and inst.components.sleeper:IsAsleep() then
	 inst.digest = false
if inst.components.hunger:GetPercent() < .7 then
	 if not TheWorld.state.iswinter then
	--inst.components.talker:Say("[..Digest..]\nRecovery Hunger [15%]")
	inst.components.hunger:DoDelta(60)
	elseif TheWorld.state.iswinter then
	--inst.components.talker:Say("[..Digest..]\nRecovery Hunger [5%]\n-Winter-")
	inst.components.hunger:DoDelta(20)
end
	end	
	  end
  elseif TheWorld.state.iscaveday and not inst.force_sleep then
  inst.digest = true
    inst.onsleep = false
  elseif TheWorld.state.iscavedusk and not inst.force_sleep then
  inst.digest = true
	inst.onsleep = false
  elseif TheWorld.state.iscavenight then
	inst.onsleep = true
	if inst.digest and inst.components.sleeper:IsAsleep() then
	 inst.digest = false
if inst.components.hunger:GetPercent() < .7 then	 
	if not TheWorld.state.iswinter then
	--inst.components.talker:Say("[..Digest..]\nRecovery Hunger [15%]")
	inst.components.hunger:DoDelta(60)
	elseif TheWorld.state.iswinter then
	--inst.components.talker:Say("[..Digest..]\nRecovery Hunger [5%]\n-Winter-")
	inst.components.hunger:DoDelta(20)
end	
	end	
	  end
   end  

end 

local function on_follow(inst, data)

if inst.yamche then
inst.sg:GoToState("bellow")
if not inst.follow_talk then
inst.components.talker:Say("[I like follow..]")
inst.follow_talk = true
elseif inst.follow_talk then
inst.follow_talk = false
end
if inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp()
 end

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
if inst.sleep_on and inst.onsleep then
inst.anti_monkey = false
inst.components.container.canbeopened = true

InShadow(inst)
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
elseif not inst.sleep_on then

end
if inst.components.follower.leader and inst.follow then
inst.components.combat:GiveUp()
inst.components.health:SetAbsorptionAmount(0.95)
inst.components.locomotor.walkspeed = 2.2
elseif inst.components.follower.leader and not inst.follow then
inst.components.health:SetAbsorptionAmount(0.6)
inst.components.locomotor.walkspeed = 1.2
elseif not inst.components.follower.leader then
inst.components.health:SetAbsorptionAmount(0.6)
inst.components.locomotor.walkspeed = 0.5
end
if not inst.components.rideable:GetRider() and not inst.components.follower.leader then
inst.sleep_on = true
InShadow(inst)
end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20, {"musha"})
for k,v in pairs(ents) do
v.arong_follow = true
--Checklevel
if inst.yamcheinfo then
inst.components.talker:Say("[Max Health]\n".. (inst.level +600))
    inst.yamcheinfo = false 
end
 end
 end 

local function on_wakeup(inst, data)

if inst.components.hunger:GetPercent() < 0.5 then
  SpawnPrefab("pine_needles_chop").Transform:SetPosition(inst:GetPosition():Get())
end 
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 5, {"musha"})
for k,v in pairs(ents) do
if inst.components.follower.leader and (v.sleep_on or v.tiny_sleep) then
inst.force_sleep = true
inst.onsleep = true
inst.sleep_on = true
--inst.sg:GoToState("sleeping")
elseif inst.components.follower.leader and not (v.sleep_on or v.tiny_sleep) then
if inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp() end
inst.force_sleep = false
inst.onsleep = false
inst.sleep_on = false
end end
 end  

local function OnDomesticationDelta(inst, data)
    inst:SetTendency()
end

local function OnHealthDelta(inst, data)
    if data.oldpercent >= 0.2 and
        data.newpercent < 0.2 and
        inst.components.rideable.rider ~= nil then
        inst.components.rideable.rider:PushEvent("mountwounded")
    end
end

local function OnBeingRidden(inst, dt)
    inst.components.domesticatable:DeltaTendency(TENDENCY.RIDER, TUNING.BEEFALO_RIDER_RIDDEN * dt)
end

local function OnRiderDoAttack(inst, data)
    inst.components.domesticatable:DeltaTendency(TENDENCY.ORNERY, TUNING.BEEFALO_ORNERY_DOATTACK)
end

local function DoRiderSleep(inst, sleepiness, sleeptime)
    inst._ridersleeptask = nil
    inst.components.sleeper:AddSleepiness(sleepiness, sleeptime)
end

local function OnRiderChanged(inst, data)
    if inst._bucktask ~= nil then
        inst._bucktask:Cancel()
        inst._bucktask = nil
    end

    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end

    if data.newrider ~= nil then
        if inst.components.sleeper ~= nil then
            inst.components.sleeper:WakeUp()
        end
        inst._bucktask = inst:DoTaskInTime(CalculateBuckDelay(inst), OnBuckTime)
        inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
    elseif inst.components.health:IsDead() then
        if inst.sg.currentstate.name ~= "death" then
            inst.sg:GoToState("death")
        end
    elseif inst.components.sleeper ~= nil then
        inst.components.sleeper:StartTesting()
        if inst._ridersleep ~= nil then
            local sleeptime = inst._ridersleep.sleeptime + inst._ridersleep.time - GetTime()
            if sleeptime > 2 then
                inst._ridersleeptask = inst:DoTaskInTime(0, DoRiderSleep, inst._ridersleep.sleepiness, sleeptime)
            end
            inst._ridersleep = nil
        end
    end
end

local function OnSaddleChanged(inst, data)
    --[[if data.saddle ~= nil then
        inst:AddTag("companion")
    else
        inst:RemoveTag("companion")
    end]]
end

local function _OnRefuseRider(inst)
    if inst.components.sleeper:IsAsleep() and not inst.components.health:IsDead() then
        -- this needs to happen after the stategraph
        inst.components.sleeper:WakeUp()
    end
end

local function OnRefuseRider(inst, data)
    inst:DoTaskInTime(0, _OnRefuseRider)
end

local function OnRiderSleep(inst, data)
    inst._ridersleep = inst.components.rideable:IsBeingRidden() and {
        time = GetTime(),
        sleepiness = data.sleepiness,
        sleeptime = data.sleeptime,
    } or nil
end

local function MountSleepTest(inst)
    return not inst.components.rideable:IsBeingRidden() and DefaultSleepTest(inst)
end

local function ToggleDomesticationDecay(inst)
    inst.components.domesticatable:PauseDomesticationDecay(inst.components.saltlicker.salted or inst.components.sleeper:IsAsleep())
end

local function OnInit(inst)
    inst.components.mood:ValidateMood()
    inst:UpdateDomestication()
end

local function CustomOnHaunt(inst)
    inst.components.periodicspawner:TrySpawn()
    return true
end

local function onpreload(inst, data)
	if data then
			if data.level then
			inst.level = data.level
			levelexp(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			inst.components.health:DoDelta(0)
		end
	end
end  
		
local function OnSave(inst, data)

    data.tendency = inst.tendency
		data.level = inst.level
end

local function OnLoad(inst, data)

    if data and data.tendency then
        inst.tendency = data.tendency
    end
end


local function GetDebugString(inst)
    return string.format("tendency %s nextbuck %.2f", inst.tendency, GetTaskRemaining(inst._bucktask))
end

local function arong()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .5)

    inst.DynamicShadow:SetSize(6, 2)
    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("beefalo")
    inst.AnimState:SetBuild("arong_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("HEAT")
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "arong.tex" )
	inst.MiniMapEntity:SetPriority(10)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	inst:AddComponent("maprevealer")
	inst.components.maprevealer.revealperiod = 0.25
	inst.components.maprevealer:Start()
	
	inst:AddTag("companion")
	inst:AddTag("yamche")
    inst:AddTag("notraptrigger")	
	inst:AddTag("arongb")
	
    inst:AddTag("beefalo")
    --inst:AddTag("animal")
    inst:AddTag("largecreature")

    --bearded (from beard component) added to pristine state for optimization
    --inst:AddTag("bearded")

    --trader (from trader component) added to pristine state for optimization
    inst:AddTag("trader")

    --herdmember (from herdmember component) added to pristine state for optimization
    inst:AddTag("herdmember")

    --saddleable (from rideable component) added to pristine state for optimization
    inst:AddTag("saddleable")

    --domesticatable (from domesticatable component) added to pristine state for optimization
    inst:AddTag("domesticatable")

    --saltlicker (from saltlicker component) added to pristine state for optimization
    inst:AddTag("saltlicker")

    inst.sounds = sounds

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 30
    inst.components.talker.colour = Vector3(0.6, 0.9, 0.8, 1)
	
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
	
    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.ARONG
    inst.components.named:PickNewName()
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(8, 8)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(on_far)
	
	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY

    inst:AddComponent("bloomer")

    inst:AddComponent("beard")
    -- assume the beefalo has already grown its hair
    inst.components.beard.bits = 3
    inst.components.beard.daysgrowth = TUNING.BEEFALO_HAIR_GROWTH_DAYS + 1
    inst.components.beard.onreset = OnResetBeard
    inst.components.beard.canshavetest = CanShaveTest
    inst.components.beard.prize = "curgrass"--"beefalowool"
    inst.components.beard:AddCallback(0, OnShaved)
    inst.components.beard:AddCallback(TUNING.BEEFALO_HAIR_GROWTH_DAYS, OnHairGrowth)

    inst:AddComponent("brushable")
    inst.components.brushable.regrowthdays = 1
    inst.components.brushable.max = 1
    inst.components.brushable.prize = "beefalowool"
    inst.components.brushable:SetOnBrushed(OnBrushed)

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE }, { FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE })
    inst.components.eater:SetAbsorptionModifiers(4,1,1)
    inst.components.eater:SetOnEatFn(OnEat)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
    inst.components.combat:SetDefaultDamage(TUNING.BEEFALO_DAMAGE.DEFAULT)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    --inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.BEEFALO_HEALTH)
    inst.components.health.nofadeout = true
    inst.components.health:StartRegen(TUNING.BEEFALO_HEALTH_REGEN, TUNING.BEEFALO_HEALTH_REGEN_PERIOD)
    inst:ListenForEvent("death", OnDeath) -- need to handle this due to being mountable
    inst:ListenForEvent("healthdelta", OnHealthDelta) -- to inform rider

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('beefalo')

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("knownlocations")
    inst:ListenForEvent("entermood", OnEnterMood)
    inst:ListenForEvent("leavemood", OnLeaveMood)

    inst:AddComponent("leader")
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.BEEFALO_FOLLOW_TIME
    inst.components.follower.canaccepttarget = false

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
    inst.components.periodicspawner:SetRandomTimes(40, 60)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()

    inst:AddComponent("rideable")
    inst.components.rideable:SetRequiredObedience(TUNING.BEEFALO_MIN_BUCK_OBEDIENCE)
    inst:ListenForEvent("saddlechanged", OnSaddleChanged)
    inst:ListenForEvent("refusedrider", OnRefuseRider)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    inst:AddComponent("hunger")
    --inst.components.hunger:SetMax(TUNING.BEEFALO_HUNGER)
    --inst.components.hunger:SetRate(TUNING.BEEFALO_HUNGER_RATE)
    inst.components.hunger:SetMax(400)
	inst.components.hunger:SetRate(0)
    inst.components.hunger:SetPercent(0)
    inst.components.hunger:SetOverrideStarveFn(OnStarving)

    inst:AddComponent("domesticatable")
    inst.components.domesticatable:SetDomesticationTrigger(DomesticationTriggerFn)

    MakeLargeBurnableCharacter(inst, "beefalo_body")
    MakeLargeFreezableCharacter(inst, "beefalo_body")

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.BEEFALO_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.sleeptestfn = MountSleepTest

    inst:AddComponent("timer")
    inst:AddComponent("saltlicker")
    inst.components.saltlicker:SetUp(TUNING.SALTLICK_BEEFALO_USES)
    inst:ListenForEvent("saltchange", ToggleDomesticationDecay)
    inst:ListenForEvent("gotosleep", ToggleDomesticationDecay)
    inst:ListenForEvent("onwakeup", ToggleDomesticationDecay)

    inst.ApplyBuildOverrides = ApplyBuildOverrides
    inst.ClearBuildOverrides = ClearBuildOverrides

    inst.tendency = TENDENCY.DEFAULT
    inst._bucktask = nil

    -- Herdmember component is ONLY used when feral
    inst:AddComponent("herdmember")
    inst.components.herdmember:Enable(true)

    -- Mood component is ONLY used when domesticated, otherwise it's part of the herd
    inst:AddComponent("mood")
    inst.components.mood:SetMoodTimeInDays(TUNING.BEEFALO_MATING_SEASON_LENGTH, TUNING.BEEFALO_MATING_SEASON_WAIT)
    inst.components.mood:SetInMoodFn(OnEnterMood)
    inst.components.mood:SetLeaveMoodFn(OnLeaveMood)
    inst.components.mood:CheckForMoodChange()
    inst.components.mood:Enable(false)

    inst.UpdateDomestication = UpdateDomestication
    inst:ListenForEvent("domesticated", OnDomesticated)
    inst.DoFeral = DoFeral
    inst:ListenForEvent("goneferal", OnFeral)
    inst:ListenForEvent("obediencedelta", OnObedienceDelta)
    inst:ListenForEvent("domesticationdelta", OnDomesticationDelta)
    inst:ListenForEvent("beingridden", OnBeingRidden)
    inst:ListenForEvent("riderchanged", OnRiderChanged)
    inst:ListenForEvent("riderdoattackother", OnRiderDoAttack)
    inst:ListenForEvent("hungerdelta", OnHungerDelta)
    inst:ListenForEvent("ridersleep", OnRiderSleep)
	
	inst:ListenForEvent("attacked", flower_shield)
	inst.BreedArong = inst:DoPeriodicTask(1, BreedArong)
	inst.on_follow = inst:DoPeriodicTask(0, on_follow)  
	inst.on_wakeup = inst:DoPeriodicTask(4, on_wakeup)  

    inst:AddComponent("uniqueid")
    inst:AddComponent("beefalometrics")

    MakeHauntablePanic(inst)
    AddHauntableCustomReaction(inst, CustomOnHaunt, true, false, true)

    inst.SetTendency = SetTendency
    inst:SetTendency()

    inst.ShouldBeg = ShouldBeg

    inst:SetBrain(brain)
    inst:SetStateGraph("SGBeefalo")

    inst:DoTaskInTime(0, OnInit)

    inst.debugstringfn = GetDebugString
	inst.level = 0
	inst:ListenForEvent("levelup", levelexp)
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	inst.OnPreLoad = onpreload

    return inst
end

return Prefab("arong", arong, assets, prefabs)

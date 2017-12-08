local MakePlayerCharacter = require("prefabs/player_common")
--local easing = require("easing")
local assets = {
  Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
		Asset( "ANIM", "anim/player_actions_uniqueitem_2.zip" ),
		Asset( "ANIM", "anim/player_actions_speargun.zip" ),
		Asset( "ANIM", "anim/player_actions_telescope.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
		
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),
		
        Asset( "ANIM", "anim/musha_battle.zip" ),
        Asset( "ANIM", "anim/musha.zip" ),
        Asset( "ANIM", "anim/musha_normal.zip" ),
		Asset( "ANIM", "anim/musha_hunger.zip" ),
		Asset( "ANIM", "anim/ghost_musha_build.zip" ),

}

local prefabs =
{
    "book_birds",
    "book_tentacles",
    "book_gardening",
    "book_sleep",
    "book_brimstone",
}

local start_inv = 
{
	--"musha_egg",
 	"glowdust",
	"glowdust",
}

local function treasure_hunt(inst,data)
local max_treasure = 100
local treasure = math.min(inst.treasure, max_treasure)
 end	
 local function count_wil(inst,data)
local max_count_w = 100
local count_w = math.min(inst.count_w, max_count_w)
 end			
local function stamina_sleep(inst,data)
local max_stamina = 100
local stamina = math.min(inst.stamina, max_stamina) or nil
 end
local function fatigue_sleep(inst,data)
local max_fatigue = 100
local fatigue = math.min(inst.fatigue, max_fatigue) or nil
 end
local function fullcharged_music(inst)
local max_music = 100
local music = math.min(inst.music, max_music)
end 

-----------------------------
local function guardian_proc(inst, data)
if inst.guardian_pop and not inst.components.health:IsDead() then
inst.components.health:SetAbsorptionAmount(1)
inst.guard_on = true
inst.count_w = inst.count_w * 0
local assasin = SpawnPrefab("assasin_wilson")
local pop = SpawnPrefab("explode_small")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
pop.Transform:SetScale(1.25, 1.25, 1.25)
assasin.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
pop.Transform:SetPosition(assasin:GetPosition():Get())
SpawnPrefab("statue_transition_2").Transform:SetPosition(assasin:GetPosition():Get()) 
	if inst.loud_3 then
	SpawnPrefab("lightning").Transform:SetPosition(assasin:GetPosition():Get())
	end
SpawnPrefab("lightning_blue").Transform:SetPosition(assasin.Transform:GetWorldPosition())
assasin.components.follower:SetLeader(inst)
 	inst:DoTaskInTime(0.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(assasin:GetPosition():Get())
	inst:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(assasin:GetPosition():Get())  end) end)
local random1 = 0.2
local random2 = 1
if math.random() < random1 then
assasin.components.talker:Say("Musha! I'm here !!")
elseif math.random() < random1 then
assasin.components.talker:Say("Musha! Don't worry !!")
elseif math.random() < random1 then
assasin.components.talker:Say("Musha! I will help you !!")
elseif math.random() < random1 then
assasin.components.talker:Say("Musha! I heard your voice !!")
elseif math.random() < random1 then
assasin.components.talker:Say("Go away from my Girl!")
elseif math.random() < random1 then
assasin.components.talker:Say("Princess!")
elseif math.random() < random1 then
assasin.components.talker:Say("Musha!!!")
elseif math.random() < random2 then
assasin.components.talker:Say("Musha! I will protect you  !!")
end
end

if not inst.components.health:IsDead() then
inst.components.health:DoDelta(20) end
local fx = SpawnPrefab("forcefieldfxx")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
fx.Transform:SetScale(0.7, 0.7, 0.7)
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
if not inst.components.health:IsDead() then
inst.components.health:SetInvincible(true)
end
if math.random() < 0.2 then
inst.components.talker:Say("Wilson !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("You Save me !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("Thank you !")
elseif math.random() < 0.2  then
inst.components.talker:Say("Nice Timing!")
elseif math.random() < 0.2  then
inst.components.talker:Say("I miss You")
elseif math.random() < 0.2  then
inst.components.talker:Say("Great!")
elseif math.random() < 1 then
inst.components.talker:Say("Wilson !!")
end
inst:DoTaskInTime(--[[Duration]] 3, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
inst.components.health:SetInvincible(false)
if inst:IsValid() then
fx.kill_fx(fx)
inst.components.health:SetAbsorptionAmount(0)

inst:DoTaskInTime(--[[Cooldown]] 600, function() inst.guard_on = false inst.guardian_pop = false end)
end end) 
 end 
 
local function guard(inst)
if not inst.no_bodyguard then
--if not inst.no_assasin then
inst.count_w = inst.count_w + 1
if not inst.guard_on and inst.components.health:GetPercent() < .3 and inst.count_w >=90 and math.random() < .1 then
inst.guardian_pop = true
            guardian_proc(inst)
    end end 
end
	
	
local function MyPrecious(inst)

--[[	
	if TheSim:FindFirstEntityWithTag("musha_treasure") then
	local treasures = TheSim:FindFirstEntityWithTag("musha_treasure")
	local x, y, z = treasures.Transform:GetWorldPosition()
	local minimap = TheWorld.minimap.MiniMap
	minimap:ShowArea(x, y, z, 20)
			end
]]
	--[[if TheSim:FindFirstEntityWithTag("buriedtreasure") then
	local treasures = TheSim:FindFirstEntityWithTag("buriedtreasure")
	local x, y, z = treasures.Transform:GetLocalPosition()
	local minimap = GetWorld().minimap.MiniMap
	local map = GetWorld().Map
	local cx, cy, cz = map:GetTileCenterPoint(x, 0, z)
	minimap:ShowArea(cx, cy, cz, 15)
	map:VisitTile(map:GetTileCoordsAtPoint(cx, cy, cz))
		end]]
	end

	
local function summon_drake(inst, data)
 
 -- moondrake
 if inst.moondrake_on then
local drake = SpawnPrefab("moonnutdrake2")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local x,y,z = inst.Transform:GetWorldPosition()

	drake.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	drake.components.follower:SetLeader(inst)
	inst.components.leader:AddFollower(drake)
	drake.slave = true
	--drake.components.follower:SetLeader(inst)
drake.sg:GoToState("enter")
drake.AnimState:PlayAnimation("enter")
if drake.components.combat then
	drake.components.combat:SuggestTarget(drake.target)
end		end
	end		

local function light_call(inst, data)

local x,y,z = inst.Transform:GetWorldPosition()
local bodyguard = TheSim:FindEntities(x,y,z, 20, {"bodyguard_w"})
for k,v in pairs(bodyguard) do
if v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("bodyguard") < 1 then
inst.components.leader:AddFollower(v)
end end
local x,y,z = inst.Transform:GetWorldPosition()
local light1 = TheSim:FindEntities(x,y,z, 20, {"musha_light"})
for k,v in pairs(light1) do
if v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("musha_light") < 3 then
inst.components.leader:AddFollower(v)
end end
local x,y,z = inst.Transform:GetWorldPosition()
local light2 = TheSim:FindEntities(x,y,z, 20, {"musha_light2"})
for k,v in pairs(light2) do
if v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("musha_light2") < 1 then
inst.components.leader:AddFollower(v)
end end
end

--------------------------------------------------------------------------

local MAX_TRAIL_VARIATIONS = 7
local MAX_RECENT_TRAILS = 4
local TRAIL_MIN_SCALE = 1
local TRAIL_MAX_SCALE = 1.6

local function PickTrail(inst)
    local rand = table.remove(inst.availabletrails, math.random(#inst.availabletrails))
    table.insert(inst.usedtrails, rand)
    if #inst.usedtrails > MAX_RECENT_TRAILS then
        table.insert(inst.availabletrails, table.remove(inst.usedtrails, 1))
    end
    return rand
end

local function RefreshTrail(inst, fx)
    if fx:IsValid() then
        fx:Refresh()
    else
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end

local function DoTrail(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
   --[[ if inst.sg:HasStateTag("moving") then
        local theta = -inst.Transform:GetRotation() * DEGREES
        x = x + math.cos(theta)
        z = z + math.sin(theta)
    end
    local fx = SpawnPrefab("damp_trail")
    fx.Transform:SetPosition(x, 0, z)
    fx:SetVariation(PickTrail(inst), GetRandomMinMax(TRAIL_MIN_SCALE, TRAIL_MAX_SCALE), TUNING.STALKER_BLOOM_DECAY)
	]]
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
    end
    --inst._trailtask = inst:DoPeriodicTask(TUNING.STALKER_BLOOM_DECAY * .5, RefreshTrail, nil, fx)
end

local BLOOM_CHOICES =
{
    ["musha_bulb"] = 0.22,
    ["musha_bulb_double"] = 0.05,
    ["musha_berry"] = 0.03,
	["apple_berry"] = 0.4,
    ["musha_fern"] = 3,
	["light_fern"] = 0.6,
    ["green_fern"] = 5.2,
	
}

local function DoPlantBloom(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 1 * PI,
        math.random() * 2,
        4,
        function(offset)
            local x1 = x + offset.x
            local z1 = z + offset.z
            return map:IsPassableAtPoint(x1, 0, z1)
                and map:IsDeployPointClear(Vector3(x1, 0, z1), nil, 1)
                and #TheSim:FindEntities(x1, 0, z1, 2.5, { "stalkerbloom" }) < 4
        end
    )

    if offset ~= nil then
        SpawnPrefab(weighted_random_choice(BLOOM_CHOICES)).Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function OnStartBlooming(inst)
    DoTrail(inst)
   -- inst._bloomtask = inst:DoPeriodicTask(3 * FRAMES, DoPlantBloom, 2 * FRAMES)
	inst._bloomtask = inst:DoPeriodicTask(9 * FRAMES, DoPlantBloom, 6 * FRAMES)
end

local function _StartBlooming(inst)
    if inst._bloomtask == nil then
        inst._bloomtask = inst:DoTaskInTime(0, OnStartBlooming)
    end
end

local function ForestOnEntityWake(inst)
    if inst._blooming then
        _StartBlooming(inst)
    end
end

local function ForestOnEntitySleep(inst)
    if inst._bloomtask ~= nil then
        inst._bloomtask:Cancel()
        inst._bloomtask = nil
    end
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end

local function StartBlooming(inst)
    if not inst._blooming then
        inst._blooming = true
        if not inst:IsAsleep() then
            _StartBlooming(inst)
        end
    end
end

local function StopBlooming(inst)
    if inst._blooming then
        inst._blooming = false
        ForestOnEntitySleep(inst)
    end
end

--------------------------------------------------------------------------

local function summon_lighting(inst, data)

if inst.small_light then
local spore = SpawnPrefab("musha_spore")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	spore.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)

end
	end	
	
	
local function consume_stamina(inst, data)

	if inst.components.rider:IsRiding() then
	inst.riding_arong = true
	else
	inst.riding_arong = false
	end
	
if inst.fatigue < 0 then
inst.fatigue = inst.fatigue * 0
end

if inst.lightaura then
if inst.stamina < 100 then
inst.stamina = inst.stamina + 0.1 end
if inst.fatigue > 0 then
inst.fatigue = inst.fatigue - 0.2 end
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*2)
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE)
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
end	
end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, {"moondrake2"})
for k,v in pairs(ents) do
if inst.moondrake_on then
v.inst_in = false
if v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) then 
inst.components.leader:AddFollower(v)
end 
elseif not inst.moondrake_on and not v.inst_in  and not v.slave and inst.components.leader:IsFollower(v) then 
v.inst_in = true
v.sg:GoToState("exit")
v.components.follower:SetLeader(nil)
end 
end
--sniff
if inst.treasure <100 and inst.sg:HasStateTag("moving") then  
 inst.treasure = inst.treasure + 0.1
end

if not inst.No_Sleep_Princess then
--sleep
if not inst.sleep_on and not inst.tiny_sleep and not inst:HasTag("playerghost") then
    if TheWorld.state.isday and inst.stamina >0 then
 --inst.stamina = inst.stamina - 0.01
elseif TheWorld.state.isdusk and inst.stamina >0 then
 inst.stamina = inst.stamina - 0.02
elseif TheWorld.state.isnight and inst.stamina >0 then
 inst.stamina = inst.stamina - 0.1
end end
if not (inst.tiny_sleep or inst.sleep_on) and inst.fatigue <=100 and inst.sg:HasStateTag("attack") then
	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.05	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.1
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 0.2
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 0.4
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 0.8
	end
end
if not (inst.tiny_sleep or inst.sleep_on) and inst.fatigue <=100 and inst.sg:HasStateTag("moving") and not inst:HasTag("playerghost") then
	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.01	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.025
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 0.05
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 0.1
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 0.2
	end
end
if not (inst.tiny_sleep or inst.sleep_on) and inst.fatigue <=100 and ( inst.sg:HasStateTag("chopping") or inst.sg:HasStateTag("mining") or  inst.sg:HasStateTag("hammering") or inst.sg:HasStateTag("digging") or inst.sg:HasStateTag("netting") or inst.sg:HasStateTag("fishing") or inst.sg:HasStateTag("read")) and not inst:HasTag("playerghost") then
	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.05	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.1
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 0.2
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 0.4
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 0.8
	end
	if inst.sneak_pang then		
		inst.components.talker:Say("Unhide!")	
		inst.components.colourtweener:StartTween({1,1,1,1}, 0)
local fx = SpawnPrefab("statue_transition_2")
      fx.entity:SetParent(inst.entity)
	  fx.Transform:SetScale(1.2, 1.2, 1.2)
      fx.Transform:SetPosition(0, 0, 0)
		inst.components.sanity:DoDelta(50)
	inst.sneak_pang = false	
	inst.sneaka = false
	inst:RemoveTag("notarget")
		end
end 

if not (inst.tiny_sleep or inst.sleep_on) and inst.fatigue >1 and not inst.sg:HasStateTag("walking") and not inst.sg:HasStateTag("running") and not inst.sg:HasStateTag("moving") and not inst.sg:HasStateTag("attack") and not inst.sg:HasStateTag("chopping") and not inst.sg:HasStateTag("mining") and not  inst.sg:HasStateTag("hammering") and not inst.sg:HasStateTag("digging") and not inst.sg:HasStateTag("netting") and not inst.sg:HasStateTag("fishing") and not inst:HasTag("playerghost") then
	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue - 0.2	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue - 0.1
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue - 0.05
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue - 0.025
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue - 0.01
	end
end
if not inst.tiny_sleep and not inst.sleep_on then
	if inst.fatigue <25 then
		inst.warnning_tired = false 
	elseif inst.fatigue >=100 then
		if not inst.warnning_tired then
			if math.random() < 0.2 then
			inst.components.talker:Say("So dizzy..")
			elseif math.random() < 0.2 then
			inst.components.talker:Say("really tired..")
			elseif math.random() < 0.2 then
			inst.components.talker:Say("Musha have to rest..")
			elseif math.random() < 0.2 then
			inst.components.talker:Say("my legs too heavy..")
			elseif math.random() < 1 then
			inst.components.talker:Say("So tired..!")
			end 
			inst.warnning_tired = true 
			inst:DoTaskInTime(60, function() inst.warnning_tired = false end) 
			end
	end
end	
if inst.stamina > 0 then
if inst.fatigue >=10 and inst.fatigue <20 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.01
elseif inst.fatigue >=20 and inst.fatigue <30 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.02
elseif inst.fatigue >=30 and inst.fatigue <40 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.03
elseif inst.fatigue >=40 and inst.fatigue <50 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.04
elseif inst.fatigue >=50 and inst.fatigue <60 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.05
elseif inst.fatigue >=60 and inst.fatigue <70 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.06
elseif inst.fatigue >=70 and inst.fatigue <80 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.07
elseif inst.fatigue >=80 and inst.fatigue <90 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.08
elseif inst.fatigue >=90 and inst.fatigue <100 and not inst.sleep_on and not inst.tiny_sleep then
inst.stamina = inst.stamina - 0.09
elseif inst.fatigue >=100 and not inst.sleep_on and not inst.tiny_sleep then
	if inst.dtired_veasy then
	inst.stamina = inst.stamina - 0.2
	elseif inst.dtired_easy then
	inst.stamina = inst.stamina - 0.3
	elseif inst.dtired_normal then
	inst.stamina = inst.stamina - 0.5
	elseif inst.dtired_hard then
	inst.stamina = inst.stamina - 1
	elseif inst.dtired_hardcore then
	inst.stamina = inst.stamina - 2
	end
end 
end

if inst.tiny_sleep and inst.stamina < 100 then
if inst.dsleep_veasy then
inst.stamina = inst.stamina + 2
  elseif inst.dsleep_easy then
inst.stamina = inst.stamina + 1  
  elseif inst.dsleep_normal then
inst.stamina = inst.stamina + 0.5  
  elseif inst.dsleep_hard then
inst.stamina = inst.stamina + 0.25
  elseif inst.dsleep_hardcore then
inst.stamina = inst.stamina + 0.12
end
end
if inst.tiny_sleep and inst.fatigue > 0 then
inst.fatigue = inst.fatigue - 1.5
end 
end 
end

local function check_music(inst)

	inst.time_perfomance = inst:DoPeriodicTask(0.1,function(inst)
	local chrged_time = 2
	local chrging_timer = 0
	if inst.charging_music and inst.music < 100 then
		chrging_timer = chrging_timer + 1
		if chrging_timer > chrged_time and inst.music < 100 then
		inst.music = inst.music + 1
			fullcharged_music(inst)
		end
		if inst.time_perfomance and (chrging_timer > chrged_time)  then
			inst.time_perfomance:Cancel()
			inst.time_perfomance = nil
		end	end end)
	end 

local function TreasureSmelling(inst, data)
if inst.components.playercontroller then
inst.components.playercontroller:Enable(false)
inst.components.locomotor:Stop()
inst.sg:GoToState("talk")
inst.components.health:SetInvincible(true)
inst.components.talker:Say("What is smell??\n[(X)]")
inst:DoTaskInTime( 1, function() inst.components.playercontroller:Enable(true) inst.smelling = true 
inst:DoTaskInTime( 2, function() inst.components.health:SetInvincible(false) end) end)
end
end

local function sleep_test(inst, data)

	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 6, {"shadowminion"})
	for k,v in pairs(ents) do
	if inst.components.leader:IsFollower(v) and not v.shadowmusha then
		v.AnimState:SetBuild("musha_h")
		v.shadowmusha = true
		v:AddComponent("colourtweener")
		v.components.colourtweener:StartTween({1,1,1,.7}, 0)
		v.Transform:SetScale(0.9, 0.9, 0.9)
	end
	end
 ---------------- warm_on_test ----------------
local fire = FindEntity(inst, 6, function(ent)
return ent.components.burnable and ent.components.burnable:IsBurning()
        end, {"campfire"})
local yamche = FindEntity(inst, 6, function(ent)
return ent.components.burnable and ent.components.burnable:IsBurning()
        end, {"yamche"})		
		
if fire or yamche then
inst.warm_on = true
	end
if not fire and not yamche then
inst.warm_on = false
	end
---------------- ---------------- -------------
 if inst.sleep_on or inst.tiny_sleep and not inst:HasTag("playerghost") then
 	if inst.fberserk or inst.berserks then
 	inst.berserks = false
	inst.fberserk = false
SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
   if not inst:HasTag("playerghost") then
	--[[if inst.components.hunger.current >= 160 then
		inst.strength = "full"  
		inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_full_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_full_sw2")
		end
		end
	elseif inst.components.hunger.current < 160 then
		inst.strength = "normal"   
		inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha_normal")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_normal_sw2")			
		end
		end
	end	]]
	end
	end
	
	if inst.switch or inst.active_valkyrie or inst.berserks or inst.fberserk or inst.sneaka or inst.sneak_pang then
	 
	inst:RemoveTag("notarget")
	inst.sneaka = false
	inst.sneak_pang = false	
	inst.AnimState:SetBloomEffectHandle( "" )
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.switch = false
	inst.active_valkyrie = false
	inst.berserks = false
	inst.fberserk = false
	end
end
 
--[[if inst.No_Sleep_Princess then 
inst.stamina = inst.stamina * 0 + 100
inst.fatigue = inst.fatigue * 0
end	]] 
--[[if (inst.sleep_on or inst.tiny_sleep) and inst.components.hunger.current == 0 then
inst.sleep_on = false
inst.sleepcheck = false
inst.sg.statemem.iswaking = true
inst.sg:GoToState("wakeup")
end]]
if ( inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("tent")) then 
inst.sleep_on = true
inst.sleepcheck = true
end
if inst.sg:HasStateTag("moving") then
inst.sleep_on = false
inst.tiny_sleep = false
end
if inst.sleep_on then 
inst.sleepcheck = true
inst.switch = false
inst.active_valkyrie = false
inst.components.combat:SetRange(2)
inst.switch = false
inst.vl1 = false inst.vl2 = false inst.vl3 = false inst.vl4 = false 
inst.vl5 = false inst.vl6 = false inst.vl7 = false inst.vl8 = false 

if inst.AnimState:AnimDone() then
inst.sg:AddStateTag("sleeping")
inst.sg:AddStateTag("busy")
if inst.warm_on or inst.warm_tent then
inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
elseif not inst.warm_on then
	if inst.sg:HasStateTag("bedroll") then
	inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
	else
	inst.AnimState:PlayAnimation("sleep_loop", true)
	end
end
--inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
inst.components.inventory:Show()
--inst:ShowHUD(true)
--inst:IsAsleep()
end
end
if not inst.sleep_on and inst.sleepcheck then
inst.sleepcheck = false
end 
--[[
if inst.components.sleeper:WakeUp() then
inst.sleep_on = false
inst.sleepcheck = false
inst.tiny_sleep = false
end]]
 local danger = FindEntity(inst, 10, function(target) 
                return (target:HasTag("monster") and not target:HasTag("player") and not inst:HasTag("spiderwhisperer"))
                    or (target:HasTag("monster") and not target:HasTag("player") and inst:HasTag("spiderwhisperer") and not target:HasTag("spider"))
                    or (target:HasTag("pig") and not target:HasTag("player") and inst:HasTag("spiderwhisperer"))
                    or (target.components.combat and target.components.combat.target == inst) end)

            local hounded = TheWorld.components.hounded
			if hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking()) then
	
				danger = true
			end
			if danger then
			inst.sleep_no = true
			elseif not danger then
			inst.sleep_no = false
			end
			
     
--perfomance
--old 
--[[
if inst.sleep_on and inst.stamina <= 75 and not inst.charging_music then
inst.charging_music = true
end
if inst.charging_music and inst.stamina >=100 then
inst.switlight = true inst.music_check = true inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) 
inst.charging_music = false
end ]]
---------new
if inst.sleep_on then
inst.charging_music = true
elseif not inst.sleep_on then
inst.charging_music = false
end 
if inst.charging_music and inst.music >= 100 then --and inst.sleep_on then	
inst.music_check = true --inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) 
elseif inst.music < 100 then
inst.music_check = false 
end 

--smell
if inst.treasure >= 100 then 
inst.treasure_sniffs = true
if not inst.smelling and not inst.smelltalking then
inst.smelltalking = true
TreasureSmelling(inst)
end
elseif inst.treasure < 100 then
inst.treasure_sniffs = false
inst.smelling = false
inst.smelltalking = false
end 
--[[if inst.treasure_sniffs and inst.treasure_sniff then 
inst.treasure = inst.treasure *0
inst.treasure_sniffs = false
inst.treasure_sniff = false
on_treasure_hunt(inst)
end]]

end

	
 local function onsleepheal(inst)
		if inst.tiny_sleep then
 		inst.components.sanity:DoDelta(1)
		end
		if inst.sleep_on then
		     inst.components.sanity:DoDelta(2)
			 inst.components.health:DoDelta(1)
			 
			 
		if inst.components.temperature ~= nil then

        if inst.sleep_temp_min ~= nil and inst.components.temperature:GetCurrent() < inst.sleep_temp_min then
            inst.components.temperature:SetTemperature(inst.components.temperature:GetCurrent() + 1)
        elseif inst.sleep_temp_max ~= nil and inst.components.temperature:GetCurrent() > inst.sleep_temp_max then
            inst.components.temperature:SetTemperature(inst.components.temperature:GetCurrent() - 1)
        end
		end	 
			 
			end 


if TheWorld.state.isnight and (inst.sleep_on or inst.tiny_sleep) and inst.LightWatcher:IsInLight() and inst.components.hunger.current <=0 then
local random1 = 0.2
local last = 1
inst.sleep_on = false
inst.tiny_sleep = false
inst.sg:GoToState("wakeup")
inst.musha_press = false
inst.components.talker:Say("So hungry..")

elseif TheWorld.state.isnight and (inst.sleep_on or inst.tiny_sleep) and not inst.LightWatcher:IsInLight() and inst.components.hunger.current >0 then
--[[elseif TheWorld.state.isnight and (inst.sleep_on or inst.tiny_sleep) and not inst.warm_on and not inst.warm_tent and not inst.sleep_no and not inst.sg:HasStateTag("tent") and not inst.LightWatcher:IsInLight() and inst.components.hunger.current >0 then]]
local random1 = 0.2
local last = 1
inst.sleep_on = false
inst.tiny_sleep = false
inst.sg:GoToState("wakeup")
inst.musha_press = false
if math.random() < random1 then
inst.components.talker:Say("Too dark..")
elseif math.random() < random1 then
inst.components.talker:Say("More light !")
elseif math.random() < random1 then
inst.components.talker:Say("Darkness too danger..")
elseif math.random() < random1 then
inst.components.talker:Say("Musha must find fire !")
elseif math.random() < last then
inst.components.talker:Say("Musha need fire !")
end 
if TheWorld.state.isnight and (inst.sleep_on or inst.tiny_sleep) and inst.sleep_no and not inst.sg:HasStateTag("tent") and inst.components.hunger.current >0 then
local random1 = 0.2
local last = 1
inst.sleep_on = false
inst.tiny_sleep = false
inst.sg:GoToState("wakeup")
inst.musha_press = false
if math.random() < random1 then
inst.components.talker:Say("Smells something danger.")
elseif math.random() < random1 then
inst.components.talker:Say("Musha feels Something wrong..")
elseif math.random() < random1 then
inst.components.talker:Say("This place is not my tomb.")
elseif math.random() < random1 then
inst.components.talker:Say("Musha heared something..")
elseif math.random() <= last then
inst.components.talker:Say("No! wake up!")
end 
end 
end 
end

local function on_fatigue(inst, data)
--[[if not (inst.sleep_on or inst.tiny_sleep) then
inst.components.talker.colour = Vector3(1, 1, 1, 1)
inst.components.talker.fontsize = 28
end]]
if not inst.No_Sleep_Princess then
if inst.sleep_no then
inst:DoTaskInTime(10, function() inst.sleep_no = false end) 
end
if inst.sleep_on and inst.stamina < 100 then

if inst.dsleep_veasy then
inst.stamina = inst.stamina + 3
  elseif inst.dsleep_easy then
inst.stamina = inst.stamina + 2  
  elseif inst.dsleep_normal then
inst.stamina = inst.stamina + 1  
  elseif inst.dsleep_hard then
inst.stamina = inst.stamina + 0.5
  elseif inst.dsleep_hardcore then
inst.stamina = inst.stamina + 0.25
end

end
if inst.sleep_on and inst.fatigue > 0 then
inst.fatigue = inst.fatigue - 2.5
end

if (inst.strength == "valkyrie" or inst.active_valkyrie) and not inst.sleep_on and not inst.tiny_sleep then --and inst.fatigue <= 100
 	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.1	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.2
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 0.3
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 0.6
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 1.2
	end
end	
if (inst.strength == "berserk" or inst.berserk) and not inst.sleep_on and not inst.tiny_sleep then --and inst.fatigue <= 100
 	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.1	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.2
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 0.3
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 0.6
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 1.2
	end
end
if inst.sneak_pang then 
 	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.1	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.2
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 0.3
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 0.6
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 1.2
	end
end
if inst.on_sparkshield and inst.stamina <= 100 then
	if inst.dtired_veasy then
	inst.fatigue = inst.fatigue + 0.2	
	elseif inst.dtired_easy then
	inst.fatigue = inst.fatigue + 0.5
	elseif inst.dtired_normal then
	inst.fatigue = inst.fatigue + 1
	elseif inst.dtired_hard then
	inst.fatigue = inst.fatigue + 2
	elseif inst.dtired_hardcore then
	inst.fatigue = inst.fatigue + 3
	end
end
if not (inst.sleep_on or inst.tiny_sleep) then
--inst.components.sleeper:WakeUp()
end

--dizzy 
local dizzy = 0.1
if inst.stamina <= 0 and not inst.dizzy and math.random() < dizzy and not inst:HasTag("playerghost") and not inst.components.health:IsDead() and not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and not inst.sleep_on and not inst.tiny_sleep then 
	inst.dizzy = true
if math.random() < dizzy then
inst.components.talker:Say("feel so dizzy..")
elseif math.random() < dizzy then
inst.components.talker:Say("Musha so tired..")
elseif math.random() < dizzy then
inst.components.talker:Say("Musha fell asleep forever..")
elseif math.random() < dizzy then
inst.components.talker:Say("Musha, almost died..")
end
	inst:DoTaskInTime( 0, function() 
inst:DoTaskInTime(1, function() 
		if not (inst.tiny_sleep or inst.sleep_on) then
			inst.sg:GoToState("knockout") 
		end
	inst.tiny_sleep = true end)
inst.sg:AddStateTag("busy")
	inst:DoTaskInTime( 60, function() inst.dizzy = false end) end)
 end 
if inst.stamina > 0 and inst.stamina <= 25 and not inst.dizzy2 and math.random() < dizzy and not inst:HasTag("playerghost") and not inst.components.health:IsDead() and not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) then 
	inst.dizzy2 = true
if math.random() < dizzy then
inst.components.talker:Say("Little dizzy..")
elseif math.random() < dizzy then
inst.components.talker:Say("Musha little bit tired..")
elseif math.random() < dizzy then
inst.components.talker:Say("Sleepy..")
elseif math.random() < dizzy then
inst.components.talker:Say("hoo...")
end
	inst:DoTaskInTime( 0, function() 
inst:DoTaskInTime(1, function() 
if math.random() < 0.5 and not (inst.tiny_sleep or inst.sleep_on) then
inst.sg:GoToState("yawn")
else
inst.sg:GoToState("powerdown") 
end
inst.tiny_sleep = true end)
inst.sg:AddStateTag("busy")
	inst:DoTaskInTime( 150, function() inst.dizzy2 = false end) end)
 end 
 end
end


-- passive skills
-- critical hit
local function on_Critical_1(inst, data)
local hitcriticalchance1 = 0.1
local other = data.target
    if math.random() < hitcriticalchance1 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	 inst.SoundEmitter:PlaySound("dontstarve/tentacle/tentacle_emerge")
	other.components.health:DoDelta(-8)
			inst:RemoveEventCallback("onhitother", on_Critical_1) end end
local function on_Critical_2(inst, data)
local hitcriticalchance2 = 0.12
local other = data.target
    if math.random() < hitcriticalchance2 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	other.components.health:DoDelta(-12)
			inst:RemoveEventCallback("onhitother", on_Critical_2) end end 
local function on_Critical_3(inst, data)
local hitcriticalchance3 = 0.14
local other = data.target
    if math.random() < hitcriticalchance3 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	other.components.health:DoDelta(-16)
			inst:RemoveEventCallback("onhitother", on_Critical_3) end end 
local function on_Critical_4(inst, data)	
local hitcriticalchance4 = 0.14		
local other = data.target
    if math.random() < hitcriticalchance4 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	other.components.health:DoDelta(-20)
			inst:RemoveEventCallback("onhitother", on_Critical_4) end end 
local function on_Critical_5(inst, data)	
local hitcriticalchance5 = 0.16		
local other = data.target
    if math.random() < hitcriticalchance5 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	other.components.health:DoDelta(-24)
			inst:RemoveEventCallback("onhitother", on_Critical_5) end end 
local function on_Critical_6(inst, data)	
local hitcriticalchance6 = 0.18		
local other = data.target
    if math.random() < hitcriticalchance6 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	other.components.health:DoDelta(-28)
			inst:RemoveEventCallback("onhitother", on_Critical_6) end end
local function on_Critical_7(inst, data)		
local hitcriticalchance7 = 0.2	
local other = data.target
    if math.random() < hitcriticalchance7 and inst.components.hunger.current > 30 and not (other:HasTag("smashable")) then
    SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
	other.components.health:DoDelta(-32)
			inst:RemoveEventCallback("onhitother", on_Critical_7) end end			
	local function Critical_level_1(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_1) end end
	local function Critical_level_2(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_2) end end
	local function Critical_level_3(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_3) end end
	local function Critical_level_4(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_4) end end
	local function Critical_level_5(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_5) end end
	local function Critical_level_6(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_6) end end
	local function Critical_level_7(inst)
	if (inst.valkyrie or inst.berserk) then
   	inst:ListenForEvent("onhitother", on_Critical_7) end end
	
	
	--Electric Shield (sanity shield)
local function on_Lshield_1(inst, attacked)
   local Lshield1 = 0.2
   if math.random() < Lshield1 and inst.components.sanity.current >= 1 and inst.components.health:GetPercent() < .95 and not inst.components.health:IsDead() then
	SpawnPrefab("shock_fx").Transform:SetPosition(inst:GetPosition():Get())
	inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        inst.components.health:DoDelta(5)
        inst.components.sanity:DoDelta(-1)
		inst:RemoveEventCallback("attacked", on_Lshield_1)
	end end
local function on_Lshield_2(inst, attacked)
   local Lshield2 = 0.24
   if math.random() < Lshield2 and inst.components.sanity.current >= 1 and inst.components.health:GetPercent() < .96 and not inst.components.health:IsDead() then
	SpawnPrefab("shock_fx").Transform:SetPosition(inst:GetPosition():Get())
	inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        inst.components.health:DoDelta(7)
        inst.components.sanity:DoDelta(-1)
		inst:RemoveEventCallback("attacked", on_Lshield_2)
	end end
local function on_Lshield_3(inst, attacked)
   local Lshield3 = 0.28
   if math.random() < Lshield3 and inst.components.sanity.current >= 1 and inst.components.health:GetPercent() < .97 and not inst.components.health:IsDead() then
	SpawnPrefab("shock_fx").Transform:SetPosition(inst:GetPosition():Get())
	inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        inst.components.health:DoDelta(9)
        inst.components.sanity:DoDelta(-1)
		inst:RemoveEventCallback("attacked", on_Lshield_3)
	end end
local function on_Lshield_4(inst, attacked)
   local Lshield4 = 0.32
   if math.random() < Lshield4 and inst.components.sanity.current >= 1 and inst.components.health:GetPercent() < .98 and not inst.components.health:IsDead() then
	SpawnPrefab("shock_fx").Transform:SetPosition(inst:GetPosition():Get())
	inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        inst.components.health:DoDelta(12)
        inst.components.sanity:DoDelta(-1)
		inst:RemoveEventCallback("attacked", on_Lshield_4)
	end end	
local function on_Lshield_5(inst, attacked)
   local Lshield5 = 0.36
   if math.random() < Lshield5 and inst.components.sanity.current >= 1 and inst.components.health:GetPercent() < .98 and not inst.components.health:IsDead() then
	SpawnPrefab("shock_fx").Transform:SetPosition(inst:GetPosition():Get())
	inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
        inst.components.health:DoDelta(15)
        inst.components.sanity:DoDelta(-1)
		inst:RemoveEventCallback("attacked", on_Lshield_5)
	end end		
	
    local function Lshield_level_1(inst)
    inst:ListenForEvent("attacked", on_Lshield_1)
	end
    local function Lshield_level_2(inst)
    inst:ListenForEvent("attacked", on_Lshield_2)
	end
    local function Lshield_level_3(inst)
    inst:ListenForEvent("attacked", on_Lshield_3)
	end
    local function Lshield_level_4(inst)
    inst:ListenForEvent("attacked", on_Lshield_4)
	end
	local function Lshield_level_5(inst)
    inst:ListenForEvent("attacked", on_Lshield_5)
	end	
	
	
	
local function on_shard_shield(inst, attacked)
   if inst.f_attack and inst.components.health and not inst.components.health:IsDead() then
   --[[local prefab = "icespike_fx_"..math.random(1,4)
   local fx = SpawnPrefab(prefab)
   local shards = math.random(1.5,2)
 	fx.Transform:SetScale(shards, shards, shards)
	fx.Transform:SetPosition(inst:GetPosition():Get())]]
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	
	inst:ListenForEvent("attacked", on_shard_freeze)
	
	end	
end 	
	
	--auto shadow lightning strike 
local function on_hitLightnings_1(inst, data)
inst.vl1 = false
	local other = data.target
if other and not (other:HasTag("smashable")) then
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-5)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
			end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_1)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-5)
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_1)
	end end end
local function on_hitLightnings_2(inst, data)
inst.vl2 = false
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-10)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_2)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-10)
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_2)
	end end end
local function on_hitLightnings_3(inst, data)
inst.vl3 = false
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-15)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_3)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-15)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_3)
	end end end
local function on_hitLightnings_4(inst, data)
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.vl4 = false
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-20)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_4)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-20)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_4)
	end	end end
local function on_hitLightnings_5(inst, data)
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.vl5 = false
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-25)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_5)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-25)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_5)
	end end end
local function on_hitLightnings_6(inst, data)
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.vl6 = false
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-30)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_6)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-30)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_6)
	end end
	end
local function on_hitLightnings_7(inst, data)
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.vl7 = false
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-35)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_7)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-35)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_7)
	end end
	end
local function on_hitLightnings_8(inst, data)
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.vl8 = false
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-40)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_8)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-40)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_8)
	end end
	end
	
local function on_hitLightnings_9(inst, data)
	local other = data.target
if not (other:HasTag("smashable")) then
	inst.vl8 = false
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if other and other.components.health and not other:HasTag("wall") and not other:HasTag("structure")  then
			SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
        	SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-45)
			local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
	elseif other:HasTag("wall") or other:HasTag("structure") then
            SpawnPrefab("lightning_blue").Transform:SetPosition(other:GetPosition():Get())
			inst:DoTaskInTime( 0.5, function() if inst.loud_3 then
			SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end	end)
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	        SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-45)
 inst.components.combat:SetRange(2)
--inst.AnimState:SetBloomEffectHandle( "" )
--inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
	end end
	end
	
  local function Lightnings_level_1(inst)
  local randomL = 0.05
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl1 = true
	--inst:DoTaskInTime(2, function() if inst.vl1 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_1)
	inst.components.combat:SetRange(9,11)  
	inst:DoTaskInTime( 12, function() inst.on_hitLightnings = false end) end)
 end end
  local function Lightnings_level_2(inst)
  local randomL = 0.05
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl2 = true
	--inst:DoTaskInTime(2, function() if inst.vl2 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_2)
	inst.components.combat:SetRange(9,11)  
	inst:DoTaskInTime( 11, function() inst.on_hitLightnings = false end) end)
 end end
  local function Lightnings_level_3(inst)
  local randomL = 0.1
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl3 = true
	--inst:DoTaskInTime(2, function() if inst.vl3 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_3)
	inst.components.combat:SetRange(9,11) 
	inst:DoTaskInTime( 10, function() inst.on_hitLightnings = false end) end)
 end end
  local function Lightnings_level_4(inst)
  local randomL = 0.15
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl4 = true
	--inst:DoTaskInTime(2, function() if inst.vl4 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_4)
	inst.components.combat:SetRange(9,11) 
	inst:DoTaskInTime( 9, function() inst.on_hitLightnings = false end) end)
 end end
 local function Lightnings_level_5(inst)
 local randomL = 0.1
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl5 = true
	--inst:DoTaskInTime(2, function() if inst.vl5 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_5)
	inst.components.combat:SetRange(9,11) 
	inst:DoTaskInTime( 8, function() inst.on_hitLightnings = false end) end)
 end end
 local function Lightnings_level_6(inst)
 local randomL = 0.2
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl6 = true
	--inst:DoTaskInTime(2, function() if inst.vl6 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())	
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_6)
	inst.components.combat:SetRange(9,11) 
	inst:DoTaskInTime( 7, function() inst.on_hitLightnings = false end) end)
 end end
 local function Lightnings_level_7(inst)
 local randomL = 0.25
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl7 = true
	--inst:DoTaskInTime(2, function() if inst.vl7 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_7)
	inst.components.combat:SetRange(9,11)  
	inst:DoTaskInTime( 6, function() inst.on_hitLightnings = false end) end)
 end end
 local function Lightnings_level_8(inst)
 local randomL = 0.3
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl8 = true
	--inst:DoTaskInTime(2, function() if inst.vl8 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_8)
	inst.components.combat:SetRange(9,11) 
	inst:DoTaskInTime( 6, function() inst.on_hitLightnings = false end) end)
 end end
 local function Lightnings_level_9(inst)
 local randomL = 0.3
if inst.active_valkyrie and inst.stamina > 0 and not inst.on_hitLightnings and math.random() < randomL and not inst.sneaka then
	inst.on_hitLightnings = true inst.vl8 = true
	--inst:DoTaskInTime(2, function() if inst.vl8 then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		
		end	
	--if not inst.sneak_pang then
--inst.components.colourtweener:StartTween({0.5,0.75,1,1}, 0) end
inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime( 0, function() 
	inst:ListenForEvent("onhitother", on_hitLightnings_9)
	inst.components.combat:SetRange(9,11) 
	inst:DoTaskInTime( 5, function() inst.on_hitLightnings = false end) end)
 end end
--adds on shield

local function Sparkshield_heal(inst, attacked, data) 
if not inst.components.health:IsDead() then
if inst.level < 430  then
inst.components.health:DoDelta(6)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
elseif inst.level >= 430 then
inst.components.health:DoDelta(7)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
elseif inst.level >= 1880 then
inst.components.health:DoDelta(8)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
elseif inst.level >= 7000 then
inst.components.health:DoDelta(9)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
end end
end
	local function on_sparkshield_1( attacked, data)
if data.attacker and data.attacker.components.burnable and data.attacker.components.health and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") then
            data.attacker.components.health:DoDelta(-8)
SpawnPrefab("sparks").Transform:SetPosition(data.attacker:GetPosition():Get())
end end
	local function on_sparkshield_2( attacked, data)
if data.attacker and data.attacker.components.burnable and data.attacker.components.health and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") then
            data.attacker.components.health:DoDelta(-12)
SpawnPrefab("sparks").Transform:SetPosition(data.attacker:GetPosition():Get())
end end
	local function on_sparkshield_3( attacked, data)
if data.attacker and data.attacker.components.burnable and data.attacker.components.health and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") then
            data.attacker.components.health:DoDelta(-16)
SpawnPrefab("sparks").Transform:SetPosition(data.attacker:GetPosition():Get())
end end
	local function on_sparkshield_4( attacked, data)
if data.attacker and data.attacker.components.burnable and data.attacker.components.health and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") then
            data.attacker.components.health:DoDelta(-20)
SpawnPrefab("sparks").Transform:SetPosition(data.attacker:GetPosition():Get())
end end
		
	local function active_sparkshield(inst)
	if inst.level < 430 and inst.on_sparkshield and not inst.shield_on then		
		inst:ListenForEvent("attacked", on_sparkshield_1)
		inst:ListenForEvent("attacked", Sparkshield_heal)
		inst.shield_on = true
	elseif inst.level >= 430 and inst.level < 1880 and inst.on_sparkshield and not inst.shield_on then		
		inst:ListenForEvent("attacked", on_sparkshield_2)
		inst:ListenForEvent("attacked", Sparkshield_heal)
		inst.shield_on = true
	elseif inst.level >= 1880 and inst.level < 7000 and inst.on_sparkshield and not inst.shield_on then		
		inst:ListenForEvent("attacked", on_sparkshield_3)
		inst:ListenForEvent("attacked", Sparkshield_heal)
		inst.shield_on = true
	elseif inst.level >= 7000 and inst.on_sparkshield then	
		inst:ListenForEvent("attacked", on_sparkshield_4)
		inst:ListenForEvent("attacked", Sparkshield_heal)
		inst.shield_on = true
	elseif not inst.on_sparkshield then	
		inst.shield_on = false
		inst:RemoveEventCallback("attacked", Sparkshield_heal)
		inst:RemoveEventCallback("attacked", on_sparkshield_1)
		inst:RemoveEventCallback("attacked", on_sparkshield_2)
		inst:RemoveEventCallback("attacked", on_sparkshield_3)
		inst:RemoveEventCallback("attacked", on_sparkshield_4)
			end
--[[
if inst.charging_music and inst.music < 100 then
check_music(inst)
end

--inst.tiny_sleep
if inst.charging_music and inst.music >= 100 then --and inst.sleep_on then	
inst.music_check = true --inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) 
elseif inst.music < 100 then
inst.music_check = false 
end ]]
end

		 
local function Call_lightining_attack(inst, data)
	 local other = data.target
if not (other:HasTag("smashable")) then
	 local hitcall = 0.06
	 
if other and math.random() < hitcall and other and other.components.health and not other.components.health:IsDead() and not other:HasTag("burn") and not other:HasTag("structure") and not other:HasTag("groundspike") and not other:HasTag("stalkerminion") and other.components.locomotor and inst.components.sanity.current >= 10 then
	other:AddTag("burn")
	SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	end
	end
end 

local function Call_lightining_check(inst, data)
if inst.level >= 10 then		
    local x, y, z = inst.Transform:GetWorldPosition() 
    local burn = TheSim:FindEntities(x, y, z, 40, { "burn" })
for i, v in ipairs(burn) do	
	if v.components.health and not v.components.health:IsDead() then
	if not v.bloom then
		if not v.shocked then
		v.shocked = true
		local debuff_0 = SpawnPrefab("debuff_short_0")
		debuff_0.Transform:SetPosition(v:GetPosition():Get())
		if debuff_0 then
		local follower = debuff_0.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
		v:DoTaskInTime(7, function() debuff_0:Remove() v.shocked = false end)
		end
	
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking and not v.bloom then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0 )
		end	
	v.bloom = true
	v:DoTaskInTime(2, function() if v.bloom then v.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
	v:DoTaskInTime(7, function() if v.bloom then v.AnimState:SetBloomEffectHandle( "" ) end end)
	v:DoTaskInTime(15, function() if v.bloom then v:RemoveTag("burn") v.bloom = false end end )
	end
	end
	end
end

end


local function Call_lightining_debuff(inst, data)
    local x, y, z = inst.Transform:GetWorldPosition() 
    local slow = TheSim:FindEntities(x, y, z, 40, { "slow" })
    for i, v in ipairs(slow) do	
	if v.bloom then
	v.AnimState:SetBloomEffectHandle( "" ) 
	v.bloom = false
	end
	if v.components.health and not v.components.health:IsDead() and v.components.locomotor and not v:HasTag("wet") then
	if v:HasTag("giant") or v:HasTag("epic") then
	v.components.locomotor.groundspeedmultiplier = 0.2
	else
	v.components.locomotor.groundspeedmultiplier = 0.05
	end
	end
end
    local x, y, z = inst.Transform:GetWorldPosition() 
    local slow_poison = TheSim:FindEntities(x, y, z, 40, { "slow_poison" })
    for i, v in ipairs(slow_poison) do	
	if v.components.health and not v.components.health:IsDead() and v.components.locomotor and not v:HasTag("wet") and not v:HasTag("slow") then
	if v:HasTag("giant") or v:HasTag("epic") then
	v.components.locomotor.groundspeedmultiplier = 0.45
	else
	v.components.locomotor.groundspeedmultiplier = 0.15
	end
	end
	end
    local x, y, z = inst.Transform:GetWorldPosition() 
    local slow_frozen = TheSim:FindEntities(x, y, z, 20, { "slow_frozen" })
for i, v in ipairs(slow_frozen) do	
	if v.components.health and not v.components.health:IsDead() and v.components.locomotor and not v:HasTag("wet") and not v:HasTag("slow") and not v:HasTag("slow_poison") then
	if v:HasTag("giant") or v:HasTag("epic") then
	v.components.locomotor.groundspeedmultiplier = 0.45
	else
	v.components.locomotor.groundspeedmultiplier = 0.15
	end
	end
end	
	
end

--[[
local function Call_lightining_on(inst, data)
   local x, y, z = inst.Transform:GetWorldPosition() 
    local ents = TheSim:FindEntities(x, y, z, 18, { "burn" })
    for i, v in ipairs(ents) do	
if inst.level < 430 and inst.active_valkyrie and v:HasTag("burn") and v.components.health and not v.components.health:IsDead() then
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	TheWorld:PushEvent("screenflash", .9)
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) end)
	SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
	v.components.health:DoDelta(-20)
	v:RemoveTag("burn") 
	v.burn = false
		if v and v.components.burnable then
	v.components.burnable:Ignite()
	end
		if v.components.burnable and v.components.burnable:IsBurning() then
    v.components.burnable:Extinguish()
	end
	end)
	elseif inst.level >= 430 and inst.level < 1880 and inst.active_valkyrie and v:HasTag("burn") and v.components.health and not v.components.health:IsDead() then
  	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	TheWorld:PushEvent("screenflash", .9)
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) end)
	SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
	v.components.health:DoDelta(-25)
	v:RemoveTag("burn") 
	v.burn = false
		if v and v.components.burnable then
	v.components.burnable:Ignite()
	end
		if v.components.burnable and v.components.burnable:IsBurning() then
    v.components.burnable:Extinguish()
	end
	end)
	elseif inst.level >= 1880 and inst.level < 7000 and inst.active_valkyrie and v:HasTag("burn") and v.components.health and not v.components.health:IsDead() then
  	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	TheWorld:PushEvent("screenflash", .9)
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) end)
	SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
	v.components.health:DoDelta(-30)
	v:RemoveTag("burn") 
	v.burn = false
		if v and v.components.burnable then
	v.components.burnable:Ignite()
	end
		if v.components.burnable and v.components.burnable:IsBurning() then
    v.components.burnable:Extinguish()
	end
	end)
	elseif inst.level >= 7000 and inst.active_valkyrie and v:HasTag("burn") and v.components.health and not v.components.health:IsDead() thenand inst.components.playercontroller then
		inst.components.playercontroller:Enable(false)
		inst.components.locomotor:Stop()
	inst.sg:GoToState("book2") inst:DoTaskInTime( 0.1, function() inst.components.playercontroller:Enable(true) end)
    inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	TheWorld:PushEvent("screenflash", .9)
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) end)
	SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
	v.components.health:DoDelta(-35)
	v:RemoveTag("burn") 
	v.burn = false
		if v and v.components.burnable then
	v.components.burnable:Ignite()
	end
		if v.components.burnable and v.components.burnable:IsBurning() then
    v.components.burnable:Extinguish()
	end
	end)
	end end
	end
]]
	-- valkyrie armor 

		------------------    
	local function On_frameshield_1(attacked, data) -- 
        if data.attacker and data.attacker.components.burnable and data.attacker.components.health and data.attacker.components.burnable and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and not data.attacker.burn then
            data.attacker.components.health:DoDelta(-10)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker and data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end 
		 data.attacker.burn = true
		end
	local function On_frameshield_2(attacked, data)  --
        if data.attacker and data.attacker.components.burnable and data.attacker.components.health and data.attacker.components.burnable and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and not data.attacker.burn then
            data.attacker.components.health:DoDelta(-20)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker and data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end 
		 data.attacker.burn = true
		end
	local function On_frameshield_3(attacked, data)  --
        if data.attacker and data.attacker.components.burnable and data.attacker.components.health and data.attacker.components.burnable and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and not data.attacker.burn then
            data.attacker.components.health:DoDelta(-30)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker and data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end
		 data.attacker.burn = true
		end
	local function On_frameshield_4(attacked, data)  --
        if data.attacker and data.attacker.components.burnable and data.attacker.components.health and data.attacker.components.burnable and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and not data.attacker.burn then
            data.attacker.components.health:DoDelta(-40)
            data.attacker.components.burnable:Ignite()
		end
    if data.attacker and data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
        end
		 data.attacker.burn = true
		end
		
	local function Off_frameshield(inst)
			inst:RemoveEventCallback("attacked", On_frameshield_1)
			inst:RemoveEventCallback("attacked", On_frameshield_2)
			inst:RemoveEventCallback("attacked", On_frameshield_3)
			inst:RemoveEventCallback("attacked", On_frameshield_4)
			end
		
--active flame shield and armor		
	   local function frameshield_1(inst)
	inst.valkyrie_armor_1 =true
	end	
	   local function frameshield_2(inst)
	inst.valkyrie_armor_1 =false
		inst.valkyrie_armor_2 =true
	end 
	   local function frameshield_3(inst)
	inst.valkyrie_armor_2 =false
			inst.valkyrie_armor_3 =true
	end	
	   local function frameshield_4(inst)
	inst.valkyrie_armor_3 =false
		inst.valkyrie_armor_4 =true
	end	

local function flameshield_active(inst)	
	if inst.valkyrie_turn and inst.valkyrie_armor_1 then
		inst:ListenForEvent("attacked", On_frameshield_1) end
	if inst.valkyrie_turn and inst.valkyrie_armor_2 then		
		inst:ListenForEvent("attacked", On_frameshield_2) end
	if inst.valkyrie_turn and inst.valkyrie_armor_3 then			
		inst:ListenForEvent("attacked", On_frameshield_3) end	
	if inst.valkyrie_turn and inst.valkyrie_armor_4 then	
		inst:ListenForEvent("attacked", On_frameshield_4) end
	
	end
	
	
	local Lightningo = .15
	
	
local function on_Valkyrie_all(inst, attacked, data)
	local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if inst.switch and weapon and weapon.components.weapon and inst.active_valkyrie and inst.switch then 
weapon.components.weapon.stimuli = "electric"
elseif not inst.switch and weapon and weapon.components.weapon and not weapon:HasTag("electric_weapon") and not inst.active_valkyrie then
weapon.components.weapon.stimuli = nil
elseif not inst.switch and weapon and weapon.components.weapon and not weapon:HasTag("electric_weapon") and not inst.switch then
weapon.components.weapon.stimuli = nil
end

		if inst.on_Valkyrie_1 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then	
inst.valkyrie_turn = true 

	
	elseif inst.on_Valkyrie_2 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

		inst:DoTaskInTime(7, function() Lightnings_level_1(inst) end)
				
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_3 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

	

		inst:DoTaskInTime(7, function() Lightnings_level_1(inst) end)
		frameshield_1(inst)
		
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_4 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

	

		inst:DoTaskInTime(6, function() Lightnings_level_2(inst) end)
		frameshield_1(inst)
	
inst.valkyrie_turn = true 


	elseif inst.on_Valkyrie_5 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

	

		inst:DoTaskInTime(6, function() Lightnings_level_2(inst) end)
		frameshield_2(inst)
		
inst.valkyrie_turn = true 
				 


	elseif inst.on_Valkyrie_6 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

	

		inst:DoTaskInTime(5, function() Lightnings_level_3(inst) end)
		frameshield_2(inst)
	
inst.valkyrie_turn = true 


	elseif inst.on_Valkyrie_7 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

	

				inst:DoTaskInTime(5, function() Lightnings_level_3(inst) end)
		frameshield_3(inst)
	
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_8 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

	

		inst:DoTaskInTime(5, function() Lightnings_level_4(inst) end)
		frameshield_3(inst)
	
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_9 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

		

		inst:DoTaskInTime(5, function() Lightnings_level_4(inst) end)
		frameshield_4(inst)
		
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_10 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

		

		inst:DoTaskInTime(5, function() Lightnings_level_5(inst) end)
		frameshield_4(inst)
		
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_11 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

		

		inst:DoTaskInTime(4, function() Lightnings_level_6(inst) end)
		frameshield_4(inst)
	
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_12 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

		

		inst:DoTaskInTime(4, function() Lightnings_level_7(inst) end)
		frameshield_4(inst)
	
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_13 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then
 
		

		inst:DoTaskInTime(4, function() Lightnings_level_8(inst) end)
		frameshield_4(inst)
	
inst.valkyrie_turn = true 

	elseif inst.on_Valkyrie_14 and inst.active_valkyrie and inst.stamina > 0 and not inst.components.health:IsDead() then

		

		inst:DoTaskInTime(3, function() Lightnings_level_9(inst) end)
		frameshield_4(inst)

inst.valkyrie_turn = true 

	end 
if not inst.active_valkyrie then	
--[[inst:RemoveEventCallback("onhitother", on_hitLightnings_1)
inst:RemoveEventCallback("onhitother", on_hitLightnings_2)
inst:RemoveEventCallback("onhitother", on_hitLightnings_3)
inst:RemoveEventCallback("onhitother", on_hitLightnings_4)
inst:RemoveEventCallback("onhitother", on_hitLightnings_5)
inst:RemoveEventCallback("onhitother", on_hitLightnings_6)
inst:RemoveEventCallback("onhitother", on_hitLightnings_7)
inst:RemoveEventCallback("onhitother", on_hitLightnings_8)
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)]]
inst.switch = false
inst.vl1 = false inst.vl2 = false inst.vl3 = false inst.vl4 = false 
inst.vl5 = false inst.vl6 = false inst.vl7 = false inst.vl8 = false 
end	

	if inst.stamina <= 0 then
		if inst.active_valkyrie then
		inst.active_valkyrie = false
		inst.components.combat:SetRange(2)
		end
	inst.valkyrie_turn = false
	end 
	
end 
				 
		local function Valkyrie_level_1(inst)
	inst.on_Valkyrie_1 = true
		end 
		local function Valkyrie_level_2(inst)
	inst.on_Valkyrie_2 = true inst.on_Valkyrie_1 = false
		end 	
		local function Valkyrie_level_3(inst)
	inst.on_Valkyrie_3 = true inst.on_Valkyrie_2 = false
		end 	
		   local function Valkyrie_level_4(inst)
	inst.on_Valkyrie_4 = true inst.on_Valkyrie_3 = false
		end 	
		   local function Valkyrie_level_5(inst)
	inst.on_Valkyrie_5 = true inst.on_Valkyrie_4 = false
		end 	
		   local function Valkyrie_level_6(inst)
	inst.on_Valkyrie_6 = true inst.on_Valkyrie_5 = false
		end 	
		   local function Valkyrie_level_7(inst)
	inst.on_Valkyrie_7 = true inst.on_Valkyrie_6 = false
		end 	
		   local function Valkyrie_level_8(inst)
	inst.on_Valkyrie_8 = true  inst.on_Valkyrie_7 = false
		end 	
		   local function Valkyrie_level_9(inst)
	inst.on_Valkyrie_9 = true  inst.on_Valkyrie_8 = false
		end 	
		   local function Valkyrie_level_10(inst)
	inst.on_Valkyrie_10 = true  inst.on_Valkyrie_9 = false
		end 	
		   local function Valkyrie_level_11(inst)
	inst.on_Valkyrie_11 = true  inst.on_Valkyrie_10 = false
		end 	
		   local function Valkyrie_level_12(inst)
	inst.on_Valkyrie_12 = true  inst.on_Valkyrie_11 = false
		end 	
		   local function Valkyrie_level_13(inst)
	inst.on_Valkyrie_13 = true  inst.on_Valkyrie_12 = false
		end 	
		   local function Valkyrie_level_14(inst)
	inst.on_Valkyrie_14 = true  inst.on_Valkyrie_13 = false
		end 	
	
	
--berserk
local function OnHitfreeze(inst, data)
local hitfreeze = .1
	 local other = data.target
if not (other:HasTag("smashable")) then
	 if inst.components.hunger.current < 30 then
     if other and math.random() < hitfreeze and other.components.freezable then
        other.components.freezable:AddColdness(0.1)
       -- other.components.freezable:SpawnShatterFX()
    end
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
end
end end
end
	
local function berserk_hit(inst, data)
inst.components.combat:SetRange(2)
if inst.berserk then
    local other = data.target
if not (other:HasTag("smashable")) then
	local fx = SpawnPrefab("groundpoundring_fx")
	local fx2 = SpawnPrefab("small_puff")
--	SpawnPrefab("small_puff").Transform:SetPosition(other:GetPosition():Get())
     if other then
      --fx.entity:SetParent(other.entity)
	  fx.Transform:SetScale(0.45, 0.45, 0.45)
	  fx2.Transform:SetScale(0.6, 0.6, 0.6)
      --fx.Transform:SetPosition(0, 0, 0)
	  fx.Transform:SetPosition(other:GetPosition():Get())
	  fx2.Transform:SetPosition(other:GetPosition():Get())
--SpawnPrefab("groundpoundring_fx").Transform:SetPosition(other:GetPosition():Get())

	----inst:RemoveEventCallback("onhitother", berserk_hit)
	end end end
end
	
local function moon_berserk(inst)
	if not TheWorld.state.isfullmoon and not inst:HasTag("playerghost") then
			if inst.fberserk or inst.berserks then
 	inst.berserks = false
	inst.fberserk = false
SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
   	if not inst:HasTag("playerghost") then
	if inst.components.hunger.current >= 160 then
		inst.strength = "full" 
			
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_full_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_full_sw2")
		end
		end
	elseif inst.components.hunger.current < 160 then
		inst.strength = "normal"   
		
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha_normal")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_normal_sw2")			
		end
		end
	end	
	end	
	end
		
		if inst.changed_moon then
		inst.changed_moon = false
		inst.components.locomotor:Stop()
		inst.components.health:SetInvincible(true)
		inst.components.talker:Say("...feel dizzy... ")	
		SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
			inst:DoTaskInTime(0.5, function() 
			if not (inst.tiny_sleep or inst.sleep_on) then
			inst.sg:GoToState("knockout") 
			end
			inst.tiny_sleep = true 
			inst:DoTaskInTime(3, function() 
			inst.components.health:SetInvincible(false)
			end) end)
		end
		
	elseif  TheWorld.state.isfullmoon and not inst.valkyrie and not inst.sleep_on and not inst.tiny_sleep then
		if not inst.berserk then
		inst.berserks = true
		inst.strength = "berserk"
		SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
	if not inst:HasTag("playerghost") then	
		
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha_hunger")
	inst.soundsname = "wendy"
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_hunger")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_hunger_sw2")	
			end
		end
		end
	end
		if not inst.changed_moon then
		inst.changed_moon = true 
		end
	end
end
	
local function berserk_countdown(inst)
inst:DoTaskInTime(300, function() 
if inst.fberserk then
inst.fberserk = false
if inst.changed then
		inst.components.locomotor:Stop()
		inst.components.health:SetInvincible(true)
		inst.components.talker:Say("...feel dizzy... ")	
		SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
    	if inst.components.hunger.current >= 160 then
		inst.strength = "full"  
	elseif inst.components.hunger.current < 160 then
		inst.strength = "normal"   
		end
		inst:DoTaskInTime(0.5, function() 
			if not (inst.tiny_sleep or inst.sleep_on) then
			inst.sg:GoToState("knockout") 
			end
		inst.tiny_sleep = true 
		inst:DoTaskInTime(3, function() 
		inst.components.health:SetInvincible(false)
		end) end)
		inst.changed = false
		end end end)
end		

local function berserk_changer(inst)
if TheWorld.state.isnight and TheWorld.state.isfullmoon and not inst.tiny_sleep and not inst.sleep_on then
	if not inst.berserk then
		--inst.moon_berserks = true
		inst.changed_moon = true
		inst.fullmoon = true
		inst.berserks = true
		inst.strength = "berserk"
	if not inst:HasTag("playerghost") then	
		inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		--inst.musha_hunger = false
		if inst.visual_cos and not inst.musha_hunger then
	inst.AnimState:SetBuild("musha_hunger")
	inst.musha_hunger = true
	inst.soundsname = "wendy"
	elseif not inst.visual_cos and not inst.change_visual and not inst.musha_hunger then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_hunger")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_hunger_sw2")	
		end
		inst.musha_hunger = true
		end
	end	
	end
	elseif not TheWorld.state.isnight or not TheWorld.state.isfullmoon then		
		if inst.berserk then
		--inst.moon_berserks = false
	inst:DoTaskInTime(2, function() 
		inst.fullmoon = false
		inst.berserks = false 
	if not inst:HasTag("playerghost") and not inst.fberserk then	
		if inst.components.hunger.current >= 160 then
		inst.strength = "full"  
		--inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false
		if inst.visual_cos and not inst.musha_full then
	inst.AnimState:SetBuild("musha")
	inst.musha_full = true
		elseif not inst.visual_cos and not inst.change_visual and not inst.musha_full then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_full_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_full_sw2")
		end
		inst.musha_full = true
		end
	elseif inst.components.hunger.current < 160 then
		inst.strength = "normal"   
		inst.musha_full = false
		--inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false
		if inst.visual_cos and not inst.musha_normal then
	inst.AnimState:SetBuild("musha_normal")
	inst.musha_normal = true
		elseif not inst.visual_cos and not inst.change_visual and not inst.musha_normal then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_normal_sw2")			
		end
		inst.musha_normal = true
		end
		end
	end	
	end)
	end
end

if inst.fberserk and not inst.changed then
SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
inst.changed = true
berserk_countdown(inst)
inst.strength = "berserk"
end
end
	
    ---force berserk
	   local function force_berserk(inst)
	   if inst.berserk_on then
		--inst.components.hunger:SetPercent(.1)
		if not inst.fberserk then
		inst.components.talker:Say("..feel my power..\n(Berserker)")
		end
		inst.fberserk = true
		end end


local function levelexp(inst,data)

	local max_exp = 99999999999999997000
	local level = math.min(inst.level, max_exp)

	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()

if inst.level <=7000 then
inst.components.talker:Say("[EXP] \n".. (inst.level))
end
--stat 
	--level 1
	if inst.easyh then
if inst.level <5 then
	inst.components.health.maxhealth = math.ceil (80)
	inst.components.sanity.max = math.ceil (80)
	--level 2
elseif inst.level >=5 and inst.level <10  then
	inst.components.health.maxhealth = math.ceil (90)
	inst.components.sanity.max = math.ceil (90)
	--level 3
elseif inst.level >=10 and inst.level <30  then
	inst.components.health.maxhealth = math.ceil (100)
	inst.components.sanity.max = math.ceil (100)
	--level 4
elseif inst.level >=30 and inst.level <50  then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (110)
	--level 5
elseif inst.level >=50 and inst.level <80  then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (120)
	--level 6
elseif inst.level >=80 and inst.level <125  then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (130)
	--level 7
elseif inst.level >=125 and inst.level <200  then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (140)
	--level 8
elseif inst.level >=200 and inst.level <340  then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (150)
	--level 9
elseif inst.level >=340 and inst.level <430  then
	inst.components.health.maxhealth = math.ceil (160)
	inst.components.sanity.max = math.ceil (160)
	--level 10
elseif inst.level >=430 and inst.level <530  then
	inst.components.health.maxhealth = math.ceil (170)
	inst.components.sanity.max = math.ceil (170)
	--level 11
elseif inst.level >=530 and inst.level <640  then
	inst.components.health.maxhealth = math.ceil (180)
	inst.components.sanity.max = math.ceil (180)
	--level 12
elseif inst.level >=640 and inst.level <760  then
	inst.components.health.maxhealth = math.ceil (190)
	inst.components.sanity.max = math.ceil (190)
	--level 13
elseif inst.level >=760 and inst.level <890  then
	inst.components.health.maxhealth = math.ceil (200)
	inst.components.sanity.max = math.ceil (200)
	--level 14
elseif inst.level >=890 and inst.level <1030  then
	inst.components.health.maxhealth = math.ceil (210)
	inst.components.sanity.max = math.ceil (210)
	--level 15
elseif inst.level >=1030 and inst.level <1180  then
	inst.components.health.maxhealth = math.ceil (220)
	inst.components.sanity.max = math.ceil (220)
	--level 16
elseif inst.level >=1180 and inst.level <1340  then
	inst.components.health.maxhealth = math.ceil (230)
	inst.components.sanity.max = math.ceil (230)
	--level 17
elseif inst.level >=1340 and inst.level <1510  then
	inst.components.health.maxhealth = math.ceil (240)
	inst.components.sanity.max = math.ceil (240)
	--level 18
elseif inst.level >=1510 and inst.level <1690  then
	inst.components.health.maxhealth = math.ceil (250)
	inst.components.sanity.max = math.ceil (250)
	--level 19
elseif inst.level >=1690 and inst.level <1880  then
	inst.components.health.maxhealth = math.ceil (260)
	inst.components.sanity.max = math.ceil (260)
	--level 20
elseif inst.level >=1880 and inst.level <2080  then
	inst.components.health.maxhealth = math.ceil (270)
	inst.components.sanity.max = math.ceil (270)
	--level 21
elseif inst.level >=2080 and inst.level <2290  then
	inst.components.health.maxhealth = math.ceil (280)
	inst.components.sanity.max = math.ceil (280)
	--level 22
elseif inst.level >=2290 and inst.level <2500  then
	inst.components.health.maxhealth = math.ceil (290)
	inst.components.sanity.max = math.ceil (290)
	--level 23
elseif inst.level >=2500 and inst.level <2850  then
	inst.components.health.maxhealth = math.ceil (300)
	inst.components.sanity.max = math.ceil (300)
	--level 24
elseif inst.level >=2850 and inst.level <3200  then
	inst.components.health.maxhealth = math.ceil (310)
	inst.components.sanity.max = math.ceil (310)
	--level 25
elseif inst.level >=3200 and inst.level <3700  then
	inst.components.health.maxhealth = math.ceil (320)
	inst.components.sanity.max = math.ceil (320)
	--level 26
elseif inst.level >=3700 and inst.level <4200  then
	inst.components.health.maxhealth = math.ceil (330)
	inst.components.sanity.max = math.ceil (330)
	--level 27
elseif inst.level >=4200 and inst.level <4700  then
	inst.components.health.maxhealth = math.ceil (340)
	inst.components.sanity.max = math.ceil (340)
	--level 28
elseif inst.level >=4700 and inst.level <5500 then
	inst.components.health.maxhealth = math.ceil (350)
	inst.components.sanity.max = math.ceil (350)
	--level 29
elseif inst.level >=5500 and inst.level <7000 then
	inst.components.health.maxhealth = math.ceil (360)
	inst.components.sanity.max = math.ceil (360)
	-- level 30
elseif inst.level >=7000  then
	inst.components.health.maxhealth = math.ceil (365)
	inst.components.sanity.max = math.ceil (365 + inst.level* 0.005)
inst.x2damage = true
end

	elseif inst.normalh then
if inst.level <5 then
	inst.components.health.maxhealth = math.ceil (80)
	inst.components.sanity.max = math.ceil (80)
	--level 2
elseif inst.level >=5 and inst.level <10  then
	inst.components.health.maxhealth = math.ceil (85)
	inst.components.sanity.max = math.ceil (85)
	--level 3
elseif inst.level >=10 and inst.level <30  then
	inst.components.health.maxhealth = math.ceil (90)
	inst.components.sanity.max = math.ceil (90)
	--level 4
elseif inst.level >=30 and inst.level <50  then
	inst.components.health.maxhealth = math.ceil (95)
	inst.components.sanity.max = math.ceil (95)
	--level 5
elseif inst.level >=50 and inst.level <80  then
	inst.components.health.maxhealth = math.ceil (100)
	inst.components.sanity.max = math.ceil (100)
	--level 6
elseif inst.level >=80 and inst.level <125  then
	inst.components.health.maxhealth = math.ceil (105)
	inst.components.sanity.max = math.ceil (105)
	--level 7
elseif inst.level >=125 and inst.level <200  then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (110)
	--level 8
elseif inst.level >=200 and inst.level <340  then
	inst.components.health.maxhealth = math.ceil (115)
	inst.components.sanity.max = math.ceil (115)
	--level 9
elseif inst.level >=340 and inst.level <430  then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (120)
	--level 10
elseif inst.level >=430 and inst.level <530  then
	inst.components.health.maxhealth = math.ceil (125)
	inst.components.sanity.max = math.ceil (125)
	--level 11
elseif inst.level >=530 and inst.level <640  then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (130)
	--level 12
elseif inst.level >=640 and inst.level <760  then
	inst.components.health.maxhealth = math.ceil (135)
	inst.components.sanity.max = math.ceil (135)
	--level 13
elseif inst.level >=760 and inst.level <890  then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (140)
	--level 14
elseif inst.level >=890 and inst.level <1030  then
	inst.components.health.maxhealth = math.ceil (145)
	inst.components.sanity.max = math.ceil (145)
	--level 15
elseif inst.level >=1030 and inst.level <1180  then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (150)
	--level 16
elseif inst.level >=1180 and inst.level <1340  then
	inst.components.health.maxhealth = math.ceil (155)
	inst.components.sanity.max = math.ceil (155)
	--level 17
elseif inst.level >=1340 and inst.level <1510  then
	inst.components.health.maxhealth = math.ceil (160)
	inst.components.sanity.max = math.ceil (160)
	--level 18
elseif inst.level >=1510 and inst.level <1690  then
	inst.components.health.maxhealth = math.ceil (165)
	inst.components.sanity.max = math.ceil (165)
	--level 19
elseif inst.level >=1690 and inst.level <1880  then
	inst.components.health.maxhealth = math.ceil (170)
	inst.components.sanity.max = math.ceil (170)
	--level 20
elseif inst.level >=1880 and inst.level <2080  then
	inst.components.health.maxhealth = math.ceil (175)
	inst.components.sanity.max = math.ceil (175)
	--level 21
elseif inst.level >=2080 and inst.level <2290  then
	inst.components.health.maxhealth = math.ceil (180)
	inst.components.sanity.max = math.ceil (180)
	--level 22
elseif inst.level >=2290 and inst.level <2500  then
	inst.components.health.maxhealth = math.ceil (185)
	inst.components.sanity.max = math.ceil (185)
	--level 23
elseif inst.level >=2500 and inst.level <2850  then
	inst.components.health.maxhealth = math.ceil (190)
	inst.components.sanity.max = math.ceil (190)
	--level 24
elseif inst.level >=2850 and inst.level <3200  then
	inst.components.health.maxhealth = math.ceil (195)
	inst.components.sanity.max = math.ceil (195)
	--level 25
elseif inst.level >=3200 and inst.level <3700  then
	inst.components.health.maxhealth = math.ceil (200)
	inst.components.sanity.max = math.ceil (200)
	--level 26
elseif inst.level >=3700 and inst.level <4200  then
	inst.components.health.maxhealth = math.ceil (205)
	inst.components.sanity.max = math.ceil (205)
	--level 27
elseif inst.level >=4200 and inst.level <4700  then
	inst.components.health.maxhealth = math.ceil (210)
	inst.components.sanity.max = math.ceil (210)
	--level 28
elseif inst.level >=4700 and inst.level <5500 then
	inst.components.health.maxhealth = math.ceil (215)
	inst.components.sanity.max = math.ceil (215)
	--level 29
elseif inst.level >=5500 and inst.level <7000 then
	inst.components.health.maxhealth = math.ceil (220)
	inst.components.sanity.max = math.ceil (220)
	-- level 30
elseif inst.level >=7000  then
	inst.components.health.maxhealth = math.ceil (225)
	inst.components.sanity.max = math.ceil (220 + inst.level* 0.005)
inst.x2damage = true
end
	elseif inst.hardh then
if inst.level <5 then
	inst.components.health.maxhealth = math.ceil (80)
	inst.components.sanity.max = math.ceil (80)
	--level 2
elseif inst.level >=5 and inst.level <10  then
	inst.components.health.maxhealth = math.ceil (82)
	inst.components.sanity.max = math.ceil (85)
	--level 3
elseif inst.level >=10 and inst.level <30  then
	inst.components.health.maxhealth = math.ceil (84)
	inst.components.sanity.max = math.ceil (90)
	--level 4
elseif inst.level >=30 and inst.level <50  then
	inst.components.health.maxhealth = math.ceil (86)
	inst.components.sanity.max = math.ceil (95)
	--level 5
elseif inst.level >=50 and inst.level <80  then
	inst.components.health.maxhealth = math.ceil (88)
	inst.components.sanity.max = math.ceil (100)
	--level 6
elseif inst.level >=80 and inst.level <125  then
	inst.components.health.maxhealth = math.ceil (100)
	inst.components.sanity.max = math.ceil (105)
	--level 7
elseif inst.level >=125 and inst.level <200  then
	inst.components.health.maxhealth = math.ceil (102)
	inst.components.sanity.max = math.ceil (110)
	--level 8
elseif inst.level >=200 and inst.level <340  then
	inst.components.health.maxhealth = math.ceil (104)
	inst.components.sanity.max = math.ceil (115)
	--level 9
elseif inst.level >=340 and inst.level <430  then
	inst.components.health.maxhealth = math.ceil (106)
	inst.components.sanity.max = math.ceil (120)
	--level 10
elseif inst.level >=430 and inst.level <530  then
	inst.components.health.maxhealth = math.ceil (108)
	inst.components.sanity.max = math.ceil (125)
	--level 11
elseif inst.level >=530 and inst.level <640  then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (130)
	--level 12
elseif inst.level >=640 and inst.level <760  then
	inst.components.health.maxhealth = math.ceil (112)
	inst.components.sanity.max = math.ceil (135)
	--level 13
elseif inst.level >=760 and inst.level <890  then
	inst.components.health.maxhealth = math.ceil (114)
	inst.components.sanity.max = math.ceil (140)
	--level 14
elseif inst.level >=890 and inst.level <1030  then
	inst.components.health.maxhealth = math.ceil (116)
	inst.components.sanity.max = math.ceil (145)
	--level 15
elseif inst.level >=1030 and inst.level <1180  then
	inst.components.health.maxhealth = math.ceil (118)
	inst.components.sanity.max = math.ceil (150)
	--level 16
elseif inst.level >=1180 and inst.level <1340  then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (155)
	--level 17
elseif inst.level >=1340 and inst.level <1510  then
	inst.components.health.maxhealth = math.ceil (122)
	inst.components.sanity.max = math.ceil (160)
	--level 18
elseif inst.level >=1510 and inst.level <1690  then
	inst.components.health.maxhealth = math.ceil (124)
	inst.components.sanity.max = math.ceil (165)
	--level 19
elseif inst.level >=1690 and inst.level <1880  then
	inst.components.health.maxhealth = math.ceil (126)
	inst.components.sanity.max = math.ceil (170)
	--level 20
elseif inst.level >=1880 and inst.level <2080  then
	inst.components.health.maxhealth = math.ceil (128)
	inst.components.sanity.max = math.ceil (175)
	--level 21
elseif inst.level >=2080 and inst.level <2290  then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (180)
	--level 22
elseif inst.level >=2290 and inst.level <2500  then
	inst.components.health.maxhealth = math.ceil (132)
	inst.components.sanity.max = math.ceil (185)
	--level 23
elseif inst.level >=2500 and inst.level <2850  then
	inst.components.health.maxhealth = math.ceil (134)
	inst.components.sanity.max = math.ceil (190)
	--level 24
elseif inst.level >=2850 and inst.level <3200  then
	inst.components.health.maxhealth = math.ceil (136)
	inst.components.sanity.max = math.ceil (195)
	--level 25
elseif inst.level >=3200 and inst.level <3700  then
	inst.components.health.maxhealth = math.ceil (138)
	inst.components.sanity.max = math.ceil (200)
	--level 26
elseif inst.level >=3700 and inst.level <4200  then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (205)
	--level 27
elseif inst.level >=4200 and inst.level <4700  then
	inst.components.health.maxhealth = math.ceil (142)
	inst.components.sanity.max = math.ceil (210)
	--level 28
elseif inst.level >=4700 and inst.level <5500 then
	inst.components.health.maxhealth = math.ceil (144)
	inst.components.sanity.max = math.ceil (215)
	--level 29
elseif inst.level >=5500 and inst.level <7000 then
	inst.components.health.maxhealth = math.ceil (146)
	inst.components.sanity.max = math.ceil (220)
	-- level 30
elseif inst.level >=7000  then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (220 + inst.level* 0.005)
inst.x2damage = true
end
	elseif inst.hardcoreh then
if inst.level <5 then
	inst.components.health.maxhealth = math.ceil (80)
	inst.components.sanity.max = math.ceil (80)
	--level 2
elseif inst.level >=5 and inst.level <10  then
	inst.components.health.maxhealth = math.ceil (81)
	inst.components.sanity.max = math.ceil (81)
	--level 3
elseif inst.level >=10 and inst.level <30  then
	inst.components.health.maxhealth = math.ceil (82)
	inst.components.sanity.max = math.ceil (82)
	--level 4
elseif inst.level >=30 and inst.level <50  then
	inst.components.health.maxhealth = math.ceil (83)
	inst.components.sanity.max = math.ceil (83)
	--level 5
elseif inst.level >=50 and inst.level <80  then
	inst.components.health.maxhealth = math.ceil (84)
	inst.components.sanity.max = math.ceil (84)
	--level 6
elseif inst.level >=80 and inst.level <125  then
	inst.components.health.maxhealth = math.ceil (85)
	inst.components.sanity.max = math.ceil (85)
	--level 7
elseif inst.level >=125 and inst.level <200  then
	inst.components.health.maxhealth = math.ceil (86)
	inst.components.sanity.max = math.ceil (86)
	--level 8
elseif inst.level >=200 and inst.level <340  then
	inst.components.health.maxhealth = math.ceil (87)
	inst.components.sanity.max = math.ceil (87)
	--level 9
elseif inst.level >=340 and inst.level <430  then
	inst.components.health.maxhealth = math.ceil (88)
	inst.components.sanity.max = math.ceil (88)
	--level 10
elseif inst.level >=430 and inst.level <530  then
	inst.components.health.maxhealth = math.ceil (89)
	inst.components.sanity.max = math.ceil (89)
	--level 11
elseif inst.level >=530 and inst.level <640  then
	inst.components.health.maxhealth = math.ceil (90)
	inst.components.sanity.max = math.ceil (90)
	--level 12
elseif inst.level >=640 and inst.level <760  then
	inst.components.health.maxhealth = math.ceil (91)
	inst.components.sanity.max = math.ceil (91)
	--level 13
elseif inst.level >=760 and inst.level <890  then
	inst.components.health.maxhealth = math.ceil (92)
	inst.components.sanity.max = math.ceil (92)
	--level 14
elseif inst.level >=890 and inst.level <1030  then
	inst.components.health.maxhealth = math.ceil (93)
	inst.components.sanity.max = math.ceil (93)
	--level 15
elseif inst.level >=1030 and inst.level <1180  then
	inst.components.health.maxhealth = math.ceil (94)
	inst.components.sanity.max = math.ceil (94)
	--level 16
elseif inst.level >=1180 and inst.level <1340  then
	inst.components.health.maxhealth = math.ceil (95)
	inst.components.sanity.max = math.ceil (95)
	--level 17
elseif inst.level >=1340 and inst.level <1510  then
	inst.components.health.maxhealth = math.ceil (96)
	inst.components.sanity.max = math.ceil (96)
	--level 18
elseif inst.level >=1510 and inst.level <1690  then
	inst.components.health.maxhealth = math.ceil (97)
	inst.components.sanity.max = math.ceil (97)
	--level 19
elseif inst.level >=1690 and inst.level <1880  then
	inst.components.health.maxhealth = math.ceil (98)
	inst.components.sanity.max = math.ceil (98)
	--level 20
elseif inst.level >=1880 and inst.level <2080  then
	inst.components.health.maxhealth = math.ceil (99)
	inst.components.sanity.max = math.ceil (99)
	--level 21
elseif inst.level >=2080 and inst.level <2290  then
	inst.components.health.maxhealth = math.ceil (100)
	inst.components.sanity.max = math.ceil (100)
	--level 22
elseif inst.level >=2290 and inst.level <2500  then
	inst.components.health.maxhealth = math.ceil (101)
	inst.components.sanity.max = math.ceil (101)
	--level 23
elseif inst.level >=2500 and inst.level <2850  then
	inst.components.health.maxhealth = math.ceil (102)
	inst.components.sanity.max = math.ceil (102)
	--level 24
elseif inst.level >=2850 and inst.level <3200  then
	inst.components.health.maxhealth = math.ceil (103)
	inst.components.sanity.max = math.ceil (103)
	--level 25
elseif inst.level >=3200 and inst.level <3700  then
	inst.components.health.maxhealth = math.ceil (104)
	inst.components.sanity.max = math.ceil (104)
	--level 26
elseif inst.level >=3700 and inst.level <4200  then
	inst.components.health.maxhealth = math.ceil (105)
	inst.components.sanity.max = math.ceil (105)
	--level 27
elseif inst.level >=4200 and inst.level <4700  then
	inst.components.health.maxhealth = math.ceil (106)
	inst.components.sanity.max = math.ceil (106)
	--level 28
elseif inst.level >=4700 and inst.level <5500 then
	inst.components.health.maxhealth = math.ceil (107)
	inst.components.sanity.max = math.ceil (107)
	--level 29
elseif inst.level >=5500 and inst.level <7000 then
	inst.components.health.maxhealth = math.ceil (108)
	inst.components.sanity.max = math.ceil (108)
	-- level 30
elseif inst.level >=7000  then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (110 + inst.level* 0.005)
	inst.x2damage = true
end
end

	inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)

----level and skill
--[[test]] 
--[[
if inst.level >= 0 then
Critical_level_3(inst)  --max 7 (damage )
Lshield_level_3(inst)  --max 4 (defense heal + reflect)
Valkyrie_level_4(inst)	--max 14 (prototype1 + Lightning 8 + Armor 4 + Duration 1)
inst.berserk_a_3= true  --max3 (armor + AOS attack)]]


			if inst.level >0 and inst.level <= 4 then

			elseif inst.level >4 and inst.level <= 5 then
	inst.components.talker:Say("Level 2\n Unlock: [Ligntnig Shield]\nLV 1/5")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	Lshield_level_1(inst)
			elseif inst.level >5 and inst.level <= 9 then
--inst.components.talker:Say("Next :EXP[10]\n[EXP] + ".. (inst.level))
	Lshield_level_1(inst)
		elseif inst.level >9 and inst.level <= 10 then
	inst.components.talker:Say("Level 3\n Unlock:[Valkyrie Power Lightning]: 1/4 \n[Valkyrie]: 1/2")	
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_1(inst)
Valkyrie_level_1(inst)
			elseif inst.level >10 and inst.level <= 29 then
--inst.components.talker:Say("Next :EXP[30]\n[EXP] + ".. (inst.level))
Lshield_level_1(inst)
Valkyrie_level_1(inst)
		elseif inst.level >29 and inst.level <= 30 then
		inst.components.talker:Say("Level 4\n Unlock:[Critical Hit]\nLV 1/7")	
	inst.components.talker:Say("Level 4\n Unlock:[Valkyrie Power Lightning]: 1/4 \n[Valkyrie]: 1/2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_1(inst)
Critical_level_1(inst)
Valkyrie_level_1(inst)
			elseif inst.level > 30 and inst.level <= 49  then
--inst.components.talker:Say("Next :EXP[50]\n[EXP] + ".. (inst.level))
Lshield_level_1(inst)
Critical_level_1(inst)
Valkyrie_level_1(inst)
		elseif inst.level >49 and inst.level <= 50 then
	inst.components.talker:Say("Level 5\n Unlock: [Valkyrie Lightning]\nLV 1/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_1(inst)
Critical_level_1(inst)
Valkyrie_level_2(inst)
			elseif inst.level >50 and inst.level <=79  then
--inst.components.talker:Say("Next :EXP[80]\n[EXP] + ".. (inst.level))
Lshield_level_1(inst)
Critical_level_1(inst)
Valkyrie_level_2(inst)
		elseif inst.level >79 and inst.level <= 80 then
	inst.components.talker:Say("Level 6\n Unlock : [Electric Shield]\nLV 2/5")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_2(inst)
Critical_level_1(inst)
Valkyrie_level_2(inst)
		elseif inst.level >80 and inst.level <=124  then
Lshield_level_2(inst)
Critical_level_1(inst)
Valkyrie_level_2(inst)		
		elseif inst.level >124 and inst.level <= 125 then
	inst.components.talker:Say("Level 7\n Unlock:[Berserk]-[Berserk Armor]\nLV 1/2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_2(inst)
Valkyrie_level_2(inst)
inst.berserk_a_1 = true
			elseif inst.level >125 and inst.level <=199  then
--inst.components.talker:Say("Next :EXP[200]\n[EXP] + ".. (inst.level))
Lshield_level_2(inst)
Valkyrie_level_2(inst)
inst.berserk_a_1 = true
		elseif inst.level >199 and inst.level <= 200 then
	inst.components.talker:Say("Level 8\n Unlock : [Valkyrie Armor]\nLV 1/4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_2(inst)
Valkyrie_level_3(inst)
inst.berserk_a_1 = true
			elseif inst.level >200 and inst.level <=339  then
--inst.components.talker:Say("Next :EXP[340]\n[EXP] + ".. (inst.level))
Lshield_level_2(inst)
Valkyrie_level_3(inst)
inst.berserk_a_1 = true
		elseif inst.level >339 and inst.level <= 340 then
	inst.components.talker:Say("Level 9\n Unlock : [Valkyrie Lightning Strike]\nLV 2/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_2(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
			elseif inst.level >340 and inst.level <=429  then
--inst.components.talker:Say("Next :EXP[430]\n[EXP] + ".. (inst.level))
Lshield_level_2(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
		elseif inst.level >429 and inst.level <= 430 then
	inst.components.talker:Say("Level 10\n Unlock :[Electric Shield]\nLV 3/5 \nUpgrade all [Active Skills]")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_3(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
			elseif inst.level >430 and inst.level <=529  then
--inst.components.talker:Say("Next :EXP[530]\n[EXP] + ".. (inst.level))
Lshield_level_3(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
		elseif inst.level >529 and inst.level <= 530 then
	inst.components.talker:Say("Level 11\n Unlock: [Critical Hit]\nLV 2/7")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_3(inst)
Critical_level_2(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
			elseif inst.level >530 and inst.level <=639  then
--inst.components.talker:Say("Next :EXP[640]\n[EXP] + ".. (inst.level))
Lshield_level_3(inst)
Critical_level_2(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
		elseif inst.level >639 and inst.level <= 640 then
	inst.components.talker:Say("Level 12\n [Critical Hit]\nLV 3/7")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_3(inst)
Critical_level_3(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
			elseif inst.level >640 and inst.level <=759  then
--inst.components.talker:Say("Next :EXP[760]\n[EXP] + ".. (inst.level))
Lshield_level_3(inst)
Critical_level_3(inst)
Valkyrie_level_4(inst)
inst.berserk_a_1 = true
		elseif inst.level >759 and inst.level <= 760 then
inst.components.talker:Say("Level 13\n Unlock: [Valkyrie Armor]\nLV 2/4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_3(inst)
Critical_level_3(inst)
Valkyrie_level_5(inst)
inst.berserk_a_1 = true
			elseif inst.level >760 and inst.level <=889  then
--inst.components.talker:Say("Next :EXP[890]\n[EXP] + ".. (inst.level))
Lshield_level_3(inst)
Critical_level_3(inst)
Valkyrie_level_5(inst)
inst.berserk_a_1 = true
		elseif inst.level >889 and inst.level <= 890 then
	inst.components.talker:Say("Level 14\n Unlock: [Valkyrie Ligntnig]\nLV 3/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_3(inst)
Critical_level_3(inst)
Valkyrie_level_6(inst)
inst.berserk_a_1 = true
			elseif inst.level >890 and inst.level <=1029  then
--inst.components.talker:Say("Next :EXP[1030]\n[EXP] + ".. (inst.level))
Lshield_level_3(inst)
Critical_level_3(inst)
Valkyrie_level_6(inst)
inst.berserk_a_1 = true
		elseif inst.level >1029 and inst.level <= 1030 then
	inst.components.talker:Say("Level 15\n Unlock: [Ligntnig Shield]\nLV 4/5")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_4(inst)
Critical_level_3(inst)
Valkyrie_level_6(inst)
inst.berserk_a_1 = true
			elseif inst.level >1030 and inst.level <=1179  then
--inst.components.talker:Say("Next :EXP[1180]\n[EXP] + ".. (inst.level))
Lshield_level_4(inst)
Critical_level_3(inst)
Valkyrie_level_6(inst)
inst.berserk_a_1 = true
		elseif inst.level >1179 and inst.level <= 1180 then
inst.components.talker:Say("Level 16\n Unlock: [Critical Hit]\nLV 4/7")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_6(inst)
inst.berserk_a_1 = true
			elseif inst.level >1180 and inst.level <=1339  then
--inst.components.talker:Say("Next :EXP[1340]\n[EXP] + ".. (inst.level))
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_6(inst)
inst.berserk_a_1 = true
		elseif inst.level >1339 and inst.level <= 1340 then
inst.components.talker:Say("Level 17\n Unlock : [Valkyrie Armor]\nLV 3/4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_7(inst)
inst.berserk_a_1 = true
			elseif inst.level >1340 and inst.level <=1509  then
--inst.components.talker:Say("Next :EXP[1510]\n[EXP] + ".. (inst.level))
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_7(inst)
inst.berserk_a_1 = true
		elseif inst.level >1509 and inst.level <= 1510 then
	inst.components.talker:Say("Level 18\n Unlock : [Valkyrie Lightning Strike]\nLV 4/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_8(inst)
inst.berserk_a_1 = true
			elseif inst.level >1510 and inst.level <=1689  then
--inst.components.talker:Say("Next :EXP[1690]\n[EXP] + ".. (inst.level))
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_8(inst)
inst.berserk_a_1 = true
		elseif inst.level >1689 and inst.level <= 1690 then
inst.components.talker:Say("Level 19\n Unlock : [Berserk Armor]\nLV 2/2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_8(inst)
inst.berserk_a_2= true
			elseif inst.level >1690 and inst.level <=1879  then
--inst.components.talker:Say("Next :EXP[1880]\n[EXP] + ".. (inst.level))
Lshield_level_4(inst)
Critical_level_4(inst)
Valkyrie_level_8(inst)
inst.berserk_a_2= true
		elseif inst.level >1879 and inst.level <= 1880 then
inst.components.talker:Say("Level 20\n Unlock : Unlock : [Critical Hit]\nLV 5/7\nUpgrade all [Active Skills]")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_4(inst)
Critical_level_5(inst)
Valkyrie_level_8(inst)
inst.berserk_a_2= true
			elseif inst.level >1880 and inst.level <=2079  then
--inst.components.talker:Say("Next :EXP[2080]\n[EXP] + ".. (inst.level))
Lshield_level_4(inst)
Critical_level_5(inst)
Valkyrie_level_8(inst)
inst.berserk_a_2= true
		elseif inst.level >2079 and inst.level <= 2080 then
	inst.components.talker:Say("Level 21\n Unlock : [Electric Shield]\nLV 5/5")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_8(inst)
inst.berserk_a_2= true
			elseif inst.level >2080 and inst.level <=2289  then
--inst.components.talker:Say("Next :EXP[2289]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_8(inst)
inst.berserk_a_2= true
		elseif inst.level >2189 and inst.level <= 2290 then
	inst.components.talker:Say("Level 22\n Unlock : [Valkyrie Armor]\nLV 4/4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_9(inst)
inst.berserk_a_2= true
			elseif inst.level >2290 and inst.level <=2499  then
--inst.components.talker:Say("Next :EXP[2500]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_9(inst)
inst.berserk_a_2= true
		elseif inst.level >2499 and inst.level <= 2500 then
	inst.components.talker:Say("Level 23\n Unlock : [Valkyrie Lightning Strike]\nLV 5/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_10(inst)
inst.berserk_a_2= true
			elseif inst.level >2500 and inst.level <=2849  then
--inst.components.talker:Say("Next :EXP[2850]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_10(inst)
inst.berserk_a_2= true
		elseif inst.level >2849 and inst.level <= 2850 then
	inst.components.talker:Say("Level 24\n Unlock : [Berserk Master]\nLV 2/2")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_10(inst)
inst.berserk_a_3= true
			elseif inst.level >2850 and inst.level <=3199  then
--inst.components.talker:Say("Next :EXP[3200]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_5(inst)
Valkyrie_level_10(inst)
inst.berserk_a_3= true
		elseif inst.level >3199 and inst.level <= 3200 then
inst.components.talker:Say("Level 25\n Unlock : [Critical Hit]\nLV 6/7")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_6(inst)
Valkyrie_level_10(inst)
inst.berserk_a_3= true
			elseif inst.level >3200 and inst.level <=3699  then
--inst.components.talker:Say("Next :EXP[3700]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_6(inst)
Valkyrie_level_10(inst)
inst.berserk_a_3= true
		elseif inst.level >3699 and inst.level <= 3700 then
inst.components.talker:Say("Level 26\n Unlock : [Valkyrie Lightning Strike]\nLV 6/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_6(inst)
Valkyrie_level_11(inst)
inst.berserk_a_3= true
			elseif inst.level >3700 and inst.level <=4199  then
--inst.components.talker:Say("Next :EXP[4200]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_6(inst)
Valkyrie_level_11(inst)
inst.berserk_a_3= true
		elseif inst.level >4199 and inst.level <= 4200 then
inst.components.talker:Say("Level 27\n Unlock : [Critical]\nLV 7/7")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_11(inst)
inst.berserk_a_3= true
			elseif inst.level >4200 and inst.level <=4699  then
--inst.components.talker:Say("Next :EXP[4700]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_11(inst)
inst.berserk_a_3= true
		elseif inst.level >4699 and inst.level <= 4700 then
inst.components.talker:Say("Level 28\n Unlock : [Valkyrie Lightning Strike]\nLV 7/8")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_12(inst)
inst.berserk_a_3= true
			elseif inst.level >4700 and inst.level <=5499  then
--inst.components.talker:Say("Next :EXP[5500]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_12(inst)
inst.berserk_a_3= true
		elseif inst.level >5499 and inst.level <= 5500 then
	inst.components.talker:Say("Level 29\n Unlock : [Valkyrie Lightning Strike]\nLV 4/4")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_13(inst)
inst.berserk_a_3= true
			elseif inst.level >5500 and inst.level <=6999  then
--inst.components.talker:Say("Next :EXP[7000]\n[EXP] + ".. (inst.level))
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_13(inst)
inst.berserk_a_3= true
		elseif inst.level >6999 and inst.level <= 7000 then
inst.components.talker:Say("Level 30\n Unlock : [Double Damage]\n Unlock : [Valkyrie Master] \nLV 2/2\nUpgrade all [Active Skills]")
inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_finish", "snd")
inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_14(inst)
inst.berserk_a_3= true
		elseif inst.level > 7000 then
		Lshield_level_5(inst)
Critical_level_7(inst)
Valkyrie_level_14(inst)
inst.berserk_a_3= true
	end
end

local tynychance = 0.1
local smallllchance = 0.2
local smallchance = 0.25
local normalchance = 0.35
local largechance = 0.75
local foodnormalchance = 0.45
local foodgoodchance = 0.65
local foodlargechance = 0.85

local function spawnspirit(inst, x, y, z, scale)
    local fx = SpawnPrefab("wathgrithr_spirit")
    fx.Transform:SetPosition(x, y, z)
    fx.Transform:SetScale(scale, scale, scale)
end

local smallScale = 0.5
local medScale = 0.7
local largeScale = 1.1
local function onkilll(inst, data)
	local victim = data.victim
	if not victim:HasTag("smashable") then
		if not (
			victim:HasTag("prey") or
            victim:HasTag("veggie") or
            victim:HasTag("eyeplant") or
            victim:HasTag("insect") or			
            victim:HasTag("structure") or
			victim:HasTag("no_exp") or
			victim:HasTag("wall") or
			victim:HasTag("fossil") or 
			victim:HasTag("shadow") or
			victim:HasTag("stalkerminion") or
			victim:HasTag("shadowminion") or
			victim:HasTag("cattoyairborne")
		
						
			) and victim.components.combat then
			local delta = victim.components.combat.defaultdamage * 0.5
			if math.random() < largechance then
					inst.level = inst.level + 1
 					--if victim:HasTag("monster1x") then
					--inst.level = inst.level + 1
					if victim:HasTag("monster2x") then
					--inst.level = inst.level + 1
						if math.random() < 0.1 then
						inst.level = inst.level + 1
						if math.random() < 0.05 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end	end
					elseif victim:HasTag("monster3x") then
					--inst.level = inst.level + 2
						if math.random() < 0.1 then
						inst.level = inst.level + 1
						if math.random() < 0.05 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end end
					elseif victim:HasTag("monster4x") then
					--inst.level = inst.level + 3
						if math.random() < 0.1 then
						inst.level = inst.level + 1
						if math.random() < 0.05 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end end
						end
											   				
 		--inst.components.health:DoDelta(delta, false, "battleborn")
		inst.components.sanity:DoDelta(delta)
			levelexp(inst)					
            local time = victim.components.health.destroytime or 2
            local x, y, z = victim.Transform:GetWorldPosition()
            local scale = (victim:HasTag("smallcreature") and smallScale)
                        or (victim:HasTag("largecreature") and largeScale)
                        or medScale
					inst:DoTaskInTime(time, spawnspirit, x, y, z, scale)
					
				 	   if not inst.berserk and math.random() < 0.3 and victim:HasTag("hound") and not (victim:HasTag("prey") or victim:HasTag("bird")) then
					   local hounds = SpawnPrefab("ghosthound2")
					   --inst.components.talker:Say("Come to me! Ghost puppy")
					     inst:DoTaskInTime(1, function() SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get()) hounds.Transform:SetPosition(victim:GetPosition():Get()) end) hounds.followdog = true --[[hounds.components.follower:SetLeader(inst)]]
						 end
						 
						if math.random() < 0.15 and (victim:HasTag("hound") or victim:HasTag("prey") or victim:HasTag("spider")) and victim.components.combat then 
						
					     inst:DoTaskInTime(1, function() SpawnPrefab("musha_spore").Transform:SetPosition(victim:GetPosition():Get()) end) 
						end 
						 		
						 
			end					
		end
		
			if math.random() < 0.15 and victim:HasTag("antlion") then 
						
					     inst:DoTaskInTime(1, function() SpawnPrefab("musha_treasure2").Transform:SetPosition(inst:GetPosition():Get()) end) 
						end
						
		  if (victim:HasTag("prey") or victim:HasTag("insect") or victim:HasTag("frog")) and victim.components.combat then
    local delta = victim.components.combat.defaultdamage * 0.1
		   if math.random() < smallllchance then
    				inst.level = inst.level + 1
 			inst.components.sanity:DoDelta(delta)
			levelexp(inst)					
            local time = victim.components.health.destroytime or 2
            local x, y, z = victim.Transform:GetWorldPosition()
            local scale = (victim:HasTag("smallcreature") and smallScale)
                        or (victim:HasTag("largecreature") and largeScale)
                        or medScale
					inst:DoTaskInTime(time, spawnspirit, x, y, z, scale)
					end end 	
		 if (victim:HasTag("epic") or victim:HasTag("deerclops") or 
			 victim:HasTag("bearger") or victim:HasTag("moose") or 
							  victim:HasTag("dragonfly") ) and victim.components.combat then
			local delta = victim.components.combat.defaultdamage * 0.1
		   			inst.components.sanity:DoDelta(delta)
					if victim:HasTag("small_giant1x") then
					inst.level = inst.level + 5
					inst.components.talker:Say("Kill Epic Monster\n [EXP] + 5 ")

					elseif victim:HasTag("small_giant2x") then
					inst.level = inst.level + 10
					inst.components.talker:Say("Kill Epic Monster\n [EXP] + 10 ")
											if math.random() < 0.2 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
											elseif math.random() < 0.02 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("small_giant3x") then
					inst.level = inst.level + 15
					inst.components.talker:Say("Kill Epic Monster\n [EXP] + 15 ")
											if math.random() < 0.3 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
											elseif math.random() < 0.05 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("small_giant4x") then
					inst.level = inst.level + 20
					inst.components.talker:Say("Kill Epic Monster\n [EXP] + 20 ")
											if math.random() < 0.4 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
											elseif math.random() < 0.1 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant1x") then
					inst.level = inst.level + 10
					inst.components.talker:Say("Kill Giant\n [EXP] + 10 ")
					SpawnPrefab("small_puff").Transform:SetPosition(victim:GetPosition():Get())
					local spot = SpawnPrefab("musha_treasure2")
					spot.Transform:SetPosition(victim:GetPosition():Get())
					spot:SetTreasureHunt()
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.2 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())

					end
					elseif victim:HasTag("giant2x") then
					inst.level = inst.level + 20
					inst.components.talker:Say("Kill Giant\n [EXP] + 20 ")
					SpawnPrefab("small_puff").Transform:SetPosition(victim:GetPosition():Get())
					local spot = SpawnPrefab("musha_treasure2")
					spot.Transform:SetPosition(victim:GetPosition():Get())
					spot:SetTreasureHunt()
					SpawnPrefab("redgem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.5 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("bluegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.15 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.05 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("mandrake").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant3x") then
					inst.level = inst.level + 30
					inst.components.talker:Say("Kill Giant\n [EXP] + 30 ")
					SpawnPrefab("small_puff").Transform:SetPosition(victim:GetPosition():Get())
					local spot = SpawnPrefab("musha_treasure2")
					spot.Transform:SetPosition(victim:GetPosition():Get())
					spot:SetTreasureHunt()
					SpawnPrefab("redgem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("bluegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.5 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.3 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("greengem").Transform:SetPosition(victim:GetPosition():Get())		
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.2 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("mandrake").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant4x") then
					inst.level = inst.level + 40
					inst.components.talker:Say("Kill Giant\n [EXP] + 40 ")
					SpawnPrefab("small_puff").Transform:SetPosition(victim:GetPosition():Get())
					local spot = SpawnPrefab("musha_treasure2")
					spot.Transform:SetPosition(victim:GetPosition():Get())
					spot:SetTreasureHunt()
					SpawnPrefab("redgem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("bluegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					if math.random() < 0.7 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("greengem").Transform:SetPosition(victim:GetPosition():Get())	
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())					
						elseif math.random() < 0.6 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("yellowgem").Transform:SetPosition(victim:GetPosition():Get())	
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.5 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("orangegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("mandrake").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					end
    				levelexp(inst)			
					
            local time = victim.components.health.destroytime or 2
            local x, y, z = victim.Transform:GetWorldPosition()
            local scale = (victim:HasTag("smallcreature") and smallScale)
                        or (victim:HasTag("largecreature") and largeScale)
                        or medScale
					inst:DoTaskInTime(time, spawnspirit, x, y, z, scale)
					end 
					end 	
	end			
	
local function expeat(inst, food)
inst.fatigue = inst.fatigue -2 

if --[[food.prefab == "coffe"]] string.find(tostring(food),"coffe") then
	
	if math.random() < 0.5 then
	inst.components.talker:Say("Musha love a coffee!")
	elseif math.random() < 0.5 then
	inst.components.talker:Say("Smell so good !")
	else
	inst.components.talker:Say("Wonderful")
	end
	inst.stamina = inst.stamina + 8
	inst.level = inst.level + 1
	
elseif not --[[food.prefab == "coffe"]] string.find(tostring(food),"coffe") then

if food.components.edible.hungervalue >= 150 and food.components.edible.healthvalue >= 100 then
if inst.fatigue > 0 then
	inst.fatigue = inst.fatigue *0 end
if food.components.edible then
	inst.level = inst.level + 25
	levelexp(inst)
	inst.components.talker:Say("Yam Yam !!\n [EXP] + 25 ")
end
elseif food.components.edible.hungervalue > 140 or food.components.edible.healthvalue > 35 then 
if not inst.No_Sleep_Princess and inst.fatigue >= 0 then
inst.fatigue = inst.fatigue -30
if inst.fatigue < 0 then
inst.fatigue = 0
 end end
if food.components.edible and math.random() < foodlargechance then
	inst.level = inst.level + 1
	levelexp(inst)
end
elseif food.components.edible.hungervalue > 55 or food.components.edible.healthvalue > 29 or food.components.edible.sanityvalue > 19 then 
if not inst.No_Sleep_Princess and inst.fatigue >= 0 then
inst.fatigue = inst.fatigue -20 
if inst.fatigue < 0 then
inst.fatigue = 0
 end end
if food.components.edible and math.random() < foodgoodchance then
	inst.level = inst.level + 1
	levelexp(inst)
end
elseif food.components.edible.hungervalue > 24 or food.components.edible.healthvalue > 19 or food.components.edible.sanityvalue > 14 then 
if not inst.No_Sleep_Princess and inst.fatigue >= 0 then
inst.fatigue = inst.fatigue -10 
if inst.fatigue < 0 then
inst.fatigue = 0
 end end
if food.components.edible and math.random() < foodnormalchance then
	inst.level = inst.level + 1
	levelexp(inst)
end
else 
if not inst.No_Sleep_Princess and inst.fatigue >= 0 then
inst.fatigue = inst.fatigue -2 
if inst.fatigue < 0 then
inst.fatigue = 0
 end end
if food.components.edible and math.random() < tynychance then
	inst.level = inst.level + 1
	levelexp(inst)
end
end
end

--dislike food type
	
if inst.dis_meat_taste and not inst.berserk then
	if food.components.edible and food.components.edible.foodtype == "MEAT" then
	inst:DoTaskInTime(0.7, function() inst.sg:GoToState("refuseeat") 
	if math.random() < 0.2 then  
	inst.components.talker:Say("Bad taste !")
	elseif math.random() < 0.25 then  
	inst.components.talker:Say("Horrible taste !")
	elseif math.random() < 0.3 then  
	inst.components.talker:Say("It left a nasty taste in my mouth.")
	elseif math.random() < 0.3 then  
	inst.components.talker:Say("This food doesn't suit my taste..")
	elseif math.random() < 0.3 then  
	inst.components.talker:Say("Musha don't like the taste of meat..")
	else
	inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_HATEFOOD"))
	end
	inst.components.sanity:DoDelta(-20)
	if inst.components.health.currenthealth > 5 then
	inst.components.health:DoDelta(-3)
	end
	end)
	end
end
if inst.dis_veggie_taste and not inst.berserk then
	if food.components.edible and food.components.edible.foodtype == "VEGGIE" and not food:HasTag("green_fruit") and food.prefab ~= "butterflywings" and food.prefab ~= "glowdust" then
	inst:DoTaskInTime(0.7, function() inst.sg:GoToState("refuseeat") 
	if math.random() < 0.2 then  
	inst.components.talker:Say("Bad taste !")
	elseif math.random() < 0.25 then  
	inst.components.talker:Say("Horrible taste !")
	elseif math.random() < 0.3 then  
	inst.components.talker:Say("It left a nasty taste in my mouth.")
	elseif math.random() < 0.35 then  
	inst.components.talker:Say("This food doesn't suit my taste..")
	elseif math.random() < 0.4 then  
	inst.components.talker:Say("Musha don’t like the taste of veggie..")
	else
	inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_HATEFOOD"))
	end
	inst.components.sanity:DoDelta(-20) 
	if inst.components.health.currenthealth > 5 then
	inst.components.health:DoDelta(-3)
	end
	end)
	end
end

-- basic taste
if food.components.edible and not string.find(tostring(food),"monster") and not string.find(tostring(food),"human") and not inst.berserk then

	if food.components.edible and (food:HasTag("stale") or food:HasTag("spoiled")) and food.prefab ~= "butterflywings" then
	inst:DoTaskInTime(0.7, function() inst.sg:GoToState("refuseeat") 
	if math.random() < 0.4 then  
	inst.components.talker:Say(".. can not smell it !")
	elseif math.random() < 0.5 then  
	inst.components.talker:Say("Too old food...")
	elseif math.random() < 0.8 then  
	inst.components.talker:Say("It's not fresh ..")
	else
	inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_HATEFOOD"))
	end
	end)
	
	elseif food.components.edible and food.prefab == "butterflywings" then
	inst:DoTaskInTime(0.5, function() inst.sg:GoToState("refuseeat") 
	if math.random() < 0.4 then  
	inst.components.talker:Say("It's a BUG !")
	elseif math.random() < 0.5 then  
	inst.components.talker:Say("It left a nasty taste in my mouth.")
	elseif math.random() < 0.8 then  
	inst.components.talker:Say("Why Musha ate a bug ?")
	else
	inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_HATEFOOD"))
	end
	inst.components.sanity:DoDelta(-10) end)
	end
end

--force berserk
	if food.components.edible and string.find(tostring(food),"monster") then
		inst:DoTaskInTime(0.7, function() inst.sg:GoToState("refuseeat") 
	if math.random() < 0.4 then  
	inst.components.talker:Say("horrible taste !")
	elseif math.random() < 0.5 then  
	inst.components.talker:Say("Monster meat doesn't suit my taste..")
	elseif math.random() < 0.8 then  
	inst.components.talker:Say("Musha don’t like a taste of monster..")
	else
	inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_HATEFOOD"))
	end
	inst.components.sanity:DoDelta(-5) end)
 
		if math.random() < 0.5 then 
 		 	force_berserk(inst)
		end 
	end
	
	if food.components.edible and string.find(tostring(food),"human") then
		inst:DoTaskInTime(1, function() inst.sg:GoToState("refuseeat") 
		inst.components.sanity:DoDelta(-5) end)
 		 	force_berserk(inst)
	end 
end

local function in_fire(inst)
    local x, y, z = inst.Transform:GetWorldPosition() 
    local delta = 0
    local max_rad = 10
    local ents = TheSim:FindEntities(x, y, z, max_rad, { "fire" })
    for i, v in ipairs(ents) do
        if v.components.burnable ~= nil and v.components.burnable:IsBurning() then
            local rad = v.components.burnable:GetLargestLightRadius() or 1
            local sz = TUNING.SANITYAURA_TINY * math.min(max_rad, rad) / max_rad
            local distsq = inst:GetDistanceSqToInst(v) - 9
            -- shift the value so that a distance of 3 is the minimum
            delta = delta + sz / math.max(1, distsq)
        end
 
    end
    return delta
end

  local function onsanitydelta(inst, data)
    
    inst.components.temperature:SetModifier("sanity",
        (data.newpercent < TUNING.WILLOW_CHILL_END and TUNING.WILLOW_SANITY_CHILLING) or
        (data.newpercent < TUNING.WILLOW_CHILL_START 
        and easing.outQuad(data.newpercent - TUNING.WILLOW_CHILL_END, 
        TUNING.WILLOW_SANITY_CHILLING, -TUNING.WILLOW_SANITY_CHILLING, 
        TUNING.WILLOW_CHILL_START - TUNING.WILLOW_CHILL_END)) 
        or 0)
end

local function hungrycheck(inst, data)
if inst.No_Sleep_Princess then 
inst.stamina = inst.stamina * 0 + 100
inst.fatigue = inst.fatigue * 0
end	
if inst.strength == "full" then			
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.2)
elseif inst.strength == "normal" then			
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.0)			
elseif inst.strength == "valkyrie" then			
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.5)		
elseif inst.strength == "hunger" then			
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 2)
			
end
end

local function phasechange(inst, data)
if inst.strength == "berserk" and not inst.crazy and not inst:HasTag("playerghost") then
inst.crazy = true
elseif inst.strength ~= "berserk" and inst.crazy and not inst:HasTag("playerghost") then
inst.crazy = false
elseif inst:HasTag("playerghost") and inst.crazy then
inst.berserk = false
inst.crazy = false
end

---- damage ----
local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if weapon and (weapon:HasTag("range_weapon") or weapon:HasTag("bowm") or weapon:HasTag("blowdart") or weapon:HasTag("ranged") or weapon:HasTag("projectile") or weapon:HasTag("thrown")) then
inst.damage_set_melee = false
inst.damage_set2_melee = false
	if inst.veasy and not inst.damage_set_ranged then
	inst.components.combat.damagemultiplier = 2.5
	elseif inst.easy then
	inst.components.combat.damagemultiplier = 1.75
	elseif inst.normalr then
	inst.components.combat.damagemultiplier = 1
	elseif inst.hardr then
	inst.components.combat.damagemultiplier = 0.75
	elseif inst.hardcorer then
	inst.components.combat.damagemultiplier = 0.5
	end
inst.damage_set_ranged = true
elseif weapon and not (weapon:HasTag("range_weapon") or weapon:HasTag("bowm") or weapon:HasTag("blowdart") or weapon:HasTag("ranged") or weapon:HasTag("projectile") or weapon:HasTag("thrown")) then
inst.damage_set_ranged = false
	if not inst.x2damage and not inst.damage_set_melee then
		if inst.newbied then
inst.components.combat.damagemultiplier = 1.5
  elseif inst.sveasyd then
inst.components.combat.damagemultiplier = 1.25
  elseif inst.seasyd then
inst.components.combat.damagemultiplier = 1
  elseif inst.easyd then
inst.components.combat.damagemultiplier = 0.75
  elseif inst.normald then
inst.components.combat.damagemultiplier = 0.55
  elseif inst.hardd then
inst.components.combat.damagemultiplier = 0.4
  elseif inst.hardcored then
inst.components.combat.damagemultiplier = 0.25
		end 
		inst.damage_set_melee = true	
	elseif inst.x2damage and not inst.damage_set2_melee then
		if inst.newbied then
inst.components.combat.damagemultiplier = 3
  elseif inst.sveasyd then
inst.components.combat.damagemultiplier = 2.5
  elseif inst.seasyd then
inst.components.combat.damagemultiplier = 2
  elseif inst.easyd then
inst.components.combat.damagemultiplier = 1.5
  elseif inst.normald then
inst.components.combat.damagemultiplier = 1.1
  elseif inst.hardd then
inst.components.combat.damagemultiplier = 0.8
  elseif inst.hardcored then
inst.components.combat.damagemultiplier = 0.5
		end 
		inst.damage_set2_melee = true			
	end
else
inst.components.combat.damagemultiplier = 0.5
inst.damage_set_melee = false
inst.damage_set2_melee = false
inst.damage_set_ranged = false
end
---- ----

if inst.sg:HasStateTag("nomorph") or
          inst:HasTag("playerghost") or
          inst.components.health:IsDead() then
          return
  end  
--phase change
if inst.level >= 10 then
inst.valkyrie_on = true
end
if inst.level >= 125 then 
inst.berserk_on = true end
if inst.active_valkyrie and inst.stamina >= 20 and not inst.berserks and not inst.fberserk then
    inst.strength = "valkyrie"
elseif not inst.active_valkyrie and inst.stamina >= 20 and not inst.berserks and not inst.fberserk then
    	if inst.components.hunger.current >= 160 then
  inst.strength = "full"  
  inst.active_valkyrie = false
  inst.switch = false  
	elseif inst.components.hunger.current < 160 then
  inst.strength = "normal"   
  inst.active_valkyrie = false
  inst.switch = false
		end	
elseif inst.components.hunger.current >= 160 and not inst.active_valkyrie and not inst.berserks and not inst.fberserk then
    inst.strength = "full" 
elseif inst.components.hunger.current >= 160 and not inst.active_valkyrie and not inst.berserks and not inst.fberserk then
    inst.strength = "normal" 	
elseif inst.strength == "valkyrie" and (inst.berserks or inst.fberserk) then
	inst.strength = "berserk" 
	inst.active_valkyrie = false
	inst.switch = false
elseif inst.stamina < 20 and not inst.berserks and not inst.fberserk then 
		if inst.components.hunger.current >= 160 then
  inst.strength = "full"   
  inst.components.combat:SetRange(2)
	elseif inst.components.hunger.current < 160 then
  inst.strength = "normal"   
  inst.components.combat:SetRange(2)
		end
elseif inst.berserks or inst.fberserk then
  inst.strength = "berserk" 
  inst.active_valkyrie = false
  inst.switch = false
elseif inst.strength == "berserk" and not inst.berserks and not inst.fberserk then
		if inst.components.hunger.current >= 160 then
  inst.strength = "full"   
	elseif inst.components.hunger.current < 160 then
  inst.strength = "normal"   
		end
 end

 
	if inst.strength == "full" then
			inst.soundsname = "willow"
			if weapon and weapon:HasTag("frost_hammer") and not weapon.boost then
			inst.components.combat:SetAreaDamage(2, .5)
			else
			inst.components.combat:SetAreaDamage(0, 0)
			end
			--inst.components.health:StartRegen(0, 0)
			--inst:RemoveEventCallback("onhitother", berserk_hit)
			--inst:RemoveEventCallback("attacked", On_freeze)		
			--inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.2)
			inst.components.health.fire_damage_scale = .75
			inst.berserk = false
			inst.valkyrie = false
			inst.normal =  true
			inst:RemoveEventCallback("attacked", On_frameshield_1)
			inst:RemoveEventCallback("attacked", On_frameshield_2)
			inst:RemoveEventCallback("attacked", On_frameshield_3)
			inst:RemoveEventCallback("attacked", On_frameshield_4)
			inst.valkyrie_turn = false
			inst.switch = false
			inst.berserk_armor_1 = false
			inst.berserk_armor_2 = false
			inst.berserk_armor_3 = false
	if not inst.lightaura then
if inst.easys then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end end
	
elseif inst.normals then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	end	end	
	
elseif inst.hards then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_SMALL)
	end	end		
	
elseif inst.hardscores then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_SMALL)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_MED)
	end	end			
	end 
	end
		--inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false
		if inst.visual_cos and not inst.musha_full then
		inst.AnimState:SetBuild("musha")
		inst.musha_full = true
		elseif not inst.visual_cos and not inst.change_visual and not inst.musha_full then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_full_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_full_sw2")
			end
		inst.musha_full = true
		end 
			end
	if inst.strength == "normal" then
			inst.soundsname = "willow"
			if weapon and weapon:HasTag("frost_hammer") and not weapon.boost then
			inst.components.combat:SetAreaDamage(2, .5)
			else
			inst.components.combat:SetAreaDamage(0, 0)
			end
			--inst.components.health:StartRegen(0, 0)
			--inst:RemoveEventCallback("onhitother", berserk_hit)
			--inst:RemoveEventCallback("attacked", On_freeze)					
			--inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
			inst.components.health.fire_damage_scale = .75
			inst.berserk = false
			inst.valkyrie = false
			inst.normal =  true
			inst:RemoveEventCallback("attacked", On_frameshield_1)
			inst:RemoveEventCallback("attacked", On_frameshield_2)
			inst:RemoveEventCallback("attacked", On_frameshield_3)
			inst:RemoveEventCallback("attacked", On_frameshield_4)
			inst.valkyrie_turn = false	
			inst.switch = false
			inst.berserk_armor_1 = false
			inst.berserk_armor_2 = false
			inst.berserk_armor_3 = false		
	if not inst.lightaura then		
	
if inst.easys then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_SMALL)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	end end
	
elseif inst.normals then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_SMALL)
	end end	

elseif inst.hards then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.SANITYAURA_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_MED)
	end end	

elseif inst.hardscores then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_SMALL)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_SMALL)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_MED_LARGE)
	end end	
	end
	end
		inst.musha_full = false
		--inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false
		if inst.visual_cos and not inst.musha_normal then
	inst.AnimState:SetBuild("musha_normal")
	inst.musha_normal = true
	elseif not inst.visual_cos and not inst.change_visual and not inst.musha_normal then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_normal_sw2")			
		end
		inst.musha_normal = true
		end
		end		
	if inst.strength == "valkyrie" then
			inst.soundsname = "willow"
			if weapon and weapon:HasTag("frost_hammer") and not weapon.boost then
			inst.components.combat:SetAreaDamage(2, .5)
			else
			inst.components.combat:SetAreaDamage(0, 0)
			end
			--inst.components.sanity.dapperness = (0)
			--inst:RemoveEventCallback("onhitother", berserk_hit)
			--inst:RemoveEventCallback("attacked", On_freeze)										
			--inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.5)
			inst.components.health.fire_damage_scale = 0
			inst.berserk = false
			inst.valkyrie = true
			inst.normal =  false
inst.components.combat:SetAttackPeriod(0.005)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.3 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.3 )		
			inst.berserk_armor_1 = false
			inst.berserk_armor_2 = false
			inst.berserk_armor_3 = false
	if not inst.lightaura then		
if inst.easys then
	if TheWorld.state.isday or TheWorld.state.iscaveday then
 	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED_LARGE)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	end end
 elseif inst.normals then	
 	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end end	
 elseif inst.hards then	
 	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_MED)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	end end		
 elseif inst.hardscores then	
 	if TheWorld.state.isday or TheWorld.state.iscaveday then
	if inst.warm_on then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_TINY)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (0)
	end
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	end
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	if inst.warm_on then
	inst.components.sanity.dapperness = (0)
	elseif not inst.warm_on then
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_TINY)
	end end 
	end
	end
		inst.musha_full = false
		inst.musha_normal = false
		--inst.musha_battle = false
		inst.musha_hunger = false
			if inst.visual_cos and not inst.musha_battle then
	inst.AnimState:SetBuild("musha_battle")
	inst.musha_battle = true
	elseif not inst.visual_cos and not inst.change_visual and not inst.musha_battle then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_battle")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_battle")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_battle_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_battle_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_battle_sw2")			
		end
		inst.musha_battle = true
			end	
			end		
	if inst.strength == "berserk" then
			inst.soundsname = "wendy"
			if weapon and weapon:HasTag("frost_hammer") and not weapon.boost then
			inst.components.combat:SetAreaDamage(4, .5)
			else
			inst.components.combat:SetAreaDamage(2.5, .5)
			end
			inst.components.combat:SetRange(2)
			--inst.components.health:StartRegen(1, 1)
			--inst:ListenForEvent("onhitother", berserk_hit)
			--inst.components.sanity.dapperness = (-TUNING.TUNING.DAPPERNESS_HUGE)
			--inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 2)
			inst.components.health.fire_damage_scale = 0
			inst.berserk = true
			inst.valkyrie = false
			inst.normal =  false
			inst.active_valkyrie = false
			inst.switch = false
			inst:RemoveEventCallback("attacked", On_frameshield_1)
			inst:RemoveEventCallback("attacked", On_frameshield_2)
			inst:RemoveEventCallback("attacked", On_frameshield_3)
			inst:RemoveEventCallback("attacked", On_frameshield_4)
			inst.valkyrie_turn = false
			inst.components.combat:SetAttackPeriod(0.001)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.2 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.2 )	
 			if inst.berserk_a_1 then
			inst.berserk_armor_1 = true
			elseif inst.berserk_a_2 then
			inst.berserk_a_1 = false
			inst.berserk_armor_2 = true
			elseif inst.berserk_a_3 then
			inst.berserk_a_2 = false
			inst.berserk_armor_3 = true
			end
	if not inst.lightaura then		
if inst.easys then	
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.5)
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.5)
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.5)
	end 
elseif inst.normals then	
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.3)
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.3)
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.3)
	end 
elseif inst.hards then	
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.1)
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.1)
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE*1.1)
	end 	
elseif inst.hardscores then	
	if TheWorld.state.isday or TheWorld.state.iscaveday then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE)
	elseif TheWorld.state.isdusk or TheWorld.state.iscavedusk then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE)
	elseif TheWorld.state.isnight or TheWorld.state.iscavenight then
	inst.components.sanity.dapperness = (TUNING.DAPPERNESS_HUGE)
	end 			
	
	end
	end
		inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		--inst.musha_hunger = false
	if inst.visual_cos and not inst.musha_hunger then
	inst.AnimState:SetBuild("musha_hunger")
	inst.soundsname = "wendy"
	inst.musha_hunger = true
	elseif not inst.visual_cos and not inst.change_visual and not inst.musha_hunger then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_hunger")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_hunger_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_hunger_sw2")	
			end
			inst.musha_hunger = true
	end
  end
    
--Armor  
if (inst.tiny_sleep or inst.sleep_on) then
inst.music_armor = true
inst.sleepbuff = true
inst:ShowHUD(true)
elseif not (inst.tiny_sleep or inst.sleep_on) then
inst.sleepbuff = false
elseif not (inst.tiny_sleep or inst.sleep_on) and not inst.nsleep then
inst.music_armor = false
end

if inst.music_armor then
	inst.components.health:SetAbsorptionAmount(1)
	if inst.sg:HasStateTag("moving") then 
	inst.music_armor = false
	end
elseif not inst.music_armor and not inst.on_sparkshield and not inst.berserk and not inst.valkyrie then	
	inst.components.health:SetAbsorptionAmount(0)
end 


if not (inst.sleep_on or inst.tiny_sleep) then
	if not inst.on_sparkshield and inst.berserk and inst.berserk_armor_1 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.15)
elseif not inst.on_sparkshield and inst.berserk and inst.berserk_armor_2 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.3)	
elseif not inst.on_sparkshield and inst.berserk and inst.berserk_armor_3 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.45)
	end	
	
	if not inst.on_sparkshield and inst.valkyrie and not (inst.valkyrie_armor_1 or inst.valkyrie_armor_2 or inst.valkyrie_armor_3 or inst.valkyrie_armor_4) and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.1)
elseif not inst.on_sparkshield and inst.valkyrie and inst.valkyrie_armor_1 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.1)
elseif not inst.on_sparkshield and inst.valkyrie and inst.valkyrie_armor_2 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.2)	
elseif not inst.on_sparkshield and inst.valkyrie and inst.valkyrie_armor_3 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.25)	
elseif not inst.on_sparkshield and inst.valkyrie and inst.valkyrie_armor_4 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.3)
end

	--[[if not inst.on_sparkshield and inst.f_attack and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.5)
	end]]
end
  	if not inst.on_sparkshield and not inst.berserk and not inst.valkyrie and not inst.music_armor --[[and not inst.f_attack]] then
	inst.components.health:SetAbsorptionAmount(0)
	end 

  
  --sleepy
if not inst.valkyrie and not inst.berserk and not inst.sleep_on and not inst.tiny_sleep then
--and not inst.No_Sleep_Princess then
if inst.stamina >= 95 then
inst.components.combat:SetAttackPeriod(0.005)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.15 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.2 )	

elseif inst.stamina < 95 and inst.stamina >= 90 then
inst.components.combat:SetAttackPeriod(0.01)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.12 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.15 )	

elseif inst.stamina < 90 and inst.stamina >= 85 then
inst.components.combat:SetAttackPeriod(0.05)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.1 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.1 )	

elseif inst.stamina < 85 and inst.stamina >= 80 then
inst.components.combat:SetAttackPeriod(0.1)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.05 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.05 )	

elseif inst.stamina < 80 and inst.stamina >= 75 then
inst.components.combat:SetAttackPeriod(0.15)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.0 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.0 )	

elseif inst.stamina < 75 and inst.stamina >= 70 then
inst.components.combat:SetAttackPeriod(0.2)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.0 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.0 )	

elseif inst.stamina < 70 and inst.stamina >= 65 then
inst.components.combat:SetAttackPeriod(0.25)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.98 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.98 )	

elseif inst.stamina < 60 and inst.stamina >= 55 then
inst.components.combat:SetAttackPeriod(0.3)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.96 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.96 )	

elseif inst.stamina < 55 and inst.stamina >= 50 then
inst.components.combat:SetAttackPeriod(0.35)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.94 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.94 )	

elseif inst.stamina < 50 and inst.stamina >= 45 then
inst.components.combat:SetAttackPeriod(0.4)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.92 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.92 )	

elseif inst.stamina < 40 and inst.stamina >= 35 then
inst.components.combat:SetAttackPeriod(0.45)
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.9 )
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.9)	

elseif inst.stamina < 35 and inst.stamina >= 30 then
inst.components.combat:SetAttackPeriod(0.5)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.85 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.85 )	

elseif inst.stamina < 30 and inst.stamina >= 25 then
inst.components.combat:SetAttackPeriod(0.55)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.8 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.8 )	

elseif inst.stamina < 25 and inst.stamina >= 20 then
inst.components.combat:SetAttackPeriod(0.6)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.75 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.75 )	

elseif inst.stamina < 20 and inst.stamina >= 15 then
inst.components.combat:SetAttackPeriod(0.65)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.7 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.7 )	

elseif inst.stamina < 15 and inst.stamina >= 10 then
inst.components.combat:SetAttackPeriod(0.7)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.65 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.65 )	

elseif inst.stamina < 10 and inst.stamina >= 5 then
inst.components.combat:SetAttackPeriod(0.75)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.6 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.6 )	

elseif inst.stamina < 5 and inst.stamina > 0 then
inst.components.combat:SetAttackPeriod(0.8)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.55 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.55 )	

elseif inst.stamina <= 0 then
inst.components.combat:SetAttackPeriod(0.9)
--inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED *0.5 )
--inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.5 )	
	 

end

local sleep_walker = (inst.sg:HasStateTag("running") or inst.sg:HasStateTag("moving")) 
local idle = (inst.sg:HasStateTag("idle")) 
if inst.stamina < 35 and inst.components.rider:IsRiding() then

	if inst:HasTag("groggy") and sleep_walker and not idle then
		inst:RemoveTag("groggy")
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.85 )	
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.85) 
		
	end
	if not inst:HasTag("groggy") and not sleep_walker and idle then
		inst:AddTag("groggy")	
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.55 )
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.55)
	end

elseif inst.stamina < 35 and inst.stamina >= 10 and not inst.components.rider:IsRiding() then
	if inst:HasTag("groggy") and sleep_walker and not idle then
		inst:RemoveTag("groggy")
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.85 )	
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.85) 
		
	end
	if not inst:HasTag("groggy") and not sleep_walker and idle then
		inst:AddTag("groggy")	
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.55 )
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.55)
	end
	
			
elseif inst.stamina < 10 and not inst.components.rider:IsRiding() then
local danger_sleep = FindEntity(inst, 9, function(target) 
                return (target:HasTag("monster") and not target:HasTag("player") and not inst:HasTag("spiderwhisperer"))
                    or (target:HasTag("monster") and not target:HasTag("player") and inst:HasTag("spiderwhisperer") and not target:HasTag("spider"))
                    or (target:HasTag("pig") and not target:HasTag("player") and inst:HasTag("spiderwhisperer"))
                    or (target.components.combat and target.components.combat.target == inst) end)
					
	
	if not danger_sleep then
		if not inst:HasTag("groggy") then
		inst:AddTag("groggy") end
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.5 )
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.5)
		
	elseif danger_sleep then 
		if inst:HasTag("groggy") and sleep_walker and not idle then
		inst:RemoveTag("groggy")
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.85 )	
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.85) 
		end
		if not inst:HasTag("groggy") and not sleep_walker and idle then
		inst:AddTag("groggy")	
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 0.55 )
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 0.55)
		end
	end
else	
	if inst:HasTag("groggy") then
	inst:RemoveTag("groggy")
	end
end

end
end


local function music_start(inst)
if not inst.SoundEmitter:PlayingSound("mushamusic") then
--local work1 = "dontstarve/music/music_work"
--local work2 = "dontstarve/music/music_work_winter"
--local work3 = "dontstarve_DLC001/music/music_work_spring"
--local work4 = "dontstarve_DLC001/music/music_work_summer"
local epicfight1 = "dontstarve/music/music_epicfight"
local epicfight2 = "dontstarve/music/music_epicfight_winter"
local epicfight3 = "dontstarve_DLC001/music/music_epicfight_spring"
local epicfight4 = "dontstarve_DLC001/music/music_epicfight_summer"
local danger1 = "dontstarve/music/music_danger"
local danger2 = "dontstarve/music/music_danger_winter"
local danger3 = "dontstarve_DLC001/music/music_danger_spring"
local danger4 = "dontstarve_DLC001/music/music_danger_summer"
local moonbase1 = "dontstarve/music/music_epicfight_moonbase"
local moonbase2 = "dontstarve/music/music_epicfight_moonbase_b"
local toadstool = "dontstarve/music/music_epicfight_toadboss"
local beequeen = "dontstarve/music/music_epicfight_4"
local dragonfly = "dontstarve/music/music_epicfight_3"
local shadowchess = "dontstarve/music/music_epicfight_ruins"
local klaus = "dontstarve/music/music_epicfight_5a"
local klaus2 = "dontstarve/music/music_epicfight_5b"
local antlion = "dontstarve/music/music_epicfight_antlion"
local stalker = "dontstarve/music/music_epicfight_stalker"
local stalker2 = "dontstarve/music/music_epicfight_stalker_b"
local default = "dontstarve/music/music_epicfight_ruins"

	
if math.random() < 0.15 then
inst.SoundEmitter:PlaySound("dontstarve/music/music_hoedown","mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 1")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(stalker,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 2")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(stalker2,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 3")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(antlion,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 4")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(epicfight1,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 5")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(epicfight2,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 6")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(epicfight3,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 7")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(epicfight4,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 8")
elseif math.random() < 0.1 then
inst.SoundEmitter:PlaySound(danger1,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 9")
elseif math.random() < 0.1 then
inst.SoundEmitter:PlaySound(danger2,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 10")
elseif math.random() < 0.1 then
inst.SoundEmitter:PlaySound(danger3,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 11")
elseif math.random() < 0.1 then
inst.SoundEmitter:PlaySound(danger4,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 12")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(moonbase1,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 13")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(moonbase2,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 14")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(toadstool,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 15")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(beequeen,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 16")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(dragonfly,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 17")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(shadowchess,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 18")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(klaus,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 19")
elseif math.random() < 0.2 then
inst.SoundEmitter:PlaySound(klaus2,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 20")

else
inst.SoundEmitter:PlaySound(default,"mushamusic")
inst.components.talker:Say("[Dynamic Music]\n:Random 24")
--[[
TheWorld:PushEvent("enabledynamicmusic", false)
if not inst.SoundEmitter:PlayingSound("beavermusic") then
inst.SoundEmitter:PlaySound("dontstarve/music/music_hoedown", "beavermusic")
end
]]
end

end
end
  local function DoEffects(pet)
    local x, y, z = pet.Transform:GetWorldPosition()
    SpawnPrefab("shadow_despawn").Transform:SetPosition(x, y, z)
    SpawnPrefab("statue_transition_2").Transform:SetPosition(x, y, z)
end

local function KillPet(pet)
    pet.components.health:Kill()
end

local function OnSpawnPet(inst, pet)
    if pet:HasTag("shadowminion") then
        --Delayed in case we need to relocate for migration spawning
        pet:DoTaskInTime(0, DoEffects)

        if not (inst.components.health:IsDead() or inst:HasTag("playerghost")) then
            inst.components.sanity:AddSanityPenalty(pet, TUNING.SHADOWWAXWELL_SANITY_PENALTY[string.upper(pet.prefab)])
            inst:ListenForEvent("onremove", inst._onpetlost, pet)
        elseif pet._killtask == nil then
            pet._killtask = pet:DoTaskInTime(math.random(), KillPet)
        end
    elseif inst._OnSpawnPet ~= nil then
        inst:_OnSpawnPet(pet)
    end
end

local function OnDespawnPet(inst, pet)
    if pet:HasTag("shadowminion") then
        DoEffects(pet)
        pet:Remove()
    elseif inst._OnDespawnPet ~= nil then
        inst:_OnDespawnPet(pet)
    end
end

local function ondeath(inst)
	for k, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("shadowminion") and v._killtask == nil then
            v._killtask = v:DoTaskInTime(math.random(), KillPet)
        end
    end
    inst.components.health.numrevives = 0
	--level 1
	if not inst.no_panalty then
if inst.level >0 and inst.level <5 then
	inst.level = inst.level - 1
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -1 ") end)
	levelexp(inst)
	
	--level 2
elseif inst.level >=5 and inst.level <10  then
	inst.level = inst.level - 3
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -3 ") end)
	levelexp(inst)
	
	--level 3
elseif inst.level >=10 and inst.level <30  then
	inst.level = inst.level - 6
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -6 ") end)
	levelexp(inst)
	
	--level 4
elseif inst.level >=30 and inst.level <50  then
	inst.level = inst.level - 9
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -9 ") end)

	levelexp(inst)
	
	--level 5
elseif inst.level >=50 and inst.level <80  then
	inst.level = inst.level - 12
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -12 ") end)
	levelexp(inst)
	
	--level 6
elseif inst.level >=80 and inst.level <125  then
	inst.level = inst.level - 16
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -16 ") end)
	levelexp(inst)
		
	--level 7
elseif inst.level >=125 and inst.level <200  then
	inst.level = inst.level - 20
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -20 ") end)
	levelexp(inst)
	
	--level 8
elseif inst.level >=200 and inst.level <340  then
	inst.level = inst.level - 24
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -24 ") end)
	levelexp(inst)
		
	--level 9
elseif inst.level >=340 and inst.level <430  then
	inst.level = inst.level - 28
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -28 ") end)
	levelexp(inst)
	
	--level 10
elseif inst.level >=430 and inst.level <530  then
	inst.level = inst.level - 32
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -32 ") end)
	levelexp(inst)
	
	--level 11
elseif inst.level >=530 and inst.level <640  then
	inst.level = inst.level - 37
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -37 ") end)
	levelexp(inst)
	
	--level 12
elseif inst.level >=640 and inst.level <760  then
	inst.level = inst.level - 42
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -42 ") end)
	levelexp(inst)
	
	--level 13
elseif inst.level >=760 and inst.level <890  then
	inst.level = inst.level - 47
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -47 ") end)
	levelexp(inst)
	
	--level 14
elseif inst.level >=890 and inst.level <1030  then
	inst.level = inst.level - 52
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -52 ") end)
	levelexp(inst)
	
	--level 15
elseif inst.level >=1030 and inst.level <1180  then
	inst.level = inst.level - 57
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -57 ") end)
	levelexp(inst)
	
	--level 16
elseif inst.level >=1180 and inst.level <1340  then
	inst.level = inst.level - 63
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -63 ") end)
	levelexp(inst)
	
	--level 17
elseif inst.level >=1340 and inst.level <1510  then
	inst.level = inst.level - 69
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -69 ") end)
	levelexp(inst)
	
	--level 18
elseif inst.level >=1510 and inst.level <1690  then
	inst.level = inst.level - 75
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -75 ") end)
	levelexp(inst)
	
	--level 19
elseif inst.level >=1690 and inst.level <1880  then
	inst.level = inst.level - 81
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -81 ") end)
	levelexp(inst)
	
	--level 20
elseif inst.level >=1880 and inst.level <2080  then
	inst.level = inst.level - 87
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -87 ") end)
	levelexp(inst)
	
	--level 21
elseif inst.level >=2080 and inst.level <2290  then
	inst.level = inst.level - 94
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -94 ") end)
	levelexp(inst)
	
	--level 22
elseif inst.level >=2290 and inst.level <2500  then
	inst.level = inst.level - 111
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -111 ") end)
	levelexp(inst)
	
	--level 23
elseif inst.level >=2500 and inst.level <2850  then
	inst.level = inst.level - 118
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -118 ") end)
	levelexp(inst)
	
	--level 24
elseif inst.level >=2850 and inst.level <3200  then
	inst.level = inst.level - 125
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -125 ") end)
	levelexp(inst)
	
	--level 25
elseif inst.level >=3200 and inst.level <3700  then
	inst.level = inst.level - 132
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -132 ") end)
	levelexp(inst)
	
	--level 26
elseif inst.level >=3700 and inst.level <4200  then
	inst.level = inst.level - 140
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -140 ") end)
	levelexp(inst)
	
	--level 27
elseif inst.level >=4200 and inst.level <4700  then
	inst.level = inst.level - 150
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -150 ") end)
	levelexp(inst)
	
	--level 28
elseif inst.level >=4700 and inst.level <5500 then
	inst.level = inst.level - 160
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -160 ") end)
	levelexp(inst)
	
	--level 29
elseif inst.level >=5500 and inst.level <7000 then
	inst.level = inst.level - 170
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -170 ") end)
	levelexp(inst)
	
	-- level 30
elseif inst.level >=7000  then
	inst.level = inst.level - 200
	inst:DoTaskInTime( 4.5, function() inst.components.talker:Say("[Death]\n[EXP] -200 ") end)
	levelexp(inst)
end end
end

local function onnewstate(inst)
    if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
        inst._wasnomorph = not inst._wasnomorph
        if not inst._wasnomorph then
            phasechange(inst)
        end
    end
end

local function onbecamehuman(inst)
    if inst._wasnomorph == nil then
        inst.strength = "normal"
        inst._wasnomorph = inst.sg:HasStateTag("nomorph")
        inst.talksoundoverride = nil
        inst.hurtsoundoverride = nil
        inst:ListenForEvent("hungerdelta", phasechange)
        inst:ListenForEvent("newstate", onnewstate)
        phasechange(inst, nil, true)
    end
end

local function onbecameghost(inst)
    if inst._wasnomorph ~= nil then
        inst.strength = "normal"
        inst._wasnomorph = nil
        inst.talksoundoverride = nil
        inst.hurtsoundoverride = nil
        inst:RemoveEventCallback("hungerdelta", phasechange)
        inst:RemoveEventCallback("newstate", onnewstate)
    end
end


local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


function onpreload(inst, data)
	if data ~= nil then
		if data.yamche_egg_hunted ~= nil then
		inst.yamche_egg_hunted = true
		end
		if data.arong_egg_hunted ~= nil then
		inst.arong_egg_hunted = true
		end
			if data.treasure ~= nil then
			inst.treasure = data.treasure
			treasure_hunt(inst)
			end
				if data.count_w ~= nil then
			inst.count_w = data.count_w
			count_wil(inst)
			end
				if data.music ~= nil then
			inst.music = data.music
			fullcharged_music(inst)
			end
				if data.stamina ~= nil then
			inst.stamina = data.stamina
			stamina_sleep(inst)
			end
				if data.fatigue ~= nil then
			inst.fatigue = data.fatigue
			fatigue_sleep(inst)
			end
				if data.level ~= nil then
			inst.level = data.level
			levelexp(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
			inst.components.sanity:DoDelta(0)
			end
if data.set_on then
inst.set_on = data.set_on end
if data.visual_hold  then
inst.visual_hold = data.visual_hold end
if data.visual_hold2  then
inst.visual_hold2 = data.visual_hold2 end
if data.visual_hold3  then
inst.visual_hold3 = data.visual_hold3 end
if data.visual_hold4  then
inst.visual_hold4 = data.visual_hold4 end
if data.full_hold  then
inst.full_hold = data.full_hold end
if data.normal_hold then
inst.normal_hold = inst.normal_hold end
if data.valkyrie_hold  then
inst.valkyrie_hold =  data.valkyrie_hold end
if data.berserk_hold  then
inst.berserk_hold =  data.berserk_hold end
if data.hold_old1  then
inst.hold_old1 =  data.hold_old1 end
if data.hold_old2  then
inst.hold_old2 =  data.hold_old2 end
if data.hold_old3  then
inst.hold_old3 =  data.hold_old3 end
if data.hold_old4  then
inst.hold_old4 =  data.hold_old4 end
if data.hold_old5  then
inst.hold_old5 =  data.hold_old5 end
if data.hold_old6  then
inst.hold_old6 =  data.hold_old6 end
if data.hold_old7  then
inst.hold_old7 =  data.hold_old7 end
if data.hold_old8  then
inst.hold_old8 =  data.hold_old8 end
if data.full_k_hold  then
inst.full_k_hold =  data.full_k_hold end
if data.normal_k_hold  then
inst.normal_k_hold =  data.normal_k_hold end
if data.valkyrie_k_hold  then
inst.valkyrie_k_hold =  data.valkyrie_k_hold end
if data.berserk_k_hold  then
inst.berserk_k_hold =  data.berserk_k_hold end
if data.willow  then
inst.willow =  data.willow end
if data.wigfred  then
inst.wigfred =  data.wigfred end
if data.change_visual  then
inst.change_visual =  data.change_visual end
	
			
	end
end  
 
function onsave(inst, data)

	data.level = inst.level > 0 and inst.level or nil
	data.stamina = inst.stamina or nil
	data.fatigue = inst.fatigue or nil
	data.music = inst.music or nil
	data.count_w = inst.count_w or nil
	data.treasure = inst.treasure or nil
	data.yamche_egg_hunted = inst.yamche_egg_hunted or nil
	data.arong_egg_hunted = inst.arong_egg_hunted or nil
	
data.set_on = inst.set_on
data.visual_hold = inst.visual_hold
data.visual_hold2 = inst.visual_hold2
data.visual_hold3 = inst.visual_hold3
data.visual_hold4 = inst.visual_hold4
data.full_hold = inst.full_hold
data.normal_hold = inst.normal_hold
data.valkyrie_hold =  inst.valkyrie_hold
data.berserk_hold =  inst.berserk_hold
data.hold_old1 =  inst.hold_old1
data.hold_old2 =  inst.hold_old2
data.hold_old3 =  inst.hold_old3
data.hold_old4 =  inst.hold_old4
data.hold_old5 =  inst.hold_old5
data.hold_old6 =  inst.hold_old6
data.hold_old7 =  inst.hold_old7
data.hold_old8 =  inst.hold_old8
data.full_k_hold =  inst.full_k_hold
data.normal_k_hold =  inst.normal_k_hold
data.valkyrie_k_hold =  inst.valkyrie_k_hold
data.berserk_k_hold =  inst.berserk_k_hold
data.willow =  inst.willow
data.wigfred =  inst.wigfred
data.change_visual =  inst.change_visual
	
end

--------------------------------------------------------------
local function musha_taste(inst)
	if not inst.full_state and inst.components.hunger.current > 180 then
	inst.full_state = true
	inst.normal_state = false
	inst.hungry_state = false
		if inst.princess_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, {FOODGROUP.BERRIES_AND_SEEDS})
		elseif not inst.princess_taste then
		if inst.normal_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI }, { FOODTYPE.MEAT, FOODTYPE.GOODIES }, { FOODTYPE.VEGGIE, FOODTYPE.GOODIES } )
		elseif inst.meat_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODTYPE.MEAT, FOODTYPE.GOODIES })
		elseif inst.veggie_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODTYPE.VEGGIE, FOODTYPE.GOODIES })
		end
		end
	inst.zero_hungry = false	
	elseif not inst.normal_state and inst.components.hunger.current <= 180 and inst.components.hunger.current > 0 then
	inst.full_state = false
	inst.normal_state = true
	inst.hungry_state = false
		if inst.normal_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI }, { FOODTYPE.MEAT, FOODTYPE.GOODIES }, { FOODTYPE.VEGGIE, FOODTYPE.GOODIES } )
		elseif inst.meat_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODTYPE.MEAT, FOODTYPE.GOODIES })
		elseif inst.veggie_taste then
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODTYPE.VEGGIE, FOODTYPE.GOODIES })
		end
	--inst.zero_hungry = false
	elseif not inst.hungry_state and inst.components.hunger.current <= 0 then
	inst.full_state = false
	inst.normal_state = false
	inst.hungry_state = true
		if not inst.zero_hungry then
			if inst.meat_taste then
			inst.components.talker:Say(".. can even eat a vegetables.")
			end
			if inst.veggie_taste then
			inst.components.talker:Say(".. can even eat a meat.")
			end
		inst.zero_hungry = true
		end
		inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI }, { FOODTYPE.MEAT, FOODTYPE.GOODIES }, { FOODTYPE.VEGGIE, FOODTYPE.GOODIES } )
	end
end

--------------------------------------------------------------
local function visual_hold(inst)
----------------------------------------------
if inst.change_visual and inst.willow and not inst.wigfred then
inst.components.talker:Say("[Visual] : Willow \nCancel(O)key")
inst.AnimState:SetBuild("Willow")
elseif inst.change_visual and inst.willow and inst.wigfred then
inst.components.talker:Say("[Visual] : Wigfred \nCancel(O)key")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("wathgrithr") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and not inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Full]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and not inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Normal]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_normal") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and not inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Valkyrie]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_battle") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Berserk]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_hunger") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 1]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_old") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 2]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_normal_old") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 3]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_battle_old") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 4]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_hunger_old") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 5]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_full_sw2") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 6]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_normal_sw2") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 7]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_battle_sw2") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 8]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_hunger_sw2") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 9]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_full_k") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 10]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_normal_k") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 11]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_battle_k") end)
elseif not inst.change_visual and inst.willow and inst.wigfred and inst.set_on and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 12]")
inst:DoTaskInTime( 3, function() inst.AnimState:SetBuild("musha_hunger_k") end)
end 
end

-- This initializes for both clients and the host
local function common_postinit (inst,stamina) 

	inst.soundsname = "willow"
	inst.MiniMapEntity:SetIcon( "musha_mapicon.tex" )
	inst:AddTag("bookbuilder")
	inst:AddTag("shadowmagic")
	inst:AddTag("dappereffects")
	inst:AddTag("musha")
	--inst:AddTag("handyperson")
	--inst:AddTag("fastbuilder")
	--inst:AddTag("balloonomancer")
		
    inst.entity:AddLight()
	inst.Light:SetRadius(2.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.8)
    inst.Light:SetColour(150/255,150/255,150/255)
	inst.entity:AddLightWatcher()
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY, "INFO")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY5, "INFO2")
    inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY2, "Lightning_a")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY3, "on_shield_act")
	--inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY16, "taunt")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY4, "buff")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY6, "yamche")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY7, "visual_hold")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY15, "visual_cos")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY8, "yamche2")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY9, "yamche3")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY10, "ydebug")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY11, "shadows")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY12, "sleeping")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY13, "arong")
	inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.KEY14, "dall")
	
	inst:AddComponent("sanityaura")
	--inst:AddComponent("colourtweener")

			
	
	visual_hold(inst)
end

local function master_postinit(inst)

--inst.visual_cos = true
		inst.level = 0
		inst.stamina = 100 
		inst.fatigue = 0
		inst.music = 0
		inst.count_w = 50
		inst.treasure = 95
-----------
if inst.components.petleash ~= nil then
        inst._OnSpawnPet = inst.components.petleash.onspawnfn
        inst._OnDespawnPet = inst.components.petleash.ondespawnfn
        inst.components.petleash:SetMaxPets(inst.components.petleash:GetMaxPets() + 4)
    else
        inst:AddComponent("petleash")
        inst.components.petleash:SetMaxPets(4)
    end
    inst.components.petleash:SetOnSpawnFn(OnSpawnPet)
    inst.components.petleash:SetOnDespawnFn(OnDespawnPet)

    inst._onpetlost = function(pet) inst.components.sanity:RemoveSanityPenalty(pet) end
   
-----------
	--------------------------
	inst.components.health:SetMaxHealth(80)
	inst.components.sanity:SetMax(80)
	inst.components.hunger:SetMax(200)
	
	inst.components.temperature.hurtrate = 0.5
	
	inst.components.eater:SetOnEatFn(expeat)
	inst.components.eater.stale_hunger = TUNING.WICKERBOTTOM_STALE_FOOD_HUNGER
    inst.components.eater.stale_health = TUNING.WICKERBOTTOM_STALE_FOOD_HEALTH
    inst.components.eater.spoiled_hunger = TUNING.WICKERBOTTOM_SPOILED_FOOD_HUNGER
    inst.components.eater.spoiled_health = TUNING.WICKERBOTTOM_SPOILED_FOOD_HEALTH
		
	inst:ListenForEvent("hungerdelta", musha_taste)
	inst:ListenForEvent("killed", onkilll)
	inst:ListenForEvent("death", ondeath)
	inst:ListenForEvent("levelup", levelexp)

	--inst.Transform:SetScale(0.95,0.95,0.95)

    inst._wasnomorph = nil
    inst.talksoundoverride = nil
    inst.hurtsoundoverride = nil

	--inst.components.eater.strongstomach = true

	inst.components.talker.fontsize = 28
	inst:AddComponent("reader")
	--inst.components.builder.science_bonus = 1

inst.sleep_on = false
inst.tiny_sleep = false
phasechange(inst)	
--[[
inst:WatchWorldState("daytime", function(inst) phasechange(inst) end , TheWorld)
inst:WatchWorldState("dusktime", function(inst) phasechange(inst) end , TheWorld)
inst:WatchWorldState("nighttime", function(inst) phasechange(inst) end , TheWorld)
]]
	
--inst:ListenForEvent("attacked", on_shard_shield)
inst.sleep_test = inst:DoPeriodicTask(0, sleep_test)
inst.consume_sleep1 = inst:DoPeriodicTask(1, consume_stamina)
inst.on_fatigue = inst:DoPeriodicTask(1, on_fatigue)
inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
inst.sleepheal = inst:DoPeriodicTask(5,onsleepheal)
inst.summon_drake = inst:DoPeriodicTask(6,summon_drake)
inst.light_call = inst:DoPeriodicTask(0,light_call)
inst.summon_lighting = inst:DoPeriodicTask(15,summon_lighting)
inst.Call_lightining_defense = function(attacked, data)
 local hitcall = 0.5
if inst.LightWatcher:IsInLight() and data and data.attacker and math.random() < hitcall --[[and data.attacker.components.burnable]] and not inst.fberserk and not inst.berserks and data.attacker.components.health and not data.attacker.components.health:IsDead() and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and not data.attacker:HasTag("burn") and not data.attacker:HasTag("groundspike") and data.attacker.components.locomotor and inst.components.sanity.current >= 10 then
		data.attacker:AddTag("burn") 
		SpawnPrefab("sparks").Transform:SetPosition(data.attacker:GetPosition():Get())
		-- data.attacker.burn = true
end end	 
inst:ListenForEvent( "attacked", inst.Call_lightining_defense,inst)
inst:ListenForEvent( "onhitother", Call_lightining_attack)
inst.Call_lightining_check = inst:DoPeriodicTask(0.5,Call_lightining_check)
inst.Call_lightining_debuff = inst:DoPeriodicTask(0,Call_lightining_debuff)
inst.berserk_changer = inst:DoPeriodicTask(1,berserk_changer)
--MyPrecious(inst) 
--musha_egghunt_pass(inst)

--sleep hit
inst.wakefn = function(attacked, data)
if data and data.attacker and (inst.sleep_on or inst.tiny_sleep) then
	inst.sleep_on = false
	inst.tiny_sleep = false
	inst.sg:GoToState("wakeup")
	inst.musha_press = false
	inst:DoTaskInTime( 1, function() inst.music_armor = false end)
  end 
end
inst:ListenForEvent("attacked", inst.wakefn, inst)

if not inst.no_bodyguard then
inst.guardianfn = function() guard(inst) end
        inst:ListenForEvent("attacked", inst.guardianfn)
end
		
inst.time_perfomance = inst:DoPeriodicTask(3,function()
		if TheWorld.state.isfullmoon and TheWorld.state.isnight then
		inst.components.sanity:DoDelta(1)

	end 
	end)
	
inst.time_perfomance = inst:DoPeriodicTask(1.2,function()
	if inst.charging_music and inst.music < 100 then
	
	if inst.dmusic_veasy then
inst.music = inst.music + 2
  elseif inst.dmusic_easy then
inst.music = inst.music + 1.5  
  elseif inst.dmusic_normal then
inst.music = inst.music + 1  
  elseif inst.dmusic_hard then
inst.music = inst.music + 0.5
  elseif inst.dmusic_hardcore then
inst.music = inst.music + 0.25
	end

		fullcharged_music(inst)
	
	end	
	end)

inst.check_sleeping = inst:DoPeriodicTask(2, function()
			if (inst.sleep_on or inst.tiny_sleep) and not inst.sg:HasStateTag("tent") then
	local max_stamina = 100
	local min_stamina = 0
	local max_fatigue = 100
	local min_fatigue = 0	
	local max_music = 100
	local min_music = 0	
			local mx=math.floor(max_stamina-min_stamina)
			local cur=math.floor(inst.stamina-min_stamina)
			local mx2=math.floor(max_fatigue-min_fatigue)
			local cur2=math.floor(inst.fatigue-min_fatigue)
			local mxx=math.floor(max_music-min_music)
			local curr=math.floor(inst.music-min_music)
			local sleep = ""..math.floor(cur*100/mx).."%"
			local sleepy = ""..math.floor(cur2*100/mx2).."%"
			local musics = ""..math.floor(curr*100/mxx).."%"
inst.components.talker:StopIgnoringAll("sleeping")	
    inst.components.talker.fontsize = 22
  --  inst.components.talker.colour = Vector3(0.75, 0.85, 1, 1)
inst.components.talker:Say("[Sleep / Tired]\n"..(sleep).." / "..(sleepy).."\n[Music]: "..(musics))
	end	
	end)	


inst.check_status = inst:DoPeriodicTask(30, function()
if (inst.stamina <60 or inst.fatigue > 40) and not (inst.sleep_on and inst.tiny_sleep and inst.sg:HasStateTag("moving") and inst.sg:HasStateTag("attack") and inst.sg:HasStateTag("hit")) and not inst.components.health:IsDead() then
	local max_stamina = 100		local min_stamina = 0
	local max_fatigue = 100		local min_fatigue = 0	
	local mx=math.floor(max_stamina-min_stamina)
	local cur=math.floor(inst.stamina-min_stamina)
	local mx2=math.floor(max_fatigue-min_fatigue)
	local cur2=math.floor(inst.fatigue-min_fatigue)
	local sleep = ""..math.floor(cur*100/mx).."%"
	local sleepy = ""..math.floor(cur2*100/mx2).."%"
	if not inst.keep_check then		
	inst.keep_check = true
	end
	--inst.sg:AddStateTag("notalking")			
inst.components.talker:Say("[Sleep / Tired]\n"..(sleep).." / "..(sleepy).."\n")
inst:DoTaskInTime( 0.25, function()
if inst.keep_check then
inst.keep_check = false
--inst.sg:RemoveStateTag("notalking") 
end end)

	end	
	end)	
	
inst.Valkyrie_all = inst:DoPeriodicTask(0, on_Valkyrie_all)
inst.phasechange = inst:DoPeriodicTask(0, phasechange)
--inst.active_sparkshield = inst:DoPeriodicTask(0, function() active_sparkshield(inst) end)
inst:ListenForEvent("hungerdelta", hungrycheck)
inst:ListenForEvent("hungerdelta", active_sparkshield)
inst:ListenForEvent("hungerdelta", flameshield_active)

	---berserk passive skill
inst:ListenForEvent("onhitother", berserk_hit)

inst.On_freeze = function(attacked, data)
--local attacker = data.attacker
if inst.berserk and data.attacker and data.attacker.components.freezable and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and not data.attacker.freezy then
	        data.attacker.components.freezable:AddColdness(0.5)
            data.attacker.components.freezable:SpawnShatterFX()
			data.attacker.freezy = true
  end 
end
inst:ListenForEvent("attacked", inst.On_freeze, inst)

inst.on_shard_freeze = function(attacked, data)
--local attacker = data.attacker
local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if data.attacker and not data.attacker:HasTag("thorny") and not data.attacker:HasTag("shadowcreature") and data.attacker.components.health then
if weapon and weapon:HasTag("frost_hammer") then
	if inst.f_attack and data.attacker and data.attacker.components.freezable then
	local prefab = "icespike_fx_"..math.random(1,4)
    local fx = SpawnPrefab(prefab)
    local shards = math.random(0.75,1.25)
 	fx.Transform:SetScale(shards, shards, shards)
	fx.Transform:SetPosition(data.attacker:GetPosition():Get())
	
            data.attacker.components.freezable:AddColdness(0.4)
            data.attacker.components.freezable:SpawnShatterFX()
    end 
end	
	if data.attacker.components.burnable and data.attacker.components.burnable:IsBurning() then
        data.attacker.components.burnable:Extinguish()
    end
end		
end
	
inst:ListenForEvent("attacked", inst.on_shard_freeze, inst)

moon_berserk(inst)
inst:WatchWorldState("isfullmoon", moon_berserk)

-------------

	inst.usedtrails = {}
    inst.availabletrails = {}
    for i = 1, MAX_TRAIL_VARIATIONS do
        table.insert(inst.availabletrails, i)
    end

    inst._blooming = false
    inst.DoTrail = DoTrail
    inst.StartBlooming = StartBlooming
    inst.StopBlooming = StopBlooming
    inst.OnEntityWake = ForestOnEntityWake
    inst.OnEntitySleep = ForestOnEntitySleep
    --StartBlooming(inst)
	
	inst.check_aura = inst:DoPeriodicTask(2, function()	
	
	if inst.lightaura then
		
		if inst.components.temperature ~= nil then
		if  inst.components.temperature:GetCurrent() < 5 then
            inst.components.temperature:SetTemperature(inst.components.temperature:GetCurrent() + 2)
        elseif inst.components.temperature:GetCurrent() > 45 then
            inst.components.temperature:SetTemperature(inst.components.temperature:GetCurrent() - 2)
        end
		end
		
		StartBlooming(inst)
		
		if not inst.music_q then
		inst.SoundEmitter:KillSound("mushamusic")
		inst.music_q = true
        --TheWorld:PushEvent("enabledynamicmusic", false)
		music_start(inst)
   
		end
     
    else
		StopBlooming(inst)
		if inst.music_q then
		inst.music_q = false
		--TheWorld:PushEvent("enabledynamicmusic", true)
		inst.keep_check = true	
		inst.components.talker:Say("[Dynamic Music]\n:OFF")
		inst.SoundEmitter:KillSound("mushamusic")
			inst:DoTaskInTime( 0.5, function() if inst.keep_check then
			inst.keep_check = false end end)
		end
	end
	end)	
-------------
inst.normal_health_regen = inst:DoPeriodicTask(0.5, function() 

if inst.on_sparkshield --[[and not inst.sleepbuff]] and not inst.components.health:IsDead() then
	if not inst.shr then
	inst.regen_switch = false
	end
inst.shr = true
inst.sshr = false
inst.nhr = false
inst.bhr = false
inst.vhr = false
	if not inst.regen_switch then
	inst.regen_switch = true
	inst.components.health:StartRegen(1, 0.2)
	end

--[[elseif not inst.on_sparkshield and inst.sleepbuff and not inst.components.health:IsDead() then
	if not inst.sshr then
	inst.regen_switch = false
	end
inst.shr = false
inst.sshr = true
inst.nhr = false
inst.bhr = false
inst.vhr = false
	if not inst.regen_switch then
	inst.regen_switch = true
	if inst.sleep_on then
	inst.components.health:StartRegen(1, 5)
	elseif inst.tiny_sleep then
	inst.components.health:StartRegen(1, 12)
	end	
	end]]

	
elseif not inst.on_sparkshield --[[and not inst.sleepbuff]] and not inst.components.health:IsDead() then
	if inst.normal and not inst.valkyrie and not inst.berserk then 
	if not inst.nhr then
	inst.regen_switch = false
	end
inst.shr = false
inst.sshr = false
inst.nhr = true
inst.bhr = false
inst.vhr = false
	if not inst.regen_switch then
	inst.regen_switch = true
	inst.components.health:StartRegen(0, 0)
	end
	
	elseif not inst.normal and inst.valkyrie and not inst.berserk then 
	if not inst.vhr then
	inst.regen_switch = false
	end
inst.shr = false
inst.sshr = false
inst.nhr = false
inst.bhr = false
inst.vhr = true
	if not inst.regen_switch then
	inst.regen_switch = true
	if inst.on_Valkyrie_1 then
inst.components.health:StartRegen(1, 8)
elseif inst.on_Valkyrie_2 then
inst.components.health:StartRegen(1, 8)
elseif inst.on_Valkyrie_3 then
inst.components.health:StartRegen(1, 7)
elseif inst.on_Valkyrie_4 then
inst.components.health:StartRegen(1, 7)
elseif inst.on_Valkyrie_5 then
inst.components.health:StartRegen(1, 6)
elseif inst.on_Valkyrie_6 then
inst.components.health:StartRegen(1, 6)
elseif inst.on_Valkyrie_7 then
inst.components.health:StartRegen(1, 6)
elseif inst.on_Valkyrie_8 then
inst.components.health:StartRegen(1, 6)
elseif inst.on_Valkyrie_9 then
inst.components.health:StartRegen(1, 5)
elseif inst.on_Valkyrie_10 then
inst.components.health:StartRegen(1, 5)
elseif inst.on_Valkyrie_11 then
inst.components.health:StartRegen(1, 5)
elseif inst.on_Valkyrie_12 then
inst.components.health:StartRegen(1, 5)
elseif inst.on_Valkyrie_13 then
inst.components.health:StartRegen(1, 5)
elseif inst.on_Valkyrie_14 then
inst.components.health:StartRegen(1, 4)
	else
inst.components.health:StartRegen(1, 8)	
	end	
	end
	
	elseif not inst.normal and not inst.valkyrie and inst.berserk then 
	if not inst.bhr then
	inst.regen_switch = false
	end
inst.shr = false
inst.sshr = false
inst.nhr = false
inst.bhr = true
inst.vhr = false
	if not inst.regen_switch then
	inst.regen_switch = true
	if inst.berserk_a_1 then
	inst.components.health:StartRegen(1, 3)
	elseif inst.berserk_a_2 then
	inst.components.health:StartRegen(1, 2)
	elseif inst.berserk_a_3 then
	inst.components.health:StartRegen(1, 1)
	else
	inst.components.health:StartRegen(1, 3)
	end
	end
	
	end
end
end)
		
	levelexp(inst)
	stamina_sleep(inst)
	fatigue_sleep(inst)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload


    return inst
end

return MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit, start_inv)

	
	
	
	
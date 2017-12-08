local brain = require "brains/dallbrain"
--require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/leif_walking.zip"),
    Asset("ANIM", "anim/leif_actions.zip"),
    Asset("ANIM", "anim/leif_attacks.zip"),
    Asset("ANIM", "anim/leif_idles.zip"),
 --   Asset("ANIM", "anim/leif_build.zip"),
 --   Asset("ANIM", "anim/leif_lumpy_build.zip"),
    Asset("SOUND", "sound/leif.fsb"),
	 Asset("ANIM", "anim/leif_moon_build.zip"),
	Asset("ANIM", "anim/leif_moon_spring_build.zip"),
	Asset("ANIM", "anim/leif_moon_fall_build.zip"),
	Asset("ANIM", "anim/leif_moon_winter_build.zip"),
}

local prefabs =
{
     "livinglog",
	 "musha_egg_arong",
}

local function ondeath(inst)
SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())

if inst.components.container then
inst.components.container:DropEverything() 
SpawnPrefab("musha_egg_arong").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("livinglog").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("livinglog").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("livinglog").Transform:SetPosition(inst:GetPosition():Get())
end 	
end

---------------------------
local function levelexp(inst,data)

	local max_exp = 99999999999999993000
	local exp = math.min(inst.level, max_exp)
	local health_percent = inst.components.health:GetPercent()

inst.components.health.maxhealth = math.ceil (800 + exp* 2)
inst.components.talker:Say("[Max Health]\n".. (inst.level*2 +800))
inst.components.health:SetPercent(health_percent)
if inst.level <= 10 then
inst.level1 = true
inst.Transform:SetScale(.7, .7, .7)
elseif inst.level > 10 and inst.level <= 20 then
inst.level1 = false
inst.level2 = true
inst.Transform:SetScale(.75, .75, .75)
elseif inst.level > 20 and inst.level <= 30 then
inst.level2 = false
inst.level3 = true
inst.Transform:SetScale(.8, .8, .8)
elseif inst.level > 30 and inst.level <= 40 then
inst.level3 = false
inst.level4 = true
inst.Transform:SetScale(.85, .85, .85)
elseif inst.level > 40 and inst.level <= 50 then
inst.level4 = false
inst.level5 = true
inst.Transform:SetScale(.9, .9, .9)
elseif inst.level > 50 and inst.level <= 70 then
inst.level5 = false
inst.level6 = true
inst.Transform:SetScale(.95, .95, .95)
elseif inst.level > 70 and inst.level <= 90 then
inst.level6 = false
inst.level7 = true
inst.Transform:SetScale(1, 1, 1)
elseif inst.level > 90 and inst.level <= 120 then
inst.level7 = false
inst.level8 = true
inst.Transform:SetScale(1.1, 1.1, 1.1)
elseif inst.level > 120 and inst.level <= 150 then
inst.level8 = false
inst.level9 = true
inst.Transform:SetScale(1.15, 1.15, 1.15)
elseif inst.level > 150 and inst.level <= 180 then
inst.level9 = false
inst.level10 = true
inst.Transform:SetScale(1.2, 1.2, 1.2)
elseif inst.level > 180 and inst.level <= 210 then
inst.level10 = false
inst.level11 = true
inst.Transform:SetScale(1.25, 1.25, 1.25)
elseif inst.level > 210 and inst.level <= 250 then
inst.level11 = false
inst.level12 = true
inst.Transform:SetScale(1.3, 1.3, 1.3)
elseif inst.level > 250 and inst.level <= 300 then
inst.level12 = false
inst.level13 = true
inst.Transform:SetScale(1.35, 1.35, 1.35)
elseif inst.level > 300 and inst.level <= 400 then
inst.level13 = false
inst.level14 = true
inst.Transform:SetScale(1.4, 1.4, 1.4)
elseif inst.level > 400 and inst.level <= 500 then
inst.level14 = false
inst.level15 = true
inst.Transform:SetScale(1.45, 1.45, 1.45)
elseif inst.level > 500 then
inst.level15 = true
inst.levelmax = true
inst.Transform:SetScale(1.5, 1.5, 1.5)
	end end
	
 
 local function forgelab(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 6, {"musha_items"})
for k,v in pairs(ents) do
 v.forgelab_on = true
 end end
 
 
--level?
local function Checklevel(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 12, {"musha"})
for k,v in pairs(ents) do
if inst.yamcheinfo then
inst.components.talker:Say("[EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
if inst.level <= 10 then
inst.components.talker:Say("[Level]: 1  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 10 and inst.level <= 20 then
inst.components.talker:Say("[Level]: 2  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 20 and inst.level <= 30 then
inst.components.talker:Say("[Level]: 3  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 30 and inst.level <= 40 then
inst.components.talker:Say("[Level]: 4  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 40 and inst.level <= 50 then
inst.components.talker:Say("[Level]: 5  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 50 and inst.level <= 70 then
inst.components.talker:Say("[Level]: 6  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 70 and inst.level <= 90 then
inst.components.talker:Say("[Level]: 7  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 90 and inst.level <= 120 then
inst.components.talker:Say("[Level]: 8  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 120 and inst.level <= 150 then
inst.components.talker:Say("[Level]: 9  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 150 and inst.level <= 180 then
inst.components.talker:Say("[Level]: 10  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 180 and inst.level <= 210 then
inst.components.talker:Say("[Level]: 11  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 210 and inst.level <= 250 then
inst.components.talker:Say("[Level]: 12  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 250 and inst.level <= 300 then
inst.components.talker:Say("[Level]: 13  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 300 and inst.level <= 400 then
inst.components.talker:Say("[Level]: 14  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 400 and inst.level <= 500 then
inst.components.talker:Say("[Level]: 15  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 500 then
inst.components.talker:Say("[Level]: 16 \n[Max Health]\n".. (inst.level*2 +800))
end
    inst.yamcheinfo = false 
end
end end
	
	
local smallllchance = 0.45
local normalchance = 0.85
local largechance = 1

local function onkilll(inst, data)
	local victim = data.victim
	if not victim:HasTag("smashable") then
	    if not (victim:HasTag("prey") or
            victim:HasTag("veggie") or
            victim:HasTag("eyeplant") or
            victim:HasTag("insect") or			
            victim:HasTag("structure")) then
		   if math.random() < normalchance then
					inst.level = inst.level + 1
 					if victim:HasTag("monster1x") then
					--inst.level = inst.level + 1
					elseif victim:HasTag("monster2x") then
					inst.level = inst.level + 1
						if math.random() < 0.09 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end	
					elseif victim:HasTag("monster3x") then
					inst.level = inst.level + 2
						if math.random() < 0.12 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("monster4x") then
					inst.level = inst.level + 3
						if math.random() < 0.15 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					end 
					levelexp(inst)
					end
					end
		 if (victim:HasTag("epic") or victim:HasTag("deerclops") or 
			 victim:HasTag("bearger") or victim:HasTag("moose") or 
							  victim:HasTag("dragonfly")  ) then
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
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.2 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant2x") then
					inst.level = inst.level + 20
					inst.components.talker:Say("Kill Giant\n [EXP] + 20 ")
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
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
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
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
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
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
  					end					
		  if (victim:HasTag("prey") or victim:HasTag("insect") or victim:HasTag("frog")) then
			if math.random() < normalchance then
    				inst.level = inst.level + 1
					levelexp(inst)
					end					
			end
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
   -- inst.sg:GoToState("panic")
	if not inst.sleep_on and inst.AnimState:AnimDone() then
	  inst.sg:GoToState("panic")
	end
    --if inst.components.sleeper:IsAsleep() then
    --    inst.components.sleeper:WakeUp()
   -- end
end

local function OnEat(inst, food)
local poopchance2 = 0.6
local poopchance = 0.4
local rebackchance = 0.2
local tynychance = 0.1
local eggchance = 1.0
    local full = inst.components.hunger:GetPercent() >= 1
    if not full then
  --inst.sg:GoToState("eat")
  inst.sg:GoToState("hit")
  inst.components.hunger:DoDelta(15)
  	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())	
     end
 
if food.components.edible.hungervalue == 150 and food.components.edible.healthvalue == 100 then 
	inst.level = inst.level + 80
	levelexp(inst)
inst.components.health:DoDelta(300)
inst.components.hunger:DoDelta(150)
inst.components.talker:Say(" !!!!!!!!!! \n[Max Health] + 80 ")

end

    -- food heal
    if inst:HasTag("companion") then
        inst.components.health:DoDelta(inst.components.health.maxhealth * .05, nil, food.prefab)
        inst.components.combat:SetTarget(nil)
    else
        inst.components.health:DoDelta(inst.components.health.maxhealth, nil, food.prefab)
    end
    
    if food.components.edible and (food.components.edible.hungervalue > 100 and food.components.edible.healthvalue > 91) then
inst.components.health:DoDelta(150)
inst.components.hunger:DoDelta(50)
inst.level = inst.level + 15
levelexp(inst)
     		local fx = SpawnPrefab("poopcloud")
	fx.Transform:SetScale(0.5, 0.5, 0.5)
	fx.Transform:SetPosition(inst:GetPosition():Get())
	if math.random() < poopchance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
    elseif math.random() < poopchance then
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
      elseif math.random() < tynychance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
	end
	end

    if food.components.edible and (food.components.edible.hungervalue > 49 or food.components.edible.healthvalue > 39) then
inst.components.health:DoDelta(100)
inst.components.hunger:DoDelta(30)
		inst.level = inst.level + 8
		levelexp(inst)
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
      elseif math.random() < tynychance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
	end
	end

    if food.components.edible and (food.components.edible.hungervalue > 24 or food.components.edible.healthvalue > 29 or food.components.edible.sanityvalue > 14) then
inst.components.health:DoDelta(50)
inst.components.hunger:DoDelta(15)
    if math.random() < poopchance then
		inst.level = inst.level + 4
		levelexp(inst)
	end
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
      elseif math.random() < tynychance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())		
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
local function ShouldWakeUp(inst)
    return not inst.sleep_on
end
local function DallSleepTest(inst)
    --return not inst.components.rideable:IsBeingRidden() and DefaultSleepTest(inst)
	return (inst.sleep_on or inst.onsleep)
	
end
local function OnOpen(inst)
    if not inst.components.health:IsDead() then
		inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
if not inst.sleep_on then
inst.sg:GoToState("hit")
	SpawnPrefab("green_leaves_chop").Transform:SetPosition(inst:GetPosition():Get())	
elseif inst.sleep_on then
 	SpawnPrefab("green_leaves_chop").Transform:SetPosition(inst:GetPosition():Get())	
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
 
if not inst.sleep_on then
inst.sg:GoToState("hit")
	SpawnPrefab("pine_needles_chop").Transform:SetPosition(inst:GetPosition():Get())
elseif inst.sleep_on then
	SpawnPrefab("pine_needles_chop").Transform:SetPosition(inst:GetPosition():Get())
end
    end
end 

local function OnHitnature(inst, data)
local other = data.target
 			
if other and other:HasTag("musha") then
	inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()

    end
end

local function Retarget(inst)
     local dist = 15
	 local leader = inst.components.follower.leader
    if not inst.sleep_on and inst.components.follower and inst.components.follower.leader and leader.components.health:GetPercent() <= .3 then
 --[[ if not inst.active_hunt then
  if inst.hunt then
  inst.components.talker:Say("[(..Defense..)]")
  inst.hunt = false
  end end
    if inst.active_hunt then
	if not inst.hunt then
	inst.components.talker:Say("[(..Attack..)]")
	inst.hunt = true
	end]]
    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
      {"musha","player","wall","houndmound","structure","companion","yamche","beefalo","koalefant","arongb","pig","bee","rocky","webber","bird","koalefant","beefalo","koalefant","moondrake","prey","statue","character","abigail","smashable","veggie"})
	 
	end
end 	

local function anti_monkey(inst)
if inst.anti_monkey then
inst:DoTaskInTime(6, function() inst.anti_monkey = false inst.components.container.canbeopened = true end)

end end

local function on_follow(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 2, {"monkey"})
for k,v in pairs(ents) do
if not inst.sleep_on and not inst.anti_monkey then
inst.anti_monkey = true
inst.yamche = true
inst.components.container.canbeopened = false
inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/transform_VO")
anti_monkey(inst)
end end

local leader = inst.components.follower.leader
 if TheWorld.state.isday then
 inst.auto_exp = true
 inst.stop_day = false
 inst.stop_dusk = true
 inst.stop_night = true
 inst.moonregen = false
	if inst.components.hunger:GetPercent() >= 0.1 then
	inst.onsleep = false inst.hungry = false 
	elseif inst.components.hunger:GetPercent() < 0.05 and inst.components.follower and inst.components.follower.leader then
		if not inst.hungry then
	inst.components.talker:Say("[(..Hungry..)]")
	inst.hungry = true
	inst.onsleep = true	
    leader.follow_dall = false
	leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	inst.sleep_on = true
inst.sg:GoToState("sleeping")
	end
	end
  elseif TheWorld.state.isdusk then
   inst.auto_exp = true
   inst.stop_day = true
 inst.stop_dusk = false
 inst.stop_night = true
  inst.moonregen = false
    inst.shapechange = false
	if inst.components.hunger:GetPercent() >= 0.1 then
	inst.onsleep = false inst.hungry = false
	elseif inst.components.hunger:GetPercent() < 0.05 and inst.components.follower and inst.components.follower.leader then
		if not inst.hungry then
	inst.components.talker:Say("[(..Hungry..)]")
	inst.hungry = true
	inst.onsleep = true	
    leader.follow_dall = false
	leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	inst.sleep_on = true
inst.sg:GoToState("sleeping")
	end
	end
  elseif TheWorld.state.isnight then
  if inst.auto_exp then
  inst.level = inst.level + 1
  inst.auto_exp = false
  end
   inst.stop_day = true
 inst.stop_dusk = true
 inst.stop_night = false
  inst.shapechange = false
  	if inst.components.hunger:GetPercent() >= 0.1 then
	inst.onsleep = false inst.hungry = false
  	elseif inst.components.hunger:GetPercent() < 0.05 and inst.components.follower and inst.components.follower.leader then
		if not inst.hungry then
	inst.components.talker:Say("[(..Hungry..)]")
	inst.hungry = true
	inst.onsleep = true	
    leader.follow_dall = false
	leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	inst.sleep_on = true
inst.sg:GoToState("sleeping")
	end
	end
	--if inst.components.sleeper:IsAsleep() then
	--	 inst.onsleep = true
	--	 end
if inst.onsleep then		 
	 if inst.components.follower and inst.components.follower.leader then
	 leader.follow_dall = false
	 leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	end
 	 if not inst.moonregen and inst.components.hunger:GetPercent() < 1 then
	inst.components.hunger:DoDelta(120)
	inst.moonregen = true
	end
	end	
  elseif TheWorld.state.iscaveday then
 --  inst.stop_day = false
 inst.stop_dusk = false
 inst.stop_night = false
  inst.moonregen = false
	if not inst.components.hunger:GetPercent() >= 0.05 then
	inst.onsleep = false inst.hungry = false
	elseif not inst.components.hunger:GetPercent() < 0.05 and inst.components.follower and inst.components.follower.leader then
		if not inst.hungry then
	inst.components.talker:Say("[(..Hungry..)]")
	inst.hungry = true
	inst.onsleep = true	
    leader.follow_dall = false
	leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	inst.sleep_on = true
inst.sg:GoToState("sleeping")
	end
	end
  elseif TheWorld.state.iscavedusk then
   inst.stop_day = false
-- inst.stop_dusk = false
 inst.stop_night = false
  inst.moonregen = false
   inst.shapechange = false
	if not inst.components.hunger:GetPercent() >= 0.05 then
	inst.onsleep = false inst.hungry = false
	elseif not inst.components.hunger:GetPercent() < 0.05 and inst.components.follower and inst.components.follower.leader then
		if not inst.hungry then
	inst.components.talker:Say("[(..Hungry..)]")
	inst.hungry = true
	inst.onsleep = true	
    leader.follow_dall = false
	leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	inst.sleep_on = true
inst.sg:GoToState("sleeping")
	end
	end
  elseif TheWorld.state.iscavenight then
   inst.stop_day = false
 inst.stop_dusk = false
-- inst.stop_night = false
   inst.shapechange = false
  	if inst.components.hunger:GetPercent() >= 0.1 then
	inst.onsleep = false inst.hungry = false
  	elseif inst.components.hunger:GetPercent() < 0.05 and inst.components.follower and inst.components.follower.leader then
		if not inst.hungry then
	inst.components.talker:Say("[(..Hungry..)]")
	inst.hungry = true
	inst.onsleep = true	
    leader.follow_dall = false
	leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	inst.sleep_on = true
inst.sg:GoToState("sleeping")
	end
	end
	--if inst.components.sleeper:IsAsleep() then
	--	 inst.onsleep = true
	--	 end
if inst.onsleep then
	 if inst.components.follower and inst.components.follower.leader then
	 leader.follow_dall = false
	 leader.dall_follow = false
	inst.components.follower:SetLeader(nil)
	end
 	 if not inst.moonregen and inst.components.hunger:GetPercent() < 1 then
	inst.components.hunger:DoDelta(100)
	inst.moonregen = true
	end
	end	
	end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 19, {"musha"})
for k,v in pairs(ents) do
if inst.close and not inst.far then
v.dall_follow = true
elseif inst.far and not inst.close then
v.dall_follow = false
end
--Checklevel
if inst.yamcheinfo then
inst.components.talker:Say("[EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
if inst.level <= 10 then
inst.components.talker:Say("[Level]: 1  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 10 and inst.level <= 20 then
inst.components.talker:Say("[Level]: 2  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 20 and inst.level <= 30 then
inst.components.talker:Say("[Level]: 3  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 30 and inst.level <= 40 then
inst.components.talker:Say("[Level]: 4  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 40 and inst.level <= 50 then
inst.components.talker:Say("[Level]: 5  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 50 and inst.level <= 60 then
inst.components.talker:Say("[Level]: 6  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 60 and inst.level <= 70 then
inst.components.talker:Say("[Level]: 7  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 70 and inst.level <= 80 then
inst.components.talker:Say("[Level]: 8  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 80 and inst.level <= 90 then
inst.components.talker:Say("[Level]: 9  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 90 and inst.level <= 100 then
inst.components.talker:Say("[Level]: 10  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 100 and inst.level <= 110 then
inst.components.talker:Say("[Level]: 11  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 110 and inst.level <= 120 then
inst.components.talker:Say("[Level]: 12  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 120 and inst.level <= 130 then
inst.components.talker:Say("[Level]: 13  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 130 and inst.level <= 140 then
inst.components.talker:Say("[Level]: 14  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 140 and inst.level <= 150 then
inst.components.talker:Say("[Level]: 15  /  [EXP]: ".. (inst.level).."\n[Max Health]\n".. (inst.level*2 +800))
elseif inst.level > 150 then
inst.components.talker:Say("[Level]: 16 \n[Max Health]\n".. (inst.level*2 +800))
end
    inst.yamcheinfo = false 
end
end

local leader = inst.components.follower.leader
--[[if inst.components.follower and inst.components.follower.leader and inst.components.sleeper:IsAsleep() then
leader.follow_dall = false
leader.dall_follow = false
inst.components.follower:SetLeader(nil)
end]]
if inst.sleep_on and inst.yamche and inst.onsleep then
--inst.components.talker:Say("[(..Sleeping..)]")
--inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley")
inst.anti_monkey = false 
inst.components.container.canbeopened = true
inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/transform_VO")
if inst.components.follower and inst.components.follower.leader then
leader.follow_dall = false
leader.dall_follow = false
inst.components.follower:SetLeader(nil)
end
--inst.sleep_on = true
inst.yamche = false
	if not inst.components.follower.leader then 
		inst.MiniMapEntity:SetIcon( "moontree.tex" )
	elseif inst.components.follower.leader then
		inst.MiniMapEntity:SetIcon( "" )
	end
elseif inst.sleep_on and inst.yamche and not inst.onsleep then
inst.sg:GoToState("sleeping")
inst.yamche = false
	if not inst.components.follower.leader then 
		inst.MiniMapEntity:SetIcon( "moontree.tex" )
	elseif inst.components.follower.leader then
		inst.MiniMapEntity:SetIcon( "" )
	end
inst.anti_monkey = false 
inst.components.container.canbeopened = true
elseif not inst.sleep_on and inst.yamche and not inst.onsleep then
inst.sg:GoToState("spawn")
inst.go_sleep = false
--if inst.components.sleeper:IsAsleep() then
--inst.components.sleeper:WakeUp()
--end
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
	if not inst.components.follower.leader then 
		inst.MiniMapEntity:SetIcon( "moontree.tex" )
	elseif inst.components.follower.leader then
		inst.MiniMapEntity:SetIcon( "" )
	end
end  
--switch
if inst.sleep_on then
inst.active_hunt = false
inst.move = false
inst.components.hunger:SetRate(0)
inst.components.health:StartRegen(1, 5)
inst:AddTag("notarget")
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
inst.components.health:SetAbsorptionAmount(1)
elseif not inst.sleep_on then
inst.moondrake_out = true
inst.move = true
inst.components.hunger:SetRate(TUNING.BEEFALO_HUNGER_RATE)
inst.components.health:StartRegen(0,0)
inst:RemoveTag("notarget")
inst.components.health:SetAbsorptionAmount(0.4)
--[[
if not inst.active_hunt then
inst.components.health:SetAbsorptionAmount(0.4)
elseif not inst.active_hunt then
inst.components.health:SetAbsorptionAmount(0.6)
end]]
end
--
local leader = inst.components.follower.leader
if inst.components.follower and inst.components.follower.leader and not inst.sleep_on then
--inst.components.locomotor.walkspeed = 1.5
end
 end 
 
local function on_close(inst)
inst.close = true
inst.far = false
inst.components.locomotor.walkspeed = 1.5
if inst.components.follower.leader then
end
end
local function on_far(inst)
inst.close = false
inst.far = true
local leader = inst.components.follower.leader
if inst.components.follower.leader then
inst.components.locomotor.walkspeed = 4.5
--inst.MiniMapEntity:SetIcon( "" )
end
end


local function kill_summoned(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 100, {"moondrake"})
for k,v in pairs(ents) do
if v and v.components.health and not v.components.health and v.components.health:IsDead() then 
SpawnPrefab("small_puff").Transform:SetPosition(v:GetPosition():Get())
v.components.health:Kill()
end 
end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 100, {"moonbush"})
for k,v in pairs(ents) do
if v then 
SpawnPrefab("small_puff").Transform:SetPosition(v:GetPosition():Get())
v:Remove()
end 
end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 100, {"moonlight"})
for k,v in pairs(ents) do
if v then 
SpawnPrefab("small_puff").Transform:SetPosition(v:GetPosition():Get())
v:Remove()
end 
end
end

local function summon_check(inst, data)
 	--summon
-- moondrake 
if not inst.stop_spawning then
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 30, {"moondrake"})
if inst.radius_spawning then
local ents = TheSim:FindEntities(x,y,z, 5, {"moondrake"})
end
for k,v in pairs(ents) do
if not inst.sleep_on and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) then 
inst.components.leader:AddFollower(v)
v.inst_in = false
end 
if inst.level1 then
if inst.components.leader:CountFollowers("moondrake") >= 1 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 1 then inst.full_kkobong = false end
elseif inst.level2 then
if inst.components.leader:CountFollowers("moondrake") >= 2 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 2 then inst.full_kkobong = false end
elseif inst.level3 then
if inst.components.leader:CountFollowers("moondrake") >= 3 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 3 then inst.full_kkobong = false end
elseif inst.level4 then
if inst.components.leader:CountFollowers("moondrake") >= 4 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 4 then inst.full_kkobong = false end
elseif inst.level5 then
if inst.components.leader:CountFollowers("moondrake") >= 5 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 5 then inst.full_kkobong = false end
elseif inst.level6 then
if inst.components.leader:CountFollowers("moondrake") >= 6 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 6 then inst.full_kkobong = false end
elseif inst.level7 then
if inst.components.leader:CountFollowers("moondrake") >= 7 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 7 then inst.full_kkobong = false end
elseif inst.level8 then
if inst.components.leader:CountFollowers("moondrake") >= 8 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 8 then inst.full_kkobong = false end
elseif inst.level9 then
if inst.components.leader:CountFollowers("moondrake") >= 9 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 9 then inst.full_kkobong = false end
elseif inst.level10 then
if inst.components.leader:CountFollowers("moondrake") >= 10 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 10 then inst.full_kkobong = false end
elseif inst.level11 then
if inst.components.leader:CountFollowers("moondrake") >= 11 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 11 then inst.full_kkobong = false end
elseif inst.level12 then
if inst.components.leader:CountFollowers("moondrake") >= 12 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 12 then inst.full_kkobong = false end
elseif inst.level13 then
if inst.components.leader:CountFollowers("moondrake") >= 13 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 13 then inst.full_kkobong = false end
elseif inst.level14 then
if inst.components.leader:CountFollowers("moondrake") >= 14 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 14 then inst.full_kkobong = false end
elseif inst.level15 then
if inst.components.leader:CountFollowers("moondrake") >= 15 then inst.full_kkobong = true
elseif inst.components.leader:CountFollowers("moondrake") < 15 then inst.full_kkobong = false end
end
if inst.sleep_on and not v.inst_in and not v.slave then
--inst.moondrake_exit = true
v.components.follower:SetLeader(nil)
v.inst_in = true
v.sg:GoToState("exit")
--v.AnimState:PlayAnimation("exit")
local chance1 = 0.5
local chance2 = 0.4
local chance3 = 0.3
local chance4 = 0.2
v:DoTaskInTime(1.8, function() 
if math.random() < chance2 then
SpawnPrefab("small_puff").Transform:SetPosition(v:GetPosition():Get())
local carrot = SpawnPrefab("carrot_planted")
carrot.Transform:SetPosition(v:GetPosition():Get())
elseif math.random() < chance1 then
SpawnPrefab("green_leaves").Transform:SetPosition(v:GetPosition():Get())
local moonbush = SpawnPrefab("moonbush")
moonbush.Transform:SetPosition(v:GetPosition():Get())
moonbush.AnimState:PlayAnimation("shake")
elseif math.random() < chance3 then
--SpawnPrefab("green_leaves_chop").Transform:SetPosition(v:GetPosition():Get())
local moonlight = SpawnPrefab("moonlight_plant")
moonlight.Transform:SetPosition(v:GetPosition():Get())
moonlight.AnimState:PlayAnimation("grow")
elseif math.random() < chance2 then
--SpawnPrefab("green_leaves").Transform:SetPosition(v:GetPosition():Get())
local mushroom = SpawnPrefab("green_mushroom")
mushroom.Transform:SetPosition(v:GetPosition():Get())
mushroom.AnimState:PlayAnimation("open_green")
mushroom:DoTaskInTime(2, function() if not TheWorld.state.isdusk then
mushroom.AnimState:PlayAnimation("open_inground")
--v.SoundEmitter:PlaySound("dontstarve/common/mushroom_down")
end end )
--mushroom.SoundEmitter:PlaySound("dontstarve/common/mushroom_up")
--elseif math.random() < chance1 then
--seed.Transform:SetPosition(v:GetPosition():Get())
end 
v.inst_in = false
v:Remove()
end)
end	 end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20, {"moonbush"})
for k,v in pairs(ents) do
if inst.sleep_on and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) then 
inst.components.leader:AddFollower(v)
end 
if inst.level1 then
if inst.components.leader:CountFollowers("moonbush") >= 1 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 1 then inst.full_moon_bush = false end
elseif inst.level2 then
if inst.components.leader:CountFollowers("moonbush") >= 2 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 2 then inst.full_moon_bush = false end
elseif inst.level3 then
if inst.components.leader:CountFollowers("moonbush") >= 3 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 3 then inst.full_moon_bush = false end
elseif inst.level4 then
if inst.components.leader:CountFollowers("moonbush") >= 4 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 4 then inst.full_moon_bush = false end
elseif inst.level5 then
if inst.components.leader:CountFollowers("moonbush") >= 5 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 5 then inst.full_moon_bush = false end
elseif inst.level6 then
if inst.components.leader:CountFollowers("moonbush") >= 6 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 6 then inst.full_moon_bush = false end
elseif inst.level7 then
if inst.components.leader:CountFollowers("moonbush") >= 7 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 7 then inst.full_moon_bush = false end
elseif inst.level8 then
if inst.components.leader:CountFollowers("moonbush") >= 8 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 8 then inst.full_moon_bush = false end
elseif inst.level9 then
if inst.components.leader:CountFollowers("moonbush") >= 9 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 9 then inst.full_moon_bush = false end
elseif inst.level10 then
if inst.components.leader:CountFollowers("moonbush") >= 10 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 10 then inst.full_moon_bush = false end
elseif inst.level11 then
if inst.components.leader:CountFollowers("moonbush") >= 11 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 11 then inst.full_moon_bush = false end
elseif inst.level12 then
if inst.components.leader:CountFollowers("moonbush") >= 12 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 12 then inst.full_moon_bush = false end
elseif inst.level13 then
if inst.components.leader:CountFollowers("moonbush") >= 13 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 13 then inst.full_moon_bush = false end
elseif inst.level14 then
if inst.components.leader:CountFollowers("moonbush") >= 14 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 14 then inst.full_moon_bush = false end
elseif inst.level15 then
if inst.components.leader:CountFollowers("moonbush") >= 15 then inst.full_moon_bush = true
elseif inst.components.leader:CountFollowers("moonbush") < 15 then inst.full_moon_bush = false end
end
if not inst.sleep_on and not v.move then
v.move = true
v.AnimState:PlayAnimation("shake")
v.components.follower:SetLeader(nil)
inst.components.leader:IsFollower(nil)
    if v:HasTag("moonbush") then
	    v.AnimState:PlayAnimation("shake_empty")
        v.AnimState:PushAnimation("idle_dead")
  v:DoTaskInTime(1.25, function() SpawnPrefab("green_leaves").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("small_puff").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("moonnutdrake").Transform:SetPosition(v:GetPosition():Get()) v:Remove() end)
 
   		end
--v.AnimState:PlayAnimation("exit")
end	 end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20, {"moonlight"})
for k,v in pairs(ents) do
if inst.sleep_on and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) then 
inst.components.leader:AddFollower(v)
end 
if inst.level1 then
if inst.components.leader:CountFollowers("moonlight") >= 1 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 1 then inst.full_moonlight_plant = false end
elseif inst.level2 then
if inst.components.leader:CountFollowers("moonlight") >= 1 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 1 then inst.full_moonlight_plant = false end
elseif inst.level3 then
if inst.components.leader:CountFollowers("moonlight") >= 2 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 2 then inst.full_moonlight_plant = false end
elseif inst.level4 then
if inst.components.leader:CountFollowers("moonlight") >= 2 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 2 then inst.full_moonlight_plant = false end
elseif inst.level5 then
if inst.components.leader:CountFollowers("moonlight") >= 3 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 3 then inst.full_moonlight_plant = false end
elseif inst.level6 then
if inst.components.leader:CountFollowers("moonlight") >= 3 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 3 then inst.full_moonlight_plant = false end
elseif inst.level7 then
if inst.components.leader:CountFollowers("moonlight") >= 4 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 4 then inst.full_moonlight_plant = false end
elseif inst.level8 then
if inst.components.leader:CountFollowers("moonlight") >= 4 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 4 then inst.full_moonlight_plant = false end
elseif inst.level9 then
if inst.components.leader:CountFollowers("moonlight") >= 5 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 5 then inst.full_moonlight_plant = false end
elseif inst.level10 then
if inst.components.leader:CountFollowers("moonlight") >= 5 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 5 then inst.full_moonlight_plant = false end
elseif inst.level11 then
if inst.components.leader:CountFollowers("moonlight") >= 6 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 6 then inst.full_moonlight_plant = false end
elseif inst.level12 then
if inst.components.leader:CountFollowers("moonlight") >= 6 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 6 then inst.full_moonlight_plant = false end
elseif inst.level13 then
if inst.components.leader:CountFollowers("moonlight") >= 7 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 7 then inst.full_moonlight_plant = false end
elseif inst.level14 then
if inst.components.leader:CountFollowers("moonlight") >= 7 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 7 then inst.full_moonlight_plant = false end
elseif inst.level15 then
if inst.components.leader:CountFollowers("moonlight") >= 8 then inst.full_moonlight_plant = true
elseif inst.components.leader:CountFollowers("moonlight") < 8 then inst.full_moonlight_plant = false end
end
if not inst.sleep_on and not v.move then
v.move = true
v.AnimState:PlayAnimation("picking")
v.components.follower:SetLeader(nil)
inst.components.leader:IsFollower(nil)
    if v:HasTag("moonlight") then
  v:DoTaskInTime(1.25, function() SpawnPrefab("green_leaves").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("small_puff").Transform:SetPosition(v:GetPosition():Get()) SpawnPrefab("moonnutdrake").Transform:SetPosition(v:GetPosition():Get()) v:Remove() end)
 
   		end
--v.AnimState:PlayAnimation("exit")
end	 end
	local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, {"carrot"})
for k,v in pairs(ents) do
if inst.sleep_on and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) then 
inst.components.leader:AddFollower(v)
end 

if inst.level1 then
if inst.components.leader:CountFollowers("carrot") >= 1 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 1 then inst.full_carrot = false end
elseif inst.level2 then
if inst.components.leader:CountFollowers("carrot") >= 1 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 1 then inst.full_carrot = false end
elseif inst.level3 then
if inst.components.leader:CountFollowers("carrot") >= 2 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 2 then inst.full_carrot = false end
elseif inst.level4 then
if inst.components.leader:CountFollowers("carrot") >= 2 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 2 then inst.full_carrot = false end
elseif inst.level5 then
if inst.components.leader:CountFollowers("carrot") >= 3 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 3 then inst.full_carrot = false end
elseif inst.level6 then
if inst.components.leader:CountFollowers("carrot") >= 3 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 3 then inst.full_carrot = false end
elseif inst.level7 then
if inst.components.leader:CountFollowers("carrot") >= 4 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 4 then inst.full_carrot = false end
elseif inst.level8 then
if inst.components.leader:CountFollowers("carrot") >= 4 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 4 then inst.full_carrot = false end
elseif inst.level9 then
if inst.components.leader:CountFollowers("carrot") >= 5 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 5 then inst.full_carrot = false end
elseif inst.level10 then
if inst.components.leader:CountFollowers("carrot") >= 5 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 5 then inst.full_carrot = false end
elseif inst.level11 then
if inst.components.leader:CountFollowers("carrot") >= 6 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 6 then inst.full_carrot = false end
elseif inst.level12 then
if inst.components.leader:CountFollowers("carrot") >= 6 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 6 then inst.full_carrot = false end
elseif inst.level13 then
if inst.components.leader:CountFollowers("carrot") >= 7 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 7 then inst.full_carrot = false end
elseif inst.level14 then
if inst.components.leader:CountFollowers("carrot") >= 7 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 7 then inst.full_carrot = false end
elseif inst.level15 then
if inst.components.leader:CountFollowers("carrot") >= 8 then inst.full_carrot = true
elseif inst.components.leader:CountFollowers("carrot") < 8 then inst.full_carrot = false end
end
if not inst.sleep_on and not v.move then
v.move = true
v.components.follower:SetLeader(nil)
inst.components.leader:IsFollower(nil)

 end end
 
	local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 12, {"mushrooms"})
for k,v in pairs(ents) do
if inst.sleep_on and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) then 
inst.components.leader:AddFollower(v)
end 

if inst.level1 then
if inst.components.leader:CountFollowers("mushrooms") >= 1 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 1 then inst.full_musharoom = false end
elseif inst.level2 then
if inst.components.leader:CountFollowers("mushrooms") >= 1 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 1 then inst.full_musharoom = false end
elseif inst.level3 then
if inst.components.leader:CountFollowers("mushrooms") >= 2 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 2 then inst.full_musharoom = false end
elseif inst.level4 then
if inst.components.leader:CountFollowers("mushrooms") >= 2 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 2 then inst.full_musharoom = false end
elseif inst.level5 then
if inst.components.leader:CountFollowers("mushrooms") >= 3 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 3 then inst.full_musharoom = false end
elseif inst.level6 then
if inst.components.leader:CountFollowers("mushrooms") >= 3 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 3 then inst.full_musharoom = false end
elseif inst.level7 then
if inst.components.leader:CountFollowers("mushrooms") >= 4 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 4 then inst.full_musharoom = false end
elseif inst.level8 then
if inst.components.leader:CountFollowers("mushrooms") >= 4 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 4 then inst.full_musharoom = false end
elseif inst.level9 then
if inst.components.leader:CountFollowers("mushrooms") >= 4 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 4 then inst.full_musharoom = false end
elseif inst.level10 then
if inst.components.leader:CountFollowers("mushrooms") >= 5 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 5 then inst.full_musharoom = false end
elseif inst.level11 then
if inst.components.leader:CountFollowers("mushrooms") >= 5 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 5 then inst.full_musharoom = false end
elseif inst.level12 then
if inst.components.leader:CountFollowers("mushrooms") >= 5 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 5 then inst.full_musharoom = false end
elseif inst.level13 then
if inst.components.leader:CountFollowers("mushrooms") >= 6 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 6 then inst.full_musharoom = false end
elseif inst.level14 then
if inst.components.leader:CountFollowers("mushrooms") >= 6 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 6 then inst.full_musharoom = false end
elseif inst.level15 then
if inst.components.leader:CountFollowers("mushrooms") >= 6 then inst.full_musharoom = true
elseif inst.components.leader:CountFollowers("mushrooms") < 6 then inst.full_musharoom = false end
end
if not inst.sleep_on and not v.move then
v.move = true
v.components.follower:SetLeader(nil)
inst.components.leader:IsFollower(nil)

 end end
 end
end 
 
 local function summon_drake(inst, data)
 if not inst.stop_spawning then
 -- moondrake
if not inst.sleep_on and  not inst.full_kkobong then
local drake = SpawnPrefab("moonnutdrake")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,TUNING.DECID_MONSTER_TARGET_DIST), 30, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	drake.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	--drake.components.follower:SetLeader(inst)
	drake.components.follower:SetLeader(inst)
	inst.components.leader:AddFollower(drake)
	drake.slave = true	
drake.sg:GoToState("enter")
drake.AnimState:PlayAnimation("enter")
if drake.components.combat then
	drake.components.combat:SuggestTarget(drake.target)
end		end
	end		
end	
 local function summon_bush(inst, data)	
if not inst.stop_spawning then
if not inst.radius_spawning then
 if TheWorld.state.isday or TheWorld.state.iscaveday then
	--full_moon_bush
if inst.sleep_on and not inst.stop_day and not inst.full_moon_bush then
local berrybush = SpawnPrefab("moonbush")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,TUNING.DECID_MONSTER_TARGET_DIST), 10, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	berrybush.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	SpawnPrefab("green_leaves").Transform:SetPosition(berrybush:GetPosition():Get())
	--berrybush.components.follower:SetLeader(inst)	
	berrybush.AnimState:PlayAnimation("shake")
	 end end 
	  
elseif inst.radius_spawning then
	  if TheWorld.state.isday or TheWorld.state.iscaveday then
	--full_moon_bush
if inst.sleep_on and not inst.stop_day and not inst.full_moon_bush then
local berrybush = SpawnPrefab("moonbush")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,3), 3, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	berrybush.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	SpawnPrefab("green_leaves").Transform:SetPosition(berrybush:GetPosition():Get())
	--berrybush.components.follower:SetLeader(inst)	
	berrybush.AnimState:PlayAnimation("shake")
	 end end 
end 
end	 
end	 
local function summon_carrot(inst, data)
if not inst.stop_spawning then
if not inst.radius_spawning then		
 if TheWorld.state.isday or TheWorld.state.iscaveday then 
		--veggies
if inst.sleep_on and not inst.stop_day and not inst.full_carrot then
local carrot = SpawnPrefab("carrot_planted")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,TUNING.DECID_MONSTER_TARGET_DIST), 30, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	carrot.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	SpawnPrefab("green_leaves").Transform:SetPosition(carrot:GetPosition():Get())
	SpawnPrefab("small_puff").Transform:SetPosition(carrot:GetPosition():Get())
--carrot.AnimState:PlayAnimation("planted")
	 end end
elseif inst.radius_spawning then		
 if TheWorld.state.isday or TheWorld.state.iscaveday then 
		--veggies
if inst.sleep_on and not inst.stop_day and not inst.full_carrot then
local carrot = SpawnPrefab("carrot_planted")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,3), 3, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	carrot.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	SpawnPrefab("green_leaves").Transform:SetPosition(carrot:GetPosition():Get())
	SpawnPrefab("small_puff").Transform:SetPosition(carrot:GetPosition():Get())	 
	end end 
end
end
end	 
 local function summon_dusk(inst, data)	
 if not inst.stop_spawning then
if not inst.radius_spawning then		
if TheWorld.state.isdusk or TheWorld.state.iscavedusk then
if inst.sleep_on and not inst.stop_dusk and not inst.full_musharoom then
local green = SpawnPrefab("green_mushroom")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,TUNING.DECID_MONSTER_TARGET_DIST), 10, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	green.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
green.AnimState:PlayAnimation("open_green")
 green.SoundEmitter:PlaySound("dontstarve/common/mushroom_up")
--[[ inst:DoTaskInTime(2, function() if not TheWorld.state.isdusk then
green.AnimState:PlayAnimation("open_inground")
inst.SoundEmitter:PlaySound("dontstarve/common/mushroom_down")
end end )]]
	end end
elseif inst.radius_spawning then		
if TheWorld.state.isdusk or TheWorld.state.iscavedusk then
if inst.sleep_on and not inst.stop_dusk and not inst.full_musharoom then
local green = SpawnPrefab("green_mushroom")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,3), 3, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	green.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
green.AnimState:PlayAnimation("open_green")
 green.SoundEmitter:PlaySound("dontstarve/common/mushroom_up")	 
	end end
end 
end
end
	 
local function summon_night(inst, data)		
if not inst.stop_spawning then
if not inst.radius_spawning then	
if TheWorld.state.isnight or TheWorld.state.iscavenight then 
if inst.sleep_on then
SpawnPrefab("musha_spore").Transform:SetPosition(inst:GetPosition():Get())	
end
 if inst.sleep_on and not inst.stop_night and not inst.full_moonlight_plant then
local moonlight = SpawnPrefab("moonlight_plant")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,TUNING.DECID_MONSTER_TARGET_DIST), 10, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	moonlight.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	SpawnPrefab("green_leaves").Transform:SetPosition(moonlight:GetPosition():Get())
	moonlight.AnimState:PlayAnimation("picking")
	moonlight:DoTaskInTime(1, function() moonlight.AnimState:PlayAnimation("grow") end)
	 end end 
elseif inst.radius_spawning then	
if TheWorld.state.isnight or TheWorld.state.iscavenight then 
if inst.sleep_on then
SpawnPrefab("musha_spore").Transform:SetPosition(inst:GetPosition():Get())	
end
 if inst.sleep_on and not inst.stop_night and not inst.full_moonlight_plant then
local moonlight = SpawnPrefab("moonlight_plant")
local drakeangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,3), 3, false, false)
local x,y,z = inst.Transform:GetWorldPosition()
	moonlight.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	SpawnPrefab("green_leaves").Transform:SetPosition(moonlight:GetPosition():Get())
	moonlight.AnimState:PlayAnimation("picking")
	moonlight:DoTaskInTime(1, function() moonlight.AnimState:PlayAnimation("grow") end)
	 end end
end
end 
end


local function on_sleep(inst, data)
if inst.stop_spawning then 	
kill_summoned(inst)
end
local leader = inst.components.follower.leader
if not inst.components.follower.leader and not inst.sleep_on then
inst.sg:GoToState("sleeping")
inst.sleep_on = true
end 
if (TheWorld.state.isday or TheWorld.state.iscaveday) and not inst.shapechange then
if TheWorld.state.isspring then	
inst.AnimState:SetBuild("leif_moon_spring_build")	
SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
elseif TheWorld.state.issummer then
inst.AnimState:SetBuild("leif_moon_build")
SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
elseif TheWorld.state.isautumn then
inst.AnimState:SetBuild("leif_moon_fall_build")	
SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get())
elseif TheWorld.state.iswinter then	
inst.AnimState:SetBuild("leif_moon_winter_build")
SpawnPrefab("yellow_leaves").Transform:SetPosition(inst:GetPosition():Get())
end
 inst.shapechange = true
 end
end  
 

local onloadfn = function(inst, data)
    if data and data.hibernate then
        inst.components.sleeper.hibernate = true
    end
  --  if data and data.sleep_time then
  --       inst.components.sleeper.testtime = data.sleep_time
  --  end
    if data and data.sleeping then     
         inst.components.sleeper:GoToSleep()
    end
end

local onsavefn = function(inst, data)
data.level = inst.level
   -- if inst.components.sleeper:IsAsleep() then
   --     data.sleeping = true
   --     data.sleep_time = inst.components.sleeper.testtime
    --end

    if inst.components.sleeper:IsHibernating() then
        data.hibernate = true
    end
end

local function CalcSanityAura(inst)
    return TUNING.SANITYAURA_TINY 
	--inst.components.combat.target ~= nil and -TUNING.SANITYAURA_LARGE or -TUNING.SANITYAURA_MED
	
end

local function OnBurnt(inst)
    if inst.components.propagator and inst.components.health and not inst.components.health:IsDead() then
        inst.components.propagator.acceptsheat = true
    end
end

local function InShadow(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 15)
for k,v in pairs(ents) do
if inst.sleep_on and v.components.combat and v.components.combat.target == inst and not (v:HasTag("berrythief") or v:HasTag("prey") or v:HasTag("bird") or v:HasTag("butterfly")) then
		v.components.combat.target = nil
		inst:DoTaskInTime(3, function() inst.sg:GoToState("sleeping") end)
 end
 end end
 
local function OnAttacked(inst, data)
	if data.attacker and data.attacker:HasTag("musha") or data.attacker:HasTag("player") then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
    end
if inst.sleep_on then
InShadow(inst)
inst.sg:GoToState("sleeping")
elseif not inst.sleep_on then
    inst.components.combat:SetTarget(data.attacker)
	end
	            
end

local function OnLoad(inst, data)
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
   		data.level = inst.level
end

local function common_fn(build)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 1000, .5)

    inst.DynamicShadow:SetSize(4, 1.5)
    inst.Transform:SetFourFaced()
      
	inst:AddTag("dall")
	inst:AddTag("yamche")
	inst:AddTag("companion")
	inst:AddTag("shelter")
--	inst:AddTag("musha_slave")

  --  inst:AddTag("epic")
  --  inst:AddTag("monster")
  --  inst:AddTag("hostile")
  --  inst:AddTag("leif")
  --  inst:AddTag("tree")
  --  inst:AddTag("evergreens")
  --  inst:AddTag("largecreature")
  
	 inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "moontree.tex" )
	--inst.MiniMapEntity:SetPriority(10)
	--inst.MiniMapEntity:SetDrawOverFogOfWar(false)
	
    inst.AnimState:SetBank("leif")
inst.AnimState:SetBuild("leif_moon_build")	
if TheWorld.state.isspring then	
inst.AnimState:SetBuild("leif_moon_spring_build")	
SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
elseif TheWorld.state.issummer then
inst.AnimState:SetBuild("leif_moon_build")
SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
elseif TheWorld.state.isautumn then
inst.AnimState:SetBuild("leif_moon_fall_build")	
SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get())
elseif TheWorld.state.iswinter then	
inst.AnimState:SetBuild("leif_moon_winter_build")
SpawnPrefab("yellow_leaves").Transform:SetPosition(inst:GetPosition():Get())
end
		    inst:AddComponent("talker")
    inst.components.talker.fontsize = 30
    inst.components.talker.colour = Vector3(0.85, 0.65, 0.95, 1)
	   inst.components.talker.offset = Vector3(0,-800,0)	
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.entity:SetPristine()
  	
		if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche6")
		end)
		return inst
	end

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche6")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	
  --  inst.OnLoad = onloadfn
  --  inst.OnSave = onsavefn

    ------------------------------------------

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 1.5    
 
    ------------------------------------------
    inst:SetStateGraph("SGDall")

    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    MakeLargeBurnableCharacter(inst, "marker")
    inst.components.burnable.flammability = TUNING.LEIF_FLAMMABILITY
    inst.components.burnable:SetOnBurntFn(OnBurnt)
    inst.components.propagator.acceptsheat = true

    MakeHugeFreezableCharacter(inst, "marker")
    ------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(800)
	
    inst:AddComponent("hunger")
    inst.components.hunger:SetMax(400)
   	inst.components.hunger:SetRate(0)
    ------------------
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE }, { FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE })
    inst.components.eater:SetOnEatFn(OnEat)
	
	    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
	
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.LEIF_DAMAGE)    
    inst.components.combat.hiteffectsymbol = "marker"
    inst.components.combat:SetAttackPeriod(TUNING.LEIF_ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(1, Retarget)
		inst.components.combat.playerdamagepercent = 0
	--		inst:ListenForEvent("hungerdelta", Checklevel)
			inst:ListenForEvent("attacked", flower_shield)
		    inst:ListenForEvent("onhitother", OnHitnature)
			--inst:AddComponent("deciduoustreeupdater")
						
	inst:AddComponent("leader")
    inst:AddComponent("follower")
  
	inst.on_follow = inst:DoPeriodicTask(0, on_follow)  
	inst.on_sleep = inst:DoPeriodicTask(5, on_sleep)  
	---inst.forgelab = inst:DoPeriodicTask(0, forgelab) 
	
inst.summon_check = inst:DoPeriodicTask(1, summon_check)  	
inst.summon_drake = inst:DoPeriodicTask(25, summon_drake)  
inst.summon_1 = inst:DoPeriodicTask(90, summon_bush) 
inst.summon_2 = inst:DoPeriodicTask(120, summon_carrot) 
inst.summon_3 = inst:DoPeriodicTask(360, summon_dusk) 
inst.summon_4 = inst:DoPeriodicTask(180, summon_night)

	
local leader = inst.components.follower.leader
if not inst.components.follower.leader then
inst.sg:GoToState("sleeping")
inst.sleep_on = true
inst.components.hunger:SetRate(0)
end 
    ------------------------------------------
    MakeHauntableIgnite(inst)
    ------------------------------------------
	   inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.DALL
    inst.components.named:PickNewName()
	
		inst:AddComponent("maprevealer")
		inst.components.maprevealer.revealperiod = 0.5
		inst.components.maprevealer:Start()
	
	
       inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(12, 12)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(on_far)

--[[
    inst:AddComponent("sleeper")
     inst.components.sleeper:SetResistance(80)
     inst.components.sleeper.sleeptestfn = DallSleepTest
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	]]
    ------------------------------------------

    --inst:AddComponent("lootdropper")
   -- inst.components.lootdropper:SetLoot({"livinglog", "livinglog", "livinglog", })

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()
    ------------------------------------------
	inst.level = 0
	inst:ListenForEvent("killed", onkilll)
	inst.Transform:SetScale(0.7, 0.7, 0.7)
 inst:ListenForEvent("levelup", levelexp)
	
   inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	
    inst:SetBrain(brain)

    inst:ListenForEvent("attacked", OnAttacked)
			inst:ListenForEvent("death", ondeath)
    return inst
end


return Prefab("moontree", common_fn, assets, prefabs),
  MakePlacer("moontree_placer", "leif", "leif_moon_build", "idle")
  
require "brains/assasin_w_brain"
local brain = require "brains/assasin_w_brain"
require "stategraphs/SGassasin_w"

--local MakePlayerCharacter = require "prefabs/player_common"

local assets = 
{
    --Asset("ANIM", "anim/wilson.zip"),
	Asset("ANIM", "anim/assasin_wilson.zip"),
	Asset("SOUND", "sound/wilson.fsb"),
	---------
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
	
}

local prefabs = 
{
}

local start_inv = 
{
}

local items =
{
	AXE = "swap_axe",
	PICK = "swap_pickaxe",
	SWORD = "swap_nightmaresword",
    SWORD1 = "swap_mushasword_base",
	SWORD2 = "swap_mushasword_frost1",
	SWORD3 = "swap_mushasword_frost2",
	SWORD4 = "swap_mushasword_frost1_boost",
	SWORD5 = "swap_mushasword_frost2_boost",
	SWORD6 = "swap_mushasword_frost3_boost",
	BODY = "swap_backpack",
	BODY1 = "armor_grass",
	BODY2 = "armor_wood",
	BODY3 = "armor_marble",
	BODY4 = "armor_slurper",
	BODY5 = "armor_ruins",
	BODY6 = "armor_slurtleshell",
	HAT3 = "hat_miner",
	HAT2 = "hat_football",
	HAT1 = "hat_top",
	
}

local function ondeath(inst, data)
	--if inst.components.inventory then
	--inst.components.inventory:DropEverything() end
local dark2 = SpawnPrefab("statue_transition_2")
local pos = Vector3(inst.Transform:GetWorldPosition())
local player = inst.components.follower.leader
if player then
 		if math.random() < 0.2 then
player.components.talker:Say("Thanks Wilson..")
elseif math.random() < 0.2  then
player.components.talker:Say("See you Again..")
elseif math.random() < 0.2  then
player.components.talker:Say("Good bye..")
elseif math.random() < 1  then
player.components.talker:Say("Thank you.")
end
end
end

local function chat(inst)
local player = inst.components.follower.leader
if player and player:HasTag("musha") then
if not ((player.sleep_on or player.tiny_sleep) and inst.sleep and inst.sleep_on and inst.wakeup_check) then
if not inst.chating and not inst.sg:HasStateTag("attack") and not player.sg:HasStateTag("moving") and not inst.sg:HasStateTag("hit") then
if not inst.talk_on then
inst.sg:GoToState("talk")
inst.components.locomotor:Stop()
inst.talk_on = true
--inst:DoTaskInTime( 2, function() inst.sg:GoToState("idle") end)
end
inst.chating = true
		if math.random() < 0.05 then
		inst.components.talker:Say("Why we stop?")
elseif math.random() < 0.3  and player.sg:HasStateTag("chopping") then		
inst.components.talker:Say("My blade is your servant.")
player:DoTaskInTime( 2, function() player.components.talker:Say("...why don't you use a axe?") end)
elseif math.random() < 0.3  and player.sg:HasStateTag("mining") then		
inst.components.talker:Say("My sword will cleave the stone.")
elseif math.random() < 0.15  and player.sg:HasStateTag("fishing") then		
inst.components.talker:Say("I like fish.")
elseif math.random() < 0.2  and player.sg:HasStateTag("eating") then		
inst.components.talker:Say("delicious?")
elseif math.random() < 0.15  then
inst.components.talker:Say("I am Cool guy. isn't it?")
player:DoTaskInTime( 2, function() player.components.talker:Say("...") end)
inst:DoTaskInTime( 5, function() inst.components.talker:Say("Musha, you really pretty girl.") end)
player:DoTaskInTime( 7, function() player.components.talker:Say("Ok, you are cool guy.") end)
elseif math.random() < 0.05  then
inst.components.talker:Say("Interesting..")
elseif math.random() < 0.1 and inst.components.hunger:GetPercent() < .5 then
inst.components.talker:Say("I feel a little bit hungry.")
elseif math.random() < 0.1 and inst.components.hunger:GetPercent() < .25 then
inst.components.talker:Say("I want to something to eat.")
elseif math.random() < 0.1  then
inst.components.talker:Say("Musha, you are really pretty dog.")
player:DoTaskInTime( 2, function() player.components.talker:Say("Are you hungry?") end)
elseif math.random() < 0.1  then
inst.components.talker:Say("Hmm...?")
player:DoTaskInTime( 2, function() player.components.talker:Say("Umm..?") end)
elseif math.random() < 0.15  then
inst.components.talker:Say("What is that? oh.. just bird..")
elseif math.random() < 0.05 then
inst.components.talker:Say("Yamche, why don't you follow me?")
elseif math.random() < 0.15 and TheWorld.state.isnight then
if math.random() < 0.2  then
inst.components.talker:Say("Too dark..")
elseif math.random() < 0.2  then
inst.components.talker:Say("I think, you need some sleep.")
elseif math.random() < 0.2  then
inst.components.talker:Say("night time..\nwe need some sleep.")
player:DoTaskInTime( 2, function() player.components.talker:Say("well.. we need campfire.") end)
end
elseif math.random() < 0.2  then
inst.components.talker:Say("I am reaaally smart man.")
player:DoTaskInTime( 2, function() player.components.talker:Say("...") end)
elseif math.random() < 0.1 then
inst.components.talker:Say("Musha, we rest in here?")
player:DoTaskInTime( 2, function() player.components.talker:Say("No, We must keep going..") end)
elseif math.random() < 0.2  then
inst.components.talker:Say("Musha, can I buy your Yamche?")
inst:DoTaskInTime( 2, function() player.components.talker:Say("Definitely not.") end)
elseif math.random() < 0.2  then
inst.components.talker:Say("Musha, how can I get the Phoenix?")
player:DoTaskInTime( 3, function() player.components.talker:Say("Sorry, it's a secret.") end)
elseif math.random() < 0.2  then
inst.components.talker:Say("You so beautiful dog. Merry me?")
player:DoTaskInTime( 1, function() player.components.talker:Say("NO.") end)
elseif math.random() < 0.2  then
inst.components.talker:Say("Dog and Bird and Genius.")
player:DoTaskInTime( 2, function() player.components.talker:Say("Who is Genius?") end)
inst:DoTaskInTime( 4, function() inst.components.talker:Say("...of course you are.") end)
player:DoTaskInTime( 6, function() player.components.talker:Say("you are excellent survivor.") end)
elseif math.random() < 0.2  then
inst.components.talker:Say("Hmm...?")
player:DoTaskInTime( 2, function() player.components.talker:Say("Why?") end)
inst:DoTaskInTime( 4, function() inst.components.talker:Say("never mind.") end)
elseif math.random() < 0.2  then
player.components.talker:Say("Umm...?")
player:DoTaskInTime( 2, function() player.components.talker:Say("Why?") end)
inst:DoTaskInTime( 4, function() inst.components.talker:Say("never mind.") end)
end
end
inst:DoTaskInTime( 10, function() 
inst.chating = false
inst.talk_on = false end)
end end
end
	
local function lightning(inst)

if inst.fight then
inst:DoTaskInTime( 15, function() inst.fight = false end) end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, {"monster"})
for k,v in pairs(ents) do
if v.components.health and not v.components.health:IsDead() and inst.components.health:GetPercent() <= 0.7 then 
local random = 0.8
if math.random() < random and not inst.yamche_lightning then
inst.yamche_lightning = true
inst.bloom = true
end end
end end


local function OnRanger(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
 if other and inst.ranger2 and inst.yamche_lightning then
           SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        --other.components.health:DoDelta(-30)
		if math.random() < 0.2 then
inst.components.talker:Say("Die Monster !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("Ha Ha Ha !!")
elseif math.random() < 0.3  then
inst.components.talker:Say("Taste my Lightning !!")
elseif math.random() < 0.3  then
inst.components.talker:Say("power of science !")
elseif math.random() < 1  then
inst.components.talker:Say("See my Power !!")
end
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "" ) 
	inst.ranger2 = false inst.yamche_lightning = false
inst.components.combat:SetRange(2)	
end
end
end

function Power_check(inst, data)
if inst.yamche_lightning then -- and inst.components.health:GetPercent() >=0.4 then 
inst.ranger2 = true
inst.components.combat:SetRange(12)
if inst.bloom then
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
--inst.components.talker:Say("[Lightning -On]")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.bloom = false
end
elseif inst.yamche_lightning and inst.components.health:GetPercent() <0.4 then
--scheduler:ExecuteInTime(3, function() inst.components.talker:Say("[Not enough cost]")end)
inst.yamche_lightning = false
end end

    local function cure1_proc(inst, data)
inst.components.health:SetAbsorptionAmount(1)
--inst.components.health:DoDelta(50)
local fx = SpawnPrefab("forcefieldfxx")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
fx.Transform:SetScale(0.7, 0.7, 0.7)
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
inst.shield_on = true
inst.sg:GoToState("talk")
if math.random() < 0.2 then
inst.components.talker:Say("I will Kill You !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("Fight me !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("That's it?")
elseif math.random() < 0.2  then
inst.components.talker:Say("Ha Ha Ha Ha!")
elseif math.random() < 0.2  then
inst.components.talker:Say("Come on !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("See my Power !!")
elseif math.random() < 1 then
inst.components.talker:Say("I am Genius!")
end
inst:DoTaskInTime( 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then
fx.kill_fx(fx)
inst.components.health:SetAbsorptionAmount(0.5)

inst:DoTaskInTime( 120, function() inst.shield_on = false end)
end end) 
 end 
 
  local function EquipHead(inst, item)
 if item then
        inst.AnimState:OverrideSymbol("swap_hat", item, "swap_hat")
        inst.AnimState:Show("HAT")
        inst.AnimState:Show("HAT_HAIR")
        inst.AnimState:Show("HAIR_NOHAT")
        inst.AnimState:Hide("HAIR")
		
end
end

 local function EquipArmor(inst, item)
 if item then
	inst.AnimState:OverrideSymbol("swap_body", item, "swap_body")
end
end

local function EquipAxe(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, "swap_axe")
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
	end
end
local function EquipPickaxe(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, "swap_pickaxe")
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
	end
end
local function EquipItem(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, "swap_nightmaresword")
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
			
			
	end
end
local function ShouldAcceptItem(inst, item)
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        return true
    elseif item.components.edible and inst.components.hunger:GetPercent() <= 1 then
        return true
    end
    end

local function OnRefuseItem(inst, item)
   inst.sg:GoToState("talk")
   inst.components.talker:Say("I'm Not piggy man.")
   inst.components.locomotor:Stop()
  -- inst:DoTaskInTime( 1.5, function() inst.sg:GoToState("idle") end)
   --[[if inst.components.sleeper:IsAsleep() then
    inst.components.sleeper:WakeUp()
    end]]
end


local function OnGetItemFromPlayer(inst, giver, item)
 
 --[[if inst.components.sleeper:IsAsleep() then
    inst.components.sleeper:WakeUp()
    end]]

    if item.components.edible then

    if inst.components.combat.target and inst.components.combat.target == giver then
            inst.components.combat:SetTarget(nil)
elseif giver.components.leader then
giver.components.leader:AddFollower(inst)
        end
        if inst.components.eater:Eat(item) then
		if item.components.edible.hungervalue >= 15 then
		inst.sg:GoToState("eat")
	--inst.components.talker:Say("Yam Yam")
		elseif item.components.edible.hungervalue < 15 then
		inst.sg:GoToState("quickeat")
		end    end    
		end
   --I wear hats
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end		
    end
	
local function OnEat(inst, food, item)
inst.components.health:DoDelta(15)
inst.components.hunger:DoDelta(10)
if food.components.edible and food.components.edible.hungervalue > 20 or food.components.edible.healthvalue > 15 then
inst.components.health:DoDelta(100)
inst.components.hunger:DoDelta(50)
end end

 local function Hiding(inst) 
 inst.components.talker:Say("Hide !")
	end

local function HideInShadow(inst)
local player = inst.components.follower.leader
if inst.components.hunger.current <= 0 and not inst.time then
inst.time = true
end
if inst.time and not inst.bye then
	inst.sg:GoToState("talk") 
	inst.components.locomotor:Stop()
	--inst:DoTaskInTime( 2, function() inst.sg:GoToState("idle") end)
	inst.components.talker:Say("It's time, See you again, Musha..")  inst.hide = true
	if player then
	player:DoTaskInTime( 1, function() player.components.talker:Say("may the force be with you..") end) end
		inst.bye = true
	inst:DoTaskInTime(1.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(inst:GetPosition():Get()) 
	inst:Remove() 	
	end) end)
	end

if player and player.components.health:IsDead() and not inst.player_die then
inst.player_die = true
inst.sg:GoToState("talk")
inst.components.locomotor:Stop()
--inst:DoTaskInTime( 3, function() inst.sg:GoToState("idle") end)
		if math.random() < 0.2 then
inst.components.talker:Say("No !!")
elseif math.random() < 0.2  then
inst.components.talker:Say("No!!!")
elseif math.random() < 0.2  then
inst.components.talker:Say("Sorry..!!")
elseif math.random() < 0.2  then
inst.components.talker:Say("Oh no..")
elseif math.random() < 1  then
inst.components.talker:Say("Forgive me.. I can't protect you..")
end
inst:DoTaskInTime(3, function() inst.hide = true end)
inst:DoTaskInTime(0.25, function() inst:Remove() end)
end
 if inst.hiding then
 	--Hiding(inst) 
	inst.hiding = false
	inst.hide = true
	inst.components.health:SetInvincible(true)
	inst:AddTag("hiding")
	inst:DoTaskInTime(2, function() inst:RemoveTag("hiding")
	inst.sneak_attack = true
	inst.components.health:SetInvincible(false) end)
	inst:DoTaskInTime(6, function() if inst.hide then
	inst.hide = false end end)
	end
 if inst.hide and not inst:HasTag("notarget") then	
	inst:AddTag("notarget")
 		if inst.pop then 
		inst.pop = false
		local fx = SpawnPrefab("statue_transition_2")
fx.Transform:SetScale(1.5,1.5, 1.5)
fx.Transform:SetPosition(inst:GetPosition():Get())
				end
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.4)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.4)	
inst.components.colourtweener:StartTween({0.1,0.1,0.1,.05}, 0)
 elseif not inst.hide and inst:HasTag("notarget") then
 inst:RemoveTag("notarget")
		if not inst.pop then 
		inst.pop = true
		local fx = SpawnPrefab("statue_transition_2")
fx.Transform:SetScale(1.5,1.5, 1.5)
fx.Transform:SetPosition(inst:GetPosition():Get())
				end
 inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED )
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED )	
		inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
end
end
		
local function OnAttacked(inst, data)
if math.random() < 0.2 and not inst.hiding and inst.components.health:GetPercent() <= 0.7 then
 inst.hiding = true
end
if inst.sneak_attack then
inst.hide = false
inst.sneak_attack = false
end
if data.attacker:HasTag("musha") then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
inst.time = true
elseif not data.attacker:HasTag("musha") then
    inst.components.combat:SuggestTarget(data.attacker)
    --inst.components.combat:ShareTarget(data.attacker, 3, function(dude) return dude:HasTag("companion") and not dude.components.health:IsDead() end, 5)
end
end

local function OnHitfreeze(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
if other and other:HasTag("player") then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
end
if inst.sneak_attack and other and other.components.freezable and inst.components.health:GetPercent() <= 0.7 then
        other.components.freezable:AddColdness(2)
        other.components.freezable:SpawnShatterFX()
		
            local fx2 = SpawnPrefab("groundpoundring_fx")
	 	  fx2.Transform:SetScale(0.6, 0.6, 0.6)
	  	  fx2.Transform:SetPosition(other:GetPosition():Get())
			
				inst.sneak_attack = false 
				inst.hide = false 
	end 
if math.random() < 0.2 and not inst.hiding and other and other.components.health then
 inst.hiding = true
 end
if inst.hide or inst.sneak_attack then
 inst.hide = false
 inst.sneak_attack = false
end
   local pos = other:GetPosition()
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.1)
        other.components.freezable:SpawnShatterFX()
	elseif other and other.components.freezable and math.random() < 0.2 then
        other.components.freezable:AddColdness(1)
        other.components.freezable:SpawnShatterFX()
		
            local fx2 = SpawnPrefab("groundpoundring_fx")
	 	  fx2.Transform:SetScale(0.6, 0.6, 0.6)
	  	  fx2.Transform:SetPosition(other:GetPosition():Get())
		  
    end
end
end

local function tryproc(inst)
if not inst.shield_on and inst.components.health:GetPercent() < .1  then
            cure1_proc(inst)
    end end
	
local function Onhunt(inst, target)
    return inst.components.combat:CanTarget(target)
end

	
local function hound_hunt(inst)
    if not inst.active_hunt and not inst.peace then
if inst.combat_no then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end
 end
    local dist = 30
    if inst.active_hunt then

    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
      {"musha","player","wall","houndmound","structure","companion","yamche","beefalo","koalefant","arongb","pig","bee","rocky","bird","statue","character","abigail","smashable","veggie","shadowminion"})
	
 elseif not inst.active_hunt and inst.peace then
 inst.components.combat:SetTarget(nil)

end 	
end

local function assasin_hunt(inst)
    local dist = 6
if inst.combat_no then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end
if inst.fighting then
    return FindEntity(inst, dist, function(guy)
	return inst.components.combat:CanTarget(guy) 
     end,
    nil,
     {"musha","player","wall","houndmound","structure","companion","yamche","animal","beefalo","koalefant","pig","bee","insect","rocky","bird","statue","frog","prey","character","companion","webber","abigail","smashable","veggie"})
	end
	end

local function sleep(inst)	
local player = inst.components.follower.leader
if player and player:HasTag("musha") then
if player.sleep_on or player.tiny_sleep then
inst.sleep = true
end
if (player.sleep_on or player.tiny_sleep) and inst.sleep and not inst.sleep_on then
inst:DoTaskInTime(0, function() 
inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw") 
inst.AnimState:PlayAnimation("bedroll",true) 
inst.sg:GoToState("bedroll")
inst.sleep_on = true end)
end
if inst.sleep_on and inst.AnimState:AnimDone() and not inst.wakeup_check then
inst.wakeup_check = true
inst.AnimState:PlayAnimation("bedroll_sleep_loop", true) 
end

if not player.sleep_on and not player.tiny_sleep and inst.sleep and inst.sleep_on and inst.wakeup_check then
inst:DoTaskInTime(1, function() 
--inst.sg:GoToState("wakeup")
inst.sleep = false
inst.sleep_on = false
inst.wakeup_check = false
inst.wakeup_on = true
end)
end 

if inst.sleep_on then
inst.components.health:StartRegen(10, 1)
inst.components.hunger:SetRate(0)
elseif not inst.sleep_on then
inst.components.health:StartRegen(1, 10)
inst.components.hunger:SetRate(0.25)
end 
if inst.wakeup_on then
inst.wakeup_on = false
inst.sg:GoToState("wakeup")
inst.sg:RemoveStateTag("sleeping")
end

end
end

local function item_set(inst)

if TheWorld.state.isnight and not inst.hat3 then	
inst.hat3 = true

inst.hat2 = false
inst.hat1 = false
inst.equipfn3(inst, inst.items["HAT3"])
inst.Light:Enable(true)
elseif inst.fight and not TheWorld.state.isnight and not inst.hat2 then	
inst.hat2 = true

inst.hat1 = false
inst.hat3 = false
inst.equipfn3(inst, inst.items["HAT2"])
inst.Light:Enable(false)
elseif not inst.fight and not TheWorld.state.isnight and not inst.hat1 then	
inst.hat1 = true

inst.hat2 = false
inst.hat3 = false
inst.equipfn3(inst, inst.items["HAT1"])
inst.Light:Enable(false)
end

local player = inst.components.follower.leader
if not inst.equip_set then
if player and player:HasTag("musha") then
if player.level >=0 and player.level <200  then --1
inst.LV1 = true
	inst.equipfn(inst, inst.items["SWORD1"])
	inst.equipfn2(inst, inst.items["BODY"])
	inst.components.combat:SetDefaultDamage(15)
	inst.components.health:SetMaxHealth(300)
inst.components.health:SetAbsorptionAmount(0.15)	
elseif 	player.level >=200 and player.level <530  then	--2
inst.LV2 = true
	inst.equipfn(inst, inst.items["SWORD2"])
	inst.equipfn2(inst, inst.items["BODY1"])
	inst.components.combat:SetDefaultDamage(25)
	inst.components.health:SetMaxHealth(500)

inst.components.health:SetAbsorptionAmount(0.25)

elseif 	player.level >=530 and player.level <1340  then	--3
inst.LV3 = true
	inst.equipfn(inst, inst.items["SWORD3"])
	inst.equipfn2(inst, inst.items["BODY2"])	
	inst.components.combat:SetDefaultDamage(35)
	inst.components.health:SetMaxHealth(600)
	inst.AnimState:OverrideSymbol("beard", "beard", "beard_short")

inst.components.health:SetAbsorptionAmount(0.35)

elseif 	player.level >=1340 and player.level <2290  then	--4
inst.LV4 = true
	inst.equipfn(inst, inst.items["SWORD4"])
	inst.equipfn2(inst, inst.items["BODY3"])	
	inst.components.combat:SetDefaultDamage(45)
	inst.components.health:SetMaxHealth(700)
	
	inst.AnimState:OverrideSymbol("beard", "beard", "beard_short")

inst.components.health:SetAbsorptionAmount(0.45)
	
elseif 	player.level >=2290 and player.level <4200  then	--5
inst.LV5 = true
	inst.equipfn(inst, inst.items["SWORD5"])
	inst.equipfn2(inst, inst.items["BODY4"])	
inst.components.combat:SetDefaultDamage(55)	
	inst.components.health:SetMaxHealth(800)
	
       inst.AnimState:OverrideSymbol("beard", "beard", "beard_medium")

inst.components.health:SetAbsorptionAmount(0.55)
	   
elseif 	player.level >=4200 and player.level <7000  then	--6
inst.LV6 = true
	inst.equipfn(inst, inst.items["SWORD6"])
	inst.equipfn2(inst, inst.items["BODY5"])		
	inst.components.combat:SetDefaultDamage(65)
	inst.components.health:SetMaxHealth(900)
	
       inst.AnimState:OverrideSymbol("beard", "beard", "beard_medium")

inst.components.health:SetAbsorptionAmount(0.65)
	   
elseif 	player.level >=7000 then	-- 7
inst.LV7 = true
	inst.equipfn(inst, inst.items["SWORD6"])
	inst.equipfn2(inst, inst.items["BODY6"])		
	inst.components.combat:SetDefaultDamage(65)
	inst.components.health:SetMaxHealth(1000)
	
       inst.AnimState:OverrideSymbol("beard", "beard", "beard_long")

inst.components.health:SetAbsorptionAmount(0.75)
	   
	end
	inst.equip_set = true
end
end
--if player then
--inst.equip_set = false
--end
end

local function on_close(inst)
local player = inst.components.follower.leader
if player then
inst.fighting = true
inst.combat_no = false
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
end 
	end
	
local function far(inst)
local player = inst.components.follower.leader
if player then
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.25)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.25)
inst.combat_no = true
inst.fighting = false
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end
end


local function fn()
  local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
	
	inst.Transform:SetFourFaced(inst)

    MakeCharacterPhysics(inst, 1, .5) 
 	
	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("assasin_wilson")
	inst.AnimState:PlayAnimation("idle")

    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("hat")
    inst.AnimState:Hide("hat_hair")

    inst:AddTag("scarytoprey")
 
	inst.soundsname = "wilson"
	inst.talker_path_override = "dontstarve/characters/"

	--inst:AddTag("NOCLICK")
	--inst:AddTag("assasin")
	inst:AddTag("character")
	inst:AddTag("companion")
	inst:AddTag("yamche")
	--inst:AddTag("musha_slave")
	inst:AddTag("bodyguard_w")
	inst:AddTag("notraptrigger")
-----------light on
    inst.entity:AddLight()
	inst.Light:SetRadius(2.1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.7)
    inst.Light:SetColour(185/255,175/255,170/255)
	inst.Light:Enable(false)	
	
	--inst.components.eater.monsterimmune = true
	
			    inst:AddComponent("talker")
    inst.components.talker.fontsize = 30
    inst.components.talker.colour = Vector3(1, 0.6, 0.75, 1)
--	inst.Transform:SetScale(1.1,1.1,1.1)
			inst.hurtsoundoverride = "wilson"
		inst.talker_path_override = "wilson"
	
	inst:AddComponent("colourtweener")
	--inst.components.colourtweener:StartTween({.1,.1,.1,.1}, 0)
	
	--inst:DoTaskInTime(2, function() inst.hide = true end)
	
       	if not TheWorld.ismastersim then
   return inst
end	
inst.entity:SetPristine()		

		inst:AddComponent("locomotor")
	--inst.components.locomotor.triggerscreep = false	
	
   inst:AddComponent("follower")
    inst:AddComponent("combat")
    inst.components.combat.playerdamagepercent = 0
    inst.components.combat.hiteffectsymbol = "torso"
	inst.components.combat:SetRetargetFunction(1, hound_hunt)
	--inst.components.combat:SetRetargetFunction(0, assasin_hunt)
    inst.components.combat:SetKeepTargetFunction(Onhunt)
    inst.components.combat:SetAttackPeriod(1.5)
    inst.components.combat:SetRange(2, 3)
	
     inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(7, 8)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
  
    inst:AddComponent("health")
	inst.components.health:SetMaxHealth(850)
	inst.components.health:StartRegen(1, 10)
	inst:AddComponent("hunger")
	inst.components.hunger:SetRate(0.25)		
	inst.components.hunger:SetMax(300)
	
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI } )
	inst.components.eater.strongstomach = true
   -- inst.components.eater:SetCanEatRaw()
    inst.components.eater:SetOnEatFn(OnEat)
	
	inst:AddComponent("inventory")
    inst.components.inventory.dropondeath = false
    inst:AddComponent("beard")
   inst.components.beard.prize = "beardhair"
   
	    inst.items = items
    inst.equipfn = EquipItem
	inst.equipfn2 = EquipArmor
	inst.equipfn3 = EquipHead
	inst.equipfna = EquipAxe
	inst.equipfnp = EquipPickaxe
	EquipItem(inst)
	EquipArmor(inst)
	EquipHead(inst)
	
	inst.equipfn(inst, inst.items["SWORD1"])
	inst.equipfn2(inst, inst.items["BODY"])
	inst.equipfn3(inst, inst.items["HAT3"])
	inst.components.combat:SetDefaultDamage(5)

inst:ListenForEvent("death", ondeath)

	    inst.procfn = function() tryproc(inst) end
        inst:ListenForEvent("attacked", inst.procfn)
		inst:ListenForEvent("attacked", OnAttacked)
		inst:ListenForEvent("onhitother", OnHitfreeze)
	inst.hideinshadow = inst:DoPeriodicTask(0,HideInShadow)
	inst.sleep = inst:DoPeriodicTask(1,sleep)
	inst.item_set = inst:DoPeriodicTask(2,item_set)
	inst.hunt = inst:DoPeriodicTask(16, lightning)
	inst.Power_check = inst:DoPeriodicTask(1, Power_check)
	inst.chat = inst:DoPeriodicTask(60, chat)
	
	    inst:ListenForEvent("onhitother", OnRanger)
  
  
	inst:SetBrain(brain)
	inst:SetStateGraph("SGassasin_w")
	
		return inst
end
return Prefab("common/assasin_wilson", fn, assets, prefabs)


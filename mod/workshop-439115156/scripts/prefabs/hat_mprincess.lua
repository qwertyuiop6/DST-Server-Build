local assets=
{
	Asset("ANIM", "anim/hat_mprincess.zip"),
  Asset("ATLAS", "images/inventoryimages/hat_mprincess.xml"),
  Asset("IMAGE", "images/inventoryimages/hat_mprincess.tex"),
  	Asset("ANIM", "anim/hat_mcrown.zip"),
}

local function Break(inst)
inst:DoTaskInTime(1.5, function() SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get()) SpawnPrefab("glowdust").Transform:SetPosition(inst:GetPosition():Get()) inst:Remove() end)
end
	
local function OnHaunt(inst, haunter)
    inst.components.hauntable:SetOnHauntFn()
	if haunter:HasTag("musha") then
	SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime(1.5, function() Break(inst) end)
	return true
end end

local function Resurrection_crown(inst, guy)
    TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_break")
   
end
--------------
local function healowner(inst, owner)
if inst.healing1 and not inst.broken then
    if (owner.components.health and owner.components.health:IsHurt())then
        owner.components.health:DoDelta(1,false)
end end end
--------------growable
local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say("-[Princess Crown]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("-[Princess Crown] \n[Grow Points]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say("-[Queen Crown] \n[Grow Points]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say("-[Queen Crown] \n[MAX]")
end
end

local function onpreload(inst, data)
	if data then
		if data.level then
		inst.level = data.level
			levelexp(inst)
end
	end
		end
		
local function onsave(inst, data)
	data.level = inst.level
end
---------------------------------------
local function UpgradeArmor(inst, data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
inst.healing1 = false
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
inst.components.fueled:StopConsuming()        
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0)
inst.components.talker:Say("-[Broken Crown]\nSanity Regen(Tiny)\nArmor(0)\nDurability (0)")
  
elseif not inst.broken and not inst.shield then

 if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.11)
inst.components.talker:Say("-[Princess Crown(LV1)]\nSanity Regen(Tiny)\nArmor(11)")
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.12)
inst.components.talker:Say("-[Princess Crown(LV2)]\nSanity Regen(Tiny)\nArmor(12)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.13)
inst.components.talker:Say("-[Princess Crown(LV3)]\nSanity Regen(Tiny)\nArmor(13)")
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.14)
inst.components.talker:Say("-[Princess Crown(LV4)]\nSanity Regen(Tiny)\nArmor(14)")
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.15)
inst.components.talker:Say("-[Princess Crown(LV5)]\nSanity Regen(Tiny)\nArmor(15)")
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.16)
inst.components.talker:Say("-[Princess Crown(LV6)]\nSanity Regen(Tiny)\nArmor(16)")
 elseif inst.level >=120 and inst.level <150 then
  inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.17)
inst.components.talker:Say("-[Princess Crown(LV7)]\nSanity Regen(Tiny)\nArmor(17)")
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.18)
inst.components.talker:Say("-[Princess Crown(LV8)]\nSanity Regen(Tiny)\nArmor(18)")
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.19)
inst.components.talker:Say("-[Princess Crown(LV9)]\nSanity Regen(Tiny)\nArmor(19)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.20)
inst.components.talker:Say("-[Princess Crown(LV10)]\nSanity Regen(Tiny)\nArmor(20)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.21)
inst.components.talker:Say("-[Princess Crown(LV11)]\nSanity Regen(Tiny)\nArmor(21)")
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.22)
inst.components.talker:Say("-[Princess Crown(LV12)]\nSanity Regen(Tiny)\nArmor(22)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.23)
inst.components.talker:Say("-[Princess Crown(LV13)]\nSanity Regen(Tiny)\nArmor(23)")
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.24)
inst.components.talker:Say("-[Princess Crown(LV14)]\nSanity Regen(Tiny)\nArmor(24)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.25)
inst.components.talker:Say("-[Princess Crown(LV15)]\nSanity Regen(Tiny)\nArmor(25)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.26)
inst.components.talker:Say("-[Princess Crown(LV16)]\nSanity Regen(Tiny)\nArmor(26)")
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.27)
inst.components.talker:Say("-[Princess Crown(LV17)]\nSanity Regen(Tiny)\nArmor(27)")
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.28)
inst.components.talker:Say("-[Princess Crown(LV18)]\nSanity Regen(Tiny)\nArmor(28)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.29)
inst.components.talker:Say("-[Princess Crown(LV19)]\nSanity Regen(Tiny)\nArmor(29)")
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.30)
inst.components.talker:Say("-[Queen Crown(LV20)]\nSanity Regen(Small)\nHealing(slow)\nArmor(30)")
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.32)
inst.components.talker:Say("-[Queen Crown(LV21)]\nSanity Regen(Small)\nHealing(slow)\nArmor(32)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.34)
inst.components.talker:Say("-[Queen Crown(LV22)]\nSanity Regen(Small)\nHealing(slow)\nArmor(34)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.36)
inst.components.talker:Say("-[Queen Crown(LV23)]\nSanity Regen(Small)\nHealing(slow)\nArmor(36)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.38)
inst.components.talker:Say("-[Queen Crown(LV24)]\nSanity Regen(Small)\nHealing(slow)\nArmor(38)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.40)
inst.components.talker:Say("-[Queen Crown(LV25)]\nSanity Regen(Small)\nHealing(slow)\nArmor(40)")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.42)
inst.components.talker:Say("-[Queen Crown(LV26)]\nSanity Regen(Small)\nHealing(slow)\nArmor(42)")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.44)
inst.components.talker:Say("-[Queen Crown(LV27)]\nSanity Regen(Small)\nHealing(slow)\nArmor(44)")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.46)
inst.components.talker:Say("-[Queen Crown(LV28)]\nSanity Regen(Small)\nHealing(slow)\nArmor(46)")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.48)
inst.components.talker:Say("-[Queen Crown(LV29)]\nSanity Regen(Small)\nHealing(slow)\nArmor(48)")
elseif inst.level >=4000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.50)
inst.components.talker:Say("-[Queen Crown(LV30)]\nSanity Regen(Small)\nHealing(slow)\nArmor(50)")
end
end
end

local function OnDurability(inst, data)
inst.broken = true
 	UpgradeArmor(inst)
	inst.components.fueled:StopConsuming()        
	if inst.consume then inst.consume:Cancel() inst.consume = nil end
 end
local function forgelab(inst, data)
 if inst.active_forge then
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 6, {"forge_musha"})
for k,v in pairs(ents) do
if inst.active_forge then
v.active_forge =  true
inst.active_forge = false
end end 
 end end
-------- --------
local function TakeItem(inst, item, data)
local expchance0 = 1
local expchance1 = 0.3
local expchance2 = 0.2
local expchance3 = 0.12
	inst.components.fueled:DoDelta(5000000)
	SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())    
UpgradeArmor(inst)
 if not inst.forgelab_on then
   if math.random() < expchance1 and inst.level <= 4005 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say("-[Princess Crown] \nLucky Points ! +(2)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-[Princess Crown] \nLucky Points ! +(5)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-[Princess Crown] \nLucky Points ! +(8)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance0 and inst.level <= 4005 then
	inst.level = inst.level + 1
	levelexp(inst)
    end
elseif inst.forgelab_on then
inst.active_forge = true
forgelab(inst)
	  if math.random() < expchance1 and inst.level <= 4005 then
	inst.level = inst.level + 10
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(10)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 25
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(25)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 40
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(40)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance0 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(5)\n[Grow Points]".. (inst.level))
    end
	inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
end
	if inst.broken then
	inst.broken = false 
	end
end

-------- --------

local function OnLoad(inst, data)
    UpgradeArmor(inst)
end
---------------------------------------shield on
local function consume(inst, owner)
if not inst.broken and inst.shield then
inst.components.fueled:DoDelta(-20000)
end
if inst.broken and inst.shield then
inst.components.fueled:DoDelta(0)
end
end

local function on_shield(inst, owner)
if inst.shield and not inst.broken then
inst.components.talker:Say("[Shield On]\nArmor(100)")
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 1)
    inst.consume = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
	
	elseif inst.shield and inst.broken then
inst.components.talker:Say("[Broken Shield]\nArmor(0)")
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0)
      if inst.consume then inst.consume:Cancel() inst.consume = nil end
end end

local function off_shield(inst)
if inst.shield then
inst.shield = false
UpgradeArmor(inst)
   if inst.consume then inst.consume:Cancel() inst.consume = nil end
end end
--------------Shield hat
    local function stopusingshield(inst, data)
        local hat = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if hat and not (data.statename == "hide_idle" or data.statename == "hide") then
		inst.shield = false
        hat.components.useableitem:StopUsingItem()
        end
    end
local function OnPutInInventory(inst)
inst.healing1 = false
      UpgradeArmor(inst)
    end 
		
    local function onequipcrown(inst, owner)
	if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
         owner.components.inventory:Unequip(EQUIPSLOTS.HEAD, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	   UpgradeArmor(inst)
	   	inst.components.fueled:StartConsuming() 
     owner.AnimState:OverrideSymbol("swap_hat", "hat_mprincess", "swap_hat")
     owner.AnimState:Show("HAT")
       owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
	if inst.level <1200 then --750 LV16
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_TINY
	elseif inst.level >=1200 then	--1400 LV21
	inst.healing1 = true
     owner.AnimState:OverrideSymbol("swap_hat", "hat_mcrown", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
			if inst.healing1 and not inst.broken then
		    inst.heal = inst:DoPeriodicTask(60, function() healowner(inst, owner) end)
 		end end

    inst.expfn = function(attacked, data)
local expchance = 0.5
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1
if not inst.shield then
if data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 10 then
inst.components.fueled:DoDelta(-50000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 10 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 20 then
inst.components.fueled:DoDelta(-80000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 20 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 30 then
inst.components.fueled:DoDelta(-110000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 30 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 40 then
inst.components.fueled:DoDelta(-140000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 40 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 50 then
inst.components.fueled:DoDelta(-170000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 50 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 60 then
inst.components.fueled:DoDelta(-300000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 60 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 70 then
inst.components.fueled:DoDelta(-330000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 70 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 60 then
inst.components.fueled:DoDelta(-360000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 70 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 80 then
inst.components.fueled:DoDelta(-390000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 80 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 90 then
inst.components.fueled:DoDelta(-450000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 90 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 100 then
inst.components.fueled:DoDelta(-600000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 100 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 100 then
inst.components.fueled:DoDelta(-850000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 100 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 150 then
inst.components.fueled:DoDelta(-1000000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 150 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 200 then
inst.components.fueled:DoDelta(-1400000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 200 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 250 then
inst.components.fueled:DoDelta(-1800000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 250 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 300 then
inst.components.fueled:DoDelta(-2600000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 300 then
inst.components.fueled:DoDelta(-3000000)
end

if data and data.attacker and math.random() < damagedur1 then
inst.components.fueled:DoDelta(-50000)
elseif data and data.attacker and math.random() < damagedur2 then
inst.components.fueled:DoDelta(-30000)
elseif data and data.attacker and math.random() < damagedur3 then
inst.components.fueled:DoDelta(-10000)
end

if data and data.attacker and math.random() < expchance and inst.level < 4010 then
	inst.level = inst.level + 1
			levelexp(inst)

		end 
	    end
	end
	   inst:ListenForEvent("attacked", inst.expfn, owner)
	inst:ListenForEvent("newstate", stopusingshield, owner) 
	end

    local function onunequipcrown(inst, owner)
	inst.healing1 = false

	inst.components.fueled:StopConsuming()
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

            owner.AnimState:Show("HEAD")
            owner.AnimState:Hide("HEAD_HAIR")
	inst.shield = false
		if inst.consume then inst.consume:Cancel() inst.consume = nil end
	    if inst.healowner then inst.healowner:Cancel() inst.healowner = nil end
		   
inst:RemoveEventCallback("attacked", inst.expfn, owner)
inst:RemoveEventCallback("newstate", stopusingshield, owner) 
    end
 
 local function onuseshield(inst)
 if not inst.broken then
	inst.shield = true
	on_shield(inst)
local owner = inst.components.inventoryitem.owner
        if owner then
            owner.sg:GoToState("hide")
owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
        end
		
		elseif inst.broken then
		
		end
    end

local function offuseshield(inst)
   if inst.consume then inst.consume:Cancel() inst.consume = nil end
	off_shield(inst)
	inst.healing1 = false
	end

---------------bushhat end
	
local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

     MakeInventoryPhysics(inst)  

    inst.AnimState:SetBank("bushhat")
    inst.AnimState:SetBuild("hat_mprincess")
    inst.AnimState:PlayAnimation("anim")
	
    inst:AddTag("hat")
	 inst:AddTag("musha_items")
    inst:AddTag("metal")
	inst:AddTag("hide")
	inst:AddTag("waterproofer")
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "hat_mprincess.tex" )
	
 
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
     inst.components.talker.colour = Vector3(1, 0.8, 0.95, 1)
    inst.components.talker.offset = Vector3(0,-500,0)
    inst.components.talker.symbol = "swap_object"
	

		

	  inst.entity:SetPristine()
	    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
 	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mprincess.xml"
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/bushhat"
    inst:AddComponent("armor")
	inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.11)
	   inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
  
    inst:AddComponent("useableitem")
       inst.components.useableitem:SetOnUseFn(onuseshield)
       inst.components.useableitem:SetOnStopUseFn(offuseshield)
       inst.components.equippable:SetOnEquip( onequipcrown )
       inst.components.equippable:SetOnUnequip( onunequipcrown )
 
    inst.OnLoad = OnLoad

        inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
        inst.components.fueled:InitializeFuelLevel(25000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
inst.components.fueled:StartConsuming()        
----------resurrect
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)
    inst:ListenForEvent("activateresurrection", Resurrection_crown)	
------------	
	inst.level = 0
inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
    return inst
end
---------------------------------
return Prefab( "common/inventory/hat_mprincess", fn, assets ) 

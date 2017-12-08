local assets=
{
	--Asset("ANIM", "anim/swap_pirate_booty_bag.zip"),
	Asset("ANIM", "anim/swap_pirate_musha_bag.zip"),
	Asset( "ANIM", "anim/armor_pirate.zip"),
	
}

local function levelexp(inst,data)

	local max_exp = 4005
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say("-[Pirate Chest]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say("-[Pirate Chest] \n[Grow Points]\n".. (inst.level).."/4000")
elseif inst.level >=4000 then
inst.components.talker:Say("-[Pirate Chest] \n[Max]")
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
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
 inst.components.fueled:StopConsuming()        
    inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0)
inst.components.talker:Say("-[Broken Musha-Armor]\nArmor (0)\nDurability (0)")
  
elseif not inst.broken then

 if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.02)
inst.components.talker:Say("-[Pirate Chest (LV1)]\nArmor (2)")
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.04)
inst.components.talker:Say("-[Pirate Chest (LV2)]\nArmor (4)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.06)
inst.components.talker:Say("-[Pirate Chest (LV3)]\nArmor (6)")
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.08)
inst.components.talker:Say("-[Pirate Chest (LV4)]\nArmor (8)")
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.1)
inst.components.talker:Say("-[Pirate Chest (LV5)]\nArmor (10)")
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.12)
inst.components.talker:Say("-[Pirate Chest (LV6)]\nArmor (12)")
 elseif inst.level >=120 and inst.level <150 then
  inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.14)
inst.components.talker:Say("-[Pirate Chest (LV7)]\nArmor (14)")
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.16)
inst.components.talker:Say("-[Pirate Chest (LV8)]\nArmor (16)")
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.18)
inst.components.talker:Say("-[Pirate Chest (LV9)]\nArmor (18)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.20)
inst.components.talker:Say("-[Pirate Chest (LV10)]\nArmor (20)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.22)
inst.components.talker:Say("-[Pirate Chest (LV11)]\nArmor (22)")
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.24)
inst.components.talker:Say("-[Pirate Chest (LV12)]\nArmor (24)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.26)
inst.components.talker:Say("-[Pirate Chest (LV13)]\nArmor (26)")
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.28)
inst.components.talker:Say("-[Pirate Chest (LV14)]\nArmor (28)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.30)
inst.components.talker:Say("-[Pirate Chest (LV15)]\nArmor (30)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.31)
inst.components.talker:Say("-[Pirate Chest (LV16)]\nArmor (31)")
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.32)
inst.components.talker:Say("-[Pirate Chest (LV17)]\nArmor (32)")
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.33)
inst.components.talker:Say("-[Pirate Chest (LV18)]\nArmor (33)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.34)
inst.components.talker:Say("-[Pirate Chest (LV19)]\nArmor (34)")
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.35)
inst.components.talker:Say("-[Pirate Chest (LV20)]\nArmor (35)")
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.36)
inst.components.talker:Say("-[Pirate Chest (LV21)]\nArmor (36)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.37)
inst.components.talker:Say("-[Pirate Chest (LV22)]\nArmor (37)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.38)
inst.components.talker:Say("-[Pirate Chest (LV23)]\nArmor (38)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.39)
inst.components.talker:Say("-[Pirate Chest (LV24)]\nArmor (39)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.4)
inst.components.talker:Say("-[Pirate Chest (LV25)]\nArmor (40)")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.41)
inst.components.talker:Say("-[Pirate Chest (LV26)]\nArmor (41)")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.42)
inst.components.talker:Say("-[Pirate Chest (LV27)]\nArmor (42)")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.43)
inst.components.talker:Say("-[Pirate Chest (LV28)]\nArmor (43)")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.44)
inst.components.talker:Say("-[Pirate Chest (LV29)]\nArmor (44)")
elseif inst.level >=4000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.45)
inst.components.talker:Say("-[Pirate Chest (LV30)]\nArmor (45)")
end
end
end

local function OnDurability(inst, data)
inst.broken = true
 	UpgradeArmor(inst)
	inst.components.fueled:StopConsuming()        
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
inst.broken = false      
UpgradeArmor(inst)
 if not inst.forgelab_on then
   if math.random() < expchance1 and inst.level <= 4005 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say("-[Pirate Chest] \nLucky Points ! +(2)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-[Pirate Chest] \nLucky Points ! +(5)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-[Pirate Chest] \nLucky Points ! +(8)\n[Grow Points]".. (inst.level))
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
--------

local function SpawnGold(inst, owner)
	
	inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")

    local goldnugget = SpawnPrefab("goldnugget")
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,2,0)

    goldnugget.Transform:SetPosition(pt:Get())
    local angle = owner.Transform:GetRotation()*(PI/180)
    local sp = (math.random()+1) * -1
    goldnugget.Physics:SetVel(sp*math.cos(angle), math.random()*2+2, -sp*math.sin(angle))
    goldnugget.components.inventoryitem:OnDropped()
	
end

local function OnBlocked(owner)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function OnOpen(inst)
  --  inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
end 

local function OnClose(inst) 
 --   inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
	 	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
end 

local function onequip(inst, owner)
if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
        owner.components.inventory:Unequip(EQUIPSLOTS.BODY, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	inst:ListenForEvent("blocked", OnBlocked, owner)
   UpgradeArmor(inst)
   inst.components.fueled:StartConsuming()
     
    if inst.Pirate then  
	owner.AnimState:OverrideSymbol("swap_body", "armor_pirate", "swap_body")
	elseif inst.Green then  
	owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "swap_body")
	elseif inst.Pink then  
	owner.AnimState:OverrideSymbol("swap_body", "armor_mushab", "swap_body")
	elseif inst.Blue then  
	owner.AnimState:OverrideSymbol("swap_body", "armor_frostar", "swap_body")
	elseif inst.Chest then 
    owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_musha_bag", "backpack")
	owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_musha_bag", "swap_body")
	end
if inst.Bmm then
   owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack5_mini", "swap_body_tall")
   elseif inst.BT then
   owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack4_mini", "swap_body_tall")
   elseif inst.BS then
   owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack3", "swap_body_tall")
   elseif inst.BM then
   owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack", "swap_body_tall")
   elseif inst.BL then
   owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack2", "swap_body_tall")
   elseif inst.WSP then
   owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_pink_s", "swap_body_tall")
   elseif inst.WSR then
   owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_s", "swap_body_tall")
   elseif inst.WSB then
   owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_blue_s", "swap_body_tall")
   elseif inst.WSH then
   owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_green_s", "swap_body_tall")
   elseif inst.WLR then
   owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly", "swap_body_tall")
   elseif inst.WLB then
   owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_blue", "swap_body_tall")
   end
   
	if inst.level <750 then
	--owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack2", "swap_body_tall")
	--owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "backpack")
    --owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "swap_body")
	elseif inst.level >=750 then
	--owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack2", "swap_body_tall")
	--owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "backpack")
    --owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "swap_body")
	end
	
  	  if inst.components.container ~= nil then
        inst.components.container:Open(owner)
		end
	
	inst.goldnugget_task = inst:DoPeriodicTask(TUNING.TOTAL_DAY_TIME, function() SpawnGold(inst, owner) end)
	
inst.defense = function(attacked, data)	
	if math.random() < 0.76 then
local shadowangle = math.random(1, 360)
local offset = FindWalkableOffset(inst:GetPosition(), shadowangle*DEGREES, math.random(2,2), 5, false, false)
local tentacle = SpawnPrefab("tentacle_shadow")
local x,y,z = inst.Transform:GetWorldPosition()
tentacle.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
	end
end
	
    inst.expfn = function(attacked, data)
local expchance = 0.5
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1

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
   inst:ListenForEvent("attacked", inst.expfn, owner)
   inst:ListenForEvent("attacked", inst.defense, owner)
	    end

local function onunequip(inst, owner)
inst:RemoveEventCallback("blocked", OnBlocked, owner)
inst.components.fueled:StopConsuming()        
      UpgradeArmor(inst)
    owner.AnimState:ClearOverrideSymbol("swap_body")
	owner.AnimState:ClearOverrideSymbol("backpack")
    owner.AnimState:ClearOverrideSymbol("swap_body_tall")
   -- owner.components.inventory:SetOverflow(nil)
   -- inst.components.container:Close(owner)
inst:RemoveEventCallback("attacked", inst.expfn, owner)  
inst:RemoveEventCallback("attacked", inst.defense, owner)
		    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
	inst.goldnugget_task:Cancel()
    inst.goldnugget_task = nil
	
end


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)

 	inst.AnimState:SetBank("pirate_booty_bag")
    inst.AnimState:SetBuild("swap_pirate_musha_bag")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("backpack")
    inst:AddTag("fridge")
    inst:AddTag("lowcool")
	inst:AddTag("musha_items")
		 
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "pirateback.tex" )	
	
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.6, 0.9, 0.9, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"	
	

	inst:AddTag("marble")

    inst.foleysound = "dontstarve/movement/foley/marblearmour"
	
   inst.entity:SetPristine()
	
	    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    --inst.components.inventoryitem.cangoincontainer = false
	
     --inst.components.inventoryitem.foleysound = "dontstarve_DLC002/common/foley/pirate_booty_pack"
	 --MakeInventoryFloatable(inst, "idle_water", "anim")
	
	--inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/marblearmour"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/pirateback.xml"
		
       inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

	    inst:AddComponent("armor")
	inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.02)
	
      inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("insulator")
	inst.components.insulator.insulation = TUNING.INSULATION_MED
	
  inst:AddComponent("container")
    inst.components.container:WidgetSetup("krampus_sack")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	
   --[[ inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_piggyback_2x6"
    inst.components.container.widgetanimbuild = "ui_piggyfrost_2x6"
    inst.components.container.widgetpos = Vector3(-5,-70,0)
    inst.components.container.side_widget = true
    inst.components.container.type = "pack"]]

   -- inst.components.container.onopenfn = onopen
   -- inst.components.container.onclosefn = onclose
   
          inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
        inst.components.fueled:InitializeFuelLevel(30000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
--inst.components.fueled:StartConsuming()      

  inst.OnLoad = OnLoad

	inst.level = 0
inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload


MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab( "common/inventory/pirateback", fn, assets)

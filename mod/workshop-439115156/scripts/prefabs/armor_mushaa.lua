local assets=
{
	Asset("ANIM", "anim/armor_mushaa.zip"),
  Asset("ATLAS", "images/inventoryimages/armor_mushaa.xml"),
  Asset("IMAGE", "images/inventoryimages/armor_mushaa.tex"),
Asset("ANIM", "anim/musha_backpack3.zip"),
}



local function levelexp(inst,data)

	local max_exp = 4600
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4500 then
--inst.components.talker:Say("-[Musha Armor]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4500 then
inst.components.talker:Say("-[Musha Armor] \n[Grow Points]\n".. (inst.level).."/4500(Upgrade)")
elseif inst.level >=4500 then
inst.components.talker:Say("-[Upgrade Armor]")
if inst.components.container then
inst.components.container:DropEverything() end
SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("armor_mushab").Transform:SetPosition(inst:GetPosition():Get())
inst:Remove()
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
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.5)
inst.components.talker:Say("-[Musha Armor (LV1)]\nArmor (50)")
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.51)
inst.components.talker:Say("-[Musha Armor (LV2)]\nArmor (51)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.52)
inst.components.talker:Say("-[Musha Armor (LV3)]\nArmor (52)")
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.53)
inst.components.talker:Say("-[Musha Armor (LV4)]\nArmor (53)")
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.54)
inst.components.talker:Say("-[Musha Armor (LV5)]\nArmor (54)")
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.55)
inst.components.talker:Say("-[Musha Armor (LV6)]\nArmor (55)")
 elseif inst.level >=120 and inst.level <150 then
  inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.56)
inst.components.talker:Say("-[Musha Armor (LV7)]\nArmor (56)")
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.57)
inst.components.talker:Say("-[Musha Armor (LV8)]\nArmor (57)")
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.58)
inst.components.talker:Say("-[Musha Armor (LV9)]\nArmor (58)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.59)
inst.components.talker:Say("-[Musha Armor (LV10)]\nArmor (59)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.60)
inst.components.talker:Say("-[Musha Armor (LV11)]\nArmor (60)")
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.61)
inst.components.talker:Say("-[Musha Armor (LV12)]\nArmor (61)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.62)
inst.components.talker:Say("-[Musha Armor (LV13)]\nArmor (62)")
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.63)
inst.components.talker:Say("-[Musha Armor (LV14)]\nArmor (63)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.64)
inst.components.talker:Say("-[Musha Armor (LV15)]\nArmor (64)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.65)
inst.components.talker:Say("-[Musha Armor (LV16)]\nArmor (65)")
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.66)
inst.components.talker:Say("-[Musha Armor (LV17)]\nArmor (66)")
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.67)
inst.components.talker:Say("-[Musha Armor (LV18)]\nArmor (67)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.68)
inst.components.talker:Say("-[Musha Armor (LV19)]\nArmor (68)")
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.69)
inst.components.talker:Say("-[Musha Armor (LV20)]\nArmor (69)")
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.70)
inst.components.talker:Say("-[Musha Armor (LV21)]\nArmor (70)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.71)
inst.components.talker:Say("-[Musha Armor (LV22)]\nArmor (71)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.72)
inst.components.talker:Say("-[Musha Armor (LV23)]\nArmor (72)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.73)
inst.components.talker:Say("-[Musha Armor (LV24)]\nArmor (73)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.74)
inst.components.talker:Say("-[Musha Armor (LV25)]\nArmor (74)")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.75)
inst.components.talker:Say("-[Musha Armor (LV26)]\nArmor (75)")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.76)
inst.components.talker:Say("-[Musha Armor (LV27)]\nArmor (76)")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.77)
inst.components.talker:Say("-[Musha Armor (LV28)]\nArmor (77)")
elseif inst.level >=3000 and inst.level <4500 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.78)
inst.components.talker:Say("-[Musha Armor (LV29)]\nArmor (78)")
elseif inst.level >=4500 then
inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.80)
inst.components.talker:Say("-[Musha Armor (LV30)]\nArmor (80)")
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
   if math.random() < expchance1 and inst.level <= 4600 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say("-[Musha Armor] \nLucky Points ! +(2)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4600 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-[Musha Armor] \nLucky Points ! +(5)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4600 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-[Musha Armor] \nLucky Points ! +(8)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance0 and inst.level <= 4600 then
	inst.level = inst.level + 1
	levelexp(inst)
     end
elseif inst.forgelab_on then
inst.active_forge = true
forgelab(inst)
	  if math.random() < expchance1 and inst.level <= 4600 then
	inst.level = inst.level + 10
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(10)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4600 then
	inst.level = inst.level + 25
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(25)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4600 then
	inst.level = inst.level + 40
	levelexp(inst)
	inst.components.talker:Say("[ Forge -Lucky Points x5]\n+(40)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance0 and inst.level <= 4600 then
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
--------
local function OnBlocked(owner)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function OnOpen(inst, owner) 
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
	end 
 end
 
local function OnClose(inst, owner)
	if inst.components.container ~= nil then
       inst.components.container:Close(owner)
    end
 end

local function onequip(inst, owner) 
if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
        owner.components.inventory:Unequip(EQUIPSLOTS.BODY, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end

	inst:ListenForEvent("blocked", OnBlocked, owner)
 	
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())	
    UpgradeArmor(inst)
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
	end 
	inst.components.fueled:StartConsuming() 
   owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "swap_body")
   
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
	    end

local function onunequip(inst, owner) 
 inst:RemoveEventCallback("blocked", OnBlocked, owner)
inst.components.fueled:StopConsuming()        
      UpgradeArmor(inst)
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("backpack")
	owner.AnimState:ClearOverrideSymbol("swap_body_tall")
	    inst:RemoveEventCallback("attacked", inst.expfn, owner)
	    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
		end
		end

		
local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
   MakeInventoryPhysics(inst)  
      	
    inst.AnimState:SetBank("armor_wood")
    inst.AnimState:SetBuild("armor_mushaa")
    inst.AnimState:PlayAnimation("anim")
	
		inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "armor_mushaa.tex" )
   inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.9, 1, 0.75, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"
	
	    inst:AddTag("backpack")
		 inst:AddTag("musha_items")
		 inst:AddTag("waterproofer")
	
	inst:AddTag("ruins")
    inst:AddTag("metal")

    inst.foleysound = "dontstarve/movement/foley/metalarmour"
	
    inst.entity:SetPristine()
  
		if not TheWorld.ismastersim then
		return inst
	end
	
    inst:AddComponent("inspectable")
    	inst.boost = true
      inst:AddComponent("inventoryitem")
	--inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/backpack"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/armor_mushaa.xml"
			  inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
	   
    --inst.components.inventoryitem.cangoincontainer = false
 
    inst:AddComponent("armor")
	inst.components.armor:InitCondition(9999999999999999999999999999999999999999999999999999999999999, 0.5)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
   
    --inst:AddComponent("container")
    --inst.components.container:WidgetSetup("icepack")
	--inst.components.container:WidgetSetup("mushaa")
	
	--inst.components.container.onopenfn = OnOpen
    --inst.components.container.onclosefn = OnClose
  	
    inst.OnLoad = OnLoad

        inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
        inst.components.fueled:InitializeFuelLevel(30000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
inst.components.fueled:StartConsuming()        

	inst.level = 0
inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    return inst
end

return Prefab( "common/inventory/armor_mushaa", fn, assets) 

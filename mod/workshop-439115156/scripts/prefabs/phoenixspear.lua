local assets=
{
	Asset("ANIM", "anim/phoenixspear.zip"),
	Asset("ANIM", "anim/swap_phoenixspear.zip"),
	Asset("ANIM", "anim/swap_phoenixspear2.zip"),
	Asset("ANIM", "anim/swap_phoenixspear_2r.zip"),
	Asset("ANIM", "anim/swap_phoenixspear_broken.zip"),
	Asset("ATLAS", "images/inventoryimages/phoenixspear.xml"),
	Asset("IMAGE", "images/inventoryimages/phoenixspear.tex"),
 
}
---------------------------

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say("[ Phoenix Spear ]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <510 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/510")
elseif inst.level >=510 and inst.level <950 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say("[ Phoenix Spear ] \n[Grow Points]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say("[ Phoenix Spear ] \n[MAX]")
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
	data.charge_time = inst.charge_time
end

local function OnDurability(inst, data)
inst.broken = true
    inst.components.weapon:SetDamage(1)
	inst.components.talker:Say("-Broken Phoenix Spear \nDamage (1)")
end

local function onblink(staff, pos, caster)

    if caster.components.sanity ~= nil then
        caster.components.sanity:DoDelta(-6)
    end
end

local function blinkstaff_reticuletargetfn()
    local player = ThePlayer
	local rotation = player.Transform:GetRotation() * DEGREES
    local pos = player:GetPosition()
    for r = 13, 1, -1 do
        local numtries = 2 * PI * r
        local pt = FindWalkableOffset(pos, rotation, r, numtries)
        if pt ~= nil then
            return pt + pos
        end
    end
end


local function Upgradedamage(inst,data)

if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end

if inst.broken then
   inst.components.weapon:SetDamage(1)
	inst.components.talker:Say("-Broken Flame Glaive \nDamage (1)")
	inst:RemoveComponent("blinkstaff")
elseif not inst.broken then

if inst.boost then
 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(75)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV1)\nDamage (75)\nFreeze(2D/20C)")
 elseif inst.level >=10 and inst.level <30 then
 inst.components.weapon:SetDamage(77)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV2)\nDamage (77)\nFreeze(2D/20C)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.weapon:SetDamage(79)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV3)\nDamage (79)\nFreeze(2D/20C)")
 elseif inst.level >=50 and inst.level <70 then
   inst.components.weapon:SetDamage(81)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV4)\nDamage (81)\nFreeze(2D/20C)")
 elseif inst.level >=70 and inst.level <90 then
  inst.components.weapon:SetDamage(83)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV5)\nDamage (83)\nFreeze(2D/20C)")
 elseif inst.level >=90 and inst.level <120 then
  inst.components.weapon:SetDamage(85)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV6)\nDamage (85)\nFreeze(2D/20C)")
 elseif inst.level >=120 and inst.level <150 then
 inst.components.weapon:SetDamage(87)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV7)\nDamage (87)\nFreeze(2D/20C)")
elseif inst.level >=150 and inst.level <180 then
 inst.components.weapon:SetDamage(89)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV8)\nDamage (89)\nFreeze(2D/20C)")
elseif inst.level >=180 and inst.level <210 then
 inst.components.weapon:SetDamage(91)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV9)\nDamage (91)\nFreeze(2D/20C)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.weapon:SetDamage(93)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV10)\nDamage (93)\nFreeze(4D/30C)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.weapon:SetDamage(95)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV11)\nDamage (95)\nFreeze(4D/30C)")
elseif inst.level >=350 and inst.level <450 then
  inst.components.weapon:SetDamage(97)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV12)\nDamage (97)\nFreeze(4D/30C)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.weapon:SetDamage(99)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV13)\nDamage (99)\nFreeze(4D/30C)")
elseif inst.level >=550 and inst.level <650 then
  inst.components.weapon:SetDamage(101)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV14)\nDamage (101)\nFreeze(4D/30C)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.weapon:SetDamage(103)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV15)\nDamage (103)\nFreeze(4D/30C)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.weapon:SetDamage(105)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV16)\nDamage (105)\nFreeze(4D/30C)")
elseif inst.level >=850 and inst.level <950 then
  inst.components.weapon:SetDamage(107)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV17)\nDamage (107)\nFreeze(4D/30C)")
elseif inst.level >=950 and inst.level <1050 then
 inst.components.weapon:SetDamage(109)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV18)\nDamage (109)\nFreeze(4D/30C)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.weapon:SetDamage(111)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV19)\nDamage (111)\nFreeze(4D/30C)")
elseif inst.level >=1200 and inst.level <1400 then
  inst.components.weapon:SetDamage(113)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV20)\nDamage (113)\nFreeze(8D/40C)")
elseif inst.level >=1400 and inst.level <1600 then
  inst.components.weapon:SetDamage(115)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV21)\nDamage (115)\nFreeze(8D/40C)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.weapon:SetDamage(117)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV22)\nDamage (117)\nFreeze(8D/40C)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.weapon:SetDamage(119)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV23)\nDamage (119)\nFreeze(8D/40C)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.weapon:SetDamage(121)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV24)\nDamage (121)\nFreeze(10D/50C)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.weapon:SetDamage(123)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV25)\nDamage (123)\nFreeze(10D/50C)")
elseif inst.level >=2400 and inst.level <2600 then
 inst.components.weapon:SetDamage(125)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV26)\nDamage (125)\nFreeze(10D/50C)")
elseif inst.level >=2600 and inst.level <2800 then
 inst.components.weapon:SetDamage(127)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV27)\nDamage (127)\nFreeze(10D/50C)")
elseif inst.level >=2800 and inst.level <3000 then
  inst.components.weapon:SetDamage(129)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV28)\nDamage (129)\nFreeze(10D/50C)")
elseif inst.level >=3000 and inst.level <4000 then
 inst.components.weapon:SetDamage(131)
	inst.components.talker:Say("[ Frost Glaive ]\n(LV29)\nDamage (131)\nFreeze(10D/50C)")
elseif inst.level >=4000 then
  inst.components.weapon:SetDamage(133)
	inst.components.talker:Say("[ Frost Glaive ]\n(Max30)\nDamage (133)\nFreeze(10D/50C)")
end

elseif not inst.boost then
 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(30)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV1)\nDamage (30)\nFlame(10D/12C)")
 elseif inst.level >=10 and inst.level <30 then
    inst.components.weapon:SetDamage(32)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV2)\nDamage (32)\nFlame(10D/12C)")
 elseif inst.level >=30 and inst.level <50 then
    inst.components.weapon:SetDamage(34)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV3)\nDamage (34)\nFlame(10D/12C)")
 elseif inst.level >=50 and inst.level <70 then
    inst.components.weapon:SetDamage(36)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV4)\nDamage (36)\nFlame(10D/12C)")
 elseif inst.level >=70 and inst.level <90 then
    inst.components.weapon:SetDamage(38)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV5)\nDamage (38)\nFlame(10D/12C)")
 elseif inst.level >=90 and inst.level <120 then
    inst.components.weapon:SetDamage(40)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV6)\nDamage (40)\nFlame(10D/12C)")
 elseif inst.level >=120 and inst.level <150 then
    inst.components.weapon:SetDamage(41)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV7)\nDamage (41)\nFlame(10D/12C)")
elseif inst.level >=150 and inst.level <180 then
    inst.components.weapon:SetDamage(42)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV8)\nDamage (42)\nFlame(10D/12C)")
elseif inst.level >=180 and inst.level <210 then
    inst.components.weapon:SetDamage(43)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV9)\nDamage (43)\nFlame(10D/12C)")
elseif inst.level >=210 and inst.level <250 then
    inst.components.weapon:SetDamage(44)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV10)\nDamage (44)\nFlame(15D/20C)")
elseif inst.level >=250 and inst.level <350 then
    inst.components.weapon:SetDamage(45)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV11)\nDamage (45)\nFlame(15D/20C)")
elseif inst.level >=350 and inst.level <450 then
    inst.components.weapon:SetDamage(46)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV12)\nDamage (46)\nFlame(15D/20C)")
elseif inst.level >=450 and inst.level <550 then
    inst.components.weapon:SetDamage(47)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV13)\nDamage (47)\nFlame(15D/20C)")
elseif inst.level >=550 and inst.level <650 then
    inst.components.weapon:SetDamage(48)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV14)\nDamage (48)\nFlame(15D/20C)")
elseif inst.level >=650 and inst.level <750 then
    inst.components.weapon:SetDamage(49)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV15)\nDamage (49)\nFlame(15D/20C)")
elseif inst.level >=750 and inst.level <850 then
    inst.components.weapon:SetDamage(50)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV16)\nDamage (50)\nFlame(15D/20C)")
elseif inst.level >=850 and inst.level <950 then
    inst.components.weapon:SetDamage(51)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV17)\nDamage (51)\nFlame(15D/20C)")
elseif inst.level >=950 and inst.level <1050 then
    inst.components.weapon:SetDamage(52)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV18)\nDamage (52)\nFlame(15D/20C)")
elseif inst.level >=1050 and inst.level <1200 then
    inst.components.weapon:SetDamage(53)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV19)\nDamage (53)\nFlame(15D/20C)")
elseif inst.level >=1200 and inst.level <1400 then
    inst.components.weapon:SetDamage(54)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV20)\nDamage (54)\nFlame(20D/28C)")
elseif inst.level >=1400 and inst.level <1600 then
    inst.components.weapon:SetDamage(55)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV21)\nDamage (55)\nFlame(20D/28C)")
elseif inst.level >=1600 and inst.level <1800 then
    inst.components.weapon:SetDamage(56)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV22)\nDamage (56)\nFlame(20D/28C)")
elseif inst.level >=1800 and inst.level <2000 then
    inst.components.weapon:SetDamage(57)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV23)\nDamage (57)\nFlame(20D/28C)")
elseif inst.level >=2000 and inst.level <2200 then
    inst.components.weapon:SetDamage(58)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV24)\nDamage (58)\nFlame(20D/28C)")
elseif inst.level >=2200 and inst.level <2400 then
    inst.components.weapon:SetDamage(59)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV25)\nDamage (59)\nFlame(20D/28C)")
elseif inst.level >=2400 and inst.level <2600 then
    inst.components.weapon:SetDamage(60)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV26)\nDamage (60)\nFlame(25D/36C)")
elseif inst.level >=2600 and inst.level <2800 then
    inst.components.weapon:SetDamage(61)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV27)\nDamage (61)\nFlame(25D/36C)")
elseif inst.level >=2800 and inst.level <3000 then
    inst.components.weapon:SetDamage(62)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV28)\nDamage (62)\nFlame(25D/36C)")
elseif inst.level >=3000 and inst.level <4000 then
    inst.components.weapon:SetDamage(63)
	inst.components.talker:Say("[ Flame Glaive ]\n(LV29)\nDamage (63)\nFlame(25D/36C)")
elseif inst.level >=4000 then
    inst.components.weapon:SetDamage(64)
	inst.components.talker:Say("[ Flame Glaive ]\n(Max30)\nDamage (64)\nDark Flame(25D/36C)\nBlink")
end
end	

end
end
-------- --------
-------- --------
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
Upgradedamage(inst)
if not inst.forgelab_on then
   if math.random() < expchance1 and inst.level <= 4005 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Spear] \nLucky Points ! +(2)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Spear] \nLucky Points ! +(5)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Spear] \nLucky Points ! +(8)\n[Grow Points]".. (inst.level))
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
	if inst:HasTag("broken") then
	inst:RemoveTag("broken")
	end
end
-------- --------
-------- --------

local function OnLoad(inst, data)
    Upgradedamage(inst)
end


local function onattack_FRAME(inst, attacker, target)

local owner = inst.components.inventoryitem.owner
local framechance1 = 0.12
local framechance2 = 0.20
local framechance3 = 0.28
local framechance4 = 0.36
local freezechance1 = 0.2
local freezechance2 = 0.3
local freezechance3 = 0.4
local freezechance4 = 0.5

local expchance = 0.05
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1


if math.random() < expchance and not inst.broken and inst.level < 4000 then
	inst.level = inst.level + 1
	inst.components.talker:Say("[Weapon]:GP+1")
	--levelexp(inst)
end
    if target and not inst.broken and math.random() < damagedur1 then
inst.components.fueled:DoDelta(-150000)
    elseif target and not inst.broken and math.random() < damagedur2 then
inst.components.fueled:DoDelta(-75000)
    elseif target and not inst.broken and math.random() < damagedur3 then
inst.components.fueled:DoDelta(-35000)
    elseif target and not inst.broken and math.random() < damagedur4 then
inst.components.fueled:DoDelta(-20000)
    elseif target and inst.broken then
		local fx = SpawnPrefab("splash")
	local pos = Vector3(target.Transform:GetWorldPosition())
fx.Transform:SetPosition(pos:Get())
	inst.components.talker:Say("-Broken Weapon \nDamage (1)")
    end

	
  
if not inst.boost then
  
  	  if target and inst.level <250 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance1 then
        if target.components.burnable then
		target.components.burnable:Ignite()
		target.components.health:DoDelta(-10)
		end
		
  	  elseif target and inst.level >=250 and inst.level <1400 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance2 then
        if target.components.burnable then
		target.components.burnable:Ignite()
		target.components.health:DoDelta(-15)
		end
		
  	  elseif target and inst.level >=1400 and inst.level <2200 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance3 then
        if target.components.burnable then
		target.components.burnable:Ignite()
		target.components.health:DoDelta(-20)
		end
      
  	  elseif target and inst.level >=2200 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance4 then
        if target.components.burnable then
		target.components.burnable:Ignite()
		target.components.health:DoDelta(-25)
		end
 
			if inst.level >=4000 and math.random() < 0.4 then
	    local fx = SpawnPrefab("statue_transition")
		local pos = Vector3(target.Transform:GetWorldPosition())
		fx.Transform:SetPosition(pos:Get())
		attacker.components.sanity:DoDelta(2)
		
			end
		end
	
elseif inst.boost and target.components.locomotor and target.components.health and not target.components.health:IsDead() and not target:HasTag("shadowcreature") and not target:HasTag("structure") then

local fx = SpawnPrefab("groundpoundring_fx")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetScale(0.3, 0.3, 0.3)
	fx.Transform:SetPosition(pos:Get())
	
		if  math.random() < freezechance1 and target.components.freezable and inst.level <250 then
        target.components.freezable:AddColdness(0.12)
        target.components.freezable:SpawnShatterFX()
		target.components.health:DoDelta(-2)
		local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 0.6, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())
	elseif math.random() < freezechance2 and target.components.freezable and inst.level >=250 and inst.level <1400 then
        target.components.freezable:AddColdness(0.24)
        target.components.freezable:SpawnShatterFX()
		target.components.health:DoDelta(-4)
		local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 0.8, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())
	elseif math.random() < freezechance3 and target.components.freezable and inst.level >=1400 and inst.level <2200 then
        target.components.freezable:AddColdness(0.36)
        target.components.freezable:SpawnShatterFX()
		target.components.health:DoDelta(-8)		
		local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 0.9, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())
	elseif math.random() < freezechance4 and target.components.freezable and inst.level >=2200 then
        target.components.freezable:AddColdness(0.40)
        target.components.freezable:SpawnShatterFX()
		target.components.health:DoDelta(-10)		
		local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 1.1, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())	
		end
end

    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
    if target.components.combat and not target:HasTag("companion") then
        target.components.combat:SuggestTarget(attacker)
    end
			
		 
end


local function onequip(inst, owner)
	if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
		owner.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
        owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	
   Upgradedamage(inst)
  
	if not inst.broken then
    if inst.blue then

	inst.red = false
    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst:AddTag("frost_spear")
	else

	inst.red = true
	inst.blue = false
	owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear", "phoenixspear")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst:RemoveTag("frost_spear")
	end
	elseif inst.broken then

	inst.red = true
	inst.blue = false
	owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear_broken", "phoenixspear")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst:RemoveTag("frost_spear")
	end

	
	inst.blink_weapon = inst:DoPeriodicTask(1, function() 
	if not inst.broken and inst.level >= 4000 then
		if not inst.boost and not inst.components.blinkstaff and owner.components.sanity.current >=10 then
			inst:AddComponent("blinkstaff")
			inst.components.blinkstaff.onblinkfn = onblink
		elseif not inst.boost and inst.components.blinkstaff and owner.components.sanity.current <10 then
			inst:RemoveComponent("blinkstaff")
		elseif inst.boost and inst.components.blinkstaff then
			inst:RemoveComponent("blinkstaff")	
			
		end
	end
	end)
end

local function onunequip(inst, owner) 
   Upgradedamage(inst)
   
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
		--owner:RemoveTag("phoenixblade") 
		--inst:RemoveTag("frost_spear")
	if inst.components.blinkstaff then
    inst:RemoveComponent("blinkstaff")
	end

end

local function boost(inst, data, owner, fname_override)
local owner = inst.components.inventoryitem.owner

if owner and inst.broken then
	if inst.components.blinkstaff then
    inst:RemoveComponent("blinkstaff")
	end
	Upgradedamage(inst)
	--inst.boost = false 	
	--inst.red = true	
	--inst.blue = false
	--inst:RemoveTag("frost_spear")
	inst.components.talker:Say("-[Phoenix Spear]\nDurability (0)")
    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear_broken", "phoenixspear")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
        inst.components.useableitem:StopUsingItem()
end

if owner and not inst.boost and not inst.broken then
	local change_fx = SpawnPrefab("splash")
        local follower = change_fx.entity:AddFollower()
				follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
	inst.boost = true
	inst.components.tool:OnRemoveFromEntity()
	inst.components.tool:SetAction(ACTIONS.DIG)
	Upgradedamage(inst)
	inst:AddTag("frost_spear")
	inst.blue = true	
	inst.red = false

--inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
     --     inst.entity:AddLight()
		--[[local fx = SpawnPrefab("collapse_small")
	local pos = Vector3(inst.Transform:GetWorldPosition())
fx.Transform:SetPosition(pos:Get())]]


	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	--[[local fx = SpawnPrefab("collapse_small")
		local pos = Vector3(inst.Transform:GetWorldPosition())
		fx.Transform:SetPosition(pos:Get())]]
		
    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

    inst.components.useableitem:StopUsingItem()
-----------
elseif owner and inst.boost and not inst.broken then
local change_fx = SpawnPrefab("small_puff")
        local follower = change_fx.entity:AddFollower()
				follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
	if inst.components.blinkstaff then
    inst:RemoveComponent("blinkstaff")
	end
	inst.boost = false 	 
	inst.components.tool:OnRemoveFromEntity()
	Upgradedamage(inst)
	inst:RemoveTag("frost_spear")
	inst.red = true
	inst.blue = false

	
if inst.level >=4000 then
	
	if not inst.components.blinkstaff and owner.components.sanity.current >= 10 and not inst.broken then
	inst:AddComponent("blinkstaff")
    inst.components.blinkstaff.onblinkfn = onblink
	AddHauntableCustomReaction(inst, function(inst, haunter)
        local target = FindEntity(inst, 20, function(guy)
            return guy.components.locomotor ~= nil
        end,
        nil,
        {"playerghost"}
        )

        if target and math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
            local pos = Vector3(target.Transform:GetWorldPosition())
            local start_angle = math.random()*2*PI
            local offset = FindWalkableOffset(pos, start_angle, math.random(8,12), 60, false, true)
            local pt = pos + offset

            inst.components.blinkstaff:Blink(pt, target)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
        return false
    end, true, false, true)
	end
	
end



	--local fx = SpawnPrefab("small_puff")
	--local pos = Vector3(inst.Transform:GetWorldPosition())
	--fx.Transform:SetPosition(pos:Get())
 inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 

    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear", "phoenixspear")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

        inst.components.useableitem:StopUsingItem()
end
end

local function fn()
	local inst = CreateEntity()
 	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
 	
    inst.AnimState:SetBank("phoenixspear")
    inst.AnimState:SetBuild("phoenixspear")
    inst.AnimState:PlayAnimation("idle")
    
		inst:AddTag("sharp")
        inst:AddTag("metal")
		inst:AddTag("musha_items") 
		
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "phoenixspear.tex" )
	
	inst:AddTag("waterproofer")
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 0.8, 0.65, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"	
		

	
    inst.entity:SetPristine()
  
    if not TheWorld.ismastersim then
        return inst
    end	
	
--inst.boost = false 
--inst.red = true      
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
	
	inst:AddComponent("tool")
    inst:AddComponent("weapon")
	inst.components.weapon:SetRange(1.1)
    --inst.components.weapon:SetDamage(45)
    inst.components.weapon:SetOnAttack(Upgradedamage)

      inst.components.weapon:SetOnAttack(onattack_FRAME)
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/phoenixspear.xml"
 
    inst.OnLoad = OnLoad

    inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(boost)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "CHEMICAL"
    inst.components.fueled:InitializeFuelLevel(30000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
       inst.components.fueled.ontakefuelfn = TakeItem
       inst.components.fueled.accepting = true
		inst.components.fueled:StopConsuming()  

	inst.level = 0
	levelexp(inst)
	inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    return inst
end

return Prefab( "common/inventory/phoenixspear", fn, assets) 

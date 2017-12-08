local assets=
{
	Asset("ANIM", "anim/mushasword4.zip"),
	Asset("ANIM", "anim/swap_phoenixaxe.zip"),
	Asset("ANIM", "anim/swap_phoenixaxe2.zip"),
	Asset("ANIM", "anim/swap_phoenixaxe_broken.zip"),
	Asset("ATLAS", "images/inventoryimages/mushasword4.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword4.tex"),
 
}
---------------------------

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say("[ Phoenix Axe ]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <510 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/510")
elseif inst.level >=510 and inst.level <950 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say("[ Phoenix Axe ] \n[Grow Points]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say("[ Phoenix Axe ] \n[MAX]")
end
end

local function createlight(staff, target, pos)
    local caster = staff.components.inventoryitem.owner
if caster.components.sanity.current >= 35 then

    local light = SpawnPrefab("lightning")
    --local light2 = SpawnPrefab("stafflight")
	local light2 = SpawnPrefab("musha_spore_fire")

    light.Transform:SetPosition(pos.x, pos.y, pos.z)
    light2.Transform:SetPosition(pos.x, pos.y, pos.z)
	light2.components.follower:SetLeader(caster)
	
        caster.components.sanity:DoDelta(-20)
        --caster.components.sanity:DoDelta(-TUNING.SANITY_HUGE)

    elseif caster.components.sanity.current < 30 then
	local fail1 = SpawnPrefab("statue_transition")
    local fail2 = SpawnPrefab("statue_transition_2")

    fail1.Transform:SetPosition(pos.x, pos.y, pos.z)
    fail2.Transform:SetPosition(pos.x, pos.y, pos.z)
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
	inst.components.talker:Say("-Broken PhoenixAxe \nDamage (1)")
end

local function Upgradedamage(inst,data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end

if inst.broken then
   inst.components.weapon:SetDamage(1)
	inst.components.talker:Say("-Broken Phoenix Axe \nDamage (1)")
  
elseif not inst.broken then

if inst.boost then
 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(75)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV1)\nDamage (75)\nBlood Poison\n(4D/50C)")
 elseif inst.level >=10 and inst.level <30 then
 inst.components.weapon:SetDamage(77)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV2)\nDamage (77)\nBlood Poison\n(4D/50C)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.weapon:SetDamage(79)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV3)\nDamage (79)\nBlood Poison\n(4D/50C)")
 elseif inst.level >=50 and inst.level <70 then
   inst.components.weapon:SetDamage(81)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV4)\nDamage (81)\nBlood Poison\n(4D/50C)")
 elseif inst.level >=70 and inst.level <90 then
  inst.components.weapon:SetDamage(83)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV5)\nDamage (83)\nBlood Poison\n(4D/50C)")
 elseif inst.level >=90 and inst.level <120 then
  inst.components.weapon:SetDamage(85)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV6)\nDamage (85)\nBlood Poison\n(4D/50C)")
 elseif inst.level >=120 and inst.level <150 then
 inst.components.weapon:SetDamage(87)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV7)\nDamage (87)\nBlood Poison\n(4D/50C)")
elseif inst.level >=150 and inst.level <180 then
 inst.components.weapon:SetDamage(89)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV8)\nDamage (89)\nBlood Poison\n(4D/50C)")
elseif inst.level >=180 and inst.level <210 then
 inst.components.weapon:SetDamage(91)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV9)\nDamage (91)\nBlood Poison\n(4D/50C)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.weapon:SetDamage(93)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV10)\nDamage (93)\nBlood Poison\n(7D/55C)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.weapon:SetDamage(95)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV11)\nDamage (95)\nBlood Poison\n(7D/55C)")
elseif inst.level >=350 and inst.level <450 then
  inst.components.weapon:SetDamage(97)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV12)\nDamage (97)\nBlood Poison\n(7D/55C)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.weapon:SetDamage(99)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV13)\nDamage (99)\nBlood Poison\n(7D/55C)")
elseif inst.level >=550 and inst.level <650 then
  inst.components.weapon:SetDamage(101)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV14)\nDamage (101)\nBlood Poison\n(7D/55C)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.weapon:SetDamage(103)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV15)\nDamage (103)\nBlood Poison\n(7D/55C)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.weapon:SetDamage(105)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV16)\nDamage (105)\nBlood Poison\n(7D/55C)")
elseif inst.level >=850 and inst.level <950 then
  inst.components.weapon:SetDamage(107)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV17)\nDamage (107)\nBlood Poison\n(7D/55C)")
elseif inst.level >=950 and inst.level <1050 then
 inst.components.weapon:SetDamage(109)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV18)\nDamage (109)\nBlood Poison\n(7D/55C)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.weapon:SetDamage(111)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV19)\nDamage (111)\nBlood Poison\n(7D/55C)")
elseif inst.level >=1200 and inst.level <1400 then
  inst.components.weapon:SetDamage(113)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV20)\nDamage (113)\nBlood Poison\n(9D/60C)")
elseif inst.level >=1400 and inst.level <1600 then
  inst.components.weapon:SetDamage(115)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV21)\nDamage (115)\nBlood Poison\n(9D/60C)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.weapon:SetDamage(117)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV22)\nDamage (117)\nBlood Poison\n(9D/60C)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.weapon:SetDamage(119)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV23)\nDamage (119)\nBlood Poison\n(9D/60C)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.weapon:SetDamage(121)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV24)\nDamage (121)\nBlood Poison\n(9D/60C)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.weapon:SetDamage(123)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV25)\nDamage (123)\nBlood Poison\n(9D/60C)")
elseif inst.level >=2400 and inst.level <2600 then
 inst.components.weapon:SetDamage(125)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV26)\nDamage (125)\nBlood Poison\n(9D/60C)")
elseif inst.level >=2600 and inst.level <2800 then
 inst.components.weapon:SetDamage(127)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV27)\nDamage (127)\nBlood Poison\n(9D/60C)")
elseif inst.level >=2800 and inst.level <3000 then
  inst.components.weapon:SetDamage(129)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV28)\nDamage (129)\nBlood Poison\n(9D/60C)")
elseif inst.level >=3000 and inst.level <4000 then
 inst.components.weapon:SetDamage(131)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(LV29)\nDamage (131)\nBlood Poison\n(9D/60C)")
elseif inst.level >=4000 then
  inst.components.weapon:SetDamage(133)
	inst.components.talker:Say("[ Phoenix Pickaxe ]\n(Max30)\nDamage (133)\nBlood Poison\n(9D/60C)")
end

elseif not inst.boost then
 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(30)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV1)\nDamage (30)\nDark Flame(10D/12C)")
 elseif inst.level >=10 and inst.level <30 then
    inst.components.weapon:SetDamage(32)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV2)\nDamage (32)\nDark Flame(10D/12C)")
 elseif inst.level >=30 and inst.level <50 then
    inst.components.weapon:SetDamage(34)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV3)\nDamage (34)\nDark Flame(10D/12C)")
 elseif inst.level >=50 and inst.level <70 then
    inst.components.weapon:SetDamage(36)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV4)\nDamage (36)\nDark Flame(10D/12C)")
 elseif inst.level >=70 and inst.level <90 then
    inst.components.weapon:SetDamage(38)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV5)\nDamage (38)\nDark Flame(10D/12C)")
 elseif inst.level >=90 and inst.level <120 then
    inst.components.weapon:SetDamage(40)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV6)\nDamage (40)\nDark Flame(10D/12C)")
 elseif inst.level >=120 and inst.level <150 then
    inst.components.weapon:SetDamage(41)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV7)\nDamage (41)\nDark Flame(10D/12C)")
elseif inst.level >=150 and inst.level <180 then
    inst.components.weapon:SetDamage(42)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV8)\nDamage (42)\nDark Flame(10D/12C)")
elseif inst.level >=180 and inst.level <210 then
    inst.components.weapon:SetDamage(43)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV9)\nDamage (43)\nDark Flame(10D/12C)")
elseif inst.level >=210 and inst.level <250 then
    inst.components.weapon:SetDamage(44)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV10)\nDamage (44)\nDark Flame(15D/20C)")
elseif inst.level >=250 and inst.level <350 then
    inst.components.weapon:SetDamage(45)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV11)\nDamage (45)\nDark Flame(15D/20C)")
elseif inst.level >=350 and inst.level <450 then
    inst.components.weapon:SetDamage(46)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV12)\nDamage (46)\nDark Flame(15D/20C)")
elseif inst.level >=450 and inst.level <550 then
    inst.components.weapon:SetDamage(47)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV13)\nDamage (47)\nDark Flame(15D/20C)")
elseif inst.level >=550 and inst.level <650 then
    inst.components.weapon:SetDamage(48)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV14)\nDamage (48)\nDark Flame(15D/20C)")
elseif inst.level >=650 and inst.level <750 then
    inst.components.weapon:SetDamage(49)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV15)\nDamage (49)\nDark Flame(15D/20C)")
elseif inst.level >=750 and inst.level <850 then
    inst.components.weapon:SetDamage(50)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV16)\nDamage (50)\nDark Flame(15D/20C)")
elseif inst.level >=850 and inst.level <950 then
    inst.components.weapon:SetDamage(51)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV17)\nDamage (51)\nDark Flame(15D/20C)")
elseif inst.level >=950 and inst.level <1050 then
    inst.components.weapon:SetDamage(52)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV18)\nDamage (52)\nDark Flame(15D/20C)")
elseif inst.level >=1050 and inst.level <1200 then
    inst.components.weapon:SetDamage(53)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV19)\nDamage (53)\nDark Flame(15D/20C)")
elseif inst.level >=1200 and inst.level <1400 then
    inst.components.weapon:SetDamage(54)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV20)\nDamage (54)\nDark Flame(20D/28C)")
elseif inst.level >=1400 and inst.level <1600 then
    inst.components.weapon:SetDamage(55)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV21)\nDamage (55)\nDark Flame(20D/28C)")
elseif inst.level >=1600 and inst.level <1800 then
    inst.components.weapon:SetDamage(56)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV22)\nDamage (56)\nDark Flame(20D/28C)")
elseif inst.level >=1800 and inst.level <2000 then
    inst.components.weapon:SetDamage(57)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV23)\nDamage (57)\nDark Flame(20D/28C)")
elseif inst.level >=2000 and inst.level <2200 then
    inst.components.weapon:SetDamage(58)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV24)\nDamage (58)\nDark Flame(20D/28C)")
elseif inst.level >=2200 and inst.level <2400 then
    inst.components.weapon:SetDamage(59)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV25)\nDamage (59)\nDark Flame(20D/28C)")
elseif inst.level >=2400 and inst.level <2600 then
    inst.components.weapon:SetDamage(60)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV26)\nDamage (60)\nDark Flame(25D/36C)")
elseif inst.level >=2600 and inst.level <2800 then
    inst.components.weapon:SetDamage(61)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV27)\nDamage (61)\nDark Flame(25D/36C)")
elseif inst.level >=2800 and inst.level <3000 then
    inst.components.weapon:SetDamage(62)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV28)\nDamage (62)\nDark Flame(25D/36C)")
elseif inst.level >=3000 and inst.level <4000 then
    inst.components.weapon:SetDamage(63)
	inst.components.talker:Say("[ Phoenix Axe ]\n(LV29)\nDamage (63)\nDark Flame(25D/36C)")
elseif inst.level >=4000 then
    inst.components.weapon:SetDamage(64)
	inst.components.talker:Say("[ Phoenix Axe ]\n(Max30)\nDamage (64)\nDark Flame(25D/36C)")
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
	inst.components.talker:Say("-[Phoenix Axe] \nLucky Points ! +(2)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Axe] \nLucky Points ! +(5)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Axe] \nLucky Points ! +(8)\n[Grow Points]".. (inst.level))
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
local poisone_1 = 0.5
local poisone_2 = 0.55
local poisone_3 = 0.6

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

if target and not target:HasTag("smashable") then
	  
if not inst.boost then
  
  	  if target and inst.level <250 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance1 then
        if target.components.burnable then
		target.components.burnable:Ignite()
		end
local fx = SpawnPrefab("statue_transition")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
        target.components.health:DoDelta(-10)
		attacker.components.sanity:DoDelta(1)
  	  elseif target and inst.level >=250 and inst.level <1400 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance2 then
        if target.components.burnable then
		target.components.burnable:Ignite()
		end
local fx = SpawnPrefab("statue_transition")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
        target.components.health:DoDelta(-15)
		attacker.components.sanity:DoDelta(1)
  	  elseif target and inst.level >=1400 and inst.level <2200 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance3 then
         if target.components.burnable then
		target.components.burnable:Ignite()
		end
local fx = SpawnPrefab("statue_transition")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
        target.components.health:DoDelta(-20)
       attacker.components.sanity:DoDelta(1)
  	  elseif target and inst.level >=2200 and not target:HasTag("wall") and not target:HasTag("structure") and math.random() < framechance4 then
         if target.components.burnable then
		target.components.burnable:Ignite()
		end
local fx = SpawnPrefab("statue_transition")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
       target.components.health:DoDelta(-25)
 	  attacker.components.sanity:DoDelta(1)
       
	end
	
elseif inst.boost and target.components.locomotor and target.components.health and not target.components.health:IsDead() and not target:HasTag("shadowcreature") and not target:HasTag("structure") then

local fx = SpawnPrefab("groundpoundring_fx")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetScale(0.3, 0.3, 0.3)
	fx.Transform:SetPosition(pos:Get())
	
		if math.random() < poisone_1 and inst.boost and inst.level <250 and not target:HasTag("slow_poison") and (target.components.burnable or target.components.freezable) then
        
		local poison = SpawnPrefab("debuff_blood")
		poison.Transform:SetPosition(target:GetPosition():Get())
		--poison.Transform:SetScale(1,1,1)
		target:AddTag("slow_poison")
		if poison and target:HasTag("slow_poison") then
			if not inst.blood then 
            inst.blood = SpawnPrefab( "debuff_blood" )
            local follower = inst.blood.entity:AddFollower()
                         follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
			end
		local follower = poison.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
		TheWorld:DoPeriodicTask(3, function() 
		if target:HasTag("slow_poison") and not target.components.health:IsDead() then 
				attacker.components.health:DoDelta(4)
			if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and not target:HasTag("epic") then			
				target.components.combat:GetAttacked(inst, 4)
			elseif target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and target:HasTag("epic") then	
				target.components.health:DoDelta(-4)
			end

		elseif poison and target.components.health:IsDead() then
				poison:Remove()
		end	end)
		
		
		TheWorld:DoTaskInTime(15, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_poison") poison:Remove() 
		if inst.blood then 
		inst.blood:Remove() inst.blood = nil 
		end end)
		
	elseif math.random() < poisone_2 and inst.boost and inst.level >=250 and inst.level <1400 and not target:HasTag("slow_poison") then
        
 		local poison = SpawnPrefab("debuff_blood")
		poison.Transform:SetPosition(target:GetPosition():Get())
		--poison.Transform:SetScale(1,1,1)
		target:AddTag("slow_poison")
		if poison and target:HasTag("slow_poison") then
		if not inst.blood then 
            inst.blood = SpawnPrefab( "debuff_blood" )
            local follower = inst.blood.entity:AddFollower()
            follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
			end
		local follower = poison.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
		TheWorld:DoPeriodicTask(3, function() 
		if target:HasTag("slow_poison") and not target.components.health:IsDead() then 
				attacker.components.health:DoDelta(7)
			if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and not target:HasTag("epic") then			
				target.components.combat:GetAttacked(inst, 7)
			elseif target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and target:HasTag("epic") then	
				target.components.health:DoDelta(-7)
			end
				target.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		elseif poison and target.components.health:IsDead() then
				poison:Remove()
		end	end)		
		TheWorld:DoTaskInTime(15, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_poison") poison:Remove() 
		if inst.blood then 
		inst.blood:Remove() inst.blood = nil 
		end end)
	
	elseif math.random() < poisone_3 and inst.boost and inst.level >=1400 and not target:HasTag("slow_poison") then
        
		local poison = SpawnPrefab("debuff_blood")
		poison.Transform:SetPosition(target:GetPosition():Get())
		--poison.Transform:SetScale(1,1,1)
		target:AddTag("slow_poison")
		if poison and target:HasTag("slow_poison") then
		if not inst.blood then 
            inst.blood = SpawnPrefab( "debuff_blood" )
            local follower = inst.blood.entity:AddFollower()
            follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
			end
		local follower = poison.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
		TheWorld:DoPeriodicTask(3, function() 
		if target:HasTag("slow_poison") and not target.components.health:IsDead() then 
				attacker.components.health:DoDelta(9)
			if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and not target:HasTag("epic") then			
				target.components.combat:GetAttacked(inst, 9)
			elseif target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and target:HasTag("epic") then	
				target.components.health:DoDelta(-9)
			end
				target.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		elseif poison and target.components.health:IsDead() then
				poison:Remove()
		end	end)
		TheWorld:DoTaskInTime(15, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_poison") poison:Remove() 
		if inst.blood then 
		inst.blood:Remove() inst.blood = nil 
		end end)
		end
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
    if inst.pick then
	inst.components.weapon:SetRange(1.1)
	inst.axe = false
    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe2", "phoenixaxe")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst:AddTag("phoenix_axe")
	inst.boost = true
	if not inst.components.spellcaster then
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createlight)
    inst.components.spellcaster.canuseonpoint = true
	end
	else
	inst.components.weapon:SetRange(0)
	inst.axe = true
	inst.pick = false
	owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe", "phoenixaxe")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst:RemoveTag("phoenix_axe")
	end
	elseif inst.broken then
	inst.components.weapon:SetRange(0)
	inst.axe = true
	inst.pick = false
	owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe_broken", "phoenixaxe")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst:RemoveTag("phoenix_axe")
	end

	--owner:AddTag("phoenixblade") 
end

local function onunequip(inst, owner) 
   Upgradedamage(inst)
   
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 

		--owner:RemoveTag("phoenixblade") 
		inst:RemoveTag("phoenix_axe")
		
    inst:RemoveComponent("spellcaster")
	
	 if inst.blood then 
        inst.blood:Remove()
        inst.blood = nil
    end 
end

local function boost(inst, data, owner, fname_override)
local owner = inst.components.inventoryitem.owner

local change_fx = SpawnPrefab("small_puff")
        local follower = change_fx.entity:AddFollower()
				follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
				
if owner and inst.broken then
	inst.boost = false 
	inst:RemoveComponent("spellcaster")
	Upgradedamage(inst)	
	inst.axe = true	
	inst.pick = false
	inst:RemoveTag("phoenix_axe")
	inst.components.talker:Say("-[Phoenix Axe]\nDurability (0)")
    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe_broken", "phoenixaxe")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
        inst.components.useableitem:StopUsingItem()
end

if owner and not inst.boost and not inst.broken then
	inst.boost = true
	if not inst.components.spellcaster then
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createlight)
    inst.components.spellcaster.canuseonpoint = true
	end
	
	inst.components.tool:OnRemoveFromEntity()
	--inst.components.tool:SetAction(ACTIONS.CHOP)
	inst.components.tool:SetAction(ACTIONS.MINE)
	
	Upgradedamage(inst)
	inst.pick = true	
	inst.axe = false
	inst:AddTag("phoenix_axe")
	inst.components.weapon:SetRange(1.1)

	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	--[[local fx = SpawnPrefab("collapse_small")
		local pos = Vector3(inst.Transform:GetWorldPosition())
		fx.Transform:SetPosition(pos:Get())]]
		
    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe2", "phoenixaxe")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

    inst.components.useableitem:StopUsingItem()
-----------
elseif owner and inst.boost and not inst.broken then

	inst.boost = false 	 
	inst:RemoveComponent("spellcaster")
	inst.components.tool:OnRemoveFromEntity()
	inst.components.tool:SetAction(ACTIONS.CHOP)
	--inst.components.tool:SetAction(ACTIONS.MINE)
	Upgradedamage(inst)
	inst.axe = true
	inst.pick = false
	inst:RemoveTag("phoenix_axe")
	inst.components.weapon:SetRange(0)

	--local fx = SpawnPrefab("small_puff")
	--local pos = Vector3(inst.Transform:GetWorldPosition())
	--fx.Transform:SetPosition(pos:Get())
 inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 

    owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe", "phoenixaxe")
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
 	
    inst.AnimState:SetBank("mushasword4")
    inst.AnimState:SetBuild("mushasword4")
    inst.AnimState:PlayAnimation("idle")
    
		inst:AddTag("sharp")
        inst:AddTag("metal")
		
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "mushasword4.tex" )
	
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
	
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.CHOP)
	 
    inst:AddComponent("weapon")
	inst.components.weapon:SetRange(0)
    inst.components.weapon:SetDamage(90)
    inst.components.weapon:SetOnAttack(Upgradedamage)

      inst.components.weapon:SetOnAttack(onattack_FRAME)
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword4.xml"
 	
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
		
--inst.boost = false 
inst.axe = true      
inst:AddTag("musha_items") 

	inst.level = 0
	levelexp(inst)
	inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    return inst
end

return Prefab( "common/inventory/mushasword4", fn, assets) 


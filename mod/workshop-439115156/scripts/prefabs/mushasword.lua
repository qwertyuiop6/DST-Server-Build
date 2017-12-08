
---------------------------
local assets=
{
	Asset("ANIM", "anim/mushasword.zip"),
   	Asset("ATLAS", "images/inventoryimages/mushasword.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword.tex"),
	Asset("ANIM", "anim/swap_mushasword_base.zip"),
	Asset("ANIM", "anim/swap_mushasword.zip"),
	Asset("ANIM", "anim/swap_mushasword2.zip"),
	Asset("ANIM", "anim/swap_mushasword3.zip"),
	
	Asset("ANIM", "anim/swap_mushasword_boost.zip"),
	Asset("ANIM", "anim/swap_mushasword2_boost.zip"),
	Asset("ANIM", "anim/swap_mushasword3_boost.zip"),
}

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say("-[Phoenix Blade]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say("-[Phoenix Blade] \n[Grow Points]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say("-[Phoenix Blade] \n[MAX]")
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

local function Upgradedamage(inst, data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
	inst.boost = false 	
	inst:RemoveComponent("blinkstaff")
   inst.components.weapon:SetDamage(1)
	inst.components.talker:Say("-Broken PhoenixBlade \nDamage (1)")
  
elseif not inst.broken then

 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(30)
	inst.components.talker:Say("-Phoenix Blade (LV1)\nDamage (30)\nFlame(5D/12C)")
 elseif inst.level >=10 and inst.level <30 then
    inst.components.weapon:SetDamage(32)
	inst.components.talker:Say("-Phoenix Blade (LV2)\nDamage (32)\nFlame(5D/12C)")
 elseif inst.level >=30 and inst.level <50 then
    inst.components.weapon:SetDamage(34)
	inst.components.talker:Say("-Phoenix Blade (LV3)\nDamage (34)\nFlame(5D/12C)")
 elseif inst.level >=50 and inst.level <70 then
    inst.components.weapon:SetDamage(36)
	inst.components.talker:Say("-Phoenix Blade (LV4)]\nDamage (36)\nFlame(5D/12C)")
  elseif inst.level >=70 and inst.level <90 then
    inst.components.weapon:SetDamage(38)
	inst.components.talker:Say("-Phoenix Blade (LV5)\nDamage (38)\nFlame(5D/12C)")
 elseif inst.level >=90 and inst.level <120 then
    inst.components.weapon:SetDamage(40)
	inst.components.talker:Say("-Phoenix Blade (LV6)\nDamage (40)\nFlame(5D/12C)")
 elseif inst.level >=120 and inst.level <150 then
    inst.components.weapon:SetDamage(41)
	inst.components.talker:Say("-Phoenix Blade (LV7)\nDamage (41)\nFlame(5D/12C)")
elseif inst.level >=150 and inst.level <180 then
    inst.components.weapon:SetDamage(42)
	inst.components.talker:Say("-Phoenix Blade (LV8)\nDamage (42)\nFlame(5D/12C)")
elseif inst.level >=180 and inst.level <210 then
    inst.components.weapon:SetDamage(43)
	inst.components.talker:Say("-Phoenix Blade (LV9)\nDamage (43)\nFlame(5D/12C)")
elseif inst.level >=210 and inst.level <250 then
    inst.components.weapon:SetDamage(44)
	inst.components.talker:Say("-Phoenix Blade (LV10)\nDamage (44)\nFlame(10D/20C)")
elseif inst.level >=250 and inst.level <350 then
    inst.components.weapon:SetDamage(45)
	inst.components.talker:Say("-Phoenix Blade (LV11)\nDamage (45)\nFlame(10D/20C)")
elseif inst.level >=350 and inst.level <450 then
    inst.components.weapon:SetDamage(46)
	inst.components.talker:Say("-Phoenix Blade (LV12)\nDamage (46)\nFlame(10D/20C)")
elseif inst.level >=450 and inst.level <550 then
    inst.components.weapon:SetDamage(47)
	inst.components.talker:Say("-Phoenix Blade (LV13)\nDamage (47)\nFlame(10D/20C)")
elseif inst.level >=550 and inst.level <650 then
    inst.components.weapon:SetDamage(48)
	inst.components.talker:Say("-Phoenix Blade (LV14)\nDamage (48)\nFlame(10D/20C)")
elseif inst.level >=650 and inst.level <750 then
    inst.components.weapon:SetDamage(49)
	inst.components.talker:Say("-Phoenix Blade (LV15)\nDamage (49)\nFlame(10D/20C)")
elseif inst.level >=750 and inst.level <850 then
    inst.components.weapon:SetDamage(50)
	inst.components.talker:Say("-Phoenix Blade (LV16)\nDamage (50)\nFlame(10D/20C)")
elseif inst.level >=850 and inst.level <950 then
    inst.components.weapon:SetDamage(51)
	inst.components.talker:Say("-Phoenix Blade (LV17)\nDamage (51)\nFlame(10D/20C)")
elseif inst.level >=950 and inst.level <1050 then
    inst.components.weapon:SetDamage(52)
	inst.components.talker:Say("-Phoenix Blade (LV18)\nDamage (52)\nFlame(10D/20C)")
elseif inst.level >=1050 and inst.level <1200 then
    inst.components.weapon:SetDamage(53)
	inst.components.talker:Say("-Phoenix Blade (LV19)\nDamage (53)\nFlame(10D/20C)")
elseif inst.level >=1200 and inst.level <1400 then
    inst.components.weapon:SetDamage(54)
	inst.components.talker:Say("-Phoenix Blade (LV20)\nDamage (54)\nFlame(15D/20C)")
elseif inst.level >=1400 and inst.level <1600 then
    inst.components.weapon:SetDamage(55)
	inst.components.talker:Say("-Phoenix Blade (LV21)\nDamage (55)\nFlame(15D/20C)")
elseif inst.level >=1600 and inst.level <1800 then
    inst.components.weapon:SetDamage(56)
	inst.components.talker:Say("-Phoenix Blade (LV22)\nDamage (56)\nFlame(15D/20C)")
elseif inst.level >=1800 and inst.level <2000 then
    inst.components.weapon:SetDamage(57)
	inst.components.talker:Say("-Phoenix Blade (LV23)\nDamage (57)\nFlame(15D/20C)")
elseif inst.level >=2000 and inst.level <2200 then
    inst.components.weapon:SetDamage(58)
	inst.components.talker:Say("-Phoenix Blade (LV24)\nDamage (58)\nFlame(15D/20C)")
elseif inst.level >=2200 and inst.level <2400 then
    inst.components.weapon:SetDamage(59)
	inst.components.talker:Say("-Phoenix Blade (LV25)\nDamage (59)\nFlame(15D/20C)")
elseif inst.level >=2400 and inst.level <2600 then
    inst.components.weapon:SetDamage(60)
	inst.components.talker:Say("-Phoenix Blade (LV26)\nDamage (60)\nFlame(15D/20C)")
elseif inst.level >=2600 and inst.level <2800 then
    inst.components.weapon:SetDamage(61)
	inst.components.talker:Say("-Phoenix Blade (LV27)\nDamage (61)\nFlame(15D/20C)")
elseif inst.level >=2800 and inst.level <3000 then
    inst.components.weapon:SetDamage(62)
	inst.components.talker:Say("-Phoenix Blade (LV28)\nDamage (62)\nFlame(15D/20C)")
elseif inst.level >=3000 and inst.level <4000 then
    inst.components.weapon:SetDamage(63)
	inst.components.talker:Say("-Phoenix Blade (LV29)\nDamage (63)\nFlame(15D/20C)")
elseif inst.level >=4000 then
    inst.components.weapon:SetDamage(64)
	inst.components.talker:Say("-Phoenix Blade (Max30)\nDamage (64)\nFlame(15D/20C)")
end
end
end


local function OnDurability(inst, data)
inst.broken = true
 	Upgradedamage(inst)
	if inst.task then inst.task:Cancel() inst.task = nil end
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
Upgradedamage(inst)
if not inst.forgelab_on then
   if math.random() < expchance1 and inst.level <= 4005 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Blade] \nLucky Points ! +(2)\n[Grow Points]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Blade] \nLucky Points ! +(5)\n[Grow Points]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-[Phoenix Blade] \nLucky Points ! +(8)\n[Grow Points]".. (inst.level))
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
    Upgradedamage(inst)
end


local function onattack_Flame(inst, attacker, target)
local player = inst.components.inventoryitem.owner
local flamechance = 0.12
local flamechance2 = 0.20
local flamechance3 = 0.28
local flamechanceb = 0.17
local flamechance2b = 0.25
local flamechance3b = 0.33
local expchance = 0.1
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1


if math.random() < expchance and not inst.broken and inst.level <= 4000 then
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
SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())
	inst.components.talker:Say("-Broken Weapon \nDamage (1)")
    end
 
	-----
	if  math.random() < flamechance and target.components.burnable and not target:HasTag("structure") and not inst.boost and inst.level <250 then
        target.components.burnable:Ignite()
        target.components.health:DoDelta(-5)
	elseif math.random() < flamechance2 and target.components.burnable and not target:HasTag("structure") and not inst.boost and inst.level >=250 and inst.level <1400 then
        target.components.burnable:Ignite()
        target.components.health:DoDelta(-10)
	elseif math.random() < flamechance3 and target.components.burnable and not target:HasTag("structure") and not inst.boost and inst.level >=1400 then
        target.components.burnable:Ignite()
        target.components.health:DoDelta(-15)	
		
	elseif math.random() < flamechanceb and target.components.burnable and not target:HasTag("structure") and inst.boost and inst.level <250 then
        target.components.burnable:Ignite()
        target.components.health:DoDelta(-10)
		
	elseif math.random() < flamechance2b and target.components.burnable and not target:HasTag("structure") and inst.boost and inst.level >=250 and inst.level <1400 then
        target.components.burnable:Ignite()
        target.components.health:DoDelta(-20)
		
			if math.random() < 0.3 then
	    local fx = SpawnPrefab("statue_transition")
		local pos = Vector3(target.Transform:GetWorldPosition())
		fx.Transform:SetPosition(pos:Get())
		attacker.components.sanity:DoDelta(2)
		
			end
		
	elseif math.random() < flamechance3b and target.components.burnable and not target:HasTag("structure") and inst.boost and inst.level >=1400 then
        target.components.burnable:Ignite()
        target.components.health:DoDelta(-30)	

		if math.random() < 0.4 then
	    local fx = SpawnPrefab("statue_transition")
		local pos = Vector3(target.Transform:GetWorldPosition())
		fx.Transform:SetPosition(pos:Get())
		attacker.components.sanity:DoDelta(2)
		
			end
		
	end
    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
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
owner.fire = true
    Upgradedamage(inst)
 
if inst.level <250 then  -- 250
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
elseif inst.level >=250 and inst.level <1400 then  --250 1400
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
elseif inst.level >=1400 then  --1400
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword2", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
        inst.entity:AddLight()
	inst.Light:SetRadius(.8)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(225/255,120/255,80/255)
end
inst.blink_weapon = inst:DoPeriodicTask(1, function() 
	if not inst.broken and inst.boost and inst.level >= 250 then
		if not inst.components.blinkstaff and owner.components.sanity.current >=10 then
			inst:AddComponent("blinkstaff")
			inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
			inst.components.blinkstaff.onblinkfn = onblink
		elseif inst.components.blinkstaff and owner.components.sanity.current <10 then
			inst:RemoveComponent("blinkstaff")
		end
	end
	end)
end

local function onunequip(inst, owner) 
owner.fire = false
    Upgradedamage(inst)
	inst.Light:Enable(false)
    inst:RemoveComponent("blinkstaff")
	inst.boost = false 
    if inst.task then inst.task:Cancel() inst.task = nil end
    if inst.sanity then inst.sanity:Cancel() inst.sanity = nil end
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 

end

local function sanity(inst, owner)
if owner.components.health and owner.components.health:IsHurt() then
        owner.components.sanity:DoDelta(1,false)
end
end

local function OnDropped(inst,data)
    end
local function OnPutInInventory(inst)
    end
	
local function consume(inst, owner)
if not inst.broken and inst.boost then
inst.components.fueled:DoDelta(-50000)
end
if inst.broken and inst.boost then
inst.components.fueled:DoDelta(0)
end
end

local function on_boost(inst, data)
local player = inst.components.inventoryitem.owner
        local owner = inst.components.inventoryitem.owner
local change_fx = SpawnPrefab("small_puff")
        local follower = change_fx.entity:AddFollower()
				follower:FollowSymbol( owner.GUID, "swap_object", 1, -100, 1 )

    inst.AnimState:SetBank("nightmaresword")
    inst.AnimState:SetBuild("mushasword")
    inst.AnimState:PlayAnimation("idle")
if owner and inst.broken then
	inst.boost = false 	
	inst:RemoveComponent("blinkstaff")
	player.components.talker:Say("Phoenix Blade is Broken !")
	inst.components.talker:Say("-[Phoenix Blade]\nDurability (0)")
    --inst.components.equippable.walkspeedmult = 1
	inst.Light:Enable(false)
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
        inst.components.useableitem:StopUsingItem()
end
if owner and not inst.boost and not inst.broken then
	inst.boost = true
	player.components.talker:Say("Power Blade !")
    inst.task = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 
         inst.entity:AddLight()
--SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())

        inst.components.useableitem:StopUsingItem()
 
if inst.level <250 then  --250
	inst.components.talker:Say("-[Power Blade I]\nLight(Small+)\nFlame Damage X2(10D)")
    --inst.components.equippable.walkspeedmult = 1.1
	inst.Light:SetRadius(.4)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(225/255,120/255,80/255)
	inst.Light:Enable(true)
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_boost", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	
elseif inst.level >=250 and inst.level <1400 then  --250  1400
	inst.components.talker:Say("-[Power Blade II]\nLight(Med+)\nFlame Damage X2(20D)) \nBlink")
     --inst.components.equippable.walkspeedmult = 1.2
	inst.Light:SetRadius(.7)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(225/255,120/255,80/255)
	inst.Light:Enable(true)
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword2_boost", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 

   if not inst.components.blinkstaff and owner.components.sanity.current >= 10 and not inst.broken then
    inst:AddComponent("blinkstaff")
	inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
    inst.components.blinkstaff.onblinkfn = onblink
	end
	
   	
elseif inst.level >=1400 then  --1400
	inst.components.talker:Say("-[Power Blade III]\nLight(Large+))\nFlame Damage X2(30D)\nBlink\nSanity regen")
     if not inst.components.blinkstaff and owner.components.sanity.current >= 10 and not inst.broken then
    inst:AddComponent("blinkstaff")
	inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
    inst.components.blinkstaff.onblinkfn = onblink
	end
    inst.sanity = inst:DoPeriodicTask(10, function() sanity(inst, owner) end)
  --inst.components.equippable.walkspeedmult = 1.3
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(225/255,120/255,80/255)
	inst.Light:Enable(true)
	inst.AnimState:SetBank("nightmaresword")
    inst.AnimState:SetBuild("mushasword")
    inst.AnimState:PlayAnimation("idle")
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword3_boost", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end
-----------
elseif owner and inst.boost and not inst.broken then
	inst.boost = false 
	inst.components.talker:Say("Power off !")
	inst.components.talker:Say("-[Phoenix Blade]\nPower Off")
      inst:RemoveComponent("blinkstaff")
    if inst.task then inst.task:Cancel() inst.task = nil end
    if inst.sanity then inst.sanity:Cancel() inst.sanity = nil end

	inst.Light:Enable(false)

  inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
--SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
onequip(inst, owner)
--[[
if inst.level >=0 and inst.level <250 then  --250
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
elseif inst.level >=250 and inst.level <1400 then  --250 1400
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
elseif inst.level >=1400 then --1400
    owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword2", "swap_nightmaresword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end]]

        inst.components.useableitem:StopUsingItem()
end
end



local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    inst.entity:AddLight()
	inst.Light:SetRadius(.4)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(80/255,120/255,250/255)
	inst.Light:Enable(true)
	
  MakeInventoryPhysics(inst)  
  
    inst.AnimState:SetBank("nightmaresword")
    inst.AnimState:SetBuild("mushasword")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetMultColour(1, 1, 1, 0.7)

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "blade_1.tex" )
	 inst:AddTag("sharp")
	 	 inst:AddTag("musha_items")
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
	
   inst:AddComponent("weapon")
    inst.components.weapon:SetOnAttack(Upgradedamage)
    inst.components.weapon:SetOnAttack(onattack_Flame)
	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword.xml"
  
    inst.OnLoad = OnLoad

    inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

        inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(on_boost)
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
inst.boost = false 

	inst.level = 0
inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    MakeHauntableLaunch(inst)
    return inst
end

return Prefab( "common/inventory/mushasword", fn, assets) 


----------------------------


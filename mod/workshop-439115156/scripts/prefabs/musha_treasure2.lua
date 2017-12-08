
-- just simple treasure

local assets =
{
	Asset("ANIM", "anim/x_marks_spot.zip"),
	Asset("IMAGE", "images/inventoryimages/musha_treasure2.tex"),
	Asset("ATLAS", "images/inventoryimages/musha_treasure2.xml"),
}

local prefabs =
{
	"collapse_small",
}

SetSharedLootTable( 'musha_treasure',
{
 {'goldnugget', 1.0},
 {'goldnugget', 1.0},
 {'goldnugget', 0.8},
 {'goldnugget', 0.6},
 {'goldnugget', 0.4},
 {'goldnugget', 0.2},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget', 0.1},
 {'goldnugget',     0.05},
 {'goldnugget',     0.05},
 {'goldnugget',     0.05},
 {'goldnugget',     0.05},
 
    {'bluegem',     0.2},
	{'bluegem',     0.1},
	{'bluegem',     0.05},
	{'bluegem',     0.05},
	{'redgem',     0.2},
	{'redgem',     0.1},
	{'redgem',     0.05},
	{'redgem',     0.05},
	{'purplegem',  0.05},
	{'purplegem',  0.05},
	{'orangegem', 0.02},
	{'yellowgem', 0.02},
	{'greengem', 0.02},
	
    {'houndstooth', 0.1},
    {'houndstooth', 0.1},
	{'houndstooth', 0.1},
	{'boneshard', 0.1},
	{'boneshard', 0.1},
	{'boneshard', 0.1},
	
	{'livinglog', 0.1},
	{'livinglog', 0.1},
	{'livinglog', 0.05},
	{'livinglog', 0.05},
	
	{'gears', 0.1},
	{'gears', 0.05},
	{'gears', 0.05},
	{'gears', 0.05},
	
	{'rocks', 0.1},
	{'rocks', 0.1},
	{'rocks', 0.1},
	{'rocks', 0.1},
	{'rocks', 0.1},
	{'rocks', 0.1},
	{'rocks', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	{'flint', 0.1},
	
	{'ashe', 0.1},
	{'ashe', 0.1},
	{'ashe', 0.1},
	{'ashe', 0.1},
	{'ashe', 0.1},
	{'ashe', 0.1},
	
	{'carrot', 0.1},	
	{'carrot', 0.1},	
	{'carrot', 0.1},	
	{'carrot', 0.1},		
	{'carrot', 0.1},	
	{'carrot', 0.1},	
	
	{'amulet', 0.02},	
	{'yellowamulet', 0.01},	
	{'orangeamulet', 0.01},		
	{'purpleamulet', 0.01},	
	{'blueamulet', 0.01},	
	{'greenamulet', 0.01},
	
	
	{'tunacan', 0.5},
	{'tunacan', 0.1},
	{'tunacan', 0.1},
	{'tunacan', 0.1},
	{'tunacan', 0.1},
	{'tunacan', 0.1},	
	
	{'green_fruit', 0.1},	
	{'green_fruit', 0.1},	
	{'green_fruit', 0.1},	
	{'green_fruit', 0.1},		

	
})
--local lootdrop = {"flint","flint","boneshard"}

local function dig_up(inst, chopper)
inst.components.lootdropper:DropLoot()
--inst.components.lootdropper:SpawnLootPrefab("ash")
SpawnPrefab("ash").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("collapse_small").Transform:SetPosition(inst:GetPosition():Get())

	--danger
if math.random() < 0.03 then
SpawnPrefab("spider").Transform:SetPosition(inst:GetPosition():Get())
elseif math.random() < 0.03 then
SpawnPrefab("spider_warrior").Transform:SetPosition(inst:GetPosition():Get())
elseif math.random() < 0.02 then
SpawnPrefab("tentacle").Transform:SetPosition(inst:GetPosition():Get())
end

	--Simple random treasure
	
	--box 1
	

local chest1 = SpawnPrefab("treasurechest")
chest1.Transform:SetPosition(inst:GetPosition():Get())
	if math.random() < 0.15 then --guardian
SpawnPrefab("tentacle").Transform:SetPosition(inst:GetPosition():Get())
	elseif math.random() < 0.2 then
SpawnPrefab("spider").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("spider").Transform:SetPosition(inst:GetPosition():Get())
	elseif math.random() < 0.25 then
SpawnPrefab("spider").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("spider_warrior").Transform:SetPosition(inst:GetPosition():Get())
	end

	--treasure box1
if chest1.components.container then
	if math.random() < 0.25 then	
local item1 = SpawnPrefab("glowdust")
local item2 = SpawnPrefab("goldnugget")
local item3 = SpawnPrefab("goldnugget")
local item4 = SpawnPrefab("redgem")
local item5 = SpawnPrefab("redgem")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
	if math.random() < 0.3 then
		local item6 = SpawnPrefab("amulet")
		local item7 = SpawnPrefab("redgem")	
		local item8 = SpawnPrefab("goldnugget")	
		local item9 = SpawnPrefab("glowdust")
		chest1.components.container:GiveItem(item6)
		chest1.components.container:GiveItem(item7)
		chest1.components.container:GiveItem(item8)
		chest1.components.container:GiveItem(item9)
	elseif math.random() < 0.3 then
		local item6 = SpawnPrefab("bluegem")
		local item7 = SpawnPrefab("bluegem")	
		local item8 = SpawnPrefab("goldnugget")	
		local item9 = SpawnPrefab("portion_e")
		chest1.components.container:GiveItem(item6)
		chest1.components.container:GiveItem(item7)
		chest1.components.container:GiveItem(item8)
		chest1.components.container:GiveItem(item9)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
	elseif math.random() < 0.25 then	
local item1 = SpawnPrefab("glowdust")
local item2 = SpawnPrefab("goldnugget")
local item3 = SpawnPrefab("goldnugget")
local item4 = SpawnPrefab("bluegem")
local item5 = SpawnPrefab("bluegem")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
	if math.random() < 0.3 then
		local item6 = SpawnPrefab("bluegem")
		local item7 = SpawnPrefab("bluegem")	
		local item8 = SpawnPrefab("goldnugget")	
		local item9 = SpawnPrefab("glowdust")
		chest1.components.container:GiveItem(item6)
		chest1.components.container:GiveItem(item7)
		chest1.components.container:GiveItem(item8)
		chest1.components.container:GiveItem(item9)
	elseif math.random() < 0.3 then
		local item6 = SpawnPrefab("amulet")
		local item7 = SpawnPrefab("redgem")	
		local item8 = SpawnPrefab("goldnugget")	
		local item9 = SpawnPrefab("portion_e")
		chest1.components.container:GiveItem(item6)
		chest1.components.container:GiveItem(item7)
		chest1.components.container:GiveItem(item8)
		chest1.components.container:GiveItem(item9)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
	elseif math.random() < 0.25 then
		
		if math.random() < 0.5 then
local item1 = SpawnPrefab("meat_dried")	
local item2 = SpawnPrefab("meat_dried")	
local item3 = SpawnPrefab("pigskin")	
local item4 = SpawnPrefab("pigskin")	
local item5 = SpawnPrefab("pigskin")	
local item6 = SpawnPrefab("pigskin")
local item7 = SpawnPrefab("smallmeat_dried")	
local item8 = SpawnPrefab("smallmeat_dried")	
local item9 = SpawnPrefab("portion_e")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
			if math.random() < 0.5 then
		local item10 = SpawnPrefab("meat_dried")	
		local item11 = SpawnPrefab("meat_dried")	
		local item12 = SpawnPrefab("meat_dried")	
		local item13 = SpawnPrefab("pigskin")	
		local item14 = SpawnPrefab("pigskin")	
		local item15 = SpawnPrefab("pigskin")	
		local item16 = SpawnPrefab("tunacan")	
		local item17 = SpawnPrefab("tunacan")	
		local item18 = SpawnPrefab("tunacan")	
		local item19 = SpawnPrefab("tunacan")	
		local item20 = SpawnPrefab("tunacan")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
		else
local item1 = SpawnPrefab("carrot")	
local item2 = SpawnPrefab("carrot")	
local item3 = SpawnPrefab("manrabbit_tail")	
local item4 = SpawnPrefab("manrabbit_tail")	
local item5 = SpawnPrefab("manrabbit_tail")	
local item6 = SpawnPrefab("manrabbit_tail")
local item7 = SpawnPrefab("carrot")	
local item8 = SpawnPrefab("carrot")	
local item9 = SpawnPrefab("carrot")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)		
			if math.random() < 0.5 then
		local item10 = SpawnPrefab("carrot")	
		local item11 = SpawnPrefab("carrot")	
		local item12 = SpawnPrefab("carrot")	
		local item13 = SpawnPrefab("carrot")	
		local item14 = SpawnPrefab("carrot")	
		local item15 = SpawnPrefab("beefalowool")	
		local item16 = SpawnPrefab("beefalowool")	
		local item17 = SpawnPrefab("beefalowool")	
		local item18 = SpawnPrefab("beefalowool")	
		local item19 = SpawnPrefab("manrabbit_tail")	
		local item20 = SpawnPrefab("manrabbit_tail")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
		end

	
   elseif math.random() < 0.25 then
local item1 = SpawnPrefab("flowerhat")	
local item2 = SpawnPrefab("glowdust")
local item3 = SpawnPrefab("glowdust")	
local item4 = SpawnPrefab("mandrake")	
local item5 = SpawnPrefab("portion_e")	
local item6 = SpawnPrefab("petals")	
local item7 = SpawnPrefab("petals")	
local item8 = SpawnPrefab("petals")	
local item9 = SpawnPrefab("petals")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("mandrake")	
		local item11 = SpawnPrefab("beefalowool")	
		local item12 = SpawnPrefab("beefalowool")	
		local item13 = SpawnPrefab("beefalowool")	
		local item14 = SpawnPrefab("beefalowool")	
		local item15 = SpawnPrefab("tunacan")	
		local item16 = SpawnPrefab("tunacan")	
		local item17 = SpawnPrefab("tunacan")	
		local item18 = SpawnPrefab("tunacan")	
		local item19 = SpawnPrefab("tunacan")	
		local item20 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
    elseif math.random() < 0.25 then
local item1 = SpawnPrefab("glowdust")	
local item2 = SpawnPrefab("beardhair")
local item3 = SpawnPrefab("beardhair")	
local item4 = SpawnPrefab("beardhair")	
local item5 = SpawnPrefab("beardhair")	
local item6 = SpawnPrefab("beardhair")	
local item7 = SpawnPrefab("beardhair")	
local item8 = SpawnPrefab("beardhair")	
local item9 = SpawnPrefab("beardhair")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("nightmarefuel")	
		local item11 = SpawnPrefab("nightmarefuel")	
		local item12 = SpawnPrefab("nightmarefuel")	
		local item13 = SpawnPrefab("nightmarefuel")	
		local item14 = SpawnPrefab("nightmarefuel")	
		local item15 = SpawnPrefab("nightmarefuel")	
		local item16 = SpawnPrefab("glowdust")	
		local item17 = SpawnPrefab("glowdust")	
		local item18 = SpawnPrefab("glowdust")	
		local item19 = SpawnPrefab("purplegem")	
		local item20 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
    elseif math.random() < 0.25 then
local item1 = SpawnPrefab("glowdust")	
local item2 = SpawnPrefab("glowdust")
local item3 = SpawnPrefab("redgem")	
local item4 = SpawnPrefab("bluegem")	
local item5 = SpawnPrefab("tunacan")	
local item6 = SpawnPrefab("tunacan")	
local item7 = SpawnPrefab("tunacan")	
local item8 = SpawnPrefab("tunacan")	
local item9 = SpawnPrefab("tunacan")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("tunacan")	
		local item11 = SpawnPrefab("tunacan")	
		local item12 = SpawnPrefab("tunacan")	
		local item13 = SpawnPrefab("tunacan")	
		local item14 = SpawnPrefab("tunacan")	
		local item15 = SpawnPrefab("tunacan")	
		local item16 = SpawnPrefab("tunacan")	
		local item17 = SpawnPrefab("glowdust")	
		local item18 = SpawnPrefab("glowdust")	
		local item19 = SpawnPrefab("purplegem")	
		local item20 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
    elseif math.random() < 0.25 then
local item1 = SpawnPrefab("livinglog")	
local item2 = SpawnPrefab("livinglog")
local item3 = SpawnPrefab("livinglog")	
local item4 = SpawnPrefab("livinglog")	
local item5 = SpawnPrefab("livinglog")	
local item6 = SpawnPrefab("livinglog")	
local item7 = SpawnPrefab("log")	
local item8 = SpawnPrefab("log")	
local item9 = SpawnPrefab("log")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("livinglog")	
		local item11 = SpawnPrefab("livinglog")	
		local item12 = SpawnPrefab("livinglog")	
		local item13 = SpawnPrefab("livinglog")	
		local item14 = SpawnPrefab("livinglog")	
		local item15 = SpawnPrefab("glowdust")	
		local item16 = SpawnPrefab("glowdust")	
		local item17 = SpawnPrefab("glowdust")	
		local item18 = SpawnPrefab("log")	
		local item19 = SpawnPrefab("log")	
		local item20 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
    elseif math.random() < 0.25 then
local item1 = SpawnPrefab("gears")	
local item2 = SpawnPrefab("gears")
local item3 = SpawnPrefab("gears")	
local item4 = SpawnPrefab("gears")	
local item5 = SpawnPrefab("gears")	
local item6 = SpawnPrefab("flint")	
local item7 = SpawnPrefab("marble")	
local item8 = SpawnPrefab("rope")	
local item9 = SpawnPrefab("rope")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("gears")	
		local item11 = SpawnPrefab("gears")	
		local item12 = SpawnPrefab("gears")	
		local item13 = SpawnPrefab("redgem")	
		local item14 = SpawnPrefab("marble")	
		local item15 = SpawnPrefab("marble")	
		local item16 = SpawnPrefab("flint")	
		local item17 = SpawnPrefab("flint")	
		local item18 = SpawnPrefab("flint")	
		local item19 = SpawnPrefab("flint")	
		local item20 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
    elseif math.random() < 0.25 then
local item1 = SpawnPrefab("mandrake")	
local item2 = SpawnPrefab("mandrake")
local item3 = SpawnPrefab("glowdust")	
local item4 = SpawnPrefab("glowdust")	
local item5 = SpawnPrefab("glowdust")	
local item6 = SpawnPrefab("carrot")	
local item7 = SpawnPrefab("carrot")	
local item8 = SpawnPrefab("carrot")	
local item9 = SpawnPrefab("orangegem")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("glowdust")	
		local item11 = SpawnPrefab("glowdust")	
		local item12 = SpawnPrefab("glowdust")	
		local item13 = SpawnPrefab("mandrake")	
		local item14 = SpawnPrefab("carrot")	
		local item15 = SpawnPrefab("carrot")	
		local item16 = SpawnPrefab("carrot")	
		local item17 = SpawnPrefab("goldnugget")	
		local item18 = SpawnPrefab("goldnugget")	
		local item19 = SpawnPrefab("goldnugget")	
		local item20 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
	elseif math.random() < 0.25 then
local item1 = SpawnPrefab("glowdust")
local item2 = SpawnPrefab("glowdust")
local item3 = SpawnPrefab("goldnugget")
local item4 = SpawnPrefab("coontail")
local item5 = SpawnPrefab("coontail")
local item6 = SpawnPrefab("coontail")
local item7 = SpawnPrefab("redgem")
local item8 = SpawnPrefab("bluegem")
local item9 = SpawnPrefab("yellowgem")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("coontail")	
		local item11 = SpawnPrefab("goldnugget")	
		local item12 = SpawnPrefab("goldnugget")	
		local item13 = SpawnPrefab("goldnugget")	
		local item14 = SpawnPrefab("goldnugget")	
		local item15 = SpawnPrefab("goldnugget")	
		local item16 = SpawnPrefab("goldnugget")	
		local item17 = SpawnPrefab("goldnugget")	
		local item18 = SpawnPrefab("purplegem")	
		local item19 = SpawnPrefab("purplegem")	
		local item20 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
	elseif math.random() < 0.25 then
local item1 = SpawnPrefab("redgem")
local item2 = SpawnPrefab("redgem")
local item3 = SpawnPrefab("bluegem")
local item4 = SpawnPrefab("bluegem")
local item5 = SpawnPrefab("goldnugget")
local item6 = SpawnPrefab("goldnugget")
local item7 = SpawnPrefab("goldnugget")
local item8 = SpawnPrefab("goldnugget")
local item9 = SpawnPrefab("greengem")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("goldnugget")	
		local item11 = SpawnPrefab("goldnugget")	
		local item12 = SpawnPrefab("goldnugget")	
		local item13 = SpawnPrefab("goldnugget")	
		local item14 = SpawnPrefab("goldnugget")	
		local item15 = SpawnPrefab("goldnugget")	
		local item16 = SpawnPrefab("flint")	
		local item17 = SpawnPrefab("flint")	
		local item18 = SpawnPrefab("flint")	
		local item19 = SpawnPrefab("flint")	
		local item20 = SpawnPrefab("greenamulet")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
	elseif math.random() < 0.25 then
local item1 = SpawnPrefab("ruinshat")
local item2 = SpawnPrefab("cristal")
local item3 = SpawnPrefab("wall_ruins_item")
local item4 = SpawnPrefab("wall_ruins_item")
local item5 = SpawnPrefab("wall_ruins_item")
local item6 = SpawnPrefab("wall_ruins_item")
local item7 = SpawnPrefab("wall_ruins_item")
local item8 = SpawnPrefab("wall_ruins_item")
local item9 = SpawnPrefab("wall_ruins_item")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("armorruins")	
		local item11 = SpawnPrefab("ruins_bat")	
		local item12 = SpawnPrefab("redgem")	
		local item13 = SpawnPrefab("redgem")	
		local item14 = SpawnPrefab("redgem")	
		local item15 = SpawnPrefab("wall_ruins_item")	
		local item16 = SpawnPrefab("wall_ruins_item")	
		local item17 = SpawnPrefab("wall_ruins_item")	
		local item18 = SpawnPrefab("glowdust")	
		local item19 = SpawnPrefab("glowdust")	
		local item20 = SpawnPrefab("glowdust")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end
    elseif math.random() < 0.25 then
local item1 = SpawnPrefab("honeycomb")	
local item2 = SpawnPrefab("honeycomb")
local item3 = SpawnPrefab("honeycomb")	
local item4 = SpawnPrefab("stinger")	
local item5 = SpawnPrefab("stinger")	
local item6 = SpawnPrefab("stinger")	
local item7 = SpawnPrefab("stinger")	
local item8 = SpawnPrefab("stinger")	
local item9 = SpawnPrefab("stinger")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("honeycomb")	
		local item11 = SpawnPrefab("honeycomb")	
		local item12 = SpawnPrefab("honeycomb")	
		local item13 = SpawnPrefab("silk")	
		local item14 = SpawnPrefab("silk")	
		local item15 = SpawnPrefab("silk")	
		local item16 = SpawnPrefab("silk")	
		local item17 = SpawnPrefab("tunacan")	
		local item18 = SpawnPrefab("tunacan")	
		local item19 = SpawnPrefab("tunacan")	
		local item20 = SpawnPrefab("tunacan")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end	
	elseif math.random() < 0.25 then
local item1 = SpawnPrefab("tentaclespots")	
local item2 = SpawnPrefab("tentaclespots")
local item3 = SpawnPrefab("papyrus")	
local item4 = SpawnPrefab("papyrus")	
local item5 = SpawnPrefab("papyrus")	
local item6 = SpawnPrefab("papyrus")	
local item7 = SpawnPrefab("cutreeds")	
local item8 = SpawnPrefab("cutreeds")	
local item9 = SpawnPrefab("glowdust")	
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("cutreeds")	
		local item11 = SpawnPrefab("cutreeds")	
		local item12 = SpawnPrefab("papyrus")	
		local item13 = SpawnPrefab("papyrus")	
		local item14 = SpawnPrefab("papyrus")	
		local item15 = SpawnPrefab("sleepbomb")	
		local item16 = SpawnPrefab("sleepbomb")	
		local item17 = SpawnPrefab("blowdart_sleep")	
		local item18 = SpawnPrefab("blowdart_sleep")	
		local item19 = SpawnPrefab("blowdart_sleep")	
		local item20 = SpawnPrefab("blowdart_sleep")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("portion_e")	
		chest1.components.container:GiveItem(item10)
			end	
	else
local item1 = SpawnPrefab("glowdust")
local item2 = SpawnPrefab("glowdust")
local item3 = SpawnPrefab("glowdust")
local item4 = SpawnPrefab("redgem")
local item5 = SpawnPrefab("bluegem")
local item6 = SpawnPrefab("purplegem")
local item7 = SpawnPrefab("yellowgem")
local item8 = SpawnPrefab("greengem")
local item9 = SpawnPrefab("orangegem")
chest1.components.container:GiveItem(item1)
chest1.components.container:GiveItem(item2)
chest1.components.container:GiveItem(item3)
chest1.components.container:GiveItem(item4)
chest1.components.container:GiveItem(item5)
chest1.components.container:GiveItem(item6)
chest1.components.container:GiveItem(item7)
chest1.components.container:GiveItem(item8)
chest1.components.container:GiveItem(item9)
	if math.random() < 0.5 then
		local item10 = SpawnPrefab("exp")	
		local item11 = SpawnPrefab("glowdust")	
		local item12 = SpawnPrefab("glowdust")	
		local item13 = SpawnPrefab("glowdust")	
		local item14 = SpawnPrefab("glowdust")	
		local item15 = SpawnPrefab("glowdust")	
		local item16 = SpawnPrefab("glowdust")	
		local item17 = SpawnPrefab("glowdust")	
		local item18 = SpawnPrefab("glowdust")	
		local item19 = SpawnPrefab("glowdust")	
		local item20 = SpawnPrefab("glowdust")	
		chest1.components.container:GiveItem(item10)
		chest1.components.container:GiveItem(item11)
		chest1.components.container:GiveItem(item12)
		chest1.components.container:GiveItem(item13)
		chest1.components.container:GiveItem(item14)
		chest1.components.container:GiveItem(item15)
		chest1.components.container:GiveItem(item16)
		chest1.components.container:GiveItem(item17)
		chest1.components.container:GiveItem(item18)
		chest1.components.container:GiveItem(item19)
		chest1.components.container:GiveItem(item20)
	elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("redgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.5 then
		local item10 = SpawnPrefab("bluegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.1 then
		local item10 = SpawnPrefab("purplegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("yellowgem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("orangegem")	
		chest1.components.container:GiveItem(item10)
			elseif math.random() < 0.05 then
		local item10 = SpawnPrefab("greengem")	
		chest1.components.container:GiveItem(item10)
	end
end	
end	

	inst:Remove()
end

local function mark_map(inst, data)

end
	
local function onsave(inst, data)
    --[[if not inst.components.workable then
        data.dug = true
    end]]

	if inst.revealed then
		data.revealed = inst.revealed
	end
end

local function onload(inst, data)

    --[[if data and data.dug or not inst.components.workable then
        inst:RemoveComponent("workable")
        inst.components.hole.canbury = true
        inst:RemoveTag("NOCLICK")
    end]]

      if data and data.revealed and data.revealed == true then
    	print("Reveal treasure")
    	inst:Reveal(inst)
    end
end

local function Activateicon(inst)
local minimap = TheWorld.minimap.MiniMap
    inst.activatetask = nil
	minimap:DrawForgottenFogOfWar(true)
	if not inst.components.maprevealer then
		inst:AddComponent("maprevealer")
	end
	inst.components.maprevealer.revealperiod = 1
	inst.components.maprevealer:Start()
		
end

local function fn(Sim)
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	
	inst:AddTag("musha_treasure")
	inst:AddTag("NOCLICK")
	
	inst.entity:Hide()

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_treasure2.tex" )
		
    inst.AnimState:SetBank("x_marks_spot")
    inst.AnimState:SetBuild("x_marks_spot")
    inst.AnimState:PlayAnimation("anim")
	
	--inst.MiniMapEntity:SetPriority(10)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("maprevealer")
	inst.components.maprevealer.revealperiod = 3
	inst.components.maprevealer:Start()
	--inst.activatetask = inst:DoTaskInTime(0.1, Activateicon)
	
    inst:AddComponent("inspectable")
    --[[inst.components.inspectable.getstatus = function(inst)
        if not inst.components.workable then
            return "DUG"
        end
    end]]
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('musha_treasure')
	--inst.components.lootdropper:SetLoot(lootdrop)
	
    inst:AddComponent("workable")
		    inst.components.workable:SetWorkAction(ACTIONS.DIG)
		    inst.components.workable:SetOnFinishCallback(dig_up)
		    inst.components.workable:SetWorkLeft(1)
 	
    inst:AddComponent("hole")

    inst.revealed = false

    inst.Reveal = function(inst)
    	print("Treasure revealed")
    	inst.revealed = true
    	inst.entity:Show()
    	inst.MiniMapEntity:SetEnabled(true)
    	inst:RemoveTag("NOCLICK")

		
	end

	inst.IsRevealed = function(inst)
		return inst.revealed
	end
	
	
	--mark_map(inst)
	
	inst.OnSave = onsave
	inst.OnLoad = onload
	
	inst.SetTreasureHunt = function(inst)
		inst:Reveal()

	end
	
    return inst
end
--common/objects/
return Prefab( "musha_treasure2", fn, assets, prefabs )

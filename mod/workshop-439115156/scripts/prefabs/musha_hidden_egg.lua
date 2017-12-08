-- just simple treasure

local assets =
{
	Asset("ANIM", "anim/x_marks_spot.zip"),
	Asset("IMAGE", "images/inventoryimages/x_mark.tex"),
	Asset("ATLAS", "images/inventoryimages/x_mark.xml"),	
}

local prefabs =
{
	"collapse_small",
}

SetSharedLootTable( 'musha_eggs',
{
	{'armor_mushaa', 1.0},
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
 
 --   {'bluegem',     0.1},
	{'bluegem',     0.05},
	{'bluegem',     0.05},
	{'bluegem',     0.05},
--	{'redgem',     0.1},
	{'redgem',     0.05},
	{'redgem',     0.05},
	{'redgem',     0.05},
	{'purplegem',  0.05},
	{'purplegem',  0.05},
	
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
	
	{'tunacan', 0.1},
	{'tunacan', 0.05},
	{'tunacan', 0.05},
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
		
})
--local lootdrop = {"flint","flint","boneshard"}

local function dig_up(inst, chopper)
inst.components.lootdropper:DropLoot()

--SpawnPrefab("musha_egg").Transform:SetPosition(inst:GetPosition():Get())

local backpack = SpawnPrefab("treasurechest")
backpack.Transform:SetPosition(inst:GetPosition():Get())
if backpack.components.container then
local item1 = SpawnPrefab("musha_egg")
local item2 = SpawnPrefab("glowdust")
local item3 = SpawnPrefab("glowdust")
local item4 = SpawnPrefab("glowdust")
local item5 = SpawnPrefab("glowdust")
local item6 = SpawnPrefab("flowerhat")
local item7 = SpawnPrefab("backpack_blueprint")
local item8 = SpawnPrefab("hammer")
local item9 = SpawnPrefab("axe")
local item10 = SpawnPrefab("pickaxe")
local item11 = SpawnPrefab("goldnugget")
local item12 = SpawnPrefab("goldnugget")
local item13 = SpawnPrefab("tunacan")
local item14 = SpawnPrefab("tunacan")
local item15 = SpawnPrefab("tunacan")
backpack.components.container:GiveItem(item1)
backpack.components.container:GiveItem(item2)
backpack.components.container:GiveItem(item3)
backpack.components.container:GiveItem(item4)
backpack.components.container:GiveItem(item5)
backpack.components.container:GiveItem(item6)
backpack.components.container:GiveItem(item7)
backpack.components.container:GiveItem(item8)
backpack.components.container:GiveItem(item9)
backpack.components.container:GiveItem(item10)
backpack.components.container:GiveItem(item11)
backpack.components.container:GiveItem(item12)
backpack.components.container:GiveItem(item13)
backpack.components.container:GiveItem(item14)
backpack.components.container:GiveItem(item15)
end

SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("collapse_small").Transform:SetPosition(inst:GetPosition():Get())

	inst:Remove()
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
	inst.MiniMapEntity:SetIcon( "musha_egg.tex" )
	inst.MiniMapEntity:SetPriority(10)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
    inst.AnimState:SetBank("x_marks_spot")
    inst.AnimState:SetBuild("x_marks_spot")
    inst.AnimState:PlayAnimation("anim")
	
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
	--inst.activatetask = inst:DoTaskInTime(0.1, Activateicon)
	inst:AddComponent("maprevealer")
	inst.components.maprevealer.revealperiod = 3
	inst.components.maprevealer:Start()
	
    inst:AddComponent("inspectable")
    --[[inst.components.inspectable.getstatus = function(inst)
        if not inst.components.workable then
            return "DUG"
        end
    end]]
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('musha_eggs')
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

	inst.OnSave = onsave
	inst.OnLoad = onload
	
	inst.SetTreasureHunt = function(inst)
		inst:Reveal()
		--[[local x, y, z = inst.Transform:GetLocalPosition()
    	local minimap = GetWorld().minimap.MiniMap
    	local map = GetWorld().Map
        local cx, cy, cz = map:GetTileCenterPoint(x, 0, z)
        minimap:ShowArea(cx, cy, cz, 20)
        map:VisitTile(map:GetTileCoordsAtPoint(cx, cy, cz))
		inst.MiniMapEntity:SetDrawOverFogOfWar(true)
		local px, py, pz = GetPlayer().Transform:GetWorldPosition()
    	GetPlayer().HUD.controls:ToggleMap()
    	minimap:Focus(x - px, z - pz, -minimap:GetZoom()) --Zoom in all the way	
		]]
	end

    return inst
end

return Prefab( "common/objects/musha_hidden_egg", fn, assets, prefabs )

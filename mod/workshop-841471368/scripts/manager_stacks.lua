local _G = GLOBAL
local TheNet = _G.TheNet
local TheSim = _G.TheSim
local SpawnPrefab = _G.SpawnPrefab
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local FOODTYPE = _G.FOODTYPE

-- 物品自动堆叠检测范围
local SEE_ITEM_STACK_DIST = 10

-- 掉落物品自动堆叠
local auto_stack = GetModConfigData("auto_stack")

if auto_stack and IsServer then
    local function AnimPut(item, target)
        if target and target ~= item and target.prefab == item.prefab and item.components.stackable and not item.components.stackable:IsFull() and target.components.stackable and not target.components.stackable:IsFull() then
            local start_fx = SpawnPrefab("small_puff")
            start_fx.Transform:SetPosition(target.Transform:GetWorldPosition())
            start_fx.Transform:SetScale(.5, .5, .5)

            item.components.stackable:Put(target)
        end
    end

    local LootDropper = _G.require("components/lootdropper")
    local old_FlingItem = LootDropper.FlingItem
	-- 掉落物品自动堆叠
	function LootDropper:FlingItem(loot, pt, bouncedcb)
        if loot ~= nil and loot:IsValid() then
            if self.inst:IsValid() or pt ~= nil then
                old_FlingItem(self, loot, pt, bouncedcb)

                loot:DoTaskInTime(0.5, function(inst)
                    if inst:IsValid() then
                        local pos = inst:GetPosition()
                        local x, y, z = pos:Get()
                        local ents = TheSim:FindEntities(x, y, z, SEE_ITEM_STACK_DIST, { "_inventoryitem" }, { "INLIMBO", "NOCLICK", "catchable", "fire" })
                        for _,obj in pairs(ents) do
                            AnimPut(loot, obj)
                        end
                    end
                end)
            end
        end
	end

    -- 猪王给予物品自动堆叠
    AddPrefabPostInit("pigking", function(inst)
        local old_onaccept = inst.components.trader.onaccept
        inst.components.trader.onaccept = function(inst, giver, item)
            if old_onaccept ~= nil then old_onaccept(inst, giver, item) end

            inst:DoTaskInTime(2, function(inst)
                local pos = inst:GetPosition()
                local x, y, z = pos:Get()
                local ents = TheSim:FindEntities(x, y, z, SEE_ITEM_STACK_DIST, { "_inventoryitem" }, { "INLIMBO", "NOCLICK", "catchable", "fire" })
                for _,objBase in pairs(ents) do
                    -- objBase.replica.inventoryitem.classified ~= nil
                    if objBase:IsValid() and objBase.components.stackable and not objBase.components.stackable:IsFull() then
                        for _,obj in pairs(ents) do
                            if obj:IsValid() then
                                AnimPut(objBase, obj)
                            end
                        end
                    end
                end
            end)
        end
	end)

    -- 疯猪的屎自动堆叠
    local function OnEat(inst, food)
        if food.components.edible ~= nil then
            if food.components.edible.foodtype == FOODTYPE.VEGGIE then
                local poop = SpawnPrefab("poop")
                local pos = inst:GetPosition()
                local x, y, z = pos:Get()
                poop.Transform:SetPosition(inst.Transform:GetWorldPosition())
                local ents = TheSim:FindEntities(x, y, z, SEE_ITEM_STACK_DIST, { "_inventoryitem" }, { "INLIMBO", "NOCLICK", "catchable", "fire" })
                for _,obj in pairs(ents) do
                    AnimPut(poop, obj)
                end
            elseif food.components.edible.foodtype == FOODTYPE.MEAT and
                inst.components.werebeast ~= nil and
                not inst.components.werebeast:IsInWereState() and
                food.components.edible:GetHealth(inst) < 0 then
                inst.components.werebeast:TriggerDelta(1)
            end
        end
    end

    AddPrefabPostInit("pigman", function(inst)
        inst.components.eater:SetOnEatFn(OnEat)
	end)

    AddPrefabPostInit("pigguard", function(inst)
        inst.components.eater:SetOnEatFn(OnEat)
	end)
end
--自动清理时间间隔
local clear_period = 480
--附近要清理的物品列表(可自定义)
local function GetCleanItems()
	return {
		spiderden = true,                  -- 蜘蛛巢
		skeleton_player = true,            -- 前辈(骨头)
		-- wall_wood,
		-- wall_stone,
		-- wall_ruins,
		-- wall_hay,
		-- wall_moonrock,
		-- fence_gate,                     -- 木门
		-- fence,                          -- 木栅栏
		rabbithouse = true,                -- 兔人房
		tentacle = true,                   -- 触手
		lureplant = true,                  -- 肉球茎
	}
end
local clear_tags = {
	"wall"
}
local clear_item = GetCleanItems()

local NearAutoDelete = Class(function(self, inst)
	self.inst = inst
	-- 自动清理范围
	self.clear_near = 30
	self.CustomPrefab = ""
end)

function NearAutoDelete:SetScope(scope)
	scope = tonumber(scope)
    if scope ~= nil then
        self.clear_near = scope
    end
end

function NearAutoDelete:AddCustomPrefab(prefab)
	if type(prefab) == 'string' then
		clear_item[prefab] = true
    end
end

function NearAutoDelete:SetCustomPrefab(prefabs)
	if type(prefabs) == 'string' then
		clear_item = GetCleanItems()
		self.CustomPrefab = prefabs
        for prefab in string.gmatch(prefabs, "([%w_]+)") do
			clear_item[prefab] = true
        end
    end
end

local function HasCleanTag(inst)
	for _, tag in pairs(clear_tags) do
		if inst:HasTag(tag) then return true end
	end

	return false
end

local function AutoDeleteTask(inst, self)
	--print("delete handle!")
	local owner = nil
	local ents = {}
	local x = nil
	local y = nil
	local z = nil
	
	x, y, z = inst.Transform:GetWorldPosition()
	
	if x ~= nil and y ~= nil and z ~= nil then
		--print("x="..x..", y="..y.."z="..z)
		ents = TheSim:FindEntities(x, y, z, self.clear_near)
		
		for _,obj in pairs(ents) do
			if obj.prefab ~= nil and (clear_item[obj.prefab] or HasCleanTag(obj)) then
				if obj.components.occupier then
					owner = obj.components.occupier:GetOwner()
				end
				
				if not owner and obj then
					obj:Remove()
				end
			end
		end
	end	
end

----执行附近指定物品的删除操作
function NearAutoDelete:start()
	self.inst:DoPeriodicTask(clear_period, AutoDeleteTask, 0, self)
end

return NearAutoDelete
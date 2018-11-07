local _G = GLOBAL

--加载墙体权限，对象，索引依次为1.是否有权限控制 2.是否能被怪物摧毁 3.是否有权限才能被打开
local walls_config = {
	["fence_gate_lock"] = GetModConfigData("door_lock"),
	["fence_lock"] = GetModConfigData("fence_lock"),
	["wall_hay_lock"] = GetModConfigData("wall_hay_lock"),
	["wall_wood_lock"] = GetModConfigData("wall_wood_lock"),
	["wall_stone_lock"] = GetModConfigData("wall_stone_lock"),
	--["wall_straw_lock"] = GetModConfigData("wall_straw_lock"),
	["wall_ruins_lock"] = GetModConfigData("wall_ruins_lock"),
	["wall_moonrock_lock"] = GetModConfigData("wall_moonrock_lock"),
}

walls_state_config = {
	-- 普通墙
	walls_normal = {
	},
	-- 超级墙
	walls_power = {
	},
	-- --门
	-- doors_table = {
	-- 	"fence_gate",--木门
	-- },
	-- --普通墙
	-- walls_table = {
	-- 	"wall_stone",--石墙
	-- 	"wall_hay",--草墙
	-- 	"wall_wood",--木墙
	-- 	"wall_straw",
	-- 	--"wall_ruins",--图勒墙
	-- 	--"wall_moonrock",--月亮石墙
	-- 	--"fence_gate",--木门
	-- 	"fence",--木栅栏
	-- },
	-- --加固的无敌墙
	-- walls_ex_table = {
	-- 	"wall_ruins",--图勒墙
	-- 	"wall_moonrock",--月亮石墙
	-- },
}

-- 判断墙体权限
-- param @name 墙体名
-- param @index 权限索引: 1.是否有权限控制 2.是否不能被怪物摧毁 3.是否有权限才能被打开
function CheckWallActionPermission(name, index)
	if name == nil then return false end

	local itemKey = name.."_lock"
	if walls_config[itemKey] ~= nil and walls_config[itemKey][index] ~= nil then
		return (walls_config[itemKey][index] ~= 1)
	end

	return false
end

-- 墙状态初始化
for k, v in pairs(walls_config) do
	walls_config[k] = {}
	--print(k..":"..v)
	for i = 1, 3, 1 do
		local nItemValue = _G.tonumber(string.sub(v,i,i))
		--print(nItemValue)
		-- if i == 2 then
		-- 	table.insert(nItemValue == 1 and walls_state_config.walls_power or walls_state_config.walls_normal , (k:gsub("_lock", "")))
		-- end
		table.insert(walls_config[k], nItemValue)
	end

	local wallKey = k:gsub("_lock", "")
	if walls_config[k][1] == 1 or walls_config[k][2] == 1 then
		-- table.insert(walls_state_config.walls_power, (k:gsub("_lock", "")))
		walls_state_config.walls_power[wallKey] = true
	else
		-- table.insert(walls_state_config.walls_normal, (k:gsub("_lock", "")))
		walls_state_config.walls_normal[wallKey] = true
	end
end

-- print("test")
-- for k, v in pairs(walls_config) do
-- 	print(k..":"..tostring(v[1])..tostring(v[2])..tostring(v[3]))
-- end

-- 超级墙处理
-- for k, v in pairs(walls_state_config.walls_power) do
-- 	-- 接管超级墙攻击(砸)和生命改变事件
-- 	AddPrefabPostInit(k, makeDeployCantAttack)
-- 	-- 移除超级墙可燃烧属性
-- 	AddPrefabPostInit(k, RemoveBurnable)
-- end

-----权限保存与加载----
for k, v in pairs(walls_state_config) do
	for wall_name, val in pairs(v) do
		SavePermission(wall_name)
	end
end

--使墙/栅栏/门等被攻击和砸无效
--[[
local function makeWallPowerWork(inst)
	if _G.TheWorld.ismastersim and inst.components.workable ~= nil then
		inst:DoTaskInTime(1, function()
			inst.iniworkleft = inst.components.workable.workleft
			inst.workleft = inst.iniworkleft
			inst.components.workable.old_onwork = inst.components.workable.onwork
			local function onwork(inst, worker, workleft)
				testActPrint(nil, worker, inst, "onwork", "墙体工作")

				local leader = worker
				--如果是影子，检测影子主人
				-- if worker:HasTag("shadowminion") then
				-- 	leader = worker.components.follower.leader
				-- end
				
				-- 有权限时直接处理..主机或管理员直接可攻击
				if CheckItemPermission(leader, inst, true) or (leader:HasTag("player") and not CheckWallActionPermission(inst.prefab, 1) or not CheckWallActionPermission(inst.prefab, 2)) then
					inst.islastworkvalid=true
					inst.components.workable.destroyed=true
					if inst.avghealth == nil or inst.components.health.currenthealth == 0 then
						inst.workleft=workleft
					else
						inst.components.workable.workleft=inst.workleft
						if inst.components.health.currenthealth % inst.avghealth ~= 0 then
							inst.components.health.currenthealth = inst.components.health.currenthealth - inst.components.health.currenthealth % inst.avghealth
						else
							inst.components.health.currenthealth = inst.components.health.currenthealth - inst.avghealth
						end
						inst.components.health.old_ondelta(inst, inst.currenthealth / inst.components.health.maxhealth, inst.components.health:GetPercent())
						inst.currenthealth = inst.components.health.currenthealth
					end
				else
					inst.islastworkvalid=false
					inst.components.workable.destroyed=false
					inst.components.workable.workleft=inst.workleft
					-- and inst:HasTag("wall")
					if worker:HasTag("player") then
						local doer_num = GetPlayerIndex(worker.userid)
						local master = GetPlayerById(inst.ownerlist and inst.ownerlist.master or nil)
						if master ~= nil then
							PlayerSay(worker, get_msg(29,{master.name,inst.name}))
							PlayerSay(master, get_msg(17,{worker.name,inst.name,doer_num}))
						else
							PlayerSay(worker, get_msg(22,{GetPlayerNameByOwnerlist(inst.ownerlist)}))
						end
					end
				end
			end
			inst.components.workable:SetOnWorkCallback(onwork)

			-- 墙体处理
			if inst.components["health"] and inst.components.health.ondelta then
				inst.maxhealth = inst.components.health.maxhealth
				inst.avghealth = 0.25 * inst.maxhealth
				inst.currenthealth = inst.components.health.currenthealth
				inst.components.health.old_ondelta = inst.components.health.ondelta
				inst.components.health.ondelta = function(inst, old_percent, new_percent)
					-- 无条件允许修补
					if inst.components.health.currenthealth > inst.currenthealth then
						inst.currenthealth = inst.components.health.currenthealth
						inst.components.health.old_ondelta(inst, old_percent, new_percent)
					end

					inst.components.health.currenthealth = inst.currenthealth

					-- -- 主机或管理员直接可攻击(此处有问题未完善..无法获得当前攻击对象和被攻击对象)
					-- if not ((_G.TheWorld.ismastersim == false) or (admin_option and worker.Network:IsServerAdmin() and test_mode == false) or (inst and (inst.ownerlist == nil or tablelength(inst.ownerlist) == 0 or (worker.userid and inst:HasTag("userid_"..worker.userid))))) then
					-- 	inst.components.health.currenthealth = inst.currenthealth
					-- 	if worker:HasTag("player") and worker.components.talker then
					-- 		worker:DoTaskInTime(0, function ()
					-- 			--worker.components.talker:Say("这是别人家的墙，我砸不动！")
					-- 			worker.components.talker:Say(get_msg(29))
					-- 		end)
					-- 	end
					-- end
					-- inst.components.health.old_ondelta(inst, old_percent, new_percent)
				end
			end
		end)
	end
end
--]]
local _G = GLOBAL
local TheNet = _G.TheNet
local TheShard = _G.TheShard
local worldShardId = TheShard:GetShardId()
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()
-- 世界连接通道
local connect_worlds = GetModConfigData("connect_worlds")

if IsServer then
	local formServerName = connect_worlds and connect_worlds[worldShardId] and connect_worlds[worldShardId].name or nil
	--[[
	local CLIENT_SIDE = TheNet:GetIsClient() or (TheNet:GetIsServer() and not TheNet:IsDedicated())
	local function CheckUserHint(inst)
		local c =  _G.ThePlayer and _G.ThePlayer.player_classified
		if c == nil then
			return ""
		end
		--c.gdlock_hint
		local i = string.find(c.gdlock_hint,';',1,true)
		if i == nil then
			return ""
		end
		local guid = _G.tonumber(c.gdlock_hint:sub(1,i-1))
		if guid ~= inst.GUID then
			return ""
		end
		return c.gdlock_hint:sub(i+1)
	end

	-- 显示物品所有者
	local save_target
	local last_check_time = 0
	AddClassPostConstruct("widgets/hoverer",function(inst) --inst=self
		local old_SetString = inst.text.SetString
		inst.text.SetString = function(text, str) --text=self
			--print(tostring(str))
			local target = _G.TheInput:GetHUDEntityUnderMouse()
			if target ~= nil then
				target = target.widget ~= nil and target.widget.parent ~= nil and target.widget.parent.item
			else
				target = _G.TheInput:GetWorldEntityUnderMouse()
			end

			if target ~= nil then
				local str2 = CheckUserHint(target)
				if str2 ~= "" then
					str = str .. str2
				elseif target.ownerlist ~= nil then
					print(tostring(target) .. " - " .. target.ownerlist.master)
					local masterName = GetPlayerNameByOwnerlist(target.ownerlist)
					if masterName ~= nil then
						str = str .. "\n所有者: " .. masterName
					end
				end

				if target ~= save_target or last_check_time + 2 < _G.GetTime() then
					save_target = target
					last_check_time = _G.GetTime()
					SendModRPCToServer(MOD_RPC.GDLockHint.Hint, save_target.GUID, save_target)
				end
			end
			return old_SetString(text,str)
		end
	end)

	AddModRPCHandler("GDLockHint", "Hint", function(player, guid, item)
		if player.player_classified == nil then
			print("错误: player_classified 未找到!")
			return
		end
		if item ~= nil and item.components ~= nil and item.ownerlist ~= nil then
			local s = ""
			local masterName = GetPlayerNameByOwnerlist(item.ownerlist)
			if masterName ~= nil then
				s = s .. "\n所有者: " .. masterName
			end
			if s ~= "" then
				player.player_classified.net_gdlock_hint:set(guid..";"..s)
			end
		end
	end)

	--networking
	AddPrefabPostInit("player_classified",function(inst)
		inst.gdlock_hint = ""
		inst.net_gdlock_hint = _G.net_string(inst.GUID, "gdlock_hint", "gdlock_hint_dirty")
		if CLIENT_SIDE then
			inst:ListenForEvent("gdlock_hint_dirty",function(inst)
				inst.gdlock_hint = inst.net_gdlock_hint:value()
			end)
		end
	end)
	--]]

	local function GetHintValue(hint, inst)
		local i = string.find(hint,';',1,true)
		if i == nil then
			return ""
		end
		local guid = _G.tonumber(hint:sub(1,i-1))
		if guid ~= inst.GUID then
			return ""
		end
		return hint:sub(i+1)
	end

	-- 检测到ShowMe时利用ShowMe显示物品所有者信息
	local old_ShowMeHintFunc = _G.MOD_RPC_HANDLERS["ShowMeHint"] and _G.MOD_RPC["ShowMeHint"] and _G.MOD_RPC["ShowMeHint"]["Hint"] and _G.MOD_RPC_HANDLERS["ShowMeHint"][_G.MOD_RPC["ShowMeHint"]["Hint"].id]
	-- local old_ShowMeHintFunc = GetModRPCHandler("ShowMeHint", "Hint")
	if old_ShowMeHintFunc ~= nil then
		_G.MOD_RPC_HANDLERS["ShowMeHint"][_G.MOD_RPC["ShowMeHint"]["Hint"].id] = function(player, guid, item)
			if player.player_classified == nil then
				print("错误: player_classified 未找到!")
				return
			end
			if item ~= nil and item.components ~= nil and item.ownerlist ~= nil then
				--[[
				local old_s = ""
				local old_hint = ""
				if not item.ownerlist.emptyShow then
					old_ShowMeHintFunc(player, item.GUID, item)
					old_s = player.player_classified.net_showme_hint:value()
					old_hint = GetHintValue(old_s, item)

					if item.ownerlist.emptyShow == nil and old_hint == "" then
						item.ownerlist.emptyShow = true
					end
				end
				--]]

				old_ShowMeHintFunc(player, item.GUID, item)
				local old_s = player.player_classified.net_showme_hint:value()
				local old_hint = GetHintValue(old_s, item)

				-- print("输出old_s:"..old_s)
				-- print("输出old_hint:"..old_hint)
				local s = ""
				local masterName = GetPlayerNameByOwnerlist(item.ownerlist)
				if masterName ~= nil and string.find(old_hint, GetSayMsg("item_master_to", "")) == nil then
					s = "\n" .. GetSayMsg("item_master_to", masterName) ..(old_hint ~= "" and "\2"..old_hint or "")
					if s ~= "" then
						-- print("输出:"..s)
						player.player_classified.net_showme_hint:set(guid..";"..s)
					end
				-- 20170310 Modifyed
				-- elseif old_hint ~= "" then
				-- 	player.player_classified.net_showme_hint:set(guid..";"..old_hint)
				end
			elseif item ~= nil and item.components ~= nil and item.components.worldmigrator ~= nil and item.components.worldmigrator.linkedWorld ~= nil
				and connect_worlds and connect_worlds[item.components.worldmigrator.linkedWorld] ~= nil and connect_worlds[item.components.worldmigrator.linkedWorld].name ~= nil then
				old_ShowMeHintFunc(player, item.GUID, item)
				local old_s = player.player_classified.net_showme_hint:value()
				local old_hint = GetHintValue(old_s, item)
				local toServerName = connect_worlds[item.components.worldmigrator.linkedWorld].name
				local s = ""
				if toServerName ~= nil and string.find(old_hint, toServerName) == nil then
					s = "\n" .. GetSayMsg("item_server_to", formServerName, toServerName) ..(old_hint ~= "" and "\2"..old_hint or "")
					if s ~= "" then
						player.player_classified.net_showme_hint:set(guid..";"..s)
					end
				elseif old_hint ~= "" then
					player.player_classified.net_showme_hint:set(guid..";"..old_hint)
				end
			else
				old_ShowMeHintFunc(player, guid, item)
			end
		end
	end
end
local _G = GLOBAL
local TheNet = _G.TheNet
if not (TheNet and TheNet:GetIsServer()) then return end
local STRINGS = _G.STRINGS

local function GetModData(name, default)
	local config = GetModConfigData(name)
	if config == nil or type(config) ~= type(default) then
		config = default
	end
	return config
end

local ignoring_admin = GetModData("MOD_RESTART_IGNORING_ADMIN", true)
local allow_restart = GetModData("MOD_RESTART_ALLOW_RESTART", true)
local allow_resurrect = GetModData("MOD_RESTART_ALLOW_RESURRECT", true)
local allow_kill = GetModData("MOD_RESTART_ALLOW_KILL", true)
local cd_restart = GetModData("MOD_RESTART_CD_RESTART", 5) * 60
local cd_resurrect = GetModData("MOD_RESTART_CD_RESURRECT", 7) * 60
local cd_kill = GetModData("MOD_RESTART_CD_KILL", 3) * 60
local cd_bonus = GetModData("MOD_RESTART_CD_BONUS", 0)
local cd_max = GetModData("MOD_RESTART_CD_MAX", 0) * 60
local force_drop_mode = GetModData("MOD_RESTART_FORCE_DROP_MODE", 0)
local map_save = GetModData("MOD_RESTART_MAP_SAVE", 2)
local resurrect_health = GetModData("MOD_RESTART_RESURRECT_HEALTH", 0)
local trigger_mode = GetModData("MOD_RESTART_TRIGGER_MODE", 1)
local restart_welcome_tips = GetModData("MOD_RESTART_WELCOME_TIPS", true)
local restart_welcome_tips_time = GetModData("MOD_RESTART_WELCOME_TIPS_TIME", 6)

local MY_STRINGS = {
	welcome_msg = {
		"Enter the following command after press Y(Say) or U(Whisper):",
		"Enter the following command after press Y(Say):",
		"Enter the following command after press U(Whisper):",
	},
	allow_msg = {
		"#restart (CD: %d seconds, Re select your character)",
		"#restart_d (CD: %d seconds, Drop all items and Re select your character)",
		"#resurrect (CD: %d seconds, You will get a new life.)",
		"#kill (CD: %d seconds, Kill youself)",
	},
	force_drop_msg = {
		"Always Drop all items!",
		"Always Lost all items!",
	},
	map_save_msg = {
		"Restart will save the map data.",
		"Restart will not save the map data.",
	},
	cd_max_msg = {
		"No limited",
		"%d minutes",
	},
	cd_bonus_msg = "CD increased %d%% per use.Max: %s.",
	warning = "%s CD: %d seconds.",
	announce = "restart the game!",
	restart = "restart",
	resurrect = "resurrect",
	kill = "kill",
	resurrect_from = "resurrect",
	kill_from = "kill",
}

local MSG_CHOOSE = {
	["#restart"] = 1,
	["#restart_d"] = 2,
	["#resurrect"] = 3,
	["#kill"] = 4,
}

local welcome_tips = MY_STRINGS.welcome_msg[1]

do
	local support_languages = { chs = true, cht = true, zh_CN = "chs", cn = "chs", TW = "cht", }
	local steam_support_languages = { schinese = "chs", tchinese = "cht", }

	AddPrefabPostInit("world", function(inst)
		local steamlang = TheNet:GetLanguageCode() or nil
		if steamlang and steam_support_languages[steamlang] then
			print("<Restart> Get your language from steam!")
			modimport("restart_" .. steam_support_languages[steamlang] .. ".lua")
		else
			local lang = _G.LanguageTranslator.defaultlang or nil
			if lang ~= nil and support_languages[lang] ~= nil then
				if support_languages[lang] ~= true then
					lang = support_languages[lang]
				end
				print("<Restart> Get your language from language mod!")
				modimport("restart_" .. lang .. ".lua")
			end
		end

		if MY_STRINGS_OVERRIDE ~= nil then
			for k, v in pairs(MY_STRINGS_OVERRIDE) do
				if MY_STRINGS[k] ~= nil then
					MY_STRINGS[k] = v
				end
			end
		end

		if MSG_CHOOSE_OVERRIDE ~= nil then
			for k, v in pairs(MSG_CHOOSE_OVERRIDE) do
				for _, j in pairs(v) do
					j = string.lower(j)
					if MSG_CHOOSE[j] == nil then
						MSG_CHOOSE[j] = k
					end
				end
			end
		end

		welcome_tips = MY_STRINGS.welcome_msg[trigger_mode]
		local cd_list = { cd_restart, cd_restart, cd_resurrect, cd_kill }
		local allow_list = { allow_restart, allow_restart, allow_resurrect, allow_kill }
		for i = 1, #cd_list do
			MY_STRINGS.allow_msg[i] = string.format(MY_STRINGS.allow_msg[i], cd_list[i])
			if allow_list[i] then welcome_tips = welcome_tips .. "\n" .. MY_STRINGS.allow_msg[i] end
		end
		if cd_bonus > 0 then
			if cd_max > 0 then
				MY_STRINGS.cd_max_msg[2] = string.format(MY_STRINGS.cd_max_msg[2], cd_max / 60)
			end
			local cd_max_msg = cd_max == 0 and MY_STRINGS.cd_max_msg[1] or MY_STRINGS.cd_max_msg[2]
			welcome_tips = welcome_tips .. "\n" .. string.format(MY_STRINGS.cd_bonus_msg, cd_bonus * 100, cd_max_msg)
		end
		welcome_tips = welcome_tips .. "\n" .. MY_STRINGS.map_save_msg[map_save]
		if force_drop_mode > 0 then welcome_tips = welcome_tips .. "\n" .. MY_STRINGS.force_drop_msg[force_drop_mode] end
	end)
end

-- Get Player var userid
local function GetPlayerById(playerid)
	for _, v in ipairs(_G.AllPlayers) do
		if v ~= nil and v.userid and v.userid == playerid then
			return v
		end
	end
	return nil
end

-- DropEverything for player
local function ItemDropAll(player)
	if player and player.components and player.components.inventory then
		player.components.inventory:DropEverything(false, false)
	end
end

-- Is Player Died
local function IsDied(player)
	if player and player:HasTag("player") and player:HasTag("playerghost") then
		return true
	end
end

-- List Manage Function
local restartlist = {}

local function ListInsert(player)
	if player.userid and player.components and player.components.age then
		restartlist[player.userid] = {
			restart = 0,
			resurrect = 0,
			kill = 0,
			restart_count = 0,
			resurrect_count = 0,
			kill_count = 0,
		}
		local age = player.components.age:GetAge()
		local cd_record = restartlist[player.userid]
		if allow_restart and cd_restart ~= 0 and age >= cd_restart then
			cd_record.restart = age
		end
		if allow_resurrect and cd_resurrect ~= 0 and age >= cd_resurrect then
			cd_record.resurrect = age
		end
		if allow_kill and cd_kill ~= 0 and age >= cd_kill then
			cd_record.kill = age
		end
	end
end

-- Get player's command cooldown time
local function GetCD(player, tagnumber)
	local cd = 0
	if player.userid and restartlist[player.userid] and player.components and player.components.age then
		local age = player.components.age:GetAge()
		local cd_record = restartlist[player.userid]
		if tagnumber <= 2 and cd_restart ~= 0 then
			cd = cd_record.restart + cd_restart + cd_restart * cd_bonus * cd_record.restart_count - age
		elseif tagnumber == 3 and cd_resurrect ~= 0 then
			cd = cd_record.resurrect + cd_resurrect + cd_resurrect * cd_bonus * cd_record.resurrect_count - age
		elseif tagnumber == 4 and cd_kill ~= 0 then
			cd = cd_record.kill + cd_kill + cd_kill * cd_bonus * cd_record.kill_count - age
		end
		if cd ~= 0 and cd_max > 0 then
			cd = math.min(cd, cd_max)
		end
	end
	return cd
end

-- RecordMap Record map
local function RecordMap(player)
	if player and player.userid and player.player_classified and player.player_classified.MapExplorer then
		restartlist[player.userid].map = player.player_classified.MapExplorer:RecordMap()
	end
end

-- TeachMap Teach map
local function TeachMap(player)
	if player and player.userid and restartlist[player.userid].map and player.player_classified and player.player_classified.MapExplorer then
		if not player.player_classified.MapExplorer:LearnRecordedMap(restartlist[player.userid].map) then
			print("<Restart> TeachMap Error")
		end
		restartlist[player.userid].map = nil
	end
end

-- DodeSpawn Function
local function DodeSpawn(player)
	if allow_restart and player and player:IsValid() then
		if _G.TheWorld.ismastersim then
			local cd_record = restartlist[player.userid]
			local age = player.components.age:GetAge()
			if cd_restart ~= 0 then
				cd_record.restart = 0
			end
			if allow_resurrect and cd_resurrect ~= 0 then
				cd_record.resurrect = cd_record.resurrect - age
			end
			if allow_kill and cd_kill ~= 0 then
				cd_record.kill = cd_record.kill - age
			end
			cd_record.restart_count = cd_record.restart_count + 1
			_G.TheWorld:PushEvent("ms_playerdespawnanddelete", player)
		end
	end
end

local function ResurrectSpawn(player)
	if allow_resurrect and player and player:IsValid() and IsDied(player) then
		if _G.TheWorld.ismastersim then
			local cd_record = restartlist[player.userid]
			if cd_resurrect ~= 0 then
				cd_record.resurrect = player.components.age:GetAge()
			end
			cd_record.resurrect_count = cd_record.resurrect_count + 1
			_G.ExecuteConsoleCommand('local player = UserToPlayer("'..player.userid..'") player:PushEvent("respawnfromghost")')
			--player:PushEvent("respawnfromghost")
			player.rezsource = MY_STRINGS.resurrect_from
			if resurrect_health > 0 then
				local health = resurrect_health
				if health == 1 then
					health = 100 - cd_record.resurrect_count * 5
					health = math.max(40, health)
				elseif health == 2 then
					health = math.random(10, 100)
				else
					health = math.max(10, health)
				end
				player.components.health:SetCurrentHealth(player.components.health.maxhealth * health * 0.01)
			end
		end
	end
end

local function KillSpawn(player)
	if allow_kill and player and player:IsValid() and not IsDied(player) then
		if _G.TheWorld.ismastersim then
			local cd_record = restartlist[player.userid]
			if cd_kill ~= 0 then
				cd_record.kill = player.components.age:GetAge()
			end
			cd_record.kill_count = cd_record.kill_count + 1
			player:PushEvent("death")
			player.deathpkname = MY_STRINGS.kill_from
		end
	end
end

-- When a player dies automatic counting
local function DeathRemove(player)
	if player.userid and restartlist[player.userid] and player.components and player.components.age then
		if player:IsValid() and IsDied(player) then

			local cd_record = restartlist[player.userid]
			if GetCD(player, 1) > 0 then
				cd_record.restart = cd_record.restart - 1
			end
			if GetCD(player, 3) > 0 then
				cd_record.resurrect = cd_record.resurrect - 1
			end
			if GetCD(player, 4) > 0 then
				cd_record.kill = cd_record.kill - 1
			end

			if GetCD(player, 1) > 0 or GetCD(player, 3) > 0 or GetCD(player, 4) > 0 then
				player:DoTaskInTime(1, DeathRemove)
			end
		end
	end
end

-- Remove restart
AddComponentPostInit("playerspawner", function(OnPlayerSpawn, inst)
	inst:ListenForEvent("ms_playerjoined", function(self, player)

		if not (player and player.components) then return end

		if restart_welcome_tips and restartlist[player.userid] == nil and (allow_restart or allow_resurrect or allow_kill) then
			player:DoTaskInTime(3, function(target)
				if target.components and target.components.talker then
					target.components.talker:Say(target:GetDisplayName() .. ", " .. welcome_tips, restart_welcome_tips_time)
				end
			end)
		end

		-- Save the command cooldown time when a player leaves the server side
		if restartlist[player.userid] == nil then
			ListInsert(player)
		end

		if allow_restart and cd_restart ~= 0 or allow_resurrect and cd_resurrect ~= 0 or allow_kill and cd_kill ~= 0 then
			if IsDied(player) then
				if GetCD(player, 1) > 0 or GetCD(player, 3) > 0 or GetCD(player, 4) > 0 then
					player:DoTaskInTime(1, DeathRemove)
				end
			end

			player:ListenForEvent("death", function(target)
				-- Waiting for the player's status was changed to death.
				target:DoTaskInTime(2.5, DeathRemove)
			end)
		end

		if map_save == 1 and restartlist[player.userid].map then
			player:DoTaskInTime(1, TeachMap)
		end
	end)
end)

local function IsTrigger(whisper)
	if trigger_mode == 1 then
		return true
	elseif trigger_mode == 2 and not whisper then
		return true
	elseif trigger_mode == 3 and whisper then
		return true
	end
	return false
end

local function IsContinue(tag)
	if tag <= 2 and allow_restart then
		return true
	elseif tag == 3 and allow_resurrect then
		return true
	elseif tag == 4 and allow_kill then
		return true
	end
	return false
end

-- Main Function
local Old_Networking_Say = _G.Networking_Say
_G.Networking_Say = function(guid, userid, name, prefab, message, colour, whisper, isemote, ...)
	Old_Networking_Say(guid, userid, name, prefab, message, colour, whisper, isemote, ...)
	if IsTrigger(whisper) then
		local choose = MSG_CHOOSE[string.lower(message)]

		if choose and IsContinue(choose) then
			local player = GetPlayerById(userid)
			if player then

				local cd = GetCD(player, choose)
				if cd > 0 then
					if not (ignoring_admin and TheNet:GetIsServerAdmin() and player.components and player.Network:IsServerAdmin()) then
						local warning = choose == 3 and MY_STRINGS.resurrect or
								(choose == 4 and MY_STRINGS.kill or MY_STRINGS.restart)
						local msg = string.format(MY_STRINGS.warning, warning, cd)
						player:DoTaskInTime(0.5, function()
							if player.components.talker then player.components.talker:Say(player:GetDisplayName() .. ", " .. msg) end
						end)
						return
					end
				end

				if choose == 3 then
					player:DoTaskInTime(1, ResurrectSpawn)
				elseif choose == 4 then
					player:DoTaskInTime(1, KillSpawn)
				elseif choose <= 2 then

					-- Drop Everything
					if force_drop_mode == 1 or force_drop_mode == 0 and choose == 2 then
						ItemDropAll(player)
					end

					if map_save == 1 then
						RecordMap(player)
					end

					-- Announce all Players who restart the Game
					player:DoTaskInTime(0.5, function()
						local charactername = STRINGS.CHARACTER_NAMES[prefab] or prefab
						TheNet:Announce(player:GetDisplayName() .. " (" .. charactername .. ") " .. MY_STRINGS.announce)
					end)

					-- Restart the Game
					player:DoTaskInTime(1, DodeSpawn)
				end
			end
		end
	end
end

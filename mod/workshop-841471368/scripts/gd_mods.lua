local _G = GLOBAL
local TheSim = _G.TheSim
local TheNet = _G.TheNet

if TheNet:GetIsClient() then
	_G.getmetatable(TheSim).__index.ShouldWarnModsLoaded = function() return false end
end

-- 测试模式
local test_mode = GetModConfigData("test_mode")
if test_mode then
	if _G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods
	then
		print(modname)
		local known_mod = _G.KnownModIndex.savedata.known_mods[modname]
		if known_mod then
			print(modname .. "当前设置:")
			for i,v in pairs(known_mod.modinfo.configuration_options) do
				if v.saved ~= nil then
					print(v.name, v.saved)
				end
			end

			print(modname .. "默认设置:")
			for i,v in pairs(known_mod.modinfo.configuration_options) do
				print(v.name, v.default)
			end
		end
	end

	local GetGlobal=function(gname,default)
		local res=_G.rawget(_G,gname)
		if res == nil and default ~= nil then
			_G.rawset(_G,gname,default)
			return default
		end
		return res
	end

	local mods = GetGlobal("mods",{})

	--Detecting enabled mods
	local mod_names	 --названия всех модов (чтобы не дергать джвижок)
	local mod_names_nover --названия модов с обрезанной версией (если смысловая часть достаточно длинная)
	mod_names = {}
	mod_names_nover = {}
	local function GetAllModNames()
		if not (_G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods
			and _G.ModManager and _G.ModManager.enabledmods)
		then
			return
		end
		-- 当报错时不禁用mods
		if _G.KnownModIndex.DisableAllMods then
			print("开启:报错时禁止禁用mod")
			_G.getmetatable(_G.KnownModIndex).__index.DisableAllMods = function() return false end
			-- _G.KnownModIndex.DisableAllMods = function() end
		end 
		local folders = {} --ассоциативный массив включенных модов (по папкам)
		for _,v in ipairs(_G.ModManager.enabledmods) do
			folders[v]=true
		end
		for folder, mod in pairs(_G.KnownModIndex.savedata.known_mods) do
			local name = mod.modinfo.name
			if name then
				mod_names[name]=folders[folder] and true or false
				--print("NEW_MOD: "..name.." "..tostring(mod_names[name]))
				--[[
				if name == "ShowMe" or name == "提示属性显示" then
					if mod_names[name] then
						_G.KnownModIndex.savedata.known_mods[folder].enabled = false
					end
					print("../".._G.MODS_ROOT..folder.."/modmain.lua")
					--local modfn = _G.kleiloadlua(_G.MODS_ROOT..folder.."/modmain.lua")
					modimport("../".._G.MODS_ROOT..folder.."/modmain.lua")
					print("GetTestString:"..tostring(GetTestString))
				end
				--]]
				local s=string.match(name,"^(.-)([0-9%._ ]+)$")
				if s then
					mod_names_nover[s]=name --обрезаем номер версии с конца
					--вместо true сохраняем полное имя мода (чтобы идентифицировать его в системе)
				else
					mod_names_nover[name]=name
				end
			end
		end
	end
	GetAllModNames()
	mods.mod_names = mod_names
	mods.mod_names_nover = mod_names_nover
end
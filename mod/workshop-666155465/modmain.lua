local _G = GLOBAL

if modinfo then
	print("ShowMe version:",modinfo.version)
end

local GetGlobal=function(gname,default)
	local res=_G.rawget(_G,gname)
	if res == nil and default ~= nil then
		_G.rawset(_G,gname,default)
		return default
	end
	return res
end

--Locals (Add compatibility with any other mineable mods).
local mods = GetGlobal("mods",{})

local GetTime = _G.GetTime
local TheNet = _G.TheNet
local SERVER_SIDE = TheNet:GetIsServer()
local CLIENT_SIDE =	 TheNet:GetIsClient() or (SERVER_SIDE and not TheNet:IsDedicated())

local tonumber = _G.tonumber
local food_order = tonumber(GetModConfigData("food_order",true)) or 0
if food_order == 0 then
	food_order = tonumber(GetModConfigData("food_order")) or 0
end
--TUNING.SHOWME_FOOD_ORDER = food_order --для Tell Me
local food_style = tonumber(GetModConfigData("food_style",true)) or 0
if food_style == 0 then
	food_style = tonumber(GetModConfigData("food_style")) or 0
end
--TUNING.SHOWME_FOOD_STYLE = food_style

local food_estimation = tonumber(GetModConfigData("food_estimation",true)) or -1
if food_estimation == -1 then
	food_estimation = tonumber(GetModConfigData("food_estimation")) or 0
end

local show_food_units = tonumber(GetModConfigData("show_food_units",true)) or -1
if show_food_units == -1 then
	show_food_units = tonumber(GetModConfigData("show_food_units")) or 0
end

--Название на английском, краткая сетевая строка-алиас (для пересылки).
--Если алиас начинается с маленькой буквы, то он обязан быть длиной в 1 букву. Если с большой, то 2 (вторая буква может быть любого регистра).
local MY_STRINGS =
{ 
	{ armor = "Armor:" }, --A
	{ aggro = "Aggression:" }, --B
	{ cookpot = "Probably it will be" }, --C (Crock Pot)
	{ dmg = "Damage:" }, --D
	{ electric = "Electric:" }, --E --electric power
	{ food = "Food:"},
	{ S2="Now it's the summer," }, --G
	{ health= "Health:" }, --H --for food
	{ warm = "Insulation:" }, --I --winter insulation
	{ kill = "Kill:" }, --J	 --for Canibalism 18 mod
	{ kills = "Kills:" }, --K  --for Canibalism 18 mod
	{ loyal = "Loyality:" }, --L  --pigman and bunnyman
	{ S4="Now it's the autumn," }, --M
	{ remaining_days = "Remaining days" }, --N
	{ owner = "Owner:" }, --O --support of various mods
	{ perish = "Spoil in" }, --P -- Spoil in N days.
	{ hunger= "Hunger:" }, --Q
	{ range = "Range:" }, --R  --for range weapon or for mobs
	{ sanity= "Sanity:" }, --S
	{ thickness = "Thickness:" }, --T
	{ units_of = "units of" }, --U
	{ resist = "Resistance:" }, --V --against sleep darts, ice staff etc
	{ waterproof = "Waterproof:" }, --W
	{ heal = "Heal:" }, --X
	{ fishes = "Fishes:" }, --Y	 --in a pond
	{ fish = "Fish:" }, --Z
	{ sec= "Seconds:" },  --([)for cooking in Crock Pot
	{ love = "Love:" }, --(~)
	{ summer = "Summer:" }, --(])summer insulation
	{ absorb = "Absorb:" }, --(^)
	{ S3="Now it's the spring," }, --(_)
	{ is_admin = "This is the ADMIN!\nHe is out of the game\nso don't touch him." }, --(@)
	{ temperature = "t" }, --a
	{ hp= "HP:" }, --for characters
	{ armor_character = "Armor:" },
	{ sanity_character = "Sanity:" }, --S	
	{ fuel = "Fuel:" }, --F --for firepit
	{ speed = "Speed:" }, 
	{ uses_of = "uses of" },
	{ obedience = "Obedience:" },
	{ S1="Now it's the winter," }, 
	{ dmg_character = "Damage:" }, 
	{ power="Power:"},--usually means strengths of weapon but not physical damage
	{ cooldown="Cooldown:"},
	{ domest = "Tamed:" }, -- "Domestication:"
	{ will_die = "Will die in" }, --will die in N days (saying about pet or animal).
	{ will_dry = "Will dry in" },
	{ dmg_bonus = "Damage bonus:" }, -- Damage: +X (means damage modifier, not base damage)
	{ crop = "" }, --Not used. It's just a key for info type. Info - "Product: percent"
	{ grow_in = "Grow in" }, --About grass etc
	{ perish_product = "" }, --Just a key for info type. Info - "Product: time in days"
	{ just_time = "" }, --Just a key for info type. Info - [time]
	--Thirst mod
	{ water = "Water:" },
	{ salt = "Salt:" },
	{ sip = "A sip:" },
	{ watergainspeed = "Water gain speed:" },
	{ water_poisoned = "Is poisoned!" },
	
	{ timer = "Timer" },
	{ trade_gold = 'Gold tribute:' },
	{ trade_rock = 'Rock tribute:' },
	{ durability = 'Durability:' },
	{ strength = 'Strength:' },
	{ aoe = "AoE:" },
}

SHOWME_STRINGS = {
	loyal = "forever", --for very loyal pigman with loyalty over 9000
	of = " of ", -- X of Y (reserved)
	units_1 = "1 unit of ",
	units_many = " units of ",
	uses_1 = "1 use of ",
	uses_many = " uses of ", --X uses of Y, where X > 1
	days = " days", --Spoil in N days.
}

FOOD_TAGS = {}

MY_DATA = {}
for i,v in ipairs(MY_STRINGS) do
	for k,str in pairs(v) do --одна пара
		MY_DATA[k] = {
			desc = str,
			id = i,
			sym = string.char(i+64), -- A+
			fn = nil, --Function to return the proper string. By default: desc + " " + param1
			percent = nil, --To add "%" at the end of the number
		}
		v.key = k --Записываем ключ в отдельную переменную. Вообще это ужасный костыль, лучше не трогать теперь.
		break
	end
end


local function DefaultDisplayFn(arr) --На вход особая структура: { data, param }. data - ссылка на элемент MY_DATA, a param - ссылка на массив п.
	if arr.data == nil then
		return arr.param_str --Выводим строку в том виде, в каком пришла от сервера (без первого символа)
	end
	if arr.data.sign ~= nil and (tonumber(arr.param[1]) or -1) >= 0 then
		arr.param[1] = "+" .. tostring(arr.param[1])
	end
	local s = arr.data.desc .. " " .. tostring(arr.param[1])
	if arr.data.percent ~= nil then
		s = s .. "%"
	end
	return s
end
CallDefaultDisplayFn = DefaultDisplayFn --Для языкового модуля.

local function DefaultFraction(arr) --Типичный вывод: "Название: cur / max"
	local cur,mx = arr.param[1], arr.param[2]
	return arr.data.desc .. " " .. cur .. " / " .. mx 
end

MY_DATA.hp.fn = function(arr) --Формирование строки на клиенте.
	local cur,mx = arr.param[1], arr.param[2]
	return cur .. " / " .. mx 
end
MY_DATA.owner.fn = function(arr) --Формирование строки на клиенте
	return arr.data.desc .. " " .. arr.param_str  --Игнорируем запятые, если есть в имени.
end
MY_DATA.loyal.fn = function(arr) --Формирование строки на клиенте
	if (tonumber(arr.param[1]) or 0) > 9000 then
		return arr.data.desc .. " " .. SHOWME_STRINGS.loyal 
	end
	return DefaultDisplayFn(arr) --Игнорируем запятые, если есть в имени.
end

MY_DATA.water.fn = DefaultFraction
MY_DATA.water_poisoned.fn = function(arr)
	return arr.data.desc
end

MY_DATA.timer.fn = function(arr)
	local total = _G.tonumber(arr.param[1])
	local name = arr.param[2]
	local hours = math.floor(total * 0.0002777777777777) --целое кол-во часов. 1/3600
	local mins = math.floor((total - (hours * 3600)) * 0.01666666666666) --целое. 1/60
	local secs = total - (hours * 3600) - (mins * 60) --тоже должно быть целым.
	return arr.data.desc
		.. (name and (' "'..name..'": ') or ': ')
		.. (hours > 0 and (hours .. ':'
			.. (mins > 9 and mins or ('0' .. mins)) .. ':'
			.. (secs > 9 and secs or ('0' .. secs))
		) or ( mins .. ':'
			.. (secs > 9 and secs or ('0' .. secs))
		))
end
MY_DATA.durability.fn = DefaultFraction


MY_DATA.sanity_character.percent = true
MY_DATA.sanity.sign = true
MY_DATA.dmg_character.percent = true
MY_DATA.dmg_character.sign = true
MY_DATA.speed.percent = true
MY_DATA.speed.sign = true
MY_DATA.temperature.sign = true
MY_DATA.armor.percent = true
MY_DATA.armor_character.percent = true
MY_DATA.armor_character.sign = true
MY_DATA.waterproof.percent = true
MY_DATA.dmg_bonus.sign = true

MY_DATA.watergainspeed.sign = true
MY_DATA.sip.sign = true

MY_DATA.trade_gold.sign = true
MY_DATA.trade_rock.sign = true

local AOS_Temperature_fn --Клиентская функция конвертирования игровых юнтов температуры в визуальные.
local is_Fahrenheit = false
local function ConvertTemperature(val)
	if not val then
		return "???"
	end
	if is_Fahrenheit then
		return math.floor(1.8*(val) + 32.5).."\176F" 
	else
		return math.floor(val/2 + 0.5) .. "\176C"
	end
end

MY_DATA.temperature.sign = true
MY_DATA.temperature.fn = function(arr)
	arr.param[1] = AOS_Temperature_fn and AOS_Temperature_fn(tonumber(arr.param[1])) or ConvertTemperature(tonumber(arr.param[1]))
	return DefaultDisplayFn(arr)
end

--Возвращает полноценное название предмет. Берет из локальных переменных, так что должна быть переведено.
local function GetPrefabFancyName(prefab)
	local product = tostring(prefab or "nil")
	return _G.STRINGS.NAMES[string.upper(product)] or product
end

MY_DATA.cookpot.fn = function(arr)
	return arr.data.desc .. " " .. GetPrefabFancyName(arr.param[1])
end
MY_DATA.food.fn = function(arr)
	local hg,sn,hp = arr.param[1],arr.param[2],arr.param[3]
	if food_order <= 1 then
		if food_style <= 1 then
			return MY_DATA.hunger.desc .. " "..hg.." / "..MY_DATA.sanity.desc.." "..sn.." / "..MY_DATA.health.desc.." "..hp
		else
			return hg.." / "..sn.." / "..hp
		end
	else
		if food_style <= 1 then
			return MY_DATA.health.desc.." "..hp.." / "..MY_DATA.hunger.desc.." "..hg.." / "..MY_DATA.sanity.desc.." "..sn
		else
			return hp.." / "..hg.." / "..sn
		end
	end
end
MY_DATA.units_of.fn = function(arr)
	local s = FOOD_TAGS[arr.param[2]]
	s = s ~= "" and s or arr.param[2] --If translation exists.
	if arr.param[1] == "1" then
		return SHOWME_STRINGS.units_1 .. s
	else
		return arr.param[1] .. SHOWME_STRINGS.units_many .. s
	end
end
MY_DATA.uses_of.fn = function(arr)
	if arr.param[1] == "1" then
		return SHOWME_STRINGS.uses_1 .. arr.param[2]
	else
		return arr.param[1] .. SHOWME_STRINGS.uses_many .. arr.param[2]
	end
end
MY_DATA.perish.fn = function(arr)
	return arr.data.desc .. " " .. arr.param[1] .. SHOWME_STRINGS.days
end

local PerishFunction = function(arr)
	return MY_DATA.perish.fn(arr) --Redirect to perish function with another description - "Will die in..."
end

MY_DATA.will_die.fn = PerishFunction
MY_DATA.will_dry.fn = PerishFunction --Здесь тоже просто делаем ссылку.
MY_DATA.grow_in.fn = PerishFunction
MY_DATA.just_time.fn = PerishFunction

local CONST_COUNT = { ['1'] = '(1)', ['2'] = '(2)', ['3'] = '(3)', ['4'] = '(4)', ['5'] = '(5)', ['6'] = '(6)', ['7'] = '(7)',
	 ['8'] = '(8)', ['9'] = '(9)', ['10'] = '(10)', ['11'] = '(11)', ['12'] = '(12)', ['13'] = '(13)', ['14'] = '(14)', 
	 ['15'] = '(15)', ['16'] = '(16)', ['17'] = '(17)', ['18'] = '(18)', ['19'] = '(19)', ['20'] = '(20)', 
	 ['21'] = '(21)', ['22'] = '(22)', ['23'] = '(23)', ['24'] = '(24)', ['25'] = '(25)', 
	 ['26'] = '(26)', ['27'] = '(27)', ['28'] = '(28)', ['29'] = '(29)', ['30'] = '(30)', 
	 ['31'] = '(31)', ['32'] = '(32)', ['33'] = '(33)', ['34'] = '(34)', ['35'] = '(35)', 
	 ['36'] = '(36)', ['37'] = '(37)', ['38'] = '(38)', ['39'] = '(39)', ['40'] = '(40)', 
	 ['0'] = '', --Если нет конмонента stackable, то не показываем количество вообще.
}

--Особая функция вида "ПРОДУКТ: ВРЕМЯ"
--param[1] - продукт
--param[2] - оставшееся количество дней или nil
MY_DATA.perish_product.fn = function(arr)
	local name = GetPrefabFancyName(arr.param[1]) .. (
		CONST_COUNT[arr.param[2]] or ('(' .. tostring(arr.param[2]) .. ')')
	)
	if not arr.param[3] then --Время не указано.
		return name
	end
	arr.param[1] = arr.param[3] --dirty hack!!! Preparing for using in PerishFunction
	--arr.param[2] = nil --need not
	return name.. ":" .. PerishFunction(arr) -- desc == ""
end

MY_DATA.heal.sign = true
MY_DATA.fuel.percent = true
MY_DATA.obedience.percent = true
MY_DATA.domest.percent = true
--MY_DATA.fuel.percent = true
--MY_DATA.fuel.percent = true
--MY_DATA.fuel.percent = true

MY_DATA.crop.fn = function(arr) -- Product: percent
	return GetPrefabFancyName(arr.param[1]) .. ": " .. tostring(arr.param[2]) .. "%"
end

--MY_STRINGS_OVERRIDE = nil

--Сокрытие некоторой (назойливой) информации.
if show_food_units == 0 or show_food_units == 2 then
	MY_DATA.units_of.hidden = true --Work on client only.
end


function UpdateNewLanguage()
	--print(MY_STRINGS_OVERRIDE)
	if MY_STRINGS_OVERRIDE ~= nil then --Меняем локальный перевод (в т.ч. для хоста).
		for k,tr in pairs(MY_STRINGS_OVERRIDE) do
			local data = MY_DATA[k]
			if data ~= nil then
				data.desc = tr
			--else MY_STRINGS[k] = {tr}
			end
		end
	end
	--print(MY_STRINGS.aggro[1])
end


do --Пытаемся определить язык и загрузить соответствующий файл
	local support_languages = { ru = true, chs = true, cht = true, br = true, pl = true,
		tw="cht", zh_cn="chs", ch="chs", kr=true, ko="kr", es = true,} 
	--For override: name=file. Example: ,cht="chs",
	
	AddPrefabPostInit("world",function(inst)
		local lang = GetModConfigData("lang", true) or "auto"
		if lang == "auto" then
			lang = GetModConfigData("lang") or "auto"
		end
		if lang == "auto" then
			lang = _G.LanguageTranslator.defaultlang --print("LANG=",lang)
			if _G.STRINGS.ACTIONS.PLAY == "\253\253\253\253\253\253\253\253\253\253\6\196\232\253\253\253\253\253\253\253\253\1\205" then
				lang = "kr" --Korean
			end
		end
		if type(lang) ~= "string" or lang == "en" then
			return
		end
		lang = lang:lower()
		if support_languages[lang] ~= nil then
			if support_languages[lang] ~= true then --алиас
				lang = support_languages[lang]
			end
			modimport("showme_"..lang..".lua")
		end
		UpdateNewLanguage()
	end)
end



--Попытка определить клиентские моды и отправить их через RPC
AddModRPCHandler("ShowMe","AOS",function(inst)
	--Вызов этой функции означает отключение подсказок на деревьях для данного игрока.
	inst.has_AlwaysOnStatus = true
end)

--Учитывать ли статус порчи для конкретного пользователя.
AddModRPCHandler("ShowMe","Estimate",function(inst)
	--Вызов этой функции означает отключение подсказок на деревьях для данного игрока.
	inst.should_Estimate_Stale = true
end)

--local AOS_Temperature_fn --Функция конвертирования игровой температуры у клиента. (Объявлена ранее)

--Залезаем в клиентский интерфейс с целью уменьшить показываемую температуру
if CLIENT_SIDE then
	--Делаем самую правильную в мире функцию "AddPlayersPostInit" 
	--GetGlobal("mods",{})
	--if not _G.rawget(_G,"mods") then _G.rawset(_G,"mods",{}) end
	if not mods.player_preinit_fns then
		mods.player_preinit_fns={}
		--Dirty hack
		local old_MakePlayerCharacter = _G.require("prefabs/player_common")
		local function new_MakePlayerCharacter(...)
			local inst=old_MakePlayerCharacter(...)
			for _,v in ipairs(mods.player_preinit_fns) do
				v(inst)
			end
			return inst
		end
		_G.package.loaded["prefabs/player_common"] = new_MakePlayerCharacter
	end

	local function AddPlayersPreInit(fn)
		table.insert(mods.player_preinit_fns,fn)
	end

	local player_postinit_fns = {}
	local function AddPlayersPostInit(fn) -- <<<--------- Вот она!
		table.insert(player_postinit_fns,fn)
	end

	local done_players = {}
	AddPlayersPreInit(function(inst)
		local s = inst.prefab or inst.name
		if not done_players[s] then
			done_players[s] = true
			AddPrefabPostInit(s,function(inst)
				for _,v in ipairs(player_postinit_fns) do
					v(inst)
				end
			end)
		end
	end)

	local player_afterinit_fns = {}
	function AddPlayersAfterInit(fn) --Нулевой таймер после
		table.insert(player_afterinit_fns,fn)
	end
	AddPlayersPostInit(function(inst) --Задаем нулевой таймер
		if #player_afterinit_fns > 0 then
			inst:DoTaskInTime(0,function(inst)
				for i=1,#player_afterinit_fns do
					player_afterinit_fns[i](inst)
				end
			end)
		end
	end)
	
	--А вот и не угадали. Не трогаем интерфейс. Вместо этого определяем настройки и лишь в случае их отсутствия трогаем интерфейс.
	
	--Проверка температуры. Обратный формат и приведение к универсальному Цельсию.
	local tonumber = _G.tonumber
	local function FixTemperature(s)
		if type(s) ~= "string" then
			return s --Вообще не строка. Что за?
		end
		--На конце может быть один из конкретных вариантов строки.
		local sep = s:find("\176",1,true)
		if not sep then
			return s --Разделитель не найден.
		end
		local pre, pst = tonumber(s:sub(1,sep-1)), s:sub(sep+1)
		if not pre then
			return s --Первая часть строки не является числом.
		end
		if pst == "C" then
			return s --Это Цельсий. Не надо конвертировать.
		elseif pst == "F" then
			--Фаренгейт. Сложный случай. В целом тоже не надо трогать. Но меняем локальные настройки на Фаренгейт.
			is_Fahrenheit = true
			return s
		else
			--Иначе (по умолчанию) считаем, что температура в игровых единицах. Исправляем это дело на Цельсий.
			return ConvertTemperature(pre) --TODO: Есть небольшая погрешность в уменьшение. При температуре 5.1 покажется цифра 2, хотя должна 3.
		end
	end
	
	local AOS_UNITS, AOS_UNIT
	
	--Функция исправления интерфейса на клиенте. Запускается для всех игроков при появлении.
	local function FixClient(inst)
		if inst ~= _G.ThePlayer then
			return
		end
		
		--По-хакерски добавляем отправку настроек предпочтения показа еды
		if food_estimation == 1 then
			--print("SendRPC")
			SendModRPCToServer(MOD_RPC.ShowMe.Estimate)
		end
		
		local status = inst.HUD and inst.HUD.controls and inst.HUD.controls.status
		if not status then
			print("ERROR SHOW_ME: Can't fix client side status!")
			return
		end
		local AOS
		AOS_UNITS = TUNING.COMBINED_STATUS_UNITS
		AOS_UNIT = TUNING.COMBINED_STATUS_UNIT
		if (AOS_UNITS and AOS_UNIT and AOS_UNITS[AOS_UNIT]) then
			AOS = true
			AOS_Temperature_fn = AOS_UNITS[AOS_UNIT]
		else --older version of AOS
			if status.temperature then
				AOS = true
				local old_SetString = status.temperature.num.SetString
				status.temperature.num.SetString = function(self,s)
					return old_SetString(self,FixTemperature(s))
				end
			end
			if status.worldtemp then
				AOS = true
				local old_SetString = status.worldtemp.num.SetString
				status.worldtemp.num.SetString = function(self,s)
					return old_SetString(self,FixTemperature(s))
				end
			end
		end
		if AOS then
			SendModRPCToServer(MOD_RPC.ShowMe.AOS)
		end
	end
	AddPlayersAfterInit(FixClient) 
end

-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- HOST -----------------------------------------------------------------
--Works only on host.
if TheNet and TheNet:GetIsServer() then
require = _G.require





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
	local folders = {} --ассоциативный массив включенных модов (по папкам)
	for _,v in ipairs(_G.ModManager.enabledmods) do
		folders[v]=true
	end
	for folder, mod in pairs(_G.KnownModIndex.savedata.known_mods) do
		local name = mod.modinfo.name
		if name then
			mod_names[name]=folders[folder] and true or false
			--print("NEW_MOD: "..name.." "..tostring(mod_names[name]))
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


local function SearchForModsByName()
	if mods.active_mods_by_name then
		return --Уже проинициализировано. Либо полная несовместимость.
	end
	mods.active_mods_by_name = {}
	if not (_G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods) then
		print("ERROR COMMON LIB: Can't find KnownModIndex!")
		return
	end
	for name,mod in pairs(_G.KnownModIndex.savedata.known_mods) do
		if (mod.enabled or mod.temp_enabled or _G.KnownModIndex:IsModForceEnabled(name)) --Мод активен
			and not mod.temp_disabled --И не отключен
		then
			local real_name = mod.modinfo.name
			if real_name == nil then
				print("SHOW_ME ERROR: real_name of a mod is nil,",tostring(name))
				--TODO: error if TUNING.STAR_DEBUG 
			else
				mods.active_mods_by_name[real_name] = true
			end
		end
	end
end	
SearchForModsByName()
	
local is_HealthInfo = mods.active_mods_by_name["Health Info"] --Check it to decide, is there a reason to show hp in description.
local is_DisplayFoodValues = mods.active_mods_by_name["Display food values"]
--TODO: Эта проверка нужна на клиенте!
local is_AlwaysOnStatus = mods.active_mods_by_name["Combined Status"] or mods.active_mods_by_name["Always On Status"]
--_G.arr(mod_names)

local cooking = require("cooking")
local ing = cooking.ingredients
--local config = GetModConfigData("message_style") or 1

--local backdoors = GetGlobal("backdoors",{})
--backdoors.ShowMe={MY_STRINGS=MY_STRINGS} --welcome for translaters!
--for k,v in pairs(MY_STRINGS) do
--	MY_STRINGS[k]=v[config] --overwrites with string config values --Нельзя заменять, т.к. мы теперь используем ключи.
--end

--Добавляет строку в конец дескрипшена
--desc - исходная строка (копия), val - готовое значение, txt - ключ описания, no_table - если true, то ключ используется как строка.
--[[local function cn(desc,val,txt,no_table)
	if no_table then
		return (desc=="" and "" or (desc.."\n"))..txt.." "..tostring(val)
	elseif MY_STRINGS[txt] ~= nil and MY_STRINGS[txt][2] ~= nil then
		return (desc=="" and "" or (desc.."\n"))
			..MY_STRINGS[txt][2]
			..tostring(val)
	else
		return (desc=="" and "" or (desc.."\n"))..val.." (bug?)"
	end
end--]]

local ww
AddPrefabPostInit("world",function(inst)
	ww = inst.state
end)

local function GetPerishTime(inst,c)
	local modifier = 1
	local owner = c.inventoryitem and c.inventoryitem.owner or nil
	if owner == nil and c.occupier ~= nil then
		owner = c.occupier:GetOwner() --Для птичек?
	end

	if owner ~= nil then
		if owner:HasTag("fridge") then
			if inst:HasTag("frozen") and not owner:HasTag("nocool") and not owner:HasTag("lowcool") then
				modifier = TUNING.PERISH_COLD_FROZEN_MULT
			else
				modifier = TUNING.PERISH_FRIDGE_MULT
			end
		elseif owner:HasTag("spoiler") then
			modifier = TUNING.PERISH_GROUND_MULT 
		--elseif owner:HasTag("cage") and inst:HasTag("small_livestock") then
		--	modifier = TUNING.PERISH_CAGE_MULT
		end
	else
		modifier = TUNING.PERISH_GROUND_MULT 
	end

	if inst:GetIsWet() then
		modifier = modifier * TUNING.PERISH_WET_MULT
	end

	
	if ww.temperature < 0 then
		if inst:HasTag("frozen") and not c.perishable.frozenfiremult then
			modifier = TUNING.PERISH_COLD_FROZEN_MULT
		else
			modifier = modifier * TUNING.PERISH_WINTER_MULT
		end
	end

	if c.perishable.frozenfiremult then
		modifier = modifier * TUNING.PERISH_FROZEN_FIRE_MULT
	end

	if ww.temperature > TUNING.OVERHEAT_TEMP then
		modifier = modifier * TUNING.PERISH_SUMMER_MULT
	end

	if c.perishable.localPerishMultiplyer then
		modifier = modifier * c.perishable.localPerishMultiplyer
	end

	modifier = modifier * TUNING.PERISH_GLOBAL_MULT
	
	local old_val = c.perishable.perishremainingtime
	if old_val ~= nil then
		local delta = old_val / modifier
		return delta
	end
end



--Новая функция
local desc_table
local function cn(key,param1,param2,param3)
	local data = MY_DATA[key]
	if data == nil then
		return
	end
	if param1 == nil then
		table.insert(desc_table, data.sym)
		return 
	end
	if param2 == nil then
		table.insert(desc_table, data.sym ..tostring(param1))
		return 
	end
	if param3 == nil then
		table.insert(desc_table, data.sym ..tostring(param1) .. "," ..tostring(param2))
		return
	end
	table.insert(desc_table, data.sym ..tostring(param1) .. "," ..tostring(param2) .. "," ..tostring(param3))
	return 
end

--Hack for LRP
--[[if _G.rawget(_G,"RussificationVersion") and _G.RussificationVersion<"3.6" then
	local player = _G.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PLAYER
	if player then --Add some spaces to strings. So they are incorruptible.
		player.GENERIC = "It  is %s!"
		player.ATTACKER = "That %s looks  shifty..."
		player.MURDERER = "Murderer !"
		player.REVIVER = "%s, friend  of ghosts."
		player.GHOST = "%s could use a	heart."
	end
end --]]


--nice round function
local round2=function(num, idp)
	return _G.tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

local is_admin
local last_user_talbe = {}
--Проверяет, является ли чел админом.
local function IsAdmin(viewer)
	if is_admin ~= nil then
		return is_admin
	end
	if not (viewer and viewer.userid) then
		return false
	end
	for i=1,#last_user_talbe do
		local user = last_user_talbe[i]
		if user.userid == viewer.userid then
			is_admin = user.admin or false
			return is_admin
		end
	end
	last_user_talbe = _G.TheNet:GetClientTable()
	for i=1,#last_user_talbe do
		local user = last_user_talbe[i]
		if user.userid == viewer.userid then
			is_admin = user.admin or false
			return is_admin
		end
	end
end


local function name_by_id(userid)
	for i,v in ipairs(_G.AllPlayers) do
		if v.userid == userid then
			return v.name
		end
	end
	return "---Unknown---"
end
--GetGlobal("name_by_id",name_by_id)

--local TemperatureFormatLocal

local SPICIAL_STRUCTURES = {
	campfire = true, coldfire = true,
}

--Основная функция получения описания.
function GetTestString(item,viewer) --Отныне форкуемся от Tell Me, ибо всё сложно.
	--line_cnt = 0
	desc_table = {} --старый desc отменяется
			
	is_admin = nil
	local prefab = item.prefab
	local c=item.components
	local has_owner = false --Выводим инфу о владельце лишь ОДИН раз!
	if (prefab=="evergreen" or prefab=="deciduoustree") and not viewer.has_AlwaysOnStatus then
		--if not is_AlwaysOnStatus then --TODO: Do not check! NB!
			local w=_G.TheWorld.state
			local tt=round2(w.temperature,1)
			if w.iswinter then cn("S1")
			elseif w.issummer then cn("S2")
			elseif w.isspring then cn("S3")
			elseif w.isautumn then cn("S4")
			end
			cn("remaining_days",w.remainingdaysinseason)
			cn("temperature",tt)
				--..MY_STRINGS["remaining_days"][2]..": "..w.remainingdaysinseason.."\n"
				--.."t "..(tt>=0 and "+" or "")..tt
		--end
	elseif c.health and not item.grow_stage then --Health, Hunger, Sanity Bar
		local h=c.health
		--cheat
		if item.is_admin then
			cn("is_admin")
			return desc_table[1]
		end
		
		if not is_HealthInfo then --c.health
			local mx=math.ceil(h.maxhealth-h.minhealth)
			local cur=math.ceil(h.currenthealth-h.minhealth)
			if cur>mx then cur=mx end
			cn("hp",cur,mx)
		end

		if c.hunger then
			local val = c.hunger:GetPercent()
			--Либо голода мало, либо это вообще не игрок.
			if (c.grogginess and val <= 0.5) or (not c.grogginess and (val > 0 or prefab ~= "beefalo")) then
				cn("hunger",round2(c.hunger.current,0))
			end
		elseif c.perishable ~= nil and c.perishable.updatetask ~= nil then --Here "Perishable" means "Hunger".
			local time = GetPerishTime(item, c)
			if time ~= nil then
				cn("will_die",round2(time/TUNING.TOTAL_DAY_TIME,1))
			end
		end
		if c.sanity and c.sanity:GetPercent()<=0.5 then
			local sanity = round2(math.floor(c.sanity:GetPercent()*100+0.5),1)
			cn("sanity_character",sanity)
		end
		if c.follower then
			if c.follower.leader and c.follower.leader:IsValid() and c.follower.leader:HasTag("player")
				and c.follower.leader.name and c.follower.leader.name ~= ""
			then
				cn("owner",c.follower.leader.name)
				has_owner = true
			end
			if c.follower.maxfollowtime then
				mx = c.follower.maxfollowtime
				cur = math.floor(c.follower:GetLoyaltyPercent()*mx+0.5)
				if cur>0 then
					cn("loyal",cur,mx)
				end
			end
		end
		--[[if c.locomotor and type(c.locomotor.walkspeed)=="number" then
			local speed = (c.locomotor.walkspeed + (type(c.locomotor.bonusspeed)=="number" and c.locomotor.bonusspeed or 0))
				/ TUNING.WILSON_WALK_SPEED
			if speed>1.01 or speed<0.99 then
				desc = cn(desc,"x"..round2(speed,2),"speed")
			end
		end --]]
		if item.kills and item.kills>0 then
			cn(item.kills==1 and "kill" or "kills",item.kills)
		end
		if item.aggro and item.aggro>0 then
			cn("aggro",item.aggro)
		end
		--Процент увеличения урона. Например, у Вигфрид +25%
		if c.combat and c.combat.damagemultiplier and c.combat.damagemultiplier ~= 1 then
			local perc = c.combat.damagemultiplier - 1
			cn("dmg_character",round2(perc*100,0))
		end
		--Урон
		if c.combat and c.combat.defaultdamage and c.combat.defaultdamage > 0 then
			--Игнорируем всех, чья сила равна 10 или меньше.
			local com = c.combat
			local dmg = com.defaultdamage * (com.playerdamagepercent or 1)
			cn("strength", math.floor( dmg + 0.5))
			if com.areahitdamagepercent then --AoE
				cn("aoe", math.floor( dmg * com.areahitdamagepercent + 0.5))
			end
		end
		if h.absorb~=0 or h.playerabsorb~=0 then
			local perc = 1-(1-h.absorb)*(1-h.playerabsorb)
			cn("armor_character",round2(perc*100,0))
		end
		if item.asunaheal_score and item.prefab == "asuna" and TUNING.ASUNA_HEAL_SCORE_SWORD
			and item.asunaheal_score < TUNING.ASUNA_HEAL_SCORE_SWORD
		then
			local asuna_proof = round2(math.floor((item.asunaheal_score/TUNING.ASUNA_HEAL_SCORE_SWORD)*100+0.5),0)
			if asuna_proof > 99 then
				asuna_proof = 99
			end
			table.insert(desc_table, "$Asuna Proof: "..asuna_proof.."%")
		end
		--inst.components.domesticatable:GetObedience()
		if c.domesticatable ~= nil then
			if c.domesticatable.GetObedience ~= nil then
				local obedience = c.domesticatable:GetObedience()
				if obedience ~= 0 then
					cn("obedience",round2(obedience*100,0))
				end
			end
			if c.domesticatable.GetDomestication ~= nil then
				local domest = c.domesticatable:GetDomestication()
				if domest ~= 0 then
					cn("domest",round2(domest*100,0))
				end
			end
		end
	else --elseif prefab~="rocks" and prefab~="flint" then --No rocks and flint
		--Part 1: primary info
		if c.stewer and c.stewer.product and c.stewer.IsCooking and c.stewer:IsCooking() then
			local tm=round2(c.stewer.targettime-_G.GetTime(),0)
			if tm<0 then tm=0 end
			cn("cookpot", c.stewer.product)
			cn("sec",tm)
		end
		if c.cooldown and c.cooldown.GetTimeToCharged and not c.cooldown.charged then
			local timer = round2(c.cooldown:GetTimeToCharged(),0)
			cn("cooldown", timer)
		end
		--Part 2: secondary info
		if c.armor and c.armor.absorb_percent and type(c.armor.absorb_percent)=="number" then
			local r=c.armor.absorb_percent
			cn("armor",round2(r*100,0))
			--Support of absorption mod.
			if item.phys and (item.phys.blunt or item.phys.pierc or item.phys.slash) then
				local p = item.phys
				cn("absorb",(p.blunt or 0).." / "..(p.pierc or 0).." / "..(p.slash or 0))
			end
			if c.armor.condition and c.armor.condition > 0 and c.armor.maxcondition then
				cn("durability", math.floor(c.armor.condition + 0.5), math.floor(c.armor.maxcondition + 0.5))
			end
		end
		if item.damage and type(item.damage)=="number" and item.damage>0 then
			cn("dmg",round2(item.damage,1))
		elseif c.weapon ~= nil and c.weapon.damage and type(c.weapon.damage)=="number" and c.weapon.damage>0 then
			cn("dmg",round2(c.weapon.damage,1))
			--Support of absobtion mod.
			if item.phys_dmg then
				local p = item.phys_dmg == "blunt" and "Blunt" or (
					item.phys_dmg == "pierc" and "Piercing" or (
						item.phys_dmg == "slash" and "Slashing" or nil
					)
				)
				if p ~= nil then
					table.insert(desc_table, "$Type: "..p)
				end
			end
		elseif c.zupalexsrangedweapons ~= nil
			and c.zupalexsrangedweapons.GetArrowBaseDamage ~= nil
			and type(c.zupalexsrangedweapons.GetArrowBaseDamage) == "function"
		then
			local dmg = c.zupalexsrangedweapons:GetArrowBaseDamage()
			if dmg ~= nil and type(dmg) == "number" and dmg > 0 then
				cn("dmg",round2(dmg,1))
			end
		end
		if c.weapon and c.weapon.damage and type(c.weapon.attackrange)=="number" and c.weapon.attackrange>0.3 then
			cn("range",round2(c.weapon.attackrange,1))
		elseif c.projectile and c.projectile.damage and type(c.projectile.range)=="number" and c.projectile.range>0.3 then
			cn("range",round2(c.projectile.range,1))
		elseif c.combat and c.combat.damage and type(c.combat.attackrange)=="number" and c.combat.attackrange>2.5 then
			cn("range",round2(c.combat.attackrange,1))
		end
		if c.insulator and c.insulator.insulation and type(c.insulator.insulation)=="number" and c.insulator.insulation~=0 then
			if c.insulator.SetInsulationEx then --ServerMod
				local winter,summer = c.insulator:GetInsulationEx()
				if winter~=0 then
					cn("warm",round2(winter,0))
				end
				if summer~=0 then
					cn("summer",round2(summer,0))
				end
			elseif c.insulator.GetInsulation then
				local insul,typ = c.insulator:GetInsulation()
				if typ == _G.SEASONS.WINTER then
					cn("warm",round2(insul,0))
				elseif typ == _G.SEASONS.SUMMER then
					cn("summer",round2(insul,0))
				end
			end
		end
		if c.dapperness and c.dapperness.dapperness and type(c.dapperness.dapperness)=="number" and c.dapperness.dapperness~=0 then
			local sanity = round2(c.dapperness.dapperness*54,1)
			cn("sanity",sanity)
		elseif c.equippable and c.equippable.dapperness and type(c.equippable.dapperness)=="number" and c.equippable.dapperness~=0 then
			local sanity = round2(c.equippable.dapperness*54,1)
			cn("sanity",sanity)
		end
		if c.equippable and c.equippable.walkspeedmult and c.equippable.walkspeedmult ~= 1 then
			local added_speed = math.floor((c.equippable.walkspeedmult - 1)*100+0.5)
			cn("speed",added_speed)
		end
		if c.dapperness and c.dapperness.mitigates_rain and item.prefab ~= "umbrella" then
			cn("waterproof","90")
		elseif item.protect_from_rain then
			cn("waterproof",round2((item.protect_from_rain)*100,0))
		elseif c.waterproofer then
			local effectiveness = _G.tonumber(c.waterproofer.effectiveness) or 0
			if effectiveness ~= 0 then
				cn("waterproof",round2((effectiveness)*100,0))
			else
				--desc = (desc=="" and "" or (desc.."\n")).."Waterproofer"
			end
		end
		--if c.striker and c.striker.chance and type(c.striker.chance) == "number" then
		--	desc = cn(desc,round2((c.striker.chance)*100,0).."%","striker")
		--end
		--if c.tinder and c.tinder.tinder and c.tinder.GetTinder then
		--	local power = c.tinder:GetTinder()
		--	if power >= 0.005 then
		--		desc = cn(desc,round2(power*100,0).."%","tinder")
		--	end
		--end
		if c.edible and not is_DisplayFoodValues then
			local can_eat = false
			if viewer and viewer.components.eater then
				can_eat = viewer.components.eater:CanEat(item)
			end
			if can_eat then
				local should_Estimate_Stale = viewer and viewer.should_Estimate_Stale --client priority
				if not should_Estimate_Stale then
					should_Estimate_Stale = food_estimation ~= 0
				end
				local hp,hg,sn
				if should_Estimate_Stale and c.edible.GetSanity then
					--print("Estimate")
					hp=round2(c.edible:GetHealth(viewer),1)
					hg=round2(c.edible:GetHunger(viewer),1)
					sn=round2(c.edible:GetSanity(viewer),1)
				else
					--print("Not Estimate")
					hp=round2(c.edible.healthvalue,1)
					hg=round2(c.edible.hungervalue,1)
					sn=round2(c.edible.sanityvalue,1)
				end
				if viewer ~= nil and viewer.FoodValuesChanger ~= nil then --Особая функция, призвание которой - менять еду при съедании.
					--print("+")
					--Правда, здесь мы можешь слегка подсмотреть ее результаты до поедания.
					local hp2, hg2, sn2 = viewer:FoodValuesChanger(item)
					if sn2 ~= nil then
						--print("++")
						hp=round2(hp2,1)
						hg=round2(hg2,1)
						sn=round2(sn2,1)
					end
				end
				if hp > 0 then
					hp = "+" .. tostring(hp)
				end
				if hg > 0 then
					hg = "+" .. tostring(hg)
				end
				if sn > 0 then
					sn = "+" .. tostring(sn)
				end
				cn("food",hg,sn,hp)
			end
		end
		if c.perishable ~= nil and c.perishable.updatetask ~= nil then
			local time = GetPerishTime(item, c)
			if time ~= nil then
				cn("perish",round2(time/TUNING.TOTAL_DAY_TIME,1))
			end
		end
		if ing[prefab] and show_food_units ~= 2 then -- ==2 means that food info is forbidden on the server.
			for k,v in pairs(ing[prefab].tags) do
				if k~="precook" and k~="dried" then
					cn("units_of",v,k)
				end
			end
		end
		if c.healer then
			cn("heal",round2(c.healer.health,1))
		end
		--[[if item.grow_stage and type(item.grow_stage) == "number" then --Support Clan System mod
			local val = math.floor(item.grow_stage+0.5)
			desc = cn(desc,tostring(val).."%","power")
			if IsAdmin(viewer) then
				desc = cn(desc,item.show_stage,"show_stage",true)
				desc = cn(desc,item.grow_stage,"grow_stage",true)
				desc = cn(desc,item.active,"active",true)
				desc = cn(desc,item.fuel,"fuel",true)
			end
		else--]]
		if c.finiteuses then
			local mult = 1
			if c.finiteuses.consumption then
				for k,v in pairs(c.finiteuses.consumption) do
					mult = 1/v
				end
			end
			local cur = math.floor(c.finiteuses.current * mult + 0.5)
			if c.finiteuses.current > cur then
				cur = cur + 1
			end
			cn("uses_of",cur,math.floor(c.finiteuses.total * mult + 0.5))
			--desc = (desc=="" and "" or (desc.."\n"))..cur.." use"..(cur~=1 and "s" or "").." of "..c.finiteuses.total
		end
		if c.temperature and c.temperature.current and type(c.temperature.current) == "number" then
			cn("temperature",round2(c.temperature.current,1))
		end
		if c.fueled and c.fueled:GetPercent()>0 and (SPICIAL_STRUCTURES[prefab] or item:HasTag("structure")) then
			cn("fuel",round2(c.fueled:GetPercent()*100,0))
		end
		if c.instrument and type(c.instrument.range)=="number" and c.instrument.range>0.4 then
			cn("range",round2(c.instrument.range,0))
		end
		if c.crystallizable and c.crystallizable.formation --support of Krizor's mod
			and c.crystallizable.formation.thickness
			and type(c.crystallizable.formation.thickness)=="table"
			and c.crystallizable.formation.thickness.current
			and c.crystallizable.formation.thickness.current>0
		then
			cn("thickness",round2(c.crystallizable.formation.thickness.current,1))
		end
		if c.mine then
			if c.mine.nick then
				cn("owner",c.mine.nick)
				has_owner = true
			end
			--[[if c.mine.pret and viewer and viewer.userid then
				for k,v in pairs(c.mine.pret) do
					if k==viewer.userid then
						--desc = (desc=="" and "" or (desc.."\n")).."I can see it!"
						desc = cn(desc,v,"known",true)
						break
					end
				end
			end--]]
		end
		if not has_owner then
			if item.stealable and item.stealable.owner and item.stealable.owner ~= "_?\1" then
				cn("owner",item.stealable.owner)
				has_owner = true
			elseif item.owner and type(item.owner)=="string" and string.sub(item.owner,1,3) ~= "KU_" then
				--Мы не знаем, что за имя. Но это "владелец". Так что надо вывести. И это точно не user_id.
				cn("owner",item.owner)
				has_owner = true
			end
		end
		if c.occupiable then
			local item = c.occupiable:GetOccupant()
			if item then
				local c = item.components
				if c.perishable ~= nil and c.perishable.updatetask ~= nil then --Here "Perishable" means "Hunger".
					local time = GetPerishTime(item, c)
					if time ~= nil then
						cn("will_die",round2(time/TUNING.TOTAL_DAY_TIME,1))
					end
				end
			end
		end
		if c.dryer and c.dryer.IsDrying then
			if c.dryer:IsDrying() and c.dryer.GetTimeToDry then
				cn("will_dry",round2(c.dryer:GetTimeToDry()/TUNING.TOTAL_DAY_TIME,1))
				--if c.dryer:IsPaused() then
				--end
			elseif c.dryer.IsDone and c.dryer:IsDone() and c.dryer.GetTimeToSpoil then
				cn("perish",round2(c.dryer:GetTimeToSpoil()/TUNING.TOTAL_DAY_TIME,1))
			end
		end
		if c.saddler then --Седло и его параметры.
			if c.saddler.speedmult and c.saddler.speedmult ~= 0 then
				local added_speed = math.floor((c.saddler.speedmult - 1)*100 + 0.5) -- (1.4 - 1) == 0.4
				cn("speed",added_speed)
			end
			if c.saddler.bonusdamage and c.saddler.bonusdamage ~= 0 then
				cn("dmg_bonus",round2(c.saddler.bonusdamage,1))
			end
		end
		if c.timer and c.timer.timers then
			local get_time = GetTime()
			for name, data in pairs(c.timer.timers) do
				cn('timer', round2(data.end_time - get_time,0), name)
			end
		end
		if c.tradable then
			if c.tradable.goldvalue and c.tradable.goldvalue > 0 then
				cn("trade_gold", c.tradable.goldvalue)
			end
			if c.tradable.rocktribute and c.tradable.rocktribute > 0 then
				cn("trade_rock", c.tradable.rocktribute)
			end
		end
		------------------Check prefabs?----------------------
		if prefab=="panflute" then
			--desc = cn("power","10")
		elseif prefab=="blowdart_sleep" then
			--desc = cn(desc,"1","power")
		--[[elseif prefab=="pond" and item.targettime then
			local tm = item.targettime - _G.GetTime()
			if tm>0 then
				desc = "Broken "..cn(desc,tm,"sec")
			elseif item.broken then
				desc = (desc=="" and "" or (desc.."\n")).."Broken"
			end--]]
		elseif prefab=="pond" or prefab=="pond_mos" then
			cn(c.fishable.fishleft==1 and "fish" or "fishes",c.fishable.fishleft)
		elseif prefab=="aqvarium" and item.data then
			if item.data.seeds and item.data.seeds>0 then
				table.insert(desc_table, "$Seeds: "..tostring(item.data.seeds))
			end
			if item.data.meat and item.data.meat>0 then
				table.insert(desc_table, "$Meat: "..tostring(item.data.meat))
				--desc = cn(desc,item.data.meat,"Meat:",true)
			end
			local need_wet= item.data.need_wet or 60
			if item.data.wet and item.data.wet>0 and item.data.wet<need_wet then
				table.insert(desc_table, "$Water: "..tostring(round2(100*item.data.wet/need_wet).."%"))
				--desc = cn(desc,round2(100*item.data.wet/need_wet).."%","Water:",true)
			end
			if item.total_heat then
				local temp = item.total_heat/10 --+ _G.TheWorld.state.temperature
				if temp>40 then temp = 40 end
				if temp>=0 then
					cn("temperature",tostring(round2(temp,1)))
				end
			end
		end
		--Charges: lightning rod / lamp
		if item.chargeleft and item.chargeleft > 0 then	
			table.insert(desc_table, "$Days left: "..tostring(math.floor(item.chargeleft+0.5)))
		end
		--Mod support:
		if item.GetShowItemInfo then
			local custom1, custom2, custom3 = item:GetShowItemInfo()
			if custom1 then table.insert(desc_table, "$"..tostring(custom1)) end
			if custom2 then table.insert(desc_table, "$"..tostring(custom2)) end
			if custom3 then table.insert(desc_table, "$"..tostring(custom3)) end
		end
		if c.pickable and c.pickable.task then --Трава и ветки.
			local targettime = c.pickable.targettime
			if targettime then
				local delta = targettime - GetTime()
				if delta > 0 then
					cn("grow_in",round2(delta/TUNING.TOTAL_DAY_TIME,1)) --days
				end
			end
		end
		--[[if c.witherable then
			local time = GetTime()
			table.insert(desc_table, "$witherable: "
				..tostring(c.delay_to_time and (time-c.delay_to_time)) .. ", "
				..tostring(c.task_to_time and (time-c.task_to_time)) .. ", "
				..tostring(c.protect_to_time and (time-c.protect_to_time)) .. ", "
				..tostring(c.is_watching_rain)
			)
		end
		if c.diseaseable then
			local time = GetTime()
			table.insert(desc_table, "$diseaseable: "
				--..tostring(c._spreadtask and (time-c.delay_to_time)) .. ", "
				--..tostring(c.task_to_time and (time-c.task_to_time)) .. ", "
				--..tostring(c.protect_to_time and (time-c.protect_to_time)) .. ", "
				--..tostring(c.is_watching_rain)
			)
		end--]]
		--Грядки - это на самом деле высаженные всходы (мышка наводится на них поверх грядок).
		if c.crop and c.crop.product_prefab and c.crop.product_prefab and c.crop.growthpercent
			and type(c.crop.growthpercent) == 'number' and c.crop.growthpercent < 1
		then
			--Передаем названием продукта и процент созревания (до целых).
			cn("crop",c.crop.product_prefab,round2(c.crop.growthpercent*100,0))
		end
		--c.unwrappable.itemdata[1].prefab
		--c.unwrappable.itemdata[1].data.perishable.time - оставшееся время порчи в секундах.
		--	   .stackable.stack - количество
		if c.unwrappable and c.unwrappable.itemdata and type(c.unwrappable.itemdata) == 'table' then
			--По одной строке на каждый предмет.
			for i,v in ipairs(c.unwrappable.itemdata) do
				if v.prefab then
					--Пересылаем название префаба и количество дней.
					local delta = v.data and v.data.perishable and v.data.perishable.time
					local count = v.data and v.data.stackable and v.data.stackable.stack
					cn('perish_product', v.prefab, count or 0, delta and round2(delta/TUNING.TOTAL_DAY_TIME,1))
				end
			end
		end
		--Боченок рассола из мода "Pickle It!"
		if c.pickler and c.pickler.targettime then
			local delta = c.pickler.targettime - GetTime()
			cn('just_time', round2(delta/TUNING.TOTAL_DAY_TIME,1))
		end
		--Для мода "Thirst" проверяем компонент "cwater"
		if c.cwater then
			local w = c.cwater
			--Особо не заморачиваемся. Просто выводим то, что в нём есть.
			if w.current and w.max then
				cn('water',round2(w.current,0),round2(w.max,0))
			end
			if w.waterperdrink and type(w.waterperdrink)=="number" and w.waterperdrink ~= 0 then
				cn("sip",round2(w.waterperdrink,0))
			end
			if w.watergainspeed and type(w.watergainspeed)=="number" and w.watergainspeed ~= 0 then
				cn("watergainspeed",round2(w.watergainspeed,0))
			end
			if w.poisoned then
				cn("water_poisoned")
			end
		end
	end
	--Depending from weapon info:
	if viewer and type(viewer)=="table" and viewer.components and viewer.components.inventory then
		local weapon = viewer.components.inventory:GetEquippedItem(_G.EQUIPSLOTS.HANDS)
		if weapon then
			if weapon.prefab=="icestaff" and c.freezable then
				cn("resist",c.freezable.resistance)
			elseif (weapon.prefab=="blowdart_sleep" or weapon.prefab=="panflute") and c.sleeper then
				cn("resist",c.sleeper.resistance)
			end
		end
	end
	if item.inlove and item.inlove>0 then
		if prefab=="chester" then
			cn("love",item.inlove/10)
		else
			cn("love",item.inlove)
		end
	end
	--Additional
	--[[
	if prefab=="chester" then
		local name = name_by_id(self.inst.userid)
		desc = (desc=="" and "" or (desc.."\n")).."Owner: "..name
			.."\nuserid="..tostring(self.inst.userid)
			.."\nLeader: "..tostring(c.follower.leader)
		has_owner = true
	end
	if prefab=="chester_eyebone" then
		local name = name_by_id(self.inst.userid)
		desc = (desc=="" and "" or (desc.."\n")).."Owner: "..name
			.."\nuserid="..tostring(self.inst.userid)
		has_owner = true
	end
	--]]
	--print("GetTestString: "..tostring(item)..", "..tostring(viewer)..", "..tostring(desc))
	--for i=1,line_cnt do
	--	desc = desc .. "\n" --Поднимаем описание предмета, чтобы оно было НАД предметом. Но лучше это сделать на клиенте.
	--end
	
	return table.concat(desc_table,"\2")
end

--Main description function
--[[
AddComponentPostInit("inspectable", function(inst)
	local oldGetDesc = inst.GetDescription
	function inst:GetDescription(viewer)
		local desc = oldGetDesc(self,viewer)
		if self.inst and self.inst.components then
			local item = self.inst
			if type(desc)~="string" then
				desc=""
			end
			local desc = GetTestString(item,viewer,desc)
		end
		return desc
	end
end)
--]]

--[[
AddPrefabPostInit("wes",function(wes)
	if wes.components and wes.components.talker then
		local oldSay = wes.components.talker.Say
		function wes.components.talker:Say(script, time, noanim)
			local test=type(script)=="string" and string.match(script,"([0-9]+ / [0-9]+)$") or ""
			if test then
				script=test
			else
				script=""
			end
			oldSay(self, script, time, noanim)
		end
		wes.components.talker.special_speech = false
	end
end)

GetGlobal("fol",function()
	
end)
--]]


end


-------------------------------------------------------------------------------------------------------------
------------------------------------------- HOST & CLIENT AGAIN ---------------------------------------------





--Добавляем подсказку для игрока, через которую будем пересылать данные (всплывающий текст с инфой под именем предмета)
do
	--Функция возвращает подсказку, если она в точности совпадает с присланной информацией (в player_classified).
	--И возвращает подсказку, либо "".
	local function CheckUserHint(inst)
		local c = _G.ThePlayer and _G.ThePlayer.player_classified
		if c == nil then --Нет локального игрока или classified
			return ""
		end
		--c.showme_hint
		local i = string.find(c.showme_hint,';',1,true)
		if i == nil then --Строка имеет неправильный формат.
			return ""
		end
		local guid = _G.tonumber(c.showme_hint:sub(1,i-1))
		if guid ~= inst.GUID then --guid не совпадает (либо вообще nil)
			return ""
		end
		return c.showme_hint:sub(i+1)
	end
	if CLIENT_SIDE then
		--patching Get Display Name. Нужно только клиенту.
		--[[local old_GetDisplayName = _G.EntityScript.GetDisplayName
		_G.EntityScript.GetDisplayName = function(self)
			local old_name = old_GetDisplayName(self)
			if type(old_name) ~= "string" then
				return old_name
			end
			local str2 = CheckUserHint(self)
			return old_name .. str2
		end--]]
		
		--Разбираем случаи, когда нужно отправить guid об объекте под мышью.
		local old_inst --Запоминаем, чтобы не спамить один и тот же inst по несколько раз.
		--[[AddWorldPostInit(function(w)
			w:DoPeriodicTask(0.1,function(w)
				if _G.ThePlayer == nil then
					return
				end
				local inst = _G.TheInput:GetWorldEntityUnderMouse()
				if inst ~= nil then
					if inst == old_inst then
						return
					end
					old_inst = inst
					--Посылаем желаемую подсказку.
					SendModRPCToServer(MOD_RPC.ShowMeHint.Hint, inst.GUID, inst)
				end
			end)
		end)--]]
		
		local function UnpackData(str,div)
			local pos,arr = 0,{}
			-- for each divider found
			for st,sp in function() return string.find(str,div,pos,true) end do
				table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
				pos = sp + 1 -- Jump past current divider
			end
			table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
			return arr
		end		

		local save_target
		local last_check_time = 0 --последнее время проверки. Будет устаревать каждые 2 сек.
		local LOCAL_STRING_CACHE = {} --База данных строк, чтобы не обсчитывать замены каждый раз (правда, будет потихоньку пожирать память)
		AddClassPostConstruct("widgets/hoverer",function(hoverer) --hoverer=self
			local old_SetString = hoverer.text.SetString
			hoverer.text.SetString = function(text,str) --text=self
				--print(tostring(str))
				local target = _G.TheInput:GetHUDEntityUnderMouse()
				if target ~= nil then
					--target.widget.parent - это ItemTile
					target = target.widget ~= nil and target.widget.parent ~= nil and target.widget.parent.item --реальный итем (на клиенте)
				else
					target = _G.TheInput:GetWorldEntityUnderMouse()
				end
				--local lmb = hoverer.owner.components.playercontroller:GetLeftMouseAction()
				if target ~= nil then
					--print(tostring(target))
					--Проверяем совпадение с данными.
					local str2 = CheckUserHint(target)
					if str2 ~= "" then
						--Так, сначала чистим старую строку от переходов на новую строку. Мало ли какие там моды чего добавили.
						local cnt_newlines, _ = 0 --Считаем переходы строк в конце строки (совместимость с DFV)
						while cnt_newlines < #str do
							local ch = str:sub(#str-cnt_newlines,#str-cnt_newlines)
							if ch ~= "\n" and ch ~= " " then
								break
							end
							cnt_newlines = cnt_newlines + 1
						end
						--Очищаем строку от этого мусора
						if cnt_newlines > 0 then
							str = str:sub(1,#str-cnt_newlines)
						end
						--print(#str,"clear")
						--Очищаем строку от промежуточного мусора
						if string.find(str,"\n\n",1,true) ~= nil then
							str = str:gsub("[\n]+","\n")
						end
						--[[ --Теперь это не нужно, т.к. мы тупо добавляем 1 строку.
						if string.find(str,"\n",1,true) ~= nil then
							_,cnt_newlines = str:gsub("\n","\n") --Подсчитываем количество переходов внутри (если есть).
						else
							cnt_newlines = 0
						end
						--]]

						--Извлекаем данные из полученной упакованной строки.
						str2 = UnpackData(str2,"\2")
						local arr2 = {} --Формируем массив данных в удобоваримом виде.
						for i,v in ipairs(str2) do
							if v ~= "" then
								local param_str = v:sub(2)
								local data = { param = UnpackData(param_str,","), param_str=param_str }
								local my_s = MY_STRINGS[string.byte(v:sub(1,1))-64]
								if my_s ~= nil then
									data.data = MY_DATA[my_s.key]
								end
								table.insert(arr2,data)
							end
						end
						arr2.str2= str2
						--_G.rawset(_G,"arr2",arr2) --Для теста.
						--Формируем строку
						str2=""
						for i,v in ipairs(arr2) do
							if v.data ~= nil and v.data.fn ~= nil then
								str2=str2.. v.data.fn(v) .. "\n"
							elseif v.hidden == nil then
								str2=str2 .. DefaultDisplayFn(v) .. "\n"
							end
						end
						
						--_G.arr({inst=text.inst,hover=text.parent},5)
						--print("-----"..str.."-----")
						--local sss=""
						--for i=#str,#str-10,-1 do
						--	sss=sss..string.byte(str:sub(i,i))..", "
						--end
						--print("Chars: "..sss)
						--[[print(#str,"cut str")
						--В конце тоже убираем переход, если есть.
						if str:sub(#str,#str) == "\n" then
							str = str:sub(1,#str-1)
						end--]]
						--print(#str,"test cache")
						--print("count new cache")
						--print("newlines",#str2)
						
						str = str .. "\n" .. str2
						
						--Заново считаем количество оставшихся переходов строк
						--cnt_newlines = cnt_newlines + #arr2 + 1 --Всего переходов строк.
						--cnt_newlines = math.floor((#arr2 + 1) * 0.5) --Увеличиваем, но не сильно.
						cnt_newlines = 1
						--В конце добавляем переходы
						--Добавляем пустые строки в конец. TODO: Это надо только если предмет в инвентаре.
						while cnt_newlines > 0 do
							str = str .. "\n "
							cnt_newlines = cnt_newlines - 1
						end
					end
					--print("Check User Hint: "..str2)
					--Если первый раз, то отправляем запрос.
					if target ~= save_target or last_check_time + 1 < GetTime() then
						save_target = target
						last_check_time = GetTime()
						SendModRPCToServer(MOD_RPC.ShowMeHint.Hint, save_target.GUID, save_target)
					end
				else
					--print("target nil")
				end
				return old_SetString(text,str)
			end
		end)
	end
	
	--Обработчик на сервере
	AddModRPCHandler("ShowMeHint", "Hint", function(player, guid, item)
		if player.player_classified == nil then
			print("ERROR: player_classified not found!")
			return
		end
		if item ~= nil and item.components ~= nil then
			local s = GetTestString(item,player) --Формируем строку на сервере.
			if s ~= "" then
				player.player_classified.net_showme_hint:set(guid..";"..s) --Пакуем в строку и отсылаем обратно тому же игроку.
			end
		end
	end)

	--networking
	AddPrefabPostInit("player_classified",function(inst)
		inst.showme_hint = ""
		inst.net_showme_hint = _G.net_string(inst.GUID, "showme_hint", "showme_hint_dirty")
		if CLIENT_SIDE then
			inst:ListenForEvent("showme_hint_dirty",function(inst)
				inst.showme_hint = inst.net_showme_hint:value()
			end)
		end
	end)
end

--Обработка сундуков
do
	--[[
	If you want add your custom chest, use this code:
		TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {}
		TUNING.MONITOR_CHESTS.chestprefab = true
	--]]
	local MONITOR_CHESTS = { treasurechest=1, dragonflychest=1, skullchest=1, pandoraschest=1, minotaurchest=1,
		--bundle=1, --No container component. =\
		icebox=1, cookpot=1, -- No cookpot because it may be changed.
		chester=1, hutch=1,
		largechest=1, largeicebox=1, --Large Chest mod.
		safebox=1, safechest=1, safeicebox=1, --Safe mod.
		red_treasure_chest=1, purple_treasure_chest=1, green_treasure_chest=1, blue_treasure_chest=1, --Treasure Chests mod.
		backpack=1, candybag=1, icepack=1, piggyback=1, krampus_sack=1,
	}
	if TUNING.MONITOR_CHESTS then
		for k in pairs(TUNING.MONITOR_CHESTS) do
			MONITOR_CHESTS[k] = 1
		end
	--else
		--TUNING.MONITOR_CHESTS = MONITOR_CHESTS --Это не нужно.
	end
	local _active --Текущий предмет в курсоре (на клиенте).
	local _ing_prefab --Ингредиент. Через 5 секунд убирается.
	local net_string = _G.net_string
	local chests_around = {} --Массив всех сундуков в радиусе видимости клиента. Для хоста - все сундуки, но это норм.
	
	--[[
	_G.showme_count_chests = function() --debug function
		local cnt = 0
		for k,v in pairs(chests_around) do
			cnt = cnt + 1
		end
		print('Chests around:',cnt)
	end
	--]]
	
	local function OnClose(inst) --,err) --При закрытии сундука посылаем новые данные клиенту о его содержимом.
		local c = inst.components.container
		if not c then
			--[[if type(err) ~= "number" then err=nil end
			print('ERROR ShowMe: in ',inst.prefab,err)
			if not err then
				if inst.components then
					print("\tComponents:")
					for k in pairs(inst.components) do
						print("\t\t"..tostring(k))
					end
				else
					print("\tNo components at all!")
				end
			end
			if not err or err < 2000 then
				inst:DoTaskInTime(0,function(inst)
					OnClose(inst,err and (err+1) or 1)
				end)
			end--]]
			return
		end
		--if err then
		--	print("Found!!!!! Problem solved",err)
		--end
		if c:IsEmpty() then
			inst.net_ShowMe_chest:set('')
			return
		end
		local arr = {} -- [префаб]=true
		--[[ Отрывок из предыдущего сочинения (чтобы знать, что там происходит):
		if c.unwrappable and c.unwrappable.itemdata and type(c.unwrappable.itemdata) == 'table' then
			--По одной строке на каждый предмет.
			for i,v in ipairs(c.unwrappable.itemdata) do
				if v.prefab then
					--Пересылаем название префаба и количество дней.
					local delta = v.data and v.data.perishable and v.data.perishable.time
					local count = v.data and v.data.stackable and v.data.stackable.stack
					cn('perish_product', v.prefab, count or 0, delta and round2(delta/TUNING.TOTAL_DAY_TIME,1))
				end
			end
		end--]]
		for k,v in pairs(c.slots) do
			arr[tostring(v.prefab)] = true
			local u = v.components and v.components.unwrappable
			if u and u.itemdata then
				for i,v in ipairs(u.itemdata) do
					arr[v.prefab] = true --Добавляем префаб в упаковке.
				end
			end
		end
		local s
		for k in pairs(arr) do
			if s then
				s = s .. ' ' .. k --Только пробельные символы будут далее работать.
			else
				s = k
			end
		end
		inst.net_ShowMe_chest:set(s) --Посылаем данные.
	end
	
	--Обновляет подсветку сундука. Функция должна сама узнавать, что в руке игрока.
	local function UpdateChestColor(inst)
		local in_container = inst.ShowMe_chest_table and (
			(_active and inst.ShowMe_chest_table[_active.prefab])
			or (_ing_prefab and inst.ShowMe_chest_table[_ing_prefab])
		)
		if inst.b_ShowMe_changed_color then
			if not in_container then
				if inst.ShowMeColor then
					inst.ShowMeColor(true)
				else
					inst.AnimState:SetMultColour(1,1,1,1) --По умолчанию.
					inst.b_ShowMe_changed_color = nil
				end
			end
		else
			if in_container then
				if inst.ShowMeColor then
					inst.ShowMeColor(false)
				else
					inst.AnimState:SetMultColour(0.3,1,1,1)
					inst.b_ShowMe_changed_color = true
				end
			end
		end
	end
	
	local function OnShowMeChestDirty(inst)
		--inst.components.HuntGameLogic.hunt_kills = inst.components.HuntGameLogic.net_hunt_kills:value()
		local str = inst.net_ShowMe_chest:value()
		--inst.test_str = str --test
		--print('Test Chest:',str)
		local t = inst.ShowMe_chest_table
		for k in pairs(t) do
			t[k] = nil
		end
		for w in string.gmatch(str, "%S+") do
			t[w] = true
		end
		UpdateChestColor(inst) --Перерисовывает данный конкретный сундук, если изменилось его содержимое.
	end	

	local function InitChest(inst)
		inst.net_ShowMe_chest = net_string(inst.GUID, "ShowMe_chest", "ShowMe_chest_dirty" )
		if CLIENT_SIDE then
			inst:ListenForEvent("ShowMe_chest_dirty", OnShowMeChestDirty)
			chests_around[inst] = true
			inst.ShowMe_chest_table = {}
			inst.ShowTable = function() for k in pairs(inst.ShowMe_chest_table) do print(k) end end --debug
			inst:ListenForEvent('onremove', function(inst)
				chests_around[inst] = nil
			end)
		end
		if not SERVER_SIDE then
			return
		end
		inst:ListenForEvent("onclose", OnClose)
		inst:ListenForEvent("itemget", OnClose) --Для рюкзаков.
		inst:ListenForEvent("itemlose", OnClose)
		inst:DoTaskInTime(0,function(inst)
			OnClose(inst) --Изначально тоже посылаем данные, а не только при закрытии. Ведь сундук мог быть загружен.
		end)
	end
	
	for k in pairs(MONITOR_CHESTS) do
		AddPrefabPostInit(k,InitChest)
	end
	--Фиксим игрока, чтобы мониторить действия курсора.
	if CLIENT_SIDE then
		local function UpdateAllChestsAround()
			for k in pairs(chests_around) do
				UpdateChestColor(k)
			end
		end
		AddPrefabPostInit("inventory_classified",function(inst)
			inst:ListenForEvent("activedirty", function(inst)
				--print("ACTIVE:",inst._active:value())
				_active = inst._active:value()
				_ing_prefab = nil --Если взят предмет, то рецепт сразу же забываем.
				UpdateAllChestsAround() --Перерисовываем ВСЕ сундуки при каждом активном предмете или его отмене.
			end)
		end)
		
		local _ing_task
		local function UpdateIngredientView(player, prefab)
			_ing_prefab = prefab
			UpdateAllChestsAround()
			if _ing_task then
				_ing_task:Cancel()
			end
			_ing_task = player:DoTaskInTime(15,function(inst)
				_ing_prefab = nil
				_ing_task = nil
				UpdateAllChestsAround()
			end)
		end
		
		local ingredientui = _G.require 'widgets/ingredientui'
		local old_OnGainFocus = ingredientui.OnGainFocus

		function ingredientui:OnGainFocus(...)
			local prefab = self.ing and self.ing.texture and self.ing.texture:match('[^/]+$'):gsub('%.tex$', '')
			local player = self.parent and self.parent.parent and self.parent.parent.owner

			if prefab and player then
				--print("INGREDIENT:",prefab)
				UpdateIngredientView(player,prefab)
			end
			if old_OnGainFocus then
				return old_OnGainFocus(self, ...)
			end
		end
	end
end

MY_STRINGS_OVERRIDE = {
	hp="HP:", --for characters
	health="Здоровье:", --for food
	hunger="Сытость:",
	sanity="Рассудок:",
	sec="Секунды:",
	armor="Защита:",
	dmg="Урон:",
	warm="Утепление:",
	fuel="Топливо:",
	range="Дальность:",
	speed="Скорость:",
	resist="Сопротивление:",
	power="Сила:",
	loyal="Преданность:",
	love="Любовь:",
	heal="Лечение:",
	kills="Убийств:",
	kill="Убийство:",
	fishes="Рыб:",
	fish="Рыба:",
	owner="Владелец:",
	thickness="Толщина:",
	waterproof="Влагозащита:",
	aggro="Агрессия:",
	summer="Летняя защита:",
	absorb="Поглощение:",
	obedience="Покорность:",
	perish="Испортится через",
	cookpot = "Скорее всего, это будет" ,
	electric = "Электричество:" ,
	S2="Сейчас лето,",
	S4="Сейчас осень," , 
	remaining_days = "Осталось дней" ,
	S3="Сейчас весна," ,
	is_admin = "Это одмин!\nОн вне игры,\nпоэтому нет смысла его трогать." ,
	armor_character = "Защита:" ,
	sanity_character = "Рассудок:" ,
	S1="Сейчас зима," , 
	dmg_character = "Урон:" ,
	cooldown = "Откат:",
    domest = "Приручённость:", -- "Domestication:"
    will_die = "Умрёт через",
    will_dry = "Высушится через",
    dmg_bonus = "Бонус урона:",
    grow_in = "Вырастет через",
	water = "Вода:",
	salt = "Соль:",
	sip = "Глоток:",
	watergainspeed = "Скорость прироста воды:",
	water_poisoned = "Содержит яд!",
	timer = "Таймер",
	trade_gold = "Стоимость золота:",
	trade_rock = "Стоимость камня:",
	durability = 'Прочность:',
	strength = 'Сила:',
	--aoe = 'AoE:',
}

SHOWME_STRINGS = {
	loyal = "вечная",
	of = " из ",
}

FOOD_TAGS = { --"dried" and "precook" are excluded.
	veggie = "овощей",
	fruit = "фруктов",
	monster = "монстро-еды",
	sweetener = "сахара",
	meat = "мяса",
	fish = "рыбы",
	magic = "магии",
	egg = "яиц",
	decoration = "украшений",
	dairy = "молока",
	inedible = "отравы",
	frozen = "льда",
	seed = "семян",
	fat = "жира",
	
	--Waiter 101
	fungus = "грибов", --all mushroom caps + cutlichen
	mushrooms = "полезных грибов", --all mushroom caps
	poultry = "птицы",
	wings = "крыльев", --about batwing
	seafood = "морепродуктов",
	nut = "орехов",
	cactus = "кактуса",
	starch = "крахмала", --about corn, pumpkin, cave_banana
	grapes = "винограда", --grapricot
	citrus = "цитрусовых", --grapricot_cooked, limon
	tuber = "клубня", --yamion
	shellfish = "моллюсков", --limpets, mussel
	
	--BEEFALO MILK and CHEESE mod
	rawmilk = "парного молока",
	
	--Camp Cuisine: Re-Lunched
	bulb = "шариков", --lightbulb
	spices = "специй",
	challa = "халы", -- Challah bread
	flour = "муки", --flour
	
	--Chocolate
	cacao_cooked == "какао",
}

--Russian declension of numerals
local st_tbl = {
	units = {" единица "," единицы "," единиц "},
	uses = {" использование из ", " использования из ", " использований из "},
	days = {"день","дня","дней"},
}

function StringTime(nn,s)
	local n =  math.floor(GLOBAL.tonumber(nn) or 0)
	local days = st_tbl[s]
	if days then
		local pl_type=n%10==1 and n%100~=11 and 1 or(n%10>=2 and n%10<=4 and(n%100<10 or n%100>=20)and 2 or 3)
		return tostring(nn).." "..days[pl_type]
	else
		return tostring(nn).." "..s --просто "N дней"
	end
end

MY_DATA.units_of.fn = function(arr)
	local s = FOOD_TAGS[arr.param[2]]
	s = s ~= "" and s or arr.param[2] --If translation exists.
	return StringTime(arr.param[1],"units")..s
end
MY_DATA.uses_of.fn = function(arr)
	return StringTime(arr.param[1],"uses")..arr.param[2]
end
MY_DATA.perish.fn = function(arr)
	local days = GLOBAL.tonumber(arr.param[1]) or 0
	if days == math.floor(days) then
		return arr.data.desc .. " " .. StringTime(days, "days")
	elseif days >= 1.4 and days <= 1.6 then
		return arr.data.desc .. " полтора дня"
	elseif days >= 0.4 and days <= 0.6 then
		return arr.data.desc .. " полдня"
	else
		return arr.data.desc .. " " .. tostring(days) .. " " .. st_tbl.days[3]
	end
end

UpdateNewLanguage()

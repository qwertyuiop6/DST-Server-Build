MY_STRINGS_OVERRIDE =
{ 
	armor = "盔甲: " , --A
	aggro = "攻擊: " , --B
	cookpot = "亨飪鍋" , --C (Crock Pot)
	dmg = "傷害: " , --D
	electric = "電力: " , --E --electric power
	food = "食物: ",
	S2="現在是夏天，" , --G
	health= "生命: " , --H --for food
	warm = "保溫: " , --I --winter insulation
	kill = "擊殺: " , --J --for Canibalism 18 mod
	kills = "擊殺數: " , --K --for Canibalism 18 mod
	loyal = "忠誠: " , --L --pigman and bunnyman
	S4="現在是秋天，" , --M
	remaining_days = "剩餘天數" , --N
	owner = "所有者: " , --O --support of various mods
	power = "力量: ", --P --usually means strengths of a weapon but not physical damage
	hunger= "飢餓: " , --Q
	range = "傷害範圍: " , --R --for range weapon or for mobs
	sanity= "理智: " , --S
	thickness = "厚度: " , --T
	units_of = "個單位的" , --U
	resist = "抵抗: " , --V --against sleep darts, ice staff etc
	waterproof = "防水: " , --W
	heal = "治愈: " , --X
	fishes = "魚數: " , --Y --in a pond
	fish = "魚: " , --Z
	sec= "秒數: " , --for cooking in Crock Pot
	love = "喜愛: " , 
	summer = "隔熱: " , --summer insulation
	absorb = "吸收: " ,
	S3="現在是春天，" , --
	is_admin = "這是管理員！\n他不進行遊戲，\n所以不要理他。" ,
	temperature = "溫度" ,
	hp= "基本生命: " , --for characters
	armor_character = "基本防禦: " ,
	sanity_character = "基本理智: " , --S 
	fuel = "燃料: " , --F --for firepit
	speed = "速度: " , 
	uses_of = "次使用的" ,
	obedience = "服從: " ,
	S1="現在是冬天，" , 
	dmg_character = "傷害: " ,
	perish = "" , --P -- Spoil in N days. 
	cooldown = "冷卻: ",
    will_die = "", --same as perish.
    --domest = "Tamed:",
    will_dry = "",
    dmg_bonus = "傷害: ",
}

SHOWME_STRINGS = {
	loyal = "臣服", --for very loyal pigman with loyalty over 9000
	of = " 屬於 ", -- X of Y (reserved)
	units_1 = "1 單位 ",
	units_many = " 單位 ",
	uses_1 = "1 次已使用，共 ",
	uses_many = " 次已使用，共 ", --X uses of Y, where X > 1
	days = " 天後腐壞", --Spoil in N days.
}

FOOD_TAGS = { --"dried" and "precook" are excluded.
	veggie = "蔬菜",
	fruit = "水果",
	monster = "怪物",
	sweetener = "糖類",
	meat = "肉類",
	fish = "魚類",
	magic = "魔法",
	egg = "蛋類",
	decoration = "首飾",
	dairy = "乳制品",
	fat = "油脂",
	inedible = "不可食用",
	frozen = "冷凍",
	seed = "種子",

	--Waiter 101
	fungus = "菌類", --all mushroom caps + cutlichen
	mushrooms = "蘑菇", --all mushroom caps
	poultry = "禽肉",
	wings = "翅膀", --about batwing
	seafood = "海鮮",
	nut = "堅果",
	cactus = "仙人掌",
	starch = "澱粉類", --about corn, pumpkin, cave_banana
	grapes = "葡萄", --grapricot
	citrus = "柑橘類", --grapricot_cooked, limon
	tuber = "塊莖", --yamion
	shellfish = "貝類", --limpets, mussel

	--BEEFALO MILK and CHEESE mod
	rawmilk = "生奶",

	--Camp Cuisine: Re-Lunched
	bulb = "螢光果", --lightbulb
	spices = "香料",
	challa = "哈拉麵包", -- Challah bread
	flour = "麵粉", --flour

	--Chocolate
	cacao_cooked == "可可",
}

MY_DATA.uses_of.fn = function(arr)
	return "可使用次數 " .. arr.param[1] .. "\n總使用次數 " .. arr.param[2]
end

UpdateNewLanguage()
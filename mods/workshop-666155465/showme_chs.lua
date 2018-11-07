MY_STRINGS_OVERRIDE =
{ 
	armor = "防御: " , --A
	aggro = "攻击: " , --B
	cookpot = "大概是: " , --C (Crock Pot)
	dmg = "伤害: " , --D
	electric = "电力: " , --E --electric power
	food = "食物: ",
	S2 ="现在是夏天" , --G
	health = "生命: " , --H --for food
	warm = "保暖: " , --I --winter insulation
	kill = "击杀: " , --J  --for Canibalism 18 mod
	kills = "击杀数: " , --K  --for Canibalism 18 mod
	loyal = "忠诚: " , --L  --pigman and bunnyman
	S4 = "现在是秋天" , --M
	remaining_days = "剩余天数" , --N
	owner = "所有者: " , --O --support of various mods
	perish = "距离腐烂: " , --P -- Spoil in N days. 
	power = "力量: ", --P --usually means strengths of a weapon but not physical damage
	hunger = "饥饿: " , --Q
	range = "攻击距离: " , --R  --for range weapon or for mobs
	sanity = "精神: " , --S
	thickness = "厚度: " , --T
	units_of = "单位" , --U
	resist = "抵抗: " , --V --against sleep darts, ice staff etc
	waterproof = "防水: " , --W
	heal = "生命: " , --X
	fishes = "鱼数量: " , --Y  --in a pond
	fish = "鱼: " , --Z
	sec= "剩余时间(秒): " ,  --for cooking in Crock Pot
	love = "喜爱: " , 
	summer = "隔热: " , --summer insulation
	absorb = "吸收: " ,
	S3="现在是春天" , --
	is_admin = "这是管理员\n他不在游戏中\n所以不要在意他" ,
	temperature = "温度" ,
	hp = "生命: " , --for characters
	armor_character = "基础防御: " ,
	sanity_character = "基础精神: " , --S  
	fuel = "燃料: " , --F --for firepit
	speed = "速度: " , 
	uses_of = "次可使用,总次数" ,
	obedience = "顺从: " ,
	S1 = "现在是冬天" , 
	dmg_character = "基础伤害: " ,
	cooldown = "冷却: ",
    will_die = "", --same as perish.
    --domest = "Tamed:",
    will_dry = "",
    dmg_bonus = "伤害: ",
	timer = "Timer",
	trade_gold = "价值金子:",
	trade_rock = "价值石头:",
	durability = "耐久度:",
	strength = "力量: ",
	aoe = "群伤: ",
	grow_in = "距离成熟: "
}

SHOWME_STRINGS = {
	loyal = "臣服", --for very loyal pigman with loyalty over 9000
	of = " 属于 ", -- X of Y (reserved)
	units_1 = "1 单位: ",
	units_many = " 单位: ",
	uses_1 = "1 次可使用,总次数 ",
	uses_many = " 次可使用,总次数 ", --X uses of Y, where X > 1
	days = " 天", --Spoil in N days.
}

FOOD_TAGS = { --"dried" and "precook" are excluded.
	veggie = "蔬菜",
	fruit = "水果",
	monster = "怪物肉",
	sweetener = "甜味剂",
	meat = "肉类",
	fish = "鱼类",
	magic = "魔法",
	egg = "蛋类",
	decoration = "鳞翅",
	dairy = "乳制品",
	fat = "油脂",
	inedible = "枝条",
	frozen = "冰",
	seed = "种子",
	
	--Waiter 101
	fungus = "菌类", --all mushroom caps + cutlichen
	mushrooms = "蘑菇", --all mushroom caps
	poultry = "禽肉",
	wings = "翅膀", --about batwing
	seafood = "海鲜",
	nut = "坚果",
	cactus = "仙人掌",
	starch = "淀粉", --about corn, pumpkin, cave_banana
	grapes = "葡萄", --grapricot
	citrus = "柑橘", --grapricot_cooked, limon
	tuber = "块茎", --yamion
	shellfish = "贝类", --limpets, mussel
	
	--BEEFALO MILK and CHEESE mod
	rawmilk = "奶",
	
	--Camp Cuisine: Re-Lunched
	bulb = "荧光果", --lightbulb
	spices = "香料",
	challa = "哈拉面包", -- Challah bread
	flour = "面粉", --flour
	
	--Chocolate
	cacao_cooked = "可可",
}

MY_DATA.uses_of.fn = function(arr)
	--return "可使用次数 " .. arr.param[1] .. "\n总使用次数 " .. arr.param[2]
	return "耐久: " .. arr.param[1] .. " / " .. arr.param[2]
end

UpdateNewLanguage()
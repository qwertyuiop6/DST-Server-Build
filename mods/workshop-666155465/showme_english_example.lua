MY_STRINGS_OVERRIDE =
{ 
	armor = "Armor:" , --A --Armor of the item.
	aggro = "Aggression:" , --B --Score of griefing 
	cookpot = "Probably it will be" , --C (Crock Pot)
	dmg = "Damage:" , --D
	electric = "Electric:" , --E --electric power
	food = "Food:",
	S2="Now it's the summer," , --G
	health= "Health:" , --H --for food
	warm = "Insulation:" , --I --winter insulation
	kill = "Kill:" , --J  --for Canibalism 18 mod (if character murder only once)
	kills = "Kills:" , --K  --for Canibalism 18 mod (shows count of kills)
	loyal = "Loyality:" , --L  --pigman and bunnyman
	S4="Now it's the autumn," , --M
	remaining_days = "Remaining days" , --N
	owner = "Owner:" , --O --support of various mods
	power = "Power:", --P --usually means strengths of a weapon but not physical damage
	hunger= "Hunger:" , --Q
	range = "Range:" , --R  --for range weapon or for mobs
	sanity= "Sanity:" , --S
	thickness = "Thickness:" , --T --It's about thickness of the ice of a pond
	units_of = "units of" , --U
	resist = "Resistance:" , --V --against sleep darts, ice staff etc
	waterproof = "Waterproof:" , --W --Resistance against water
	heal = "Heal:" , --X --How much health will be restored by some medic pack
	fishes = "Fishes:" , --Y  --Count fishes in a pond
	fish = "Fish:" , --Z --Count fishes in a pond if there is only 1 fish
	sec= "Seconds:" ,  --for cooking in Crock Pot
	love = "Love:" , 
	summer = "Summer:" , --summer insulation
	absorb = "Absorb:" , --Absorb damage
	S3="Now it's the spring," , --
	is_admin = "This is the ADMIN!\nHe is out of the game\nso don't touch him." ,
	temperature = "t" ,
	hp= "HP:" , --for characters
	armor_character = "Armor:" , --Armor of the creature or player.
	sanity_character = "Sanity:" , --S	
	fuel = "Fuel:" , --F --for firepit
	speed = "Speed:" , --Bonus of the speed (percent)
	uses_of = "uses of" ,
	obedience = "Obedience:" ,
	S1="Now it's the winter," , 
	dmg_character = "Damage:" ,
	perish = "Spoil in", --P -- Spoil in N days. 
	cooldown="Cooldown:",
	domest = "Tamed:", -- "Domestication:"
	will_die = "Will die in", --will die in N days (saying about pet or animal).
	will_dry = "Will dry in",
	dmg_bonus = "Damage bonus:", -- Damage: +X (means damage modifier, not base damage)
	crop = "", --Not used. It's just a key for info type. Info - "Product: percent"
	grow_in = "Grow in", --About grass etc
	perish_product = "", --Just a key for info type. Info - "Product: time in days"
	just_time = "", --Just a key for info type. Info - [time]
	--Thirst mod
	water = "Water:",
	salt = "Salt:",
	sip = "A sip:",
	watergainspeed = "Water gain speed:",
	water_poisoned = "Is poisoned!",
	
	timer = "Timer",
	trade_gold = 'Gold tribute:',
	trade_rock = 'Rock tribute:',
	durability = 'Durability:',
	strength = 'Strength:',
	aoe = "AoE:",
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

--Food tags are in genitive case.
--For example: "0.5 units of fruit"
FOOD_TAGS = { --"dried" and "precook" are excluded.
	veggie = "",
	fruit = "",
	monster = "",
	sweetener = "",
	meat = "",
	fish = "",
	magic = "",
	egg = "",
	decoration = "",
	dairy = "",
	inedible = "",
	frozen = "",
	seed = "",
	fat = "",
	
	--Waiter 101
	fungus = "", --all mushroom caps + cut lichen
	mushrooms = "", --all mushroom caps
	poultry = "",
	wings = "", --about bat wing
	seafood = "",
	nut = "",
	cactus = "",
	starch = "", --about corn, pumpkin, cave_banana
	grapes = "", --grapricot
	citrus = "", --grapricot_cooked, limon
	tuber = "", --yamion
	shellfish = "", --limpets, mussel
	
	--BEEFALO MILK and CHEESE mod
	rawmilk = "",
	
	--Camp Cuisine: Re-Lunched
	bulb = "", --lightbulb
	spices = "",
	challa = "", -- Challah bread
	flour = "", --flour
	
	--Chocolate
	cacao_cooked == "",
}

UpdateNewLanguage()

--You can add custom aspects of your native language.
--See showme_ru.lua for more details.
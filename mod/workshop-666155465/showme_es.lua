MY_STRINGS_OVERRIDE =
{ 
	armor = "Armadura:" , --A --Armor of the item.
	aggro = "Aggresiòn:" , --B --Score of griefing 
	cookpot = "Será probablemente" , --C (Crock Pot)
	dmg = "Daño:" , --D
	electric = "Eléctrico:" , --E --electric power
	food = "Comida:",
	S2="Ahora estamos en verano," , --G
	health= "Salud:" , --H --for food
	warm = "Aislamiento:" , --I --winter insulation
	kill = "Matar:" , --J  --for Canibalism 18 mod (if character murder only once)
	kills = ">Muertes:" , --K  --for Canibalism 18 mod (shows count of kills)
	loyal = "Lealtad:" , --L  --pigman and bunnyman
	S4="Ahora estamos en Otoño," , --M
	remaining_days = "Días restantes" , --N
	owner = "Dueño:" , --O --support of various mods
	power = "Daño:", --P --usually means strengths of a weapon but not physical damage
	hunger= "Hambre:" , --Q
	range = "Rango:" , --R  --for range weapon or for mobs
	sanity= "Cordura:" , --S
	thickness = "Dureza:" , --T --It's about thickness of the ice of a pond
	units_of = "unidades de" , --U
	resist = "Resistencia:" , --V --against sleep darts, ice staff etc
	waterproof = "A prueba de Agua:" , --W --Resistance against water
	heal = "Sanar:" , --X --How much health will be restored by some medic pack
	fishes = "Peces:" , --Y  --Count fishes in a pond
	fish = "Pez:" , --Z --Count fishes in a pond if there is only 1 fish
	sec= "Segundos:" ,  --for cooking in Crock Pot
	love = "Amor:" , 
	summer = "Verano:" , --summer insulation
	absorb = "Absorber:" , --Absorb damage
	S3="Ahora estamos en verano," , --
	is_admin = "Este es el ADMIN!\nNo está conectado\nasí que no lo toquen." ,
	temperature = "t" ,
	hp= "PS:" , --for characters
	armor_character = "Armadura:" , --Armor of the creature or player.
	sanity_character = "Cordura:" , --S	
	fuel = "Combustible:" , --F --for firepit
	speed = "Velociadad:" , --Bonus of the speed (percent)
	uses_of = "usos de" ,
	obedience = "Obediencia:" ,
	S1="Ahora estamos en Invierno," , 
	dmg_character = "Daño:" ,
	perish = "Caduca en", --P -- Spoil in N days. 
	cooldown="Tiempo de espera:",
	domest = "Domesticado:", -- "Domesticación:"
	will_die = "Se morirá en", --will die in N days (saying about pet or animal).
	will_dry = "Se secará en",
	dmg_bonus = "Daño extra:", -- Damage: +X (means damage modifier, not base damage)
	crop = "sembrado", --Not used. It's just a key for info type. Info - "Product: percent"
	grow_in = "Crecerá en", --About grass etc
	perish_product = "perecerá_producto", --Just a key for info type. Info - "Product: time in days"
	just_time = "tiempo_solamente", --Just a key for info type. Info - [time]
	--Thirst mod
	water = "Agua:",
	salt = "Sal:",
	sip = "Un sorbo:",
	watergainspeed = "Water gain speed:",
	water_poisoned = "Está envenenada!",
	
	timer = "Temporizador",
	trade_gold = 'Tributo en Oro:',
	trade_rock = 'Tributo en Roca:',
	durability = 'Ducación:',
	strength = 'Fuerza:',
	aoe = "AoE:",
}

SHOWME_STRINGS = {
	loyal = "para siempre", --for very loyal pigman with loyalty over 9000
	of = " de ", -- X of Y (reserved)
	units_1 = "Una unidad de ",
	units_many = " unidades de ",
	uses_1 = "Un uso de ",
	uses_many = " usos de ", --X uses of Y, where X > 1
	days = " días", --Spoil in N days.
}

--Food tags are in genitive case.
--For example: "0.5 unidades of fruta"
FOOD_TAGS = { --"seco" and "precocido" are excluded.
	veggie = "vegetales",
	fruit = "frutas",
	monster = "monstruo",
	sweetener = "endulzante",
	meat = "carne",
	fish = "pezcado",
	magic = "mágico",
	egg = "huevo",
	decoration = "decoración",
	dairy = "diario",
	inedible = "incomible",
	frozen = "congelado",
	seed = "semilla",
	fat = "grasa",
	
	--Waiter 101
	fungus = "fungus", --all mushroom caps + cut lichen
	mushrooms = "zetas", --all mushroom caps
	poultry = "pernil de pollo",
	wings = "alas", --about bat wing
	seafood = "comida de mar",
	nut = "maní",
	cactus = "cactus",
	starch = "almidón", --about corn, pumpkin, cave_banana
	grapes = "uvas", --grapricot
	citrus = "cítricos", --grapricot_cooked, limon
	tuber = "tubérculo", --yamion
	shellfish = "crustáceos", --limpets, mussel
	
	--BEEFALO MILK and CHEESE mod
	rawmilk = "leche entera",
	
	--Camp Cuisine: Re-Lunched
	bulb = "bulbo", --lightbulb
	spices = "condimentos",
	challa = "jalá", -- Challah bread
	flour = "harina", --flour
	
	--Chocolate
	cacao_cooked == "cacao cocido",
}

UpdateNewLanguage()

--You can add custom aspects of your native language.
--See showme_ru.lua for more details.
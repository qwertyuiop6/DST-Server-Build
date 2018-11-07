MY_STRINGS_OVERRIDE =
{ 
	armor = "Zbroja:" , --A
	aggro = "Agresja:" , --B --Score of griefing 
	cookpot = "Prawdopodobnie będzie to" , --C (Crock Pot)
	dmg = "Obrażenia:" , --D
	electric = "Elektryczność:" , --E --electric power
	food = "Jedzenie:",
	S2="Nastało lato," , --G
	health= "Zdrowie:" , --H --for food
	warm = "Izolacja:" , --I --winter insulation
	kill = "Morderca:" , --J  --for Canibalism 18 mod (if character murder only once)
	kills = "Zabójstw:" , --K  --for Canibalism 18 mod (shows count of kills)
	loyal = "Lojalność:" , --L  --pigman and bunnyman
	S4="Nastała jesień," , --M
	remaining_days = "Pozostałe dni" , --N
	owner = "Właściciel:" , --O --support of various mods
	power = "Moc:", --P --usually means strengths of a weapon but not physical damage
	hunger= "Głód:" , --Q
	range = "Zasięg:" , --R  --for range weapon or for mobs
	sanity= "Poczytalność:" , --S
	thickness = "Grubość:" , --T --It's about thickness of the ice of a pond
	units_of = "jednostki" , --U
	resist = "Odporność:" , --V --against sleep darts, ice staff etc
	waterproof = "Wodoodporność:" , --W --Resistance against water
	heal = "Leczenie:" , --X --How much health will be restored by some medic pack
	fishes = "Ryby:" , --Y  --Count fishes in a pond
	fish = "Fish:" , --Z --Count fishes in a pond if there is only 1 fish
	sec= "Sekundy:" ,  --for cooking in Crock Pot
	love = "Miłość:" , 
	summer = "Lato:" , --summer insulation
	absorb = "Absorpcja:" , --Absorb damage
	S3="Nastała wiosna," , --
	is_admin = "To ADMIN!\nJest poza grą\nwięc nie dotykaj go." ,
	temperature = "temperatura" ,
	hp= "HP:" , --for characters
	armor_character = "Zbroja:" ,
	sanity_character = "Poczytalność:" , --S	
	fuel = "Paliwo:" , --F --for firepit
	speed = "Prędkość:" , --Bonus of the speed (percent)
	uses_of = "użyć" ,
	obedience = "Posłuszeństwo:" ,
	S1="Nastała zima," ,
	dmg_character = "Obrażenia:" ,
	perish = "Zgnije za" , --P -- Spoil in N days. 
}

SHOWME_STRINGS = {
	loyal = "zawsze", --for very loyal pigman with loyalty over 9000
	of = " z ", -- X of Y (reserved)
	units_1 = "1 sztuka ",
	units_many = " jednostek ",
	uses_1 = "1 użycie ",
	uses_many = " użyć ", --X uses of Y, where X > 1
	days = " dni", --Spoil in N days.
}

--Food tags are in genitive case.
--For example: "0.5 units of fruit"
FOOD_TAGS = { --"dried" and "precook" are excluded.
	veggie = "warzywa",
	fruit = "owocu",
	monster = "potwornego",
	sweetener = "słodzika",
	meat = "mięsa",
	fish = "ryby",
	magic = "magii",
	egg = "jajka",
	decoration = "dekoracji",
	dairy = "nabiału",
	inedible = "niejadalne",
	frozen = "zamrożonego",
	seed = "nasiona",
	fat = "tłuszczu",
	
	--Waiter 101
	fungus = "fungi", --all mushroom caps + cut lichen
	mushrooms = "grzyby", --all mushroom caps
	poultry = "drób",
	wings = "skrzydła", --about bat wing
	seafood = "owoce morza",
	nut = "orzech",
	cactus = "kaktus",
	starch = "skrobia", --about corn, pumpkin, cave_banana
	grapes = "", --grapricot
	citrus = "cytrus", --grapricot_cooked, limon
	tuber = "bulwa", --yamion
	shellfish = "skorupiak", --limpets, mussel
	
	--BEEFALO MILK and CHEESE mod
	rawmilk = "surowe mleko",
	
	--Camp Cuisine: Re-Lunched
	bulb = "żarówka", --lightbulb
	spices = "przyprawy",
	challa = "chałka", -- Challah bread
	flour = "mąka", --flour
	
	--Chocolate
	cacao_cooked == "Prażone ziarna kakaowca",
}


--Polish declension of numerals
local st_tbl = {
	units = {" sztuka "," sztuki "," sztuk "},
	uses = {" użycie z ", " użycia z ", " użyć z "},
	days = {"dzień","dnia","dni"},
}

function StringTime(nn,s)
	local n =  math.floor(GLOBAL.tonumber(nn) or 0)
	local days = st_tbl[s]
	if days then
		local pl_type=n==1 and 1 or(n>=2 and n<=4 and 2 or 3)
		return tostring(nn).." "..days[pl_type]
	else
		return tostring(nn).." "..s --just "N days"
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
	else
		return arr.data.desc .. " " .. tostring(days) .. " " .. st_tbl.days[2]
	end
end

UpdateNewLanguage()


MY_STRINGS_OVERRIDE = {
	hp="체력:", --for characters
	health="체력:", --for food
	hunger="배고픔:",
	sanity="정신력:",
	sec="남은 시간:",
	armor="보호율:",
	dmg="공격력:",
	warm="따뜻함:",
	fuel="연료:",
	range="사거리:",
	speed="속도:",
	resist="저항성:",
	power="파워:",
	loyal="충성 시간:",
	love="호감도:",
	heal="체력:",
	kills="죽인 수:",
	kill="살해:",
	fishes="생선 수:",
	fish="생선 수:",
	owner="주인:",
	thickness="두께:",
	waterproof="방수율:",
	aggro="악행 지수:",
	summer="시원함:",
	absorb="총 보호율:",
	obedience="충성도:",
	perish="썩기까지",
	electric = "전기:" ,
	S2="여름이 오기까지",
	S4="겨울이 오기까지" , 
	remaining_days = "남은 일수:" ,
	S3="가을이 오기까지" ,
	is_admin = "그는 관리자야!\n지금 게임에 있지 않아.\n그러니까 건들면 안 돼." ,
	armor_character = "보호율:" ,
	sanity_character = "정신력:" ,
	S1="봄이 오기까지" , 
	dmg_character = "공격력:" ,
	cooldown = "쿨타임:",
    domest = "길들임:", -- "Domestication:"
    will_die = "죽기까지",
    will_dry = "마르기까지",
    dmg_bonus = "추가 공격력:",
    grow_in = "자라기까지",
	water = "물:",
	salt = "소금:",
	sip = "Sip:",
	watergainspeed = "Water gain speed:",
	water_poisoned = "물 중독!",
	timer = "Timer",
	trade_gold = "금으로의 가치:",
	trade_rock = "돌로의 가치:",
	durability = '내구도:',
	strength = '공격력:',
	--aoe = 'AoE:',
}

SHOWME_STRINGS = {
	loyal = "로얄",
	of = " OF ",
	units_1 = "1개의 ",
	units_many = "개의 ",
	days = "일", --Spoil in N days.
}

FOOD_TAGS = { --"dried" and "precook" are excluded.
	veggie = "야채",
	fruit = "과일",
	monster = "괴물",
	sweetener = "감미료",
	meat = "고기",
	fish = "생선",
	magic = "마법",
	egg = "알",
	decoration = "장식품",
	dairy = "우유",
	inedible = "비식품",
	frozen = "얼음",
	seed = "씨앗",
	fat = "기름",
	
	--Waiter 101
	fungus = "곰팡이", --all mushroom caps + cutlichen
	mushrooms = "버섯", --all mushroom caps
	poultry = "조류",
	wings = "날개", --about batwing
	seafood = "해산물",
	nut = "견과",
	cactus = "선인장",
	starch = "녹말", --about corn, pumpkin, cave_banana
	grapes = "포도", --grapricot
	citrus = "감귤", --grapricot_cooked, limon
	tuber = "덩이줄기", --yamion
	shellfish = "조개", --limpets, mussel
	
	--BEEFALO MILK and CHEESE mod
	rawmilk = "생우유",
	
	--Camp Cuisine: Re-Lunched
	bulb = "전구", --lightbulb
	spices = "양념",
	challa = "할라 빵", -- Challah bread
	flour = "가루", --flour
	
	--Chocolate
	cacao_cooked == "카카오",
}

MY_DATA.uses_of.fn = function(arr)
	return "사용횟수: " .. arr.param[1] .. " / " .. arr.param[2]
end

MY_DATA.cookpot.fn = function(arr)
	return arr.param[1] .. " 요리가 완료되기까지"
end


UpdateNewLanguage()
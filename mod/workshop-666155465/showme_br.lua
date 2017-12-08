local MY_STRINGS_OVERRIDE =
{
    armor = "Protecao:" , --A
    aggro = "Agressividade:" , --B
    cookpot = "Chance de ser" , --C (Crock Pot)
    dmg = "Dano:" , --D
    electric = "Eletrico:" , --E --electric power
    food = "Comida:",
    S2="Agora estamos no verao," , --G
    health= "Vida:" , --H --for food
    warm = "Aquecimento:" , --I --winter insulation
    kill = "Morte:" , --J  --for Canibalism 18 mod
    kills = "Mortes:" , --K  --for Canibalism 18 mod
    loyal = "Lealdade:" , --L  --pigman and bunnyman
    S4="Agora estamos no outono," , --M
    remaining_days = "Dias restantes" , --N
    owner = "Dono:" , --O --support of various mods
    power = "Poder:", --P --usually means strengths of a weapon but not physical damage
    hunger= "Fome:" , --Q
    range = "Alcance:" , --R  --for range weapon or for mobs
    sanity= "Sanidade:" , --S
    thickness = "Grossura:" , --T
    units_of = "unidades de" , --U
    resist = "Resistencia:" , --V --against sleep darts, ice staff etc
    waterproof = "Impermeabilidade:" , --W
    heal = "Cura:" , --X
    fishes = "Peixes:" , --Y  --in a pond
    fish = "Peixe:" , --Z
    sec= "Segundos:" ,  --for cooking in Crock Pot
    love = "Carinho:" ,
    summer = "Verao:" , --summer insulation
    absorb = "Absorcao:" ,
    S3="Agora estamos na primavera," , --
    is_admin = "Este e o ADMIN!\nEle saiu do jogo\nlogo nao toque nele." ,
    temperature = "Temp." ,
    hp= "PV:" , --for characters
    armor_character = "Protecao:" ,
    sanity_character = "Sanidade:" , --S
    fuel = "Combustivel:" , --F --for firepit
    speed = "Velocidade:" ,
    uses_of = "usos de" ,
    obedience = "Obediencia:" ,
    S1="Agora estamos no inverno," ,
    dmg_character = "Dano:" ,
    perish = "Estraga em" , --P -- Spoil in N days.
}
 
SHOWME_STRINGS = {
    loyal = "eterna", --for very loyal pigman with loyalty over 9000
    of = " de ", -- X of Y (reserved)
    units_1 = "1 unidade de ",
    units_many = " unidades de ",
    uses_1 = "1 uso de ",
    uses_many = " usos de ", --X uses of Y, where X > 1
    days = " dias", --Spoil in N days.
}
 
FOOD_TAGS = { --"dried" and "precook" are excluded.
    veggie = "Vegetal",
    fruit = "Fruta",
    monster = "Monstro",
    sweetener = "Adocante",
    meat = "Carne",
    fish = "Peixe",
    magic = "Magica",
    egg = "Ovo",
    decoration = "Decoracao",
    dairy = "Laticinio",
    inedible = "Intragavel",
    frozen = "Congelado",
    seed = "Semente",
   
    --Waiter 101
    fungus = "fungo", --all mushroom caps + cutlichen
    mushrooms = "cogumelos", --all mushroom caps
    poultry = "aves",
    wings = "asas", --about batwing
    seafood = "frutos do mar",
    nut = "noz",
    cactus = "cacto",
    starch = "amido", --about corn, pumpkin, cave_banana
    grapes = "videira", --grapricot
    citrus = "citrico", --grapricot_cooked, limon
    tuber = tuberculo"", --yamion
    shellfish = "marisco", --limpets, mussel
   
    --BEEFALO MILK and CHEESE mod
    rawmilk = "lei fresco",
   
    --Camp Cuisine: Re-Lunched
    bulb = "bulbo", --lightbulb
    spices = "temperos",
    challa = "chala", -- Challah bread
    flour = "farinha", --flour
   
    --Chocolate
    cacao_cooked == "Chocolate",
}

UpdateNewLanguage()
 
--You can add custom aspects of your native language.
--See showme_ru.lua for more details.
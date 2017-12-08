local Layouts = GLOBAL.require("map/layouts").Layouts
local StaticLayout = GLOBAL.require("map/static_layout")

--traps
Layouts["Chilled Base"] = StaticLayout.Get("map/static_layouts/trap_winter")
Layouts["Chilled Decid Base"] = StaticLayout.Get("map/static_layouts/trap_winter_deciduous")
Layouts["Hot Base"] = StaticLayout.Get("map/static_layouts/trap_summer")
Layouts["Dev Graveyard"] = StaticLayout.Get("map/static_layouts/dev_graveyard")
Layouts["Sleeping Spider"] = StaticLayout.Get("map/static_layouts/trap_sleepingspider")
Layouts["Rotted Base"] = StaticLayout.Get("map/static_layouts/trap_spoilfood")
Layouts["Beefalo Farm"] = StaticLayout.Get("map/static_layouts/beefalo_farm")
Layouts["Ice Hounds"] = StaticLayout.Get("map/static_layouts/trap_icestaff")
Layouts["Fire Hounds"] = StaticLayout.Get("map/static_layouts/trap_firestaff")
--protected resources
Layouts["leif_forest"] = StaticLayout.Get("map/static_layouts/leif_forest")
Layouts["spider_forest"] = StaticLayout.Get("map/static_layouts/spider_forest")
Layouts["pigguard_berries"] = StaticLayout.Get("map/static_layouts/pigguard_berries")
Layouts["pigguard_berries_easy"] = StaticLayout.Get("map/static_layouts/pigguard_berries_easy")
Layouts["wasphive_grass_easy"] = StaticLayout.Get("map/static_layouts/wasphive_grass_easy")
Layouts["hound_rocks"] = StaticLayout.Get("map/static_layouts/hound_rocks")
Layouts["tenticle_reeds"] = StaticLayout.Get("map/static_layouts/tenticle_reeds")
Layouts["tallbird_rocks"] = StaticLayout.Get("map/static_layouts/tallbird_rocks")
Layouts["pigguard_grass"] = StaticLayout.Get("map/static_layouts/pigguard_grass") 	
Layouts["pigguard_grass_easy"] = StaticLayout.Get("map/static_layouts/pigguard_grass_easy")
--points of interest
Layouts["skeleton_dapper"] = StaticLayout.Get("map/static_layouts/skeleton_dapper")
Layouts["skeleton_researchlab1"] = StaticLayout.Get("map/static_layouts/skeleton_researchlab1")
Layouts["skeleton_researchlab2"] = StaticLayout.Get("map/static_layouts/skeleton_researchlab2")
Layouts["skeleton_researchlab3"] = StaticLayout.Get("map/static_layouts/skeleton_researchlab3")
Layouts["skeleton_trapper"] = StaticLayout.Get("map/static_layouts/skeleton_trapper")
Layouts["skeleton_entomologist"] = StaticLayout.Get("map/static_layouts/skeleton_entomologist")
Layouts["skeleton_farmer"] = StaticLayout.Get("map/static_layouts/skeleton_farmer")
Layouts["grass_spots"] = StaticLayout.Get("map/static_layouts/grass_spots")
Layouts["skeleton_miner_dirt"] = StaticLayout.Get("map/static_layouts/skeleton_miner_dirt")	
Layouts["skeleton_hunter_swamp"] = StaticLayout.Get("map/static_layouts/skeleton_hunter_swamp")
Layouts["skeleton_miner"] = StaticLayout.Get("map/static_layouts/skeleton_miner")
Layouts["skeleton_camper"] = StaticLayout.Get("map/static_layouts/skeleton_camper")
Layouts["skeleton_hunter"] = StaticLayout.Get("map/static_layouts/skeleton_hunter")
Layouts["skeleton_miner"] = StaticLayout.Get("map/static_layouts/skeleton_miner")
Layouts["skeleton_miner"] = StaticLayout.Get("map/static_layouts/skeleton_miner")
Layouts["skeleton_batfight"] = StaticLayout.Get("map/static_layouts/skeleton_batfight")
Layouts["skeleton_lightfarmer"] = StaticLayout.Get("map/static_layouts/skeleton_lightfarmer")
Layouts["skeleton_entomologist"] = StaticLayout.Get("map/static_layouts/skeleton_entomologist")
Layouts["skeleton_farmer"] = StaticLayout.Get("map/static_layouts/skeleton_farmer")
Layouts["skeleton_wizard_ice"] = StaticLayout.Get("map/static_layouts/skeleton_wizard_ice")
Layouts["skeleton_wizard_fire"] = StaticLayout.Get("map/static_layouts/skeleton_wizard_fire")
Layouts["skeleton_warrior"] = StaticLayout.Get("map/static_layouts/skeleton_warrior")
Layouts["skeleton_construction"] = StaticLayout.Get("map/static_layouts/skeleton_construction")
Layouts["skeleton_fisher"] = StaticLayout.Get("map/static_layouts/skeleton_fisher")
Layouts["skeleton_graverobber"] = StaticLayout.Get("map.static_layouts/skeleton_graverobber")
Layouts["skeleton_night_hunter"] = StaticLayout.Get("map/static_layouts/skeleton_night_hunter")
Layouts["skeleton_summer"] = StaticLayout.Get("map/static_layouts/skeleton_summer")
Layouts["skeleton_rain_coat"] = StaticLayout.Get("map/static_layouts/skeleton_rain_coat")
Layouts["skeleton_lumberjack"] = StaticLayout.Get("map/static_layouts/skeleton_lumberjack")
Layouts["skeleton_researchlab1"] = StaticLayout.Get("map/static_layouts/skeleton_researchlab1")
Layouts["skeleton_researchlab2"] = StaticLayout.Get("map/static_layouts/skeleton_researchlab2")
Layouts["skeleton_researchlab3"] = StaticLayout.Get("map/static_layouts/skeleton_researchlab3")

local _TR_override = GetModConfigData("_TR_override")
local _POI_override = GetModConfigData("_POI_override")
local _PR_override = GetModConfigData("_PR_override")
local _REEDS_override = GetModConfigData("_REEDS_override")

local traps = 
{
	[1] = {name = "Dev_Graveyard",count = 0},
	[2] = {name = "Sleeping_Spider",count = 0},
	[3] = {name = "Chilled_Base",count = 0},
	[4] = {name = "Chilled_Decid_Base",count = 0},
	[5] = {name = "Rotted_Base",count = 0},
	[6] = {name = "Hot_Base",count = 3},
	[7] = {name = "Beefalo_Farm",count = 0},
	[8] = {name = "Fire_Hounds",count = 0},
	[9] = {name = "Ice_Hounds",count = 0},
}

local protectedresources = 
{
	[1] = {name = "leif_forest",count = 0},
	[2] = {name = "spider_forest",count = 0},
	[3] = {name = "pigguard_berries",count = 0},
	[4] = {name = "pigguard_berries_easy",count = 0},
	[5] = {name = "wasphive_grass_easy",count = 0},
	[6] = {name = "tenticle_reeds",count = 0},
	[7] = {name = "tallbird_rocks",count = 0},
	[8] = {name = "pigguard_grass_easy",count = 0},
	[9] = {name = "leif_forest",count = 0},
	[10] = {name = "lures_and_worms",count = 0},
	[11] = {name = "hound_rocks",count = 0},

}

local pointsofinterest = 
{
	[1] = {name = "skeleton_rain_coat",count = 0},
	[2] = {name = "skeleton_summer",count = 0},
	[3] = {name = "skeleton_night_hunter",count = 0},
	[4] = {name = "skeleton_graverobber",count = 0},
	[5] = {name = "skeleton_fisher",count = 0},
	[6] = {name = "skeleton_construction",count = 0},
	[7] = {name = "skeleton_warrior",count = 0},
	[8] = {name = "skeleton_wizard_fire",count = 0},
	[9] = {name = "skeleton_wizard_ice",count = 0},
	[10] = {name = "skeleton_cave_farmer",count = 0},
	[11] = {name = "skeleton_cave_entomologist",count = 0},
	[12] = {name = "skeleton_cave_lumberjack",count = 0},
	[13] = {name = "skeleton_cave_lightfarmer",count = 0},
	[14] = {name = "skeleton_cave_batfight",count = 0},
	[15] = {name = "skeleton_hunter",count = 0},
	[16] = {name = "skeleton_hunter_swamp",count = 0},
	[17] = {name = "skeleton_miner",count = 0},
	[18] = {name = "skeleton_miner_dirt",count = 0},
	[19] = {name = "pigguard_grass_easy",count = 0},
	[20] = {name = "grass_spots",count = 0},
	[21] = {name = "skeleton_farmer",count = 0},
	[22] = {name = "skeleton_entomologist",count = 0},
	[23] = {name = "skeleton_trapper",count = 0},
	[24] = {name = "skeleton_lumberjack",count = 0},
	[25] = {name = "skeleton_researchlab1",count = 0},
	[26] = {name = "skeleton_researchlab2",count = 0},
	[27] = {name = "skeleton_researchlab3",count = 0},
	[28] = {name = "skeleton_dapper",count = 0},
}

local task_forest_any = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!", "Speak to the king", "Forest hunters", "Befriend the pigs", "For a nice walk", "Kill the spiders", "Killer bees!", "Make a Beehat", "The hunters", "Magic meadow", "Frogs and bugs", "Badlands"}
local task_forest_swamp = {"Squeltch","Lots-o-Spiders","Lots-o-Tentacles","Merms ahoy"}
local task_forest_desert = {"Badlands","Oasis",}
local task_forest_grasslands = {"Waspy Beeeees!","For a nice walk","Frogs and bugs","Magic meadow","Make a Beehat","Killer bees!","Wasps and Frogs and bugs","Killer bees!",}
local task_forest_deciduous = {"Speak to the king","Mole Colony Deciduous",}
local task_forest_rocky = {"Mole Colony Rocks","Dig that rock","The hunters",}
local task_forest_savannah = {"Great Plains","Greater Plains"}
local task_forest_forest = {"The Deep Forest","Befriend the pigs","Kill the spiders","Forest hunters",}

local over_ride = 0
local rand = GLOBAL.os.time()

if _TR_override > 0 then	
	for TR = 1, _TR_override do
		rand = rand + 30
		math.randomseed(rand)
		math.random(rand)
		over_ride = math.random(1,#traps)
		traps[over_ride].count = traps[over_ride].count + 1
	end
end

if _POI_override > 0 then
	for POI = 1, _POI_override do
		rand = rand + 30
		math.randomseed(rand)
		math.random(rand)
		over_ride = math.random(1,#pointsofinterest)
		pointsofinterest[over_ride].count = pointsofinterest[over_ride].count + 1
	end
end

if _PR_override > 0 then
	for PR = 1, _PR_override do
		rand = rand + 30
		math.randomseed(rand)
		math.random(rand)
		over_ride = math.random(1,#protectedresources)
		protectedresources[over_ride].count = protectedresources[over_ride].count + 1
	end
end

if _REEDS_override ~= 0 then
	protectedresources[6].count = _REEDS_override
end

AddSetPiecePreInitAny = function(name, count, tasks)
	AddLevelPreInitAny(function(level)

		if level.location ~= "forest" then
			return
		end

		if not level.set_pieces then
			level.set_pieces = {}
		end
		level.set_pieces[name] = { count = count, tasks = tasks }
	end)
end

--traps
AddSetPiecePreInitAny("Dev Graveyard",traps[1].count,task_forest_any)
AddSetPiecePreInitAny("Sleeping Spider",traps[2].count,task_forest_forest)
AddSetPiecePreInitAny("Chilled Base",traps[3].count,task_forest_forest)
AddSetPiecePreInitAny("Chilled Decid Base",traps[4].count,task_forest_grasslands)
AddSetPiecePreInitAny("Rotted Base",traps[5].count,task_forest_swamp)
--AddSetPiecePreInitAny("Hot Base",traps[6].count,task_forest_desert)
AddSetPiecePreInitAny("Beefalo Farm",traps[7].count,task_forest_savannah)
AddSetPiecePreInitAny("Fire Hounds",traps[8].count,task_forest_any)
AddSetPiecePreInitAny("Ice Hounds",traps[9].count,task_forest_any)
--protected resources
AddSetPiecePreInitAny("leif_forest",protectedresources[1].count,task_forest_any)
AddSetPiecePreInitAny("spider_forest",protectedresources[2].count,task_forest_forest)
AddSetPiecePreInitAny("pigguard_berries",protectedresources[3].count,task_forest_grasslands)
AddSetPiecePreInitAny("pigguard_berries_easy",protectedresources[4].count,task_forest_grasslands)
AddSetPiecePreInitAny("wasphive_grass_easy",protectedresources[5].count,task_forest_grasslands)
AddSetPiecePreInitAny("tenticle_reeds",protectedresources[6].count,task_forest_swamp)
AddSetPiecePreInitAny("tallbird_rocks",protectedresources[7].count,task_forest_rocky)
AddSetPiecePreInitAny("pigguard_grass",protectedresources[8].count,task_forest_savannah)
AddSetPiecePreInitAny("pigguard_grass_easy",protectedresources[9].count,task_forest_savannah)
AddSetPiecePreInitAny("hound_rocks",protectedresources[11].count,task_forest_rocky)
--points of interest
AddSetPiecePreInitAny("skeleton_rain_coat",pointsofinterest[1].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_summer",pointsofinterest[2].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_night_hunter",pointsofinterest[3].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_graverobber",pointsofinterest[4].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_fisher",pointsofinterest[5].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_construction",pointsofinterest[6].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_warrior",pointsofinterest[7].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_wizard_fire",pointsofinterest[8].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_wizard_ice",pointsofinterest[9].count,task_forest_any)
AddSetPiecePreInitAny("skeleton_hunter",pointsofinterest[15].count,task_forest_forest)
AddSetPiecePreInitAny("skeleton_hunter_swamp",pointsofinterest[16].count,task_forest_grasslands)
AddSetPiecePreInitAny("skeleton_miner",pointsofinterest[17].count,task_forest_grasslands)
AddSetPiecePreInitAny("skeleton_miner_dirt",pointsofinterest[18].count,task_forest_grasslands)
AddSetPiecePreInitAny("grass_spots",pointsofinterest[20].count,task_forest_swamp)
AddSetPiecePreInitAny("skeleton_farmer",pointsofinterest[21].count,task_forest_rocky)
AddSetPiecePreInitAny("skeleton_entomologist",pointsofinterest[22].count,task_forest_savannah)
AddSetPiecePreInitAny("skeleton_trapper",pointsofinterest[23].count,task_forest_savannah)
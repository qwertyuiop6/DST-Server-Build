name = "Enhanced Houndius Shootius"
description = 
	[[
		Think Houndius Shootius is too weak when besieged by plenty of other creatures?
		Now, everyone can enhance the Houndius Shootius with this mod.
		You can change the damage, health, health regen rate and attack period of Houndius Shootius. 
		Defaultly, these values are not changed, so you need to customize it in the configuration tab.
		In additon, the Houndius Shootius that is deployed can turn into Houndius Shootius item, which makes it movable.
		And when destroyed, it can drop Houndius Shootius item on the ground so that you can redeploy it.
		Both of the function is defaultly enabled, you can disable it in the configuration tab.
	]]
author = "Jupiter Su"
version = "1.0"
forumthread = ""
api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
restart_required = false
standalone = false
icon_atlas = "modicon.xml"
icon = "modicon.tex"

----------------------
-- General settings --
----------------------

configuration_options =
{
	{
		name = "movable",
		label = "Movable",
		hover = "Configure whether you want the Houndius Shootius movable after deployed.",
		options =	{
						{description = "On", data = 1, hover = ""},
						{description = "Off", data = 0, hover = ""},
					},
		default = 0,
	},
	{
		name = "droppable",
		label = "Droppable",
		hover = "Configure whether you want the Houndius Shootius to drop Houndius Shootius item after destroyed.",
		options =	{
						{description = "On", data = 1, hover = ""},
						{description = "Off", data = 0, hover = ""},
					},
		default = 1,
	},
	{
		name = "eyeturret_damage",
		label = "Damage",
		hover = "Configure Houndius Shootius' Damage.",
		options =	{
						{description = "65(default)", data = 65, hover = ""},
						{description = "70", data = 70, hover = ""},
						{description = "75", data = 75, hover = ""},
						{description = "80", data = 80, hover = ""},
						{description = "85", data = 85, hover = ""},
						{description = "90", data = 90, hover = ""},
						{description = "95", data = 95, hover = ""},
						{description = "100", data = 100, hover = ""},
						{description = "150", data = 150, hover = ""},
						{description = "200", data = 200, hover = ""},
						{description = "30", data = 30, hover = ""},
					},
		default = 100,
	},
	{
		name = "eyeturret_health",
		label = "Health",
		hover = "Configure Houndius Shootius' Health.",
		options =	{
						{description = "1000(default)", data = 1000, hover = ""},
						{description = "1250", data = 1250, hover = ""},
						{description = "1500", data = 1500, hover = ""},
						{description = "1750", data = 1750, hover = ""},
						{description = "2000", data = 2000, hover = ""},
						{description = "2250", data = 2250, hover = ""},
						{description = "2500", data = 2500, hover = ""},
						{description = "2750", data = 2750, hover = ""},
						{description = "3000", data = 3000, hover = ""},
						{description = "3500", data = 3500, hover = ""},
						{description = "4000", data = 4000, hover = ""},
						{description = "5000", data = 5000, hover = ""},
					},
		default = 2000,
	},
	{
		name = "eyeturret_regen",
		label = "Health Regen",
		hover = "Configure Houndius Shootius' Health Regen(per second).",
		options =	{
						{description = "12(default)", data = 12, hover = ""},
						{description = "15", data = 15, hover = ""},
						{description = "20", data = 20, hover = ""},
						{description = "25", data = 25, hover = ""},
						{description = "30", data = 30, hover = ""},
						{description = "35", data = 35, hover = ""},
						{description = "40", data = 40, hover = ""},
						{description = "45", data = 45, hover = ""},
						{description = "50", data = 50, hover = ""},
					},
		default = 30,
	},
	{
		name = "eyeturret_range",
		label = "Attack Range",
		hover = "Configure Houndius Shootius' Attack Range.",
		options =	{
						{description = "15(default)", data = 15, hover = ""},
						{description = "20", data = 20, hover = ""},
						{description = "25", data = 25, hover = ""},
						{description = "30", data = 30, hover = ""},
					},
		default = 30,
	},
	{
		name = "eyeturret_attack_period",
		label = "Attack Period",
		hover = "Configure Houndius Shootius' Attack Period.",
		options =	{
						{description = "3s(default)", data = 3, hover = ""},
						{description = "2s", data = 2, hover = ""},
						{description = "1s", data = 1, hover = ""},
						{description = "0.5s", data = 0.5, hover = ""},
						{description = "0.1s", data = 0.1, hover = ""},
					},
		default = 1,
	},
}
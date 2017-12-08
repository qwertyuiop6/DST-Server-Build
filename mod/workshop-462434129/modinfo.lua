name = "Restart"
author = "Skull & Orange"
version = "0.3.2"
forumthread = "" -- http://steamcommunity.com/sharedfiles/filedetails/?id=462434129
api_version = 10
priority = -77
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = false
server_filter_tags = { "Restart" }

icon_atlas = "modicon.xml"
icon = "modicon.tex"

description = [[Server side MOD.
Enter the following command after press Y(Say) or U(Whisper):
#restart (Re select your character)
#restart_d (Drop all items and Re select your character)
#resurrect (You will get a new life.)
#kill (Kill youself)
]]

configuration_options = {
	{
		name = "MOD_RESTART_IGNORING_ADMIN",
		label = "Ignoring Admin",
		hover = "Admin can use this all the time.",
		options =
		{
			{ description = "On", data = true },
			{ description = "Off", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESTART",
		label = "Allow Restart",
		options =
		{
			{ description = "On", data = true },
			{ description = "Off", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESURRECT",
		label = "Allow Resurrect",
		options =
		{
			{ description = "On", data = true },
			{ description = "Off", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_KILL",
		label = "Allow Kill",
		options =
		{
			{ description = "On", data = true },
			{ description = "Off", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_CD_RESTART",
		label = "Restart Interval (min)",
		hover = "Restart Cooldown.",
		options =
		{
			{ description = "None", data = 0, hover = "Unlimited" },
			{ description = "1", data = 1, hover = "1 min" },
			{ description = "2", data = 2, hover = "2 min" },
			{ description = "3", data = 3, hover = "3 min" },
			{ description = "5", data = 5, hover = "5 min" },
			{ description = "7", data = 7, hover = "7 min" },
			{ description = "10", data = 10, hover = "10 min" },
		},
		default = 5,
	},
	{
		name = "MOD_RESTART_CD_RESURRECT",
		label = "Resurrect Interval (min)",
		hover = "Resurrect Cooldown.",
		options =
		{
			{ description = "None", data = 0, hover = "Unlimited" },
			{ description = "1", data = 1, hover = "1 min" },
			{ description = "2", data = 2, hover = "2 min" },
			{ description = "3", data = 3, hover = "3 min" },
			{ description = "5", data = 5, hover = "5 min" },
			{ description = "7", data = 7, hover = "7 min" },
			{ description = "10", data = 10, hover = "10 min" },
		},
		default = 3,
	},
	{
		name = "MOD_RESTART_CD_KILL",
		label = "Kill Interval (min)",
		hover = "Kill Cooldown.",
		options =
		{
			{ description = "None", data = 0, hover = "Unlimited" },
			{ description = "1", data = 1, hover = "1 min" },
			{ description = "2", data = 2, hover = "2 min" },
			{ description = "3", data = 3, hover = "3 min" },
			{ description = "5", data = 5, hover = "5 min" },
			{ description = "7", data = 7, hover = "7 min" },
			{ description = "10", data = 10, hover = "10 min" },
		},
		default = 3,
	},
	{
		name = "MOD_RESTART_CD_BONUS",
		label = "Interval Bonus",
		hover = "Cooling time will increase per use?",
		options =
		{
			{ description = "Off", data = 0, hover = "Cooling time will not change" },
			{ description = "10%", data = 0.1, hover = "Increase after each use (base value's) 10%" },
			{ description = "20%", data = 0.2, hover = "Increase after each use (base value's) 20%" },
			{ description = "30%", data = 0.3, hover = "Increase after each use (base value's) 30%" },
			{ description = "40%", data = 0.4, hover = "Increase after each use (base value's) 40%" },
			{ description = "50%", data = 0.5, hover = "Increase after each use (base value's) 50%" },
			{ description = "100%", data = 1, hover = "Increase after each use (base value's) 100%" },
			{ description = "150%", data = 1.5, hover = "Increase after each use (base value's) 150%" },
			{ description = "200%", data = 2, hover = "Increase after each use (base value's) 200%" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_CD_MAX",
		label = "Max Interval (min)",
		hover = "Max Cooling time if 'Interval Bonus' works.",
		options =
		{
			{ description = "None", data = 0, hover = "Max Cooling time is no limited" },
			{ description = "10", data = 10, hover = "10 min" },
			{ description = "15", data = 15, hover = "15 min" },
			{ description = "20", data = 20, hover = "20 min" },
			{ description = "25", data = 25, hover = "25 min" },
			{ description = "30", data = 30, hover = "30 min" },
			{ description = "45", data = 45, hover = "45 min" },
			{ description = "60", data = 60, hover = "60 min" },
			{ description = "75", data = 75, hover = "75 min" },
			{ description = "90", data = 90, hover = "90 min" },
			{ description = "105", data = 105, hover = "105 min" },
			{ description = "120", data = 120, hover = "120 min" },
			{ description = "180", data = 180, hover = "180 min" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_FORCE_DROP_MODE",
		label = "Force Drop All",
		hover = "Restart whether to Force Drop All.",
		options =
		{
			{ description = "Default", data = 0, hover = "Default" },
			{ description = "Force Drop", data = 1, hover = "Restart will Drop Everything" },
			{ description = "Don't Force Drop", data = 2, hover = "Restart will not Drop Everything" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_MAP_SAVE",
		label = "Map Data",
		hover = "Restart whether to save the map data.",
		options =
		{
			{ description = "On", data = 1, hover = "You will not forget the map" },
			{ description = "Off", data = 2, hover = "The memory is gone" },
		},
		default = 2,
	},
	{
		name = "MOD_RESTART_RESURRECT_HEALTH",
		label = "Resurrect Health",
		hover = "After resurrection you will get some health.",
		options =
		{
			{ description = "Default", data = 0, hover = "Get Default health(Only 50)" },
			{ description = "Reduce", data = 1, hover = "Get health Less and less(min: 40%)" },
			{ description = "Random", data = 2, hover = "Get random health(10% ~ 100%)" },
			{ description = "100%", data = 100, hover = "Get 100% of max health" },
			{ description = "90%", data = 90, hover = "Get 90% of max health" },
			{ description = "80%", data = 80, hover = "Get 80% of max health" },
			{ description = "70%", data = 70, hover = "Get 70% of max health" },
			{ description = "60%", data = 60, hover = "Get 60% of max health" },
			{ description = "50%", data = 50, hover = "Get 50% of max health" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_TRIGGER_MODE",
		label = "Chat mode",
		hover = "Say or Whisper to use commands.",
		options =
		{
			{ description = "Say & Whisper", data = 1 },
			{ description = "Only Say", data = 2 },
			{ description = "Only Whisper", data = 3 },
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS",
		label = "Welcome Tips",
		hover = "Tell player first join the server how to use this mod.",
		options =
		{
			{ description = "On", data = true },
			{ description = "Off", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS_TIME",
		label = "Tips time",
		hover = "How long the tips will last.",
		options =
		{
			{ description = "4", data = 4 },
			{ description = "5", data = 5 },
			{ description = "6", data = 6 },
			{ description = "7", data = 7 },
			{ description = "8", data = 8 },
			{ description = "9", data = 9 },
			{ description = "10", data = 10 },
			{ description = "11", data = 11 },
			{ description = "12", data = 12 },
		},
		default = 6,
	},
}

name = "Setpiece Config"
description = "Configure Setpiece Generation"

author = "Joeshmocoolstuff"
version = "1.6"
forumthread = ""
api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"
all_clients_require_mod = false
client_only_mod = false
dst_compatible = true
server_filter_tags = {}

configuration_options =
{
	{
        name = "_TR_override",
        label = "Traps",
		hover = "Traps include:\
				Ice Hounds\
				Fire Hounds\
				Beefalo Pen\
				Rotted Base\
				Developer Graveyard\
				Sleeping Spider",
        options = 
        {
            {description = "None", data = 0},
            {description = "Default", data = 1},
            {description = "More", data = 3},
            {description = "Lots", data = 7},
            {description = "Most", data = 13},
        },
        default = 3,
    },
	{
        name = "_POI_override",
        label = "Points of Interest",
		hover = "Points of Interest include:\
				Grass Spots\
				Skeleton Miner\
				Skeleton Camper\
				Skeleton Trapper\
				Lots more themed skeletons. Too many to list here.",
        options = 
        {
            {description = "None", data = 0},
            {description = "Default", data = 1},
            {description = "More", data = 3},
            {description = "Lots", data = 7},
            {description = "Most", data = 13},
        },
        default = 3,
    },
	{
        name = "_PR_override",
        label = "Protected Resources",
		hover = "Protected Resources include:\
				Reed Trap\
				Hound Fortress\
				Tallbird Fort\
				Various Pig Torch Sets\
				Spider Queens' Gathering\
				Treeguard Gathering\
				Wasp Hives in Grass",
        options = 
        {
            {description = "None", data = 0},
            {description = "Default", data = 1},
            {description = "More", data = 3},
            {description = "Lots", data = 7},
            {description = "Most", data = 13},
        },
        default = 3,
    },
	{
        name = "_REEDS_override",
        label = "Reed Trap",
        options = 
        {
            {description = "Default", data = 0},
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
        },
        default = 2,
    },
}
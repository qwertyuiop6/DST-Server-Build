-- information about the mod
version = "0.36"
version_compatible = "0.30"
name = "Show Me"
author = "Star"
forumthread = ""
description = version --"" --GAMELANGUAGE=="RU"
	--and "Рассказывает о предметах и существах после действия \"Осмотреть\"."
	--or "Shows various info about creatures and items on \"inspect\" action."

-- custom icon
icon_atlas = "preview.xml"
icon = "preview.tex"

dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true

all_clients_require_mod=true
client_only_mod=false
--server_only_mod=true

api_version = 10
priority = 0.00666155465 --Priority does not matter.
--russian_icon = true

server_filter_tags = {"show"}


configuration_options =
{
    --[[{
        name = "message_style",
        label = "Style",
        options = 
        {
            {description = "Isolation ->", data = 1},
            {description = "isolation ->", data = 2},
            {description = "Isol ->", data = 3},
            {description = "isol ->", data = 4}, 
            {description = "<- Warm", data = 5}, 
            {description = "<- warm", data = 6}, 
        }, 
        default = 1,
    },--]]
	{
        name = "food_style",
        label = "Food Style",
        options = 
        {
            {description = "undefined", data = 0, hover = "?"},
            {description = "long", data = 1, hover = "Hunger: +12.5 / Sanity: -10 / Health: +3"},
            {description = "short", data = 2, hover = "+12.5 / -10 / +3"},
        }, 
        default = 0,
    },
	{
        name = "food_order",
        label = "Food Properties Order",
        options = 
        {
            {description = "undefined", data = 0, hover = "?"},
            {description = "interface", data = 1, hover = "Hunger / Sanity / Health"},
            {description = "wikia", data = 2, hover = "Health / Hunger / Sanity"},
        }, 
        default = 0,
    },
	{
        name = "food_estimation",
        label = "Estimate Stale Status",
		hover = "Should we estimate the stale status?",
        options = 
        {
            {description = "undefined", data = -1, hover = "Yes"},
            {description = "No", data = 0, hover = "No"},
            {description = "Yes", data = 1, hover = "Yes"},
        }, 
        default = -1,
    },
	{
        name = "show_food_units",
        label = "Show Food Units",
		hover = "For example, units of meat, units of veggie etc.",
        options = 
        {
            {description = "undefined", data = -1, hover = "Yes"},
            {description = "No", data = 0, hover = "No"},
            {description = "Yes", data = 1, hover = "Yes"},
			{description = "Forbidden", data = 2, hover = "Server won't send food info to clients\nand their settings will not matter."},
        }, 
        default = -1,
    },
	{
        name = "lang",
        label = "Language",
		--hover = "",
        options = 
        {
            {description = "Auto", data = "auto", hover = "Detect Language Pack"},
            {description = "en", data = "en", hover = "English"},
            {description = "ru", data = "ru", hover = "Russian"},
            {description = "chs", data = "chs", hover = "Simplified Chinese"},
            {description = "cht", data = "cht", hover = "Traditional Chinese"},
            {description = "br", data = "br", hover = "Brazilian Portuguese"},
            {description = "pl", data = "pl", hover = "Polish"},
            {description = "kr", data = "kr", hover = "Korean"},
            {description = "es", data = "es", hover = "Spanish"},
        }, 
        default = "auto",
    },
}





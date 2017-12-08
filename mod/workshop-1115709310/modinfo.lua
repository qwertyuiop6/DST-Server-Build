name =
[[ 简单经济学Simple Economy
]]
description =
[[Implemented a new shopping system, where players can now earn gold in game.
Use dedicated items to earn gold.
Click on the icon at the top left corner to open the shop interface, and use gold to buy items.
Rare items will be reshuffled every 3 days in the morning.
Prices will vary seasonally.
]]
author = "柴柴"
version = "1.3.2"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true


icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {}

configuration_options =
{
    {
        name = "Language",
        label = "Language",
        options =   {
                        {description = "English", data = false},
                        {description = "Chinese", data = true},
                    },
        default = true,
    },
    {
        name = "Disintegrate",
        label = "Disintegrate",
        options =   {
                        {description = "No", data = false, hover = "Not allow to use Midas Wand to disintegrate something.".."\n".."It can only gain gold by killing a mob with low health"},
                        {description = "Yes", data = true, hover = "Allow to use Midas Wand to disintegration something"},
                    },
        default = true,
    },
}
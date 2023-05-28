KLEI     1 return {
    --地上世界配置，参考worldgenoverride.lua文件里的选项
    override_enabled = true,
    worldgen_preset = "ENDLESS",
    settings_preset = "ENDLESS",
    overrides = {
        ["frograin"] = "never",
        ["hunt"] = "often",
        ["krampus"] = "often",
        ["regrowth"] = "veryslow",
--         ["specialevent"] = "winters_feast", --特殊事件
        ["world_size"] = "medium", --世界大小
        ["wormattacks"] = "rare",
    },
}
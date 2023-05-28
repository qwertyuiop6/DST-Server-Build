KLEI     1 return {
    --洞穴世界配置，参考worldgenoverride.lua文件里的选项
	override_enabled = true,
	worldgen_preset = "DST_CAVE",
	settings_preset = "DST_CAVE",
	overrides = {
		["basicresource_regrowth"] = "always",
		["frograin"] = "rare",
		["ghostsanitydrain"] = "none",
		["portalresurection"] = "always",
		["regrowth"] = "slow",
		["resettime"] = "none",
		["specialevent"] = "", --特殊事件
		["start_location"] = "default",
		["wormattacks"] = "rare",
	},
}
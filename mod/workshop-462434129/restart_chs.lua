MY_STRINGS_OVERRIDE = {
	welcome_msg = {
		"按 Y(公聊) 或者 U(私聊) 输入指令:",
		"按 Y(公聊) 输入指令:",
		"按 U(私聊) 输入指令:",
	},
	allow_msg = {
		"#restart / #重生 (冷却: %d 秒, 重生换角色)",
		"#restart_d / ##重生 (冷却: %d 秒, 重生并掉落物品)",
		"#resurrect / #复活 / #復活 (冷却: %d 秒, 角色复活)",
		"#kill / #自杀 / #自殺 (冷却: %d 秒, 角色自杀)",
	},
	force_drop_msg = {
		"重生必定掉落道具",
		"重生不会掉落道具",
	},
	map_save_msg = {
		"重生将保留探索过的地图",
		"重生不会保留地图数据",
	},
	cd_max_msg = {
		"无",
		"%d 分",
	},
	cd_bonus_msg = "每次使用指令, 冷却时间都会增加(基础值的)%d%%. 上限: %s.",
	warning = "%s 冷却: %d 秒.",
	announce = "重新开始!",
	restart = "重生",
	resurrect = "复活",
	kill = "自杀",
	resurrect_from = "复活",
	kill_from = "自杀",
}

MSG_CHOOSE_OVERRIDE = {
	{ "#重生" },
	{ "##重生" },
	{ "#复活", "#復活" },
	{ "#自杀", "#自殺" },
}

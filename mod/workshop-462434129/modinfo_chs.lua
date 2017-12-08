description = [[服务端专用MOD.
按Y(公聊)或者U(私聊)输入指令:
#restart / #重生 (重生换角色)
#restart_d / ##重生 (重生并掉落物品)
#resurrect / #复活 / #復活 (角色复活)
#kill / #自杀 / #自殺 (角色自杀)
]]

configuration_options = {
	{
		name = "MOD_RESTART_IGNORING_ADMIN",
		label = "管理员无冷却",
		hover = "房主和管理员不受冷却时间限制.",
		options =
		{
			{ description = "开", data = true },
			{ description = "关", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESTART",
		label = "重生",
		options =
		{
			{ description = "开", data = true },
			{ description = "关", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESURRECT",
		label = "复活",
		options =
		{
			{ description = "开", data = true },
			{ description = "关", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_KILL",
		label = "自杀",
		options =
		{
			{ description = "开", data = true },
			{ description = "关", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_CD_RESTART",
		label = "重生冷却(分)",
		hover = "重生的冷却时间.",
		options =
		{
			{ description = "无", data = 0, hover = "无限使用" },
			{ description = "1", data = 1, hover = "1 分钟" },
			{ description = "2", data = 2, hover = "2 分钟" },
			{ description = "3", data = 3, hover = "3 分钟" },
			{ description = "5", data = 5, hover = "5 分钟" },
			{ description = "7", data = 7, hover = "7 分钟" },
			{ description = "10", data = 10, hover = "10 分钟" },
		},
		default = 5,
	},
	{
		name = "MOD_RESTART_CD_RESURRECT",
		label = "复活冷却(分)",
		hover = "复活的冷却时间.",
		options =
		{
			{ description = "无", data = 0, hover = "无限使用" },
			{ description = "1", data = 1, hover = "1 分钟" },
			{ description = "2", data = 2, hover = "2 分钟" },
			{ description = "3", data = 3, hover = "3 分钟" },
			{ description = "5", data = 5, hover = "5 分钟" },
			{ description = "7", data = 7, hover = "7 分钟" },
			{ description = "10", data = 10, hover = "10 分钟" },
		},
		default = 7,
	},
	{
		name = "MOD_RESTART_CD_KILL",
		label = "自杀冷却(分)",
		hover = "自杀的冷却时间.",
		options =
		{
			{ description = "无", data = 0, hover = "无限使用" },
			{ description = "1", data = 1, hover = "1 分钟" },
			{ description = "2", data = 2, hover = "2 分钟" },
			{ description = "3", data = 3, hover = "3 分钟" },
			{ description = "5", data = 5, hover = "5 分钟" },
			{ description = "7", data = 7, hover = "7 分钟" },
			{ description = "10", data = 10, hover = "10 分钟" },
		},
		default = 3,
	},
	{
		name = "MOD_RESTART_CD_BONUS",
		label = "冷却调整",
		hover = "冷却时间随使用次数不断增加.",
		options =
		{
			{ description = "关", data = 0, hover = "固定的冷却时间" },
			{ description = "10%", data = 0.1, hover = "每次使用后增加(基础值的)10%" },
			{ description = "20%", data = 0.2, hover = "每次使用后增加(基础值的)20%" },
			{ description = "30%", data = 0.3, hover = "每次使用后增加(基础值的)30%" },
			{ description = "40%", data = 0.4, hover = "每次使用后增加(基础值的)40%" },
			{ description = "50%", data = 0.5, hover = "每次使用后增加(基础值的)50%" },
			{ description = "100%", data = 1, hover = "每次使用后增加(基础值的)100%" },
			{ description = "150%", data = 1.5, hover = "每次使用后增加(基础值的)150%" },
			{ description = "200%", data = 2, hover = "每次使用后增加(基础值的)200%" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_CD_MAX",
		label = "最大冷却(分)",
		hover = "开启冷却调整后累计可达到的最大冷却时间.",
		options =
		{
			{ description = "无", data = 0, hover = "冷却无上限" },
			{ description = "10", data = 10, hover = "10 分钟" },
			{ description = "15", data = 15, hover = "15 分钟" },
			{ description = "20", data = 20, hover = "20 分钟" },
			{ description = "25", data = 25, hover = "25 分钟" },
			{ description = "30", data = 30, hover = "30 分钟" },
			{ description = "45", data = 45, hover = "45 分钟" },
			{ description = "60", data = 60, hover = "60 分钟" },
			{ description = "75", data = 75, hover = "75 分钟" },
			{ description = "90", data = 90, hover = "90 分钟" },
			{ description = "105", data = 105, hover = "105 分钟" },
			{ description = "120", data = 120, hover = "120 分钟" },
			{ description = "180", data = 180, hover = "180 分钟" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_FORCE_DROP_MODE",
		label = "强制掉落道具",
		hover = "重生是否强制掉落道具.",
		options =
		{
			{ description = "默认", data = 0, hover = "默认" },
			{ description = "掉落", data = 1, hover = "重生强制掉落道具" },
			{ description = "不掉落", data = 2, hover = "重生强制不掉落道具" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_MAP_SAVE",
		label = "保留地图",
		hover = "使用重生指令是否保留探索过的地图.",
		options =
		{
			{ description = "开", data = 1, hover = "重生将会记住地图" },
			{ description = "关", data = 2, hover = "重生失去所有地图的记忆" },
		},
		default = 2,
	},
	{
		name = "MOD_RESTART_RESURRECT_HEALTH",
		label = "复活血量",
		hover = "使用复活指令后恢复的血量.",
		options =
		{
			{ description = "默认", data = 0, hover = "游戏默认\n(只剩 50 点血量)" },
			{ description = "递减", data = 1, hover = "每次复活恢复的血量不断减少\n(最少为 40% 的血量)" },
			{ description = "随机", data = 2, hover = "复活随机恢复血量\n(随机血量范围: 10% ~ 100%)" },
			{ description = "100%", data = 100, hover = "固定恢复 100% 的血量" },
			{ description = "90%", data = 90, hover = "固定恢复 90% 的血量" },
			{ description = "80%", data = 80, hover = "固定恢复 80% 的血量" },
			{ description = "70%", data = 70, hover = "固定恢复 70% 的血量" },
			{ description = "60%", data = 60, hover = "固定恢复 60% 的血量" },
			{ description = "50%", data = 50, hover = "固定恢复 50% 的血量" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_TRIGGER_MODE",
		label = "触发模式",
		hover = "公聊或者私聊触发指令.",
		options =
		{
			{ description = "公&私聊", data = 1 },
			{ description = "仅公聊", data = 2 },
			{ description = "仅私聊", data = 3 },
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS",
		label = "帮助信息",
		hover = "首次进入游戏的使用提示.",
		options =
		{
			{ description = "开", data = true },
			{ description = "关", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS_TIME",
		label = "帮助显示(秒)",
		hover = "帮助信息显示多久.",
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

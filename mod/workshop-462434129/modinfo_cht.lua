description = [[服務端專用MOD.
按Y(公聊)或者U(私聊)輸入指令:
#restart / #重生 (重生換角色)
#restart_d / ##重生 (重生並掉落物品)
#resurrect / #復活 / #复活 (角色復活)
#kill / #自殺 / #自杀 (角色自殺)
]]

configuration_options = {
	{
		name = "MOD_RESTART_IGNORING_ADMIN",
		label = "管理員無冷卻",
		hover = "房主和管理員不受冷卻時間限制.",
		options =
		{
			{ description = "開", data = true },
			{ description = "關", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESTART",
		label = "重生",
		options =
		{
			{ description = "開", data = true },
			{ description = "關", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_RESURRECT",
		label = "復活",
		options =
		{
			{ description = "開", data = true },
			{ description = "關", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_ALLOW_KILL",
		label = "自殺",
		options =
		{
			{ description = "開", data = true },
			{ description = "關", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_CD_RESTART",
		label = "重生冷卻(分)",
		hover = "重生的冷卻時間.",
		options =
		{
			{ description = "無", data = 0, hover = "無限使用" },
			{ description = "1", data = 1, hover = "1 分鐘" },
			{ description = "2", data = 2, hover = "2 分鐘" },
			{ description = "3", data = 3, hover = "3 分鐘" },
			{ description = "5", data = 5, hover = "5 分鐘" },
			{ description = "7", data = 7, hover = "7 分鐘" },
			{ description = "10", data = 10, hover = "10 分鐘" },
		},
		default = 5,
	},
	{
		name = "MOD_RESTART_CD_RESURRECT",
		label = "復活冷卻(分)",
		hover = "復活的冷卻時間.",
		options =
		{
			{ description = "無", data = 0, hover = "無限使用" },
			{ description = "1", data = 1, hover = "1 分鐘" },
			{ description = "2", data = 2, hover = "2 分鐘" },
			{ description = "3", data = 3, hover = "3 分鐘" },
			{ description = "5", data = 5, hover = "5 分鐘" },
			{ description = "7", data = 7, hover = "7 分鐘" },
			{ description = "10", data = 10, hover = "10 分鐘" },
		},
		default = 7,
	},
	{
		name = "MOD_RESTART_CD_KILL",
		label = "自殺冷卻(分)",
		hover = "自殺的冷卻時間.",
		options =
		{
			{ description = "無", data = 0, hover = "無限使用" },
			{ description = "1", data = 1, hover = "1 分鐘" },
			{ description = "2", data = 2, hover = "2 分鐘" },
			{ description = "3", data = 3, hover = "3 分鐘" },
			{ description = "5", data = 5, hover = "5 分鐘" },
			{ description = "7", data = 7, hover = "7 分鐘" },
			{ description = "10", data = 10, hover = "10 分鐘" },
		},
		default = 3,
	},
	{
		name = "MOD_RESTART_CD_BONUS",
		label = "冷卻調整",
		hover = "冷卻時間隨使用次數不斷增加.",
		options =
		{
			{ description = "關", data = 0, hover = "固定的冷卻時間" },
			{ description = "10%", data = 0.1, hover = "每次使用後新增(基礎值的)10%" },
			{ description = "20%", data = 0.2, hover = "每次使用後新增(基礎值的)20%" },
			{ description = "30%", data = 0.3, hover = "每次使用後新增(基礎值的)30%" },
			{ description = "40%", data = 0.4, hover = "每次使用後新增(基礎值的)40%" },
			{ description = "50%", data = 0.5, hover = "每次使用後新增(基礎值的)50%" },
			{ description = "100%", data = 1, hover = "每次使用後新增(基礎值的)100%" },
			{ description = "150%", data = 1.5, hover = "每次使用後新增(基礎值的)150%" },
			{ description = "200%", data = 2, hover = "每次使用後新增(基礎值的)200%" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_CD_MAX",
		label = "最大冷卻(分)",
		hover = "開啟冷卻調整後累計可達到的最大冷卻時間.",
		options =
		{
			{ description = "无", data = 0, hover = "冷卻無上限" },
			{ description = "10", data = 10, hover = "10 分鐘" },
			{ description = "15", data = 15, hover = "15 分鐘" },
			{ description = "20", data = 20, hover = "20 分鐘" },
			{ description = "25", data = 25, hover = "25 分鐘" },
			{ description = "30", data = 30, hover = "30 分鐘" },
			{ description = "45", data = 45, hover = "45 分鐘" },
			{ description = "60", data = 60, hover = "60 分鐘" },
			{ description = "75", data = 75, hover = "75 分鐘" },
			{ description = "90", data = 90, hover = "90 分鐘" },
			{ description = "105", data = 105, hover = "105 分鐘" },
			{ description = "120", data = 120, hover = "120 分鐘" },
			{ description = "180", data = 180, hover = "180 分鐘" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_FORCE_DROP_MODE",
		label = "強制掉落道具",
		hover = "重生是否強制掉落道具.",
		options =
		{
			{ description = "預設", data = 0, hover = "預設" },
			{ description = "掉落", data = 1, hover = "重生強制掉落道具" },
			{ description = "不掉落", data = 2, hover = "重生強制不掉落道具" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_MAP_SAVE",
		label = "保留地圖",
		hover = "使用重生指令是否保留探索過的地圖.",
		options =
		{
			{ description = "開", data = 1, hover = "重生將會記住地圖" },
			{ description = "關", data = 2, hover = "重生失去所有地圖的記憶" },
		},
		default = 2,
	},
	{
		name = "MOD_RESTART_RESURRECT_HEALTH",
		label = "復活血量",
		hover = "使用復活指令後恢復的血量.",
		options =
		{
			{ description = "預設", data = 0, hover = "遊戲預設\n(只剩 50 点血量)" },
			{ description = "遞減", data = 1, hover = "每次復活恢復的血量不斷減少\n(最少為 40% 的血量)" },
			{ description = "隨機", data = 2, hover = "復活隨機恢復血量\n(隨機血量範圍: 10% ~ 100%)" },
			{ description = "100%", data = 100, hover = "固定恢復 100% 的血量" },
			{ description = "90%", data = 90, hover = "固定恢復 90% 的血量" },
			{ description = "80%", data = 80, hover = "固定恢復 80% 的血量" },
			{ description = "70%", data = 70, hover = "固定恢復 70% 的血量" },
			{ description = "60%", data = 60, hover = "固定恢復 60% 的血量" },
			{ description = "50%", data = 50, hover = "固定恢復 50% 的血量" },
		},
		default = 0,
	},
	{
		name = "MOD_RESTART_TRIGGER_MODE",
		label = "觸發模式",
		hover = "公聊或者私聊觸發指令.",
		options =
		{
			{ description = "公&私聊", data = 1 },
			{ description = "僅公聊", data = 2 },
			{ description = "僅私聊", data = 3 },
		},
		default = 1,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS",
		label = "幫助資訊",
		hover = "首次進入遊戲的使用提示.",
		options =
		{
			{ description = "開", data = true },
			{ description = "關", data = false },
		},
		default = true,
	},
	{
		name = "MOD_RESTART_WELCOME_TIPS_TIME",
		label = "幫助顯示(秒)",
		hover = "幫助資訊顯示多久.",
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

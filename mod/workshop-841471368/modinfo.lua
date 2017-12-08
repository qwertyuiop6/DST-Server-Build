name = " 河蟹防熊锁"
forumthread = ""
description = [[原作者RedPig..由小红猪防熊锁重写而来
（路人局联机必备利器, 防止玩家烧家和恶意搞破坏）
主机启用就可以了，收给权限，操作简单
按Y键或U键输入#add  玩家数字 可以给其他玩家权限
按Y键或U键输入#del  玩家数字 可以收回其他玩家权限
鼠标右键点箱子还可以给箱子上锁和解锁哦

例如：按U键输入#add3  即给编号3的玩家权限
按tab键在玩家列表左边可查看相应玩家数字，也会有提示。

建议有玩家正在进出房间时不要收给权限，可能编号错位
更多功能请配置更多设置（离线解锁时间、防怪物摧毁等）
]]
author = "GuardAngelY"
version = "2.4.8"
api_version = 10
priority = -9527
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
all_clients_require_mod = false
client_only_mod = false
server_only_mod = true
server_filter_tags = {"ownership","lock","server","protect","RedPig","GuardAngelY"}

icon_atlas = "modicon.xml"
icon = "modicon.tex"

--如果是搭建专属服务器，可通过两种方式更改MOD配置。
--一种是直接修改该modinfo文件各配置项的默认值（注意UTF-8编码格式）。
--另一种是在modoverride文件中进行配置，具体配置详情请参考链接http://www.lyun.me/lyun/427。

configuration_options =
{
    {
        name = "test_mode",
        label = "测试模式",
        options =
        {
            {description = "是", data = true, hover = "开启测试模式"},
            {description = "否", data = false, hover = "关闭测试模式"},
        },
        default = false,
    },

    {
        name = "permission_mode",
        label = "权限保护模式",
        options =
        {
            {description = "是", data = true, hover = "开启防熊相关权限验证功能"},
            {description = "否", data = false, hover = "关闭防熊相关权限验证功能\n(关闭后所有有权限的物品失去保护)"},
        },
        default = true,
    },

    {
        name = "language",
        label = "选择语言风格",
        options =
        {
            {description = "正常版", data = "normal", hover = "正常"},
            {description = "红猪欢乐版", data = "redpig_fun", hover = "欢乐"},
        },
        default = "normal",
    },
	
	{
        name = "give_start_item",
        label = "是否给玩家初始物品",
        options =
        {
            {description = "是", data = true, hover = "给予玩家一些有利于当前环境生存的初始物品"},
            {description = "否", data = false, hover = "否"},
        },
        default = true,
    },

    {
        name = "door_lock",
        label = "木门增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "木门有权限的玩家才能砸和打开，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "木门有权限的玩家才能砸和打开，怪物可摧毁"},
            {description = "部分权限控制", data = "110", hover = "木门有权限的玩家才能砸，任何玩家都能打开，免疫怪物伤害"},
            {description = "部分权限控制2", data = "100", hover = "木门有权限的玩家才能砸，任何玩家都能打开，怪物可摧毁"},
            {description = "无权限控制", data = "010", hover = "木门任何玩家都能砸和打开，免疫怪物伤害"},
            {description = "关闭", data = "000", hover = "关闭"},  
        },
        default = "111",
    },
    
	{
        name = "fence_lock",
        label = "木栅栏增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "木栅栏有权限的玩家才能砸，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "木栅栏有权限的玩家才能砸，怪物可摧毁"},
            {description = "关闭", data = "000", hover = "关闭"},
        },
        default = "111",
    },

    {
        name = "wall_hay_lock",
        label = "草墙增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "草墙有权限的玩家才能砸，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "草墙有权限的玩家才能砸，怪物可摧毁"},
            {description = "关闭", data = "000", hover = "关闭"},
        },
        default = "111",
    },

    {
        name = "wall_wood_lock",
        label = "木墙增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "木墙有权限的玩家才能砸，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "草墙有权限的玩家才能砸，怪物可摧毁"},
            {description = "关闭", data = "000", hover = "关闭"},
        },
        default = "111",
    },

    {
        name = "wall_stone_lock",
        label = "石墙增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "石墙有权限的玩家才能砸，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "石墙有权限的玩家才能砸，怪物可摧毁"},
            {description = "关闭", data = "000", hover = "关闭"},
        },
        default = "111",
    },

    {
        name = "wall_ruins_lock",
        label = "图勒墙增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "图勒墙有权限的玩家才能砸，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "图勒墙有权限的玩家才能砸，怪物可摧毁"},
            {description = "关闭", data = "000", hover = "关闭"},
        },
        default = "111",
    },

    {
        name = "wall_moonrock_lock",
        label = "月石墙增强",
        options =
        {
            {description = "有权限控制", data = "111", hover = "月石墙有权限的玩家才能砸，免疫怪物伤害"},
            {description = "有权限控制2", data = "101", hover = "月石墙有权限的玩家才能砸，怪物可摧毁"},
            {description = "关闭", data = "000", hover = "关闭"},
        },
        default = "111",
    },
	
	{
        name = "cant_destroyby_monster",
        label = "防止怪物摧毁建筑",
        options =
        {
			{description = "开启", data = true, hover = "开启，门和墙体为单独设置"},
            {description = "关闭", data = false, hover = "为了更全面的游戏体验，建议关闭，门和墙体为单独设置"},  
        },
        default = true,
    },
	
	{
        name = "portal_clear",
        label = "防止恶意封门",
        options =
        {
            {description = "50码", data = 50, hover = "50码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "40码", data = 40, hover = "40码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "30码", data = 30, hover = "30码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "25码", data = 25, hover = "25码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "20码", data = 20, hover = "20码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "15码", data = 15, hover = "15码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "10码", data = 10, hover = "10码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "5码", data = 5, hover = "5码内定期清理出生点,落水洞,地下阶梯,主要boss周边不良物体"},
			{description = "关闭", data = 0, hover = "关闭"},
        },
        default = 5,
    },
	
	{
        name = "firesuppressor_dig",
        label = "防止农作物被挖范围",
        options =
        {

			{description = "50码", data = 50},
			{description = "40码", data = 40},
			{description = "30码", data = 30, hover = "农作物与自己建筑之间的距离"},
			{description = "25码", data = 25},
			{description = "20码", data = 20},
			{description = "15码", data = 15},
			{description = "10码", data = 10},
			{description = "5码", data = 5},
			{description = "关闭", data = -1},
        },
        default = 30,
    },
	
	{
        name = "is_allow_build_near",
        label = "防止别人造违规建筑",
        options =
        {
			{description = "开启", data = false, hover = "不允许未授权的玩家在自己家附近造建筑"}, 
			{description = "关闭", data = true}, 
        },
        default = false,
    },

	{
        name = "admin_option",
        label = "管理员受权限控制",
        options =
        {
			{description = "受", data = false, hover = "服务器管理员受权限控制"}, 
			{description = "不受", data = true, hover = "服务器管理员不受权限控制"},
        },
        default = true,
    },
	
    {
        name = "remove_owner_time",
        label = "玩家离线自动解锁的时间",
        options =
        {
            {description = "10秒", data = 10},
            {description = "8分钟", data = 480},
            {description = "40分钟", data = 2400},
            {description = "1小时", data = 3600},
            {description = "3小时", data = 10800},
            {description = "9小时", data = 32400},
            {description = "24小时", data = 86400},  
			{description = "永远不解锁", data = "never", hover = "玩家离开游戏后，其所有物的自动解锁时间"},			
        },
        default = "never",
    },
	
	{
        name = "spread_fire",
        label = "火焰蔓延半径",
        options =
        {
			{description = "不蔓延", data = 0},
            {description = "一半半径", data = 1, hover = "游戏中火焰的蔓延范围，防止大火烧山"},  
			{description = "正常半径", data = 2},  
        },
        default = 1,
    },

    {
        name = "trap_teeth_player",
        label = "犬牙陷阱攻击无权限玩家",
        options =
        {
			{description = "开启", data = true, hover = "犬牙陷阱会被没有权限的玩家触发,造成伤害"}, 
			{description = "关闭", data = false}, 
        },
        default = false,
    },

    {
        name = "eyeturret_player",
        label = "眼球塔攻击无权限玩家",
        options =
        {
			{description = "开启", data = true, hover = "只会攻击有权限的人的目标\n眼球塔会主动攻击没有权限的玩家\n眼球塔之间互相无仇恨"}, 
			{description = "关闭", data = false}, 
        },
        default = false,
    },

    {
        name = "beefalo_power",
        label = "牛增强",
        options =
        {
			{description = "开启", data = true, hover = "防止服从度大于0的牛抖落鞍或主人，并且当牛有主人时防御增强"}, 
			{description = "关闭", data = false}, 
        },
        default = true,
    },

    {
        name = "krampus_sack_ice",
        label = "小偷包保鲜",
        options =
        {
			{description = "开启", data = true, hover = "小偷包保鲜,保鲜度同冰箱"}, 
			{description = "关闭", data = false}, 
        },
        default = true,
    },

    {
        name = "pack_pickup",
        label = "背包拾取增强",
        options =
        {
			{description = "开启", data = true, hover = "当身上有背包时拾取地上的背包将持有在手上而不是直接装备"}, 
			{description = "关闭", data = false}, 
        },
        default = false,
    },

    {
        name = "auto_stack",
        label = "掉落自动堆叠",
        options =
        {
			{description = "开启", data = true, hover = "猪王/喂鸟/挖矿/砍树等掉落物品自动堆叠"}, 
			{description = "关闭", data = false}, 
        },
        default = true,
    },

    {
        name = "minotaur_regenerate",
        label = "远古犀牛刷新时间",
        options =
        {
            {description = "10天", data = 10, hover = "远古犀牛死亡10天后刷新"}, 
            {description = "20天", data = 20, hover = "远古犀牛死亡20天后刷新"}, 
			{description = "30天", data = 30, hover = "远古犀牛死亡30天后刷新"}, 
            {description = "40天", data = 40, hover = "远古犀牛死亡40天后刷新"}, 
            {description = "50天", data = 50, hover = "远古犀牛死亡50天后刷新"}, 
            {description = "60天", data = 60, hover = "远古犀牛死亡60天后刷新"}, 
            {description = "70天", data = 70, hover = "远古犀牛死亡70天后刷新"}, 
            {description = "80天", data = 80, hover = "远古犀牛死亡80天后刷新"}, 
            {description = "90天", data = 90, hover = "远古犀牛死亡90天后刷新"}, 
            {description = "100天", data = 100, hover = "远古犀牛死亡100天后刷新"}, 
			{description = "关闭", data = -1}, 
        },
        default = 50,
    },

    {
        name = "minotaur_destroy",
        label = "远古犀牛可拆毁建筑",
        options =
        {
			{description = "开启", data = true, hover = "在开启防止怪物摧毁建筑时允许犀牛拆毁建筑,建筑不包括墙类"}, 
			{description = "关闭", data = false}, 
        },
        default = false,
    },

    {
        name = "ancient_altar_no_destroy",
        label = "完整远古祭坛防拆毁",
        options =
        {
			{description = "开启", data = true, hover = "防止完整的远古祭坛被玩家破坏"}, 
			{description = "关闭", data = false}, 
        },
        default = false,
    },

    {
        name = "house_plain_nodestroy",
        label = "野外猪人兔人房防拆毁",
        options =
        {
			{description = "开启", data = true, hover = "防止野外猪人兔人房被玩家破坏"}, 
			{description = "关闭", data = false}, 
        },
        default = true,
    },

    {
        name = "clean_level",
        label = "清理级别",
        options =
        {
			{description = "非常高", data = 1, hover = "贫瘠"}, 
            {description = "高", data = 2, hover = "略微贫瘠"}, 
            {description = "中", data = 3, hover = "普通"}, 
            {description = "低", data = 4, hover = "略微富饶"}, 
            {description = "非常低", data = 5, hover = "富饶"}, 
			{description = "关闭", data = -1}, 
        },
        default = 5,
    },

    {
        name = "clean_period",
        label = "清理周期",
        hover = "此选项只有在开启[清理级别]选项后有效",
        options =
        {
			{description = "非常短", data = 1, hover = "1天"},
            {description = "短", data = 5, hover = "5天"},
            {description = "普通", data = 10, hover = "10天"},
            {description = "长", data = 15, hover = "15天"},
            {description = "非常长", data = 20, hover = "20天"},
        },
        default = 10,
    },

    {
        name = "clean_custom",
        -- 配置为 名称:数量
        -- 如 bearger:1|deerclops:1
        default = "",
    },

    {
        name = "connect_worlds",
        label = "世界连接通道",
        hover = "此选项开启后需要手动修改配置,配置类似\n[世界ID] = { name = 世界名, data = 洞口/阶梯通向的世界 }\n[\"1\"] = { name = \"主世界\", data = { \"2\", \"2\", \"2\", \"2\", \"2\", \"2\", \"2\", \"2\", \"2\", \"2\" } }",
        options =
        {
			{description = "开启", data = {
                -- [世界ID] = { name = 世界名, data = 洞口/阶梯通向的世界 }
                ["1"] = { name = "主世界", data = { "2", "2", "2", "2", "2", "2", "2", "2", "2", "2" } },
                ["2"] = { name = "第二世界", data = { "1", "1", "1", "1", "1", "1", "1", "1", "1", "1" } },
            }, hover = "当开启ShowMe时鼠标悬停将显示通往的世界,需要手动修改mod配置,data不配置则为默认"},
			{description = "关闭", data = false}, 
        },
        default = false,
    },
}
return {
    --不可烧的物品列表
    remove_burnable_from =
    {
        'beebox',
        'treasurechest', 
        'cookpot',
        'researchlab', 
        'researchlab2',
        'researchlab3',
        'researchlab4',
        'meatrack',
        'grass',
        'twig',
        'berrybush',
        'berrybush2',
        'sapling',
        'red_mushroom',
        'green_mushroom',
        'pandoraschest',
        'skullchest',
        'homesign',
        'tent',
        'siestahut',
        'dragonflychest',
        'slow_farmplot',
        'fast_farmplot',
        'resurrectionstatue',
        'pighouse',
        'rabbithouse',
        "tallbirdnest",
        "backpack",
        "piggyback",
        "krampus_sack",
        "berrybush_juicy",
        "wardrobe",
        "storeroom",
        "wall_hay",--草墙
        "wall_wood",--木墙
        "fence_gate",--木门
        "fence",--木栅栏
        "winter_tree",--圣诞松树
        "winter_deciduoustree",--圣诞桦树
        "winter_twiggytree",--圣诞多枝分叉树
        "sculptingtable",--陶工转盘
        "cartographydesk",--绘图师的桌子
        "mushroom_farm",--蘑菇种植机
        "mushroom_light",--蘑菇灯
        "mushroom_light2",--发光器
        "winter_treestand",--节日树盆
        "pottedfern",--蕨类盆栽
        "endtable",--茶几
        "scarecrow",--稻草人
        "sentryward",--显示印记
        "perdshrine",--火鸡神坛
    },
    --开启防怪物摧毁后生效
    --不能被怪物摧毁的建筑列表--新物品可自行添加
    cant_destroy_buildings = {
        "firepit", "coldfire", "coldfirepit", "cookpot", "icebox", "winterometer", "rainometer", "slow_farmplot", "fast_farmplot", "siestahut", "tent", "homesign",
        "arrowsign_post", "birdcage", "meatrack", "lightning_rod", "nightmarelight", "researchlab",
        "treasurechest", "skullchest", "pandoraschest", "minotaurchest", "dragonflychest","pighouse", "rabbithouse", "mermhouse", "resurrectionstatue",
        "eyeturret", "mermhead", "beebox",
        "researchlab2",--炼金引擎
        "pottedfern",--蕨类盆栽
        "firesuppressor",--雪球发射器
        "catcoonden",--空心树桩
        "wardrobe",--衣柜
        "storeroom",--地窖
        "dragonflyfurnace",--龙鳞火炉
        "sculptingtable",--陶工转盘
        "cartographydesk",--绘图师的桌子
        "mushroom_farm",--蘑菇种植机
        "mushroom_light",--蘑菇灯
        "mushroom_light2",--发光器
        "winter_treestand",--节日树盆
        "endtable",--茶几
        "scarecrow",--稻草人
        "pumpkin_lantern",--南瓜灯
        -------- 建筑 --------
        "perdshrine",--火鸡神坛
        -------- 魔法 --------
        "researchlab4",--灵子分解器
        "researchlab3",--暗影操控器
        "resurrectionstatue",--肉块雕像
        "nightlight",--暗夜照明灯
        "telebase",--传送点
        "sentryward",--显示印记
        "moondial",--月盘
        -------- 系统建筑 --------
        "ancient_altar", -- 完整远古祭坛
        "ancient_altar_broken", -- 残破的远古祭坛
    },
    --要记录状态的物品
    save_state_table = {
        "storeroom",--地窖
        "plant_normal",--农场植物
        --"pinecone",--榛果
        -- "pinecone_sapling",--榛果_种下
        -- "acorn_sapling",--白桦果_种下
        -- "twiggy_nut_sapling",--多枝树果_种下
        -- "lumpy_sapling",--常青树果_种下(它没有种子)
        -- "evergreen_sparse",--粗壮常青树(它没有种子)
        --"marblebean",--大理石豆子
        "twiggytree",--多枝树
        "deciduoustree",--白桦树
        "evergreen",--松树
        "stafflight",--矮人之星
        "staffcoldlight",--极光
        "beefalo",--牛
        "eyeturret",-- 眼球镭射塔
    },
    --防挖/摧毁的安置物
    deploys_cant_table = {
        grass = true,                --草丛
        sapling = true,              --树苗
        berrybush = true,            --浆果丛
        berrybush2 = true,           --分叉浆果丛
        berrybush_juicy = true,      --多汁浆果丛
        flower = true,               --花
        fossil_stalker = true,       --奇怪的骨骼
        pinecone_sapling = true,     --榛果_种下
        acorn_sapling = true,        --白桦果_种下
        twiggy_nut_sapling = true,   --多枝树果_种下
        marblebean_sapling = true,   --大理石豆子_种下
    },
    --防摧毁的树
    winter_trees_table = {
        winter_tree = true,          --圣诞松树
        winter_deciduoustree = true, --圣诞桦树
        winter_twiggytree = true,    --圣诞多枝分叉树
        --"evergreen_sparse",        --粗壮常青树
        marbleshrub = true,          --大理石树
    },
    --指定物件周边自动清理
    item_clear_auto = {
        "multiplayer_portal", -- 出生点
        "cave_entrance_open", -- 洞口
        "cave_entrance",      -- 堵住的洞口
        "migration_portal",   -- 旅行机器
        "beequeenhive",       -- 巨大蜂巢
        "klaus_sack",         -- 战利品贮藏(圣诞boss)
        "walrus_camp",        -- 海象冰屋
        "critterlab",         -- 岩石巢穴
        "pigking",            -- 猪王
        "sanityrock",         -- 方尖碑
        "statueglommer",      -- 咕噜咪雕像
        "resurrectionstone",  -- 复活石
        --地下
        "cave_exit",          -- 地下阶梯
        "toadstool_cap",      -- 毒菇
    },
}
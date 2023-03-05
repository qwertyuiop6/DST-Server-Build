--饥荒服务器命令,更多请参考Klei官方WIKI: https://dontstarve.fandom.com/wiki/Console/Don%27t_Starve_Together_Commands
--res,复活所有玩家，输入res()即可复活当前世界的所有玩家
function res()
    for i, v in ipairs(AllPlayers) do v:PushEvent('respawnfromghost') end
end

--rmhalf,清理一半的物品，比如，输入rmhalf("beefalo")，就可以清理一半的牛群
function rmhalf(name)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == name then
            if math.random() < 0.5 then
                v:Remove()
                count = count + 1
            end
        end
    end
    print("removed", count, name)
end

--rmpart,按百分比清理物品，比如，输入rmhalf("evergreen",0.8)，就可以清理80%的常青树
function rmpart(name,percent)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == name then
            if percent and math.random() < percent then
                v:Remove()
                count = count + 1
            end
        end
    end
    print("removed", count, name)
end

--rmog,清理地面的物品，比如，输入rmog("spoiled_food")，就可以清理地面上所有的腐烂的食物
function rmog(name)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == name then
            if v.components.inventoryitem then
                if v.components.inventoryitem.owner == nil then
                    v:Remove()
                    count = count + 1
                end
            else
                v:Remove()
                count = count + 1
            end
        end
    end
    print("removed", count, name)
end

--rmbt,清理烧毁的建筑及植物，比如，输入rmbt("treasurechest")即可清理所有烧毁的箱子
function rmbt(name)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == name and v:HasTag("burnt") then
            v:Remove()
            count = count + 1
        end
    end
    print("removed", count, "burnt", name)
end

--rmcrop,清理虫木种在地上的作物腐烂后及枯萎后
function rmcrop()
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == "plant_normal_ground" then
            if v:HasTag("rotten") or v:HasTag("withered") then
                v:Remove()
                count = count + 1
            end
        end
    end
    print("removed", count, "plant_normal_ground")
end

--list,显示当前世界的玩家
function list()
    for i, v in ipairs(AllPlayers) do
        print(string.format("[%d] (%s) %s <%s>", i, v.userid, v.name, v.prefab))
    end
end

--show,显示当前服务器的所有玩家
function show()
    local index = 0
    for i, v in ipairs(TheNet:GetClientTable()) do
        if index ~= 0 then
            --print(' ['..index..'] {'..string.format('%03d', v.playerage)..'} ('..v.userid..') '..v.name..' <'..v.prefab..'>')
            print(string.format("[%d] {%s} (%s) %s <%s>", index, string.format('%03d', v.playerage), v.userid, v.name, v.prefab))
        end
        index = index + 1
    end
end

--say,服务器宣告 输入say("欢迎加入")即可发出相应内容的公告
function say(msg, interval, category)
    if msg == nil then
        if TheWorld.__announcementtask ~= nil then
            TheWorld.__announcementtask:Cancel()
            TheWorld.__announcementtask = nil
        end
    elseif interval == nil or interval <= 0 then
        if category == "system" then
            TheNet:SystemMessage(msg)
        else
            TheNet:Announce(msg, nil, nil, category)
        end
    else
        if TheWorld.__announcementtask ~= nil then
            TheWorld.__announcementtask:Cancel()
        end
        TheWorld.__announcementtask =
        TheWorld:DoPeriodicTask(
        interval,
        category == "system" and
        function() TheNet:SystemMessage(msg) end or
        function() TheNet:Announce(msg, nil, nil, category) end,
        0
    )
end
end

--count,计数,输入count("flint")即可打印出碎石的数量
function count(prefab, noprint)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == prefab then
            count = count + 1
        end
    end
    if not noprint then
        print("There are ", count, prefab.."s in the world.")
    end
    return count
end

--countall,计数所有物品
function countall()
    local total = 0
    local unk = 0
    local counted = {}
    for k,v in pairs(Ents) do
        if v.prefab ~= nil then
            if counted[v.prefab] == nil then
                counted[v.prefab] = 1
            else
                counted[v.prefab] = counted[v.prefab] + 1
            end
            total = total + 1
        else
            unk = unk + 1
        end
    end

    local function pairsByKeys (t, f)
        local a = {}
        for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0      -- iterator variable
        local iter = function ()   -- iterator function
            i = i + 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
            end
        end
        return iter
    end

    for k,v in pairsByKeys(counted) do
        print(k, v)
    end

    print(string.format("There are %d different prefabs in the world, %d total (and %d unknown)", GetTableSize(counted), total, unk))
end

--countog,计数所有在地面的物品,输入countog()即可打印所有在地面的物品、建筑及动植物（即不包括箱子里和玩家身上的物品）
function countog()
    local total = 0
    local unk = 0
    local counted = {}
    for k,v in pairs(Ents) do
        if v.prefab ~= nil then
            if v.components.inventoryitem then
                if v.components.inventoryitem.owner == nil then
                    if counted[v.prefab] == nil then
                        counted[v.prefab] = 1
                    else
                        counted[v.prefab] = counted[v.prefab] + 1
                    end
                    total = total + 1
                end
            else
                if counted[v.prefab] == nil then
                    counted[v.prefab] = 1
                else
                    counted[v.prefab] = counted[v.prefab] + 1
                end
                total = total + 1
            end
        else
            unk = unk + 1
        end
    end

    local function pairsByKeys (t, f)
        local a = {}
        for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0      -- iterator variable
        local iter = function ()   -- iterator function
            i = i + 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
            end
        end
        return iter
    end

    for k,v in pairsByKeys(counted) do
        print(k, v)
    end

    print(string.format("There are %d different prefabs on the ground, %d total (and %d unknown)", GetTableSize(counted), total, unk))
end

--day,显示世界天数即季节
function day()
    print('World Day:', TheWorld.state.cycles + 1)
    print('Season:', TheWorld.state.season)
    print('Days Left in the Season:',TheWorld.state.remainingdaysinseason)
end

--按照自定义设置清理服务器
local function count_current(prefab)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == prefab then
            if v.components.inventoryitem then
                if v.components.inventoryitem.owner == nil then
                    count = count + 1
                end
            else
                count = count + 1
            end
        end
    end
    return count
end

local function s_rmognum(name,maxnum)
    local count = 0
    for k,v in pairs(Ents) do
        if v.prefab == name then
            if v.components.inventoryitem then
                if v.components.inventoryitem.owner == nil and count_current(name) > maxnum then
                    v:Remove()
                    count = count + 1
                end
            else
                if count_current(name) > maxnum then
                    v:Remove()
                    count = count + 1
                end
            end
        end
    end
    if count ~= 0 then
        print("removed", count, name)
    end
end

local rmlist = {
    ------------------------  动      物  ------------------------
    {"hound", 30},                                      -- 狗
    {"firehound", 10},                                  -- 火狗
    {"icehound", 10},                                   -- 冰狗
    {"spider_warrior", 10},                             -- 蜘蛛战士
    {"spider", 10},                                     -- 蜘蛛
    {"flies", 10},                                      -- 苍蝇
    {"mosquito", 10},                                   -- 蚊子
    {"bee", 10},                                        -- 蜜蜂
    {"killerbee", 10},                                  -- 杀人蜂
    {"frog", 20},                                       -- 青蛙
    {"beefalo", 50},                                    -- 牛
    {"grassgekko", 15},                                 -- 草蜥蜴
    {"lightninggoat", 50},                              -- 羊
    {"deer", 50},                                       -- 鹿
    ------------------------  地面  物体  ------------------------
    {"evergreen_sparse", 250},                          -- 常青树
    {"twiggytree", 150},                                -- 树枝树
    {"marsh_tree", 100},                                -- 针刺树
    {"rock_petrified_tree", 1000},                      -- 石化树
    {"skeleton_player", 50},                            -- 玩家尸体
    {"spiderden", 80},                                  -- 蜘蛛巢
    {"burntground", 50},                                -- 陨石痕跡
    ------------------------  可拾取物品  ------------------------
    --{"seeds", 0},                                     -- 种子
    --{"log", 0},                                       -- 木头
    --{"pinecone", 0},                                  -- 松果
    --{"twiggy_nut", 0},                                -- 多枝树的果实
    --{"cutgrass", 0},                                  -- 草
    --{"twigs", 0},                                     -- 树枝
    --{"rocks", 100},                                   -- 石头
    --{"nitre", 100},                                   -- 硝石
    --{"flint", 100},                                   -- 燧石
    {"poop", 0},                                        -- 屎
    {"guano", 0},                                       -- 鸟屎
    {"manrabbit_tail", 0},                              -- 兔毛
    {"silk", 50},                                       -- 蜘蛛丝
    {"spidergland", 50},                                -- 蜘蛛腺体
    {"stinger", 0},                                     -- 蜂刺
    {"houndstooth", 0},                                 -- 狗牙
    {"mosquitosack", 0},                                -- 蚊子血袋
    --{"glommerfuel", 0},                               -- 格罗姆粘液
    {"slurtleslime", 0},                                -- 鼻涕虫粘液
    {"slurtle_shellpieces", 0},                         -- 鼻涕虫壳碎片
    {"charcoal", 0},                                    -- 炭
    {"rottenegg", 0},                                   -- 坏蛋
    {"horn", 5},                                        -- 牛角
    {"beardhair", 0},                                   -- 胡须
    {"beefalowool", 0},                                 -- 牛毛
    {"feather_crow", 0},                                -- 羽毛
    {"feather_robin", 0},                               -- 羽毛
    {"feather_robin_winter", 0},                        -- 羽毛
    {"spoiled_food", 0},                                -- 腐烂食物
    {"sketch", 0},                                      -- 草图
    {"blueprint", 0},                                   -- 蓝图
    {"backpack", 0},                                    -- 背包
    {"piggyback", 0},                                   -- 小猪包
    {"candybag", 0},                                    -- 糖果包
    {"compass", 0},                                     -- 指南針
    {"bedroll_furry", 0},                               -- 兔毛席子
    {"bedroll_straw", 0},                               -- 草席
    {"axe", 3},                                         -- 斧子
    {"goldenaxe", 3},                                   -- 黄金斧子
    {"torch", 0},                                       -- 火炬
    {"pickaxe", 3},                                     -- 镐子
    {"goldenpickaxe", 3},                               -- 黄金镐子
    {"hammer", 3},                                      -- 锤子
    {"shovel", 3},                                      -- 铲子
    {"goldenshovel", 3},                                -- 黄金铲子
    {"razor", 1},                                       -- 剃刀
    {"pitchfork", 0},                                   -- 草叉
    {"bugnet", 0},                                      -- 捕虫网
    {"fishingrod", 0},                                  -- 鱼竿
    {"umbrella", 0},                                    -- 雨伞
    {"earmuffshat", 0},                                 -- 兔耳罩
    {"winterhat", 0},                                   -- 冬帽
    --{"heatrock", 5},                                  -- 热能石
    {"strawhat", 0},                                    -- 草帽
    {"tophat", 0},                                      -- 高礼帽
    {"featherhat", 0},                                  -- 羽毛帽
    {"beehat", 0},                                      -- 蜜蜂帽
    {"spiderhat", 0},                                   -- 女王帽
    {"bushhat", 0},                                     -- 浆果丛帽
    {"trap", 10},                                       -- 动物陷阱
    {"birdtrap", 3},                                    -- 鸟陷阱
    {"spear", 0},                                       -- 矛
    {"boomerang", 0},                                   -- 回旋镖
    --{"nightsword", 10},                               -- 影刀
    {"ruins_bat", 0},                                   -- 铥矿棒
    --{"spear_wathgrithr", 0},                          -- 女武神长矛
    {"armorgrass", 0},                                  -- 草甲
    {"armormarble", 0},                                 -- 大理石甲
    --{"armor_sanity", 10},                             -- 影甲
    {"armorsnurtleshell", 0},                           -- 蜗牛甲
    {"armorwood", 0},                                   -- 木甲
    {"armordragonfly", 0},                              -- 蜻蜓甲
    {"armor_bramble", 0},                               -- 荆棘甲
    {"footballhat", 0},                                 -- 猪皮帽
    {"slurtlehat", 0},                                  -- 蜗牛帽
    --{"wathgrithrhat", 0},                             -- 女武神头盔
    --{"firestaff", 0},                                 -- 火魔杖
    --{"icestaff", 0},                                  -- 冰魔杖
    {"chesspiece_deerclops_sketch", 0},                 -- 四季 boss 棋子图
    {"chesspiece_bearger_sketch", 0},
    {"chesspiece_moosegoose_sketch", 0},
    {"chesspiece_dragonfly_sketch", 0},
    --{"shadowheart", 3},                               -- 影心
    {"oar", 0},                                         -- 桨
    {"oar_driftwood", 0},                                         -- 桨
    {"antliontrinket", 0},                              -- 蚁狮掉落物
    ------------------------  厨师的物品  ------------------------
    {"portablecookpot_item", 0},
    {"portableblender_item", 0},
    {"portablespicer_item", 0},
}

--冬季盛宴
local function winterfeast_rmlist()
    for i=1,9 do table.insert(rmlist, {"winter_food"..i, 0}) end
    for i=1,12 do table.insert(rmlist, {"winter_ornament_plain"..i, 0}) end
    for i=1,8 do table.insert(rmlist, {"winter_ornament_fancy"..i, 0}) end
    for i=1,8 do table.insert(rmlist, {"winter_ornament_light"..i, 0}) end
    for i=1,5 do table.insert(rmlist, {"winter_ornament_festivalevents"..i, 0}) end
    table.insert(rmlist, {"winter_ornament_boss_bearger", 0 })
    table.insert(rmlist, {"winter_ornament_boss_beequeen", 0})
    table.insert(rmlist, {"winter_ornament_boss_deerclops", 0})
    table.insert(rmlist, {"winter_ornament_boss_dragonfly", 0})
    table.insert(rmlist, {"winter_ornament_boss_moose", 0})
    table.insert(rmlist, {"winter_ornament_boss_toadstool", 0})
    table.insert(rmlist, {"winter_ornament_boss_antlion", 0})
    table.insert(rmlist, {"winter_ornament_boss_fuelweaver", 0})
    table.insert(rmlist, {"winter_ornament_boss_klaus", 0})
    table.insert(rmlist, {"winter_ornament_boss_krampus", 0})
    table.insert(rmlist, {"winter_ornament_boss_noeyered", 0})
    table.insert(rmlist, {"winter_ornament_boss_noeyeblue", 0})
end

--万圣节
local function hallowed_night_rmlist()
    for i=1,14 do table.insert(rmlist, {"halloweencandy_"..i, 0}) end
    for i=1,6 do table.insert(rmlist, {"halloween_ornament_"..i, 0}) end
    table.insert(rmlist, {"halloween_experiment_bravery", 0})
    table.insert(rmlist, {"halloween_experiment_health", 0})
    table.insert(rmlist, {"halloween_experiment_sanity", 0})
    table.insert(rmlist, {"halloween_experiment_volatile", 0})
    table.insert(rmlist, {"halloween_experiment_moon", 0})
    table.insert(rmlist, {"halloween_experiment_root", 0})
end

--玩具
local function trinket_rmlist()
    for i=2,5 do table.insert(rmlist, {"trinket_"..i, 0}) end
    for i=7,45 do table.insert(rmlist, {"trinket_"..i, 0}) end
end
--clean,清理服务器
function clean()
    winterfeast_rmlist()
    hallowed_night_rmlist()
    trinket_rmlist()
    for k,v in pairs(rmlist) do s_rmognum(v[1],v[2]) end
    print("Clean Finished!")
end
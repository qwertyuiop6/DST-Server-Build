local _G = GLOBAL
local TheNet = _G.TheNet
local TheShard = _G.TheShard
local worldShardId = TheShard:GetShardId()

local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local TUNING = _G.TUNING

local clean_level = _G.tonumber(GetModConfigData("clean_level"))
local clean_period = _G.tonumber(GetModConfigData("clean_period"))
local clean_custom = GetModConfigData("clean_custom")
-- 世界连接通道
local connect_worlds = GetModConfigData("connect_worlds")

if IsServer then
    local formServerName = connect_worlds and connect_worlds[worldShardId] and connect_worlds[worldShardId].name or nil

    -- 需要清理的物品
    -- @permission 标识为true时表示仅清理无权限的物品
    -- @stack      标识为true时表示仅清理无堆叠的物品
    -- @reclean    标识为数字,表示超过第n次清理时物品还存在则强制清理(第一次找到物品并未清理的计数为1)
    local function GetLevelPrefabs(level)
        local levelPrefabs = {
            ------------------------  生物  ------------------------
            hound           = { max = 3 * level },    -- 狗
            firehound       = { max = 1 * level },    -- 火狗
            spider_warrior  = { max = 1 * level },    -- 蜘蛛战士
            spider          = { max = 1 * level },    -- 蜘蛛
            spiderqueen     = { max = 1 * level },    -- 蜘蛛女王
            flies           = { max = 1 * level },    -- 苍蝇
            mosquito        = { max = 1 * level },    -- 蚊子
            bee             = { max = 1 * level },    -- 蜜蜂
            killerbee       = { max = 1 * level },    -- 杀人蜂
            mole            = { max = 10 * level },   -- 鼹鼠
            frog            = { max = 2 * level },    -- 青蛙
            grassgekko      = { max = 15 * level },   -- 草蜥蜴
            beefalo         = { max = 12 * level, permission = true },   -- 牛
            lightninggoat   = { max = 8 * level },    -- 羊
            deer            = { max = 10 * level },   -- 鹿
            bunnyman        = { max = 10 * level },   -- 兔人
            slurtle         = { max = 5 * level },    -- 鼻涕虫
            snurtle         = { max = 5 * level },    -- 蜗牛
            --leif            = { max = 2 * level },    -- 树精
            --spat            = { max = 1 * level },    -- 钢羊
            --warg            = { max = 1 * level },    -- 座狼
            mooseegg        = { max = 1 * level },    -- 春鸭巢
            --moose           = { max = 1 * level },    -- 春鸭
            --bearger         = { max = 1 * level },    -- 熊
            --deerclops       = { max = 1 * level },    -- 巨鹿

            ------------------------  地面物体  ------------------------
            grass               = { max = 150 * level, permission = true },  -- 草
            sapling             = { max = 150 * level, permission = true },  -- 树苗
            berrybush           = { max = 150 * level, permission = true },  -- 浆果丛
            berrybush2          = { max = 150 * level, permission = true },  -- 分叉浆果丛
            berrybush_juicy     = { max = 150 * level, permission = true },  -- 多汁浆果丛
            flower              = { max = 80 * level, permission = true },   -- 花
            acorn_sapling       = { max = 10 * level, permission = true },   -- 白树苗
            pinecone_sapling    = { max = 1 * level, permission = true },    -- 松树苗
            twiggy_nut_sapling  = { max = 1 * level, permission = true },    -- 树枝树苗
            lumpy_sapling       = { max = 10 * level },                      -- 常青树苗
            deciduoustree       = { max = 300 * level, permission = true },  -- 白树
            evergreen           = { max = 500 * level, permission = true },  -- 松树
            evergreen_sparse    = { max = 250 * level },                     -- 常青树
            twiggytree          = { max = 150 * level, permission = true },  -- 树枝树
            marsh_tree          = { max = 100 * level },                     -- 针刺树
            rock_petrified_tree = { max = 100 * level },                     -- 石化树
            rock1               = { max = 70 * level },                      -- 石头
            skeleton_player     = { max = 5 * level },                       -- 玩家尸体
            spiderden           = { max = 5 * level, permission = true },    -- 蜘蛛巢
            burntground         = { max = 5 * level },                       -- 陨石痕跡

            ------------------------  可拾取物品  ------------------------
            seeds           = { max = 1, stack = true, reclean = 3 },                -- 种子
            log             = { max = 10 * level, stack = true, reclean = 3 },       -- 木头
            pinecone        = { max = 10 * level, stack = true, reclean = 3 },       -- 松果
            cutgrass        = { max = 10 * level, stack = true, reclean = 3 },       -- 草
            twigs           = { max = 10 * level, stack = true, reclean = 3 },       -- 树枝
            rocks           = { max = 10 * level, stack = true, reclean = 3 },       -- 石头
            nitre           = { max = 10 * level, stack = true, reclean = 3 },       -- 硝石
            flint           = { max = 10 * level, stack = true, reclean = 3 },       -- 燧石
            poop            = { max = 7  * level, stack = true, reclean = 3 },       -- 屎
            guano           = { max = 5  * level, stack = true, reclean = 3 },       -- 鸟屎
            manrabbit_tail  = { max = 7  * level, stack = true, reclean = 3 },       -- 兔毛
            silk            = { max = 7  * level, stack = true, reclean = 3 },       -- 蜘蛛丝
            spidergland     = { max = 7  * level, stack = true, reclean = 3 },       -- 蜘蛛腺体
            stinger         = { max = 5  * level, stack = true, reclean = 3 },       -- 蜂刺
            houndstooth     = { max = 8  * level, stack = true, reclean = 3 },       -- 犬牙
            mosquitosack    = { max = 8  * level, stack = true, reclean = 3 },       -- 蚊子血袋
            glommerfuel     = { max = 8  * level, stack = true, reclean = 3 },       -- 咕嚕咪粘液
            slurtleslime    = { max = 6  * level, stack = true, reclean = 3 },       -- 鼻涕虫粘液
            slurtle_shellpieces = { max = 10 * level, stack = true, reclean = 3 },   -- 鼻涕虫壳碎片

            spoiled_food    = { max = 10 * level },                                  -- 腐烂食物
            winter_food1    = { max = 2 * level, stack = true, reclean = 3 },        -- 姜饼人曲奇饼
            winter_food2    = { max = 2 * level, stack = true, reclean = 3 },
            winter_food3    = { max = 2 * level, stack = true, reclean = 3 },
            winter_food4    = { max = 2 * level, stack = true, reclean = 3 },
            winter_food5    = { max = 2 * level, stack = true, reclean = 3 },

            winter_ornament_plain1 = { max = 2 * level, stack = true, reclean = 3 }, -- 节日小饰品
            winter_ornament_plain2 = { max = 2 * level, stack = true, reclean = 3 },
            winter_ornament_plain4 = { max = 2 * level, stack = true, reclean = 3 },
            winter_ornament_plain5 = { max = 2 * level, stack = true, reclean = 3 },
            winter_ornament_plain6 = { max = 2 * level, stack = true, reclean = 3 },
            winter_ornament_plain7 = { max = 2 * level, stack = true, reclean = 3 },

            trinket_3   = { max = 2 * level, stack = true, reclean = 3 },            -- 戈尔迪乌姆之结
            trinket_4   = { max = 2 * level, stack = true, reclean = 3 },
            trinket_6   = { max = 2 * level, stack = true, reclean = 3 },
            trinket_8   = { max = 2 * level, stack = true, reclean = 3 },

            blueprint   = { max = 3 * level },    -- 蓝图
            axe         = { max = 3 * level },    -- 斧子
            torch       = { max = 3 * level },    -- 火炬
            pickaxe     = { max = 3 * level },    -- 镐子
            hammer      = { max = 3 * level },    -- 锤子
            shovel      = { max = 3 * level },    -- 铲子
            razor       = { max = 3 * level },    -- 剃刀
            pitchfork   = { max = 3 * level },    -- 草叉
            bugnet      = { max = 3 * level },    -- 捕虫网
            fishingrod  = { max = 3 * level },    -- 魚竿
            spear       = { max = 3 * level },    -- 矛
            earmuffshat = { max = 3 * level },    -- 兔耳罩
            winterhat   = { max = 3 * level },    -- 冬帽
            heatrock    = { max = 3 * level },    -- 热能石
            trap        = { max = 30 * level },   -- 动物陷阱
            birdtrap    = { max = 30 * level },   -- 鸟陷阱
            compass     = { max = 3 * level },    -- 指南針

            ------------------------  地面玩家失去权限的建筑  ------------------------
            -- firepit     	= { max = 0 * level, permission = true },  -- 石篝火
            -- coldfire     	= { max = 0 * level, permission = true },  -- 冷火
            -- researchlab     = { max = 0 * level, permission = true },  -- 科学机器
            -- researchlab2    = { max = 0 * level, permission = true },  -- 炼金术引擎
            -- researchlab3    = { max = 0 * level, permission = true },  -- 阴影操纵者
            -- researchlab4    = { max = 0 * level, permission = true },  -- 灵子分解器
            -- treasurechest   = { max = 0 * level, permission = true },  -- 木箱
            -- dragonflychest  = { max = 0 * level, permission = true },  -- 蜻蜓箱子
            -- dragonflyfurnace= { max = 0 * level, permission = true },  -- 鳞片火炉
            -- storeroom  		= { max = 0 * level, permission = true },  -- 地窖
            -- cookpot     	= { max = 0 * level, permission = true },  -- 锅
            -- icebox			= { max = 0 * level, permission = true },  -- 冰箱
            -- winterometer    = { max = 0 * level, permission = true },  -- 寒冰温度计
            -- rainometer     	= { max = 0 * level, permission = true },  -- 雨量计
            -- slow_farmplot   = { max = 0 * level, permission = true },  -- 一般农田
            -- fast_farmplot   = { max = 0 * level, permission = true },  -- 高级农田
            -- siestahut     	= { max = 0 * level, permission = true },  -- 午睡小屋
            -- tent     		= { max = 0 * level, permission = true },  -- 帐篷
            -- wardrobe     	= { max = 0 * level, permission = true },  -- 衣柜
            -- birdcage     	= { max = 0 * level, permission = true },  -- 鸟笼
            -- bebox         	= { max = 0 * level, permission = true },  -- 蜂箱
            -- meatrack     	= { max = 0 * level, permission = true },  -- 晾肉架
            -- lightning_rod   = { max = 0 * level, permission = true },  -- 避雷针
            -- pottedfern     	= { max = 0 * level, permission = true },  -- 盆栽
            -- nightlight     	= { max = 0 * level, permission = true },  -- 暗夜照明灯
            -- nightmarelight  = { max = 0 * level, permission = true },  -- 影灯
            -- mushroom_light  = { max = 0 * level, permission = true },  -- 蘑菇灯
            -- mushroom_light2 = { max = 0 * level, permission = true },  -- 发光器
            -- eyeturret     	= { max = 0 * level, permission = true },  -- 眼睛炮塔
            -- firesuppressor  = { max = 0 * level, permission = true },  -- 灭火器
            -- minisign  		= { max = 0 * level, permission = true },  -- 小型标志
            -- homesign  		= { max = 0 * level, permission = true },  -- 路牌
            -- arrowsign_post  = { max = 0 * level, permission = true },  -- 方向指示牌
            -- scarecrow  		= { max = 0 * level, permission = true },  -- 稻草人

            ------------------------  地面玩家失去权限的门墙  ------------------------
            -- fence_gate  	= { max = 0 * level, permission = true },  -- 木门
            -- fence  			= { max = 0 * level, permission = true },  -- 木栅栏
            -- wall_hay  		= { max = 0 * level, permission = true },  -- 草墙
            -- wall_wood  		= { max = 0 * level, permission = true },  -- 木墙
            -- wall_stone  	= { max = 0 * level, permission = true },  -- 石墙
            -- wall_ruins  	= { max = 0 * level, permission = true },  -- 铥墙
            -- wall_moonrock 	= { max = 0 * level, permission = true },  -- 月墙
        }

        return levelPrefabs
    end

    -- 自定义清理
    local function GetCustomPrefabs(prefabs, base_max_prefabs)
        if base_max_prefabs == nil then
            base_max_prefabs = GetLevelPrefabs(clean_level)
        end
        
        if type(prefabs) == 'string' then
            for prefab, num in string.gmatch(prefabs, "([%w_]+):(%w+)") do
                num = _G.tonumber(num)
                print("[河蟹防熊锁]自定义清理", prefab, num)
                base_max_prefabs[prefab] = num and { max = num } or nil
            end
        end

        return base_max_prefabs
    end
    local max_prefabs = GetCustomPrefabs(clean_custom)

    local function IsInInventory(inst)
        return inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner ~= nil
    end

    local function RemoveItem(inst)
        if inst.components.health ~= nil and not inst:HasTag("wall") then
            if inst.components.lootdropper ~= nil then
                inst.components.lootdropper.DropLoot = function(pt) end
            end
            inst.components.health:SetPercent(0)
        else
            inst:Remove()
        end
    end

    local function Clean(inst, level)
        TheNet:Announce(GetSayMsg("cleaning", formServerName))
        print("[河蟹防熊锁]常玩的小伙伴加群【347197515】一起交流~")
        local this_max_prefabs = level and GetCustomPrefabs(clean_custom, GetLevelPrefabs(level)) or max_prefabs
        local countList = {}
        local countPer = {}
        local thisPrefab = nil

        for _,v in pairs(_G.Ents) do
            if v.prefab ~= nil then
                repeat
                    thisPrefab = v.prefab
                    if this_max_prefabs[thisPrefab] ~= nil then
                        if v.reclean == nil then
                            v.reclean = 1
                        else
                            v.reclean = v.reclean + 1
                        end

                        local bNotClean = true
                        if this_max_prefabs[thisPrefab].reclean ~= nil then
                            bNotClean = this_max_prefabs[thisPrefab].reclean > v.reclean
                        end

                        if this_max_prefabs[thisPrefab].stack and bNotClean and v.components and v.components.stackable and v.components.stackable:StackSize() > 1 then break end
                        
                        if this_max_prefabs[thisPrefab].permission then
                            if countPer[thisPrefab] == nil then
                                countPer[thisPrefab] = {}
                            end
                            countPer[thisPrefab][#countPer[thisPrefab] + 1] = {
                                v,
                                (v.ownerlist ~= nil or v.saved_ownerlist ~= nil) and bNotClean and 1 or 0
                            }
                            break
                        end
                    else break end

                    -- 不可见物品(在包裹内等)
                    if v.inlimbo then break end

                    -- 在包裹内物品
                    --if IsInInventory(v) then break end

                    if countList[thisPrefab] == nil then
                        countList[thisPrefab] = { name = v.name, count = 1, currentcount = 1 }
                    else
                        countList[thisPrefab].count = countList[thisPrefab].count + 1
                        countList[thisPrefab].currentcount = countList[thisPrefab].currentcount + 1
                    end

                    if this_max_prefabs[thisPrefab].max >= countList[thisPrefab].count then break end

                    if (v.components.hunger ~= nil and v.components.hunger.current > 0) or (v.components.domesticatable ~= nil and v.components.domesticatable.domestication > 0) then
                        break
                    end

                    RemoveItem(v)
                    countList[thisPrefab].currentcount = countList[thisPrefab].currentcount - 1
                until true
            end
        end

        -- 需要判断权限的物体单独清理
        for k,v in pairs(countPer) do
            if #v > this_max_prefabs[k].max then
                table.sort(v, function(a,b) return a[2] < b[2] end)
                countList[k] = { name = v[1][1].name, count = #v, currentcount = #v }
                repeat
                    local itemObj = table.remove(v, 1)
                    if itemObj[2] == 0 then
                        RemoveItem(itemObj[1])
                        countList[k].currentcount = #v
                    else break end
                until this_max_prefabs[k].max >= #v
            end
        end

        for k,v in pairs(this_max_prefabs) do
            if countList[k] ~= nil and countList[k].count > v.max then
                print(string.format("[河蟹防熊锁]清理   %s(%s)   %d   %d   %d", countList[k].name, k, countList[k].count, countList[k].count - countList[k].currentcount, countList[k].currentcount))
            end
        end
    end

    local function CleanDelay(inst, time, level)
        TheNet:Announce(GetSayMsg("clean_warning", formServerName, time))
        inst:DoTaskInTime(time, Clean, level)
    end

    if clean_level ~= -1 then
        AddPrefabPostInit("world", function(inst)
            if clean_period > 0 then
                inst:DoPeriodicTask(clean_period * TUNING.TOTAL_DAY_TIME, CleanDelay, clean_period * TUNING.TOTAL_DAY_TIME, 15)
            end
        end)
    end

    -- 控制台命令
    _G.hx_clean = function(time, level)
        time = _G.tonumber(time)
        level = level and _G.tonumber(level) or (clean_level == -1 and 3 or nil)
        print("[河蟹防熊锁]手动清理", "hx_clean", time, level)
        if time ~= nil and time > 0 then
            CleanDelay(_G.TheWorld, time, level)
        else Clean(_G.TheWorld, level) end
    end

    _G.hx_clean_lv = function(level)
        level = _G.tonumber(level)
        print("[河蟹防熊锁]设置清理级别", level)
        if level ~= nil then
            clean_level = level
            max_prefabs = GetCustomPrefabs(clean_custom)
        end
    end

    _G.hx_clean_custom = function(custom_prefabs)
        clean_custom = custom_prefabs
        print("[河蟹防熊锁]设置自定义清理物品", custom_prefabs)
        max_prefabs = GetCustomPrefabs(clean_custom, max_prefabs)
    end

    _G.hx_clean_list = function()
        print("[河蟹防熊锁]待清理物品当前总数")
        local countList = {}
        local thisPrefab = nil

        for _,v in pairs(_G.Ents) do
            if v.prefab ~= nil then
                thisPrefab = v.prefab
                if max_prefabs[thisPrefab] ~= nil and not v.inlimbo then
                    if countList[thisPrefab] == nil then
                        countList[thisPrefab] = { name = v.name, count = 1, currentcount = 1 }
                    else
                        countList[thisPrefab].count = countList[thisPrefab].count + 1
                    end
                end
            end
        end

        for k,v in pairs(max_prefabs) do
            if countList[k] ~= nil then
                print("[河蟹防熊锁]", countList[k].name .."(".. k ..")", countList[k].count)
            end
        end
    end
end
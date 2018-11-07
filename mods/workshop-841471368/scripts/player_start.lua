-- 给予玩家初始物品
local give_start_item = GetModConfigData("give_start_item")

--给多少东西给玩家
local function giveItemToPlayer(startInventory, num, prefab_name)
	for i = 1, num do
		table.insert(startInventory, prefab_name)
	end
end

--玩家初始物品（可根据自己需要自行修改）
local function StartingInventory(inst, player)
	local startInventory = {}
	
	--配置初始物品--
	giveItemToPlayer(startInventory, 8, "cutgrass") --给8个草
	giveItemToPlayer(startInventory, 8, "twigs") --给8个树枝
	giveItemToPlayer(startInventory, 8, "log") --给8个木头
	giveItemToPlayer(startInventory, 8, "flint") --给8个燧石
	giveItemToPlayer(startInventory, 8, "rocks") --给8个岩石
	giveItemToPlayer(startInventory, 2, "meat") --给2个大肉

	giveItemToPlayer(startInventory, 1, "gears") --给1个齿轮
    giveItemToPlayer(startInventory, 1, "poop")--便便
    giveItemToPlayer(startInventory, 1, "green_mushroomhat")--绿帽子

	--初始进入的时间是冬天或者临近冬天的时候
	if GLOBAL.TheWorld.state.iswinter or (GLOBAL.TheWorld.state.isautumn and GLOBAL.TheWorld.state.remainingdaysinseason < 5) then
		--额外给的东西
		giveItemToPlayer(startInventory, 2, "cutgrass")
		giveItemToPlayer(startInventory, 2, "twigs")
		giveItemToPlayer(startInventory, 2, "log")
		giveItemToPlayer(startInventory, 1, "heatrock") --热能石
		giveItemToPlayer(startInventory, 1, "winterhat") --冬帽
	end
		
	--春天
	if GLOBAL.TheWorld.state.isspring or (GLOBAL.TheWorld.state.iswinter and GLOBAL.TheWorld.state.remainingdaysinseason < 3) then
		giveItemToPlayer(startInventory, 1, "umbrella") --雨伞
	end		
	
	--夏天
	if GLOBAL.TheWorld.state.issummer or (GLOBAL.TheWorld.state.isspring and GLOBAL.TheWorld.state.remainingdaysinseason < 5) then
		giveItemToPlayer(startInventory, 6, "nitre") --硝石
		giveItemToPlayer(startInventory, 6, "ice") --冰
		giveItemToPlayer(startInventory, 1, "heatrock")
		giveItemToPlayer(startInventory, 1, "strawhat") --西瓜帽
	end

	--夜晚
	if GLOBAL.TheWorld.state.isnight or (GLOBAL.TheWorld.state.isdusk and GLOBAL.TheWorld.state.timeinphase > .8) then
		giveItemToPlayer(startInventory, 1, "torch") --火炬
	end

	--如果初始点在洞穴
	if GLOBAL.TheWorld:HasTag("cave") then
		giveItemToPlayer(startInventory, 1, "minerhat") --矿工帽
	end

	--如果是PVP模式
	if GLOBAL.TheNet:GetPVPEnabled() then
		giveItemToPlayer(startInventory, 1, "spear") --长矛
		giveItemToPlayer(startInventory, 1, "footballhat") --皮帽
	end

	--玩家第一次进入时获取初始物品
	local CurrentOnNewSpawn = player.OnNewSpawn or function() return true end
	player.OnNewSpawn = function(...)
        PlayerSay(player, GetSayMsg("player_start"), nil, 5)

		player.components.inventory.ignoresound = true
		if startInventory ~= nil and #startInventory > 0 then
			for i, itemName in pairs(startInventory) do
				player.components.inventory:GiveItem(GLOBAL.SpawnPrefab(itemName))
			end
		end
		return CurrentOnNewSpawn(...)
	end
	
end

--初始化
AddPrefabPostInit("world", function(inst)
    if GLOBAL.TheWorld.ismastersim then --判断是不是主机
		--监听玩家安置，给初始物品
		if give_start_item then 
			inst:ListenForEvent("ms_playerspawn", StartingInventory, inst)
		end
    end
end)
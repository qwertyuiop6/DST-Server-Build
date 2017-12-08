--------------------------------------------------------------------------
--[[ Shard_PlayerChange ]]
--------------------------------------------------------------------------

return Class(function(self, inst)

assert(TheWorld.ismastersim, "Shard_PlayerChange 不应该存在于客户端")

--------------------------------------------------------------------------
--[[ Member variables ]]
--------------------------------------------------------------------------

--Public
self.inst = inst

--Private
local _world = TheWorld
local _ismastershard = _world.ismastershard
local _localPlayerTable = {}
local _allHistoryPlayerTable = {}
local _isInitPlayers = _ismastershard and true or false
local _task = nil

local _worldShardId = TheShard:GetShardId()

--Network
local _playerchange = net_string(inst.GUID, "shard_playerchange._playerchange", "playerchange")

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------

local UpdatePlayerStatus = _ismastershard and function()
    _task = nil

    local isStandalone = TheNet:GetServerIsClientHosted()
    local clientObjs = TheNet:GetClientTable()
    if type(clientObjs) == "table" then
        local thisPlayers = {}
        for i, v in ipairs(clientObjs) do
            if isStandalone or v.performance == nil then
                thisPlayers[v.userid] = {
                    userid = v.userid,
                    name = v.name,
                    prefab = v.prefab,
                }

                if _allHistoryPlayerTable[v.userid] == nil then
                    inst:DoTaskInTime(0, function(inst)
                        _playerchange:set("join;" .. v.userid)
                    end)
                end
            end
        end

        for k, v in pairs(_allHistoryPlayerTable) do
            if thisPlayers[k] == nil then
                inst:DoTaskInTime(0, function(inst)
                    _playerchange:set("leave;" .. k)
                end)
            end
        end

        _allHistoryPlayerTable = thisPlayers
    end
end or nil

--------------------------------------------------------------------------
--[[ Private event listeners ]]
--------------------------------------------------------------------------

local OnSlavePlayersChanged = _ismastershard and function( ... )
    if _task == nil then
        _task = inst:DoTaskInTime(0, UpdatePlayerStatus)
    end
end or nil

local OnLocalPlayersChanged = _ismastershard and function( ... )
    if _task == nil then
        _task = inst:DoTaskInTime(0, UpdatePlayerStatus)
    end
end or nil

local OnPlayerSpawn = _ismastershard and function(src, player)
    if not _localPlayerTable[player] then
        _localPlayerTable[player] = true
        inst:ListenForEvent("ms_becameghost", OnLocalPlayersChanged, player)
        inst:ListenForEvent("ms_respawnedfromghost", OnLocalPlayersChanged, player)
        OnLocalPlayersChanged()
    end
end or nil

local OnPlayerLeft = _ismastershard and function(src, player)
    if _localPlayerTable[player] then
        _localPlayerTable[player] = nil
        inst:RemoveEventCallback("ms_becameghost", OnLocalPlayersChanged, player)
        inst:RemoveEventCallback("ms_respawnedfromghost", OnLocalPlayersChanged, player)
        OnLocalPlayersChanged()
    end
end or nil

local function OnPlayerChange()
    -- 未进行初始化(仅用于副世界初始化)
    if not _isInitPlayers then
        _isInitPlayers = true

        local isStandalone = TheNet:GetServerIsClientHosted()
        local clientObjs = TheNet:GetClientTable()
        if type(clientObjs) == "table" then
            for i, v in ipairs(clientObjs) do
                if isStandalone or v.performance == nil then
                    _world:PushEvent("ms_gd_playerjoined",
                    {
                        userid = v.userid,
                    })
                end
            end
        end
    end

    local option, userid = nil, nil
    for opt, id in string.gmatch(_playerchange:value(), "([%w_-]+);([%w_-]+)") do
        option = opt
        userid = id
    end

    if option ~= nil then
        _world:PushEvent(option == "join" and "ms_gd_playerjoined" or "ms_gd_playerleft",
        {
            userid = userid,
        })
    end
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------

if _ismastershard then
    --Register master shard events
    inst:ListenForEvent("master_slaveplayerschanged", OnSlavePlayersChanged, _world)
    inst:ListenForEvent("ms_playerspawn", OnPlayerSpawn, _world)
    inst:ListenForEvent("ms_playerleft", OnPlayerLeft, _world)

    --Initialize network variables
    for i, v in ipairs(AllPlayers) do
        OnPlayerSpawn(nil, v)
    end
    if _task ~= nil then
        _task:Cancel()
    end
    UpdatePlayerStatus()
end

--Register network variable sync events
inst:ListenForEvent("playerchange", OnPlayerChange)

--------------------------------------------------------------------------
--[[ Public member functions ]]
--------------------------------------------------------------------------

function self:LastPlayerChange()
    return _playerchange:value()
end

--------------------------------------------------------------------------
--[[ End ]]
--------------------------------------------------------------------------

end)

require "behaviours/wander"
require "behaviours/follow"

local MAX_WANDER_DIST = 20

local MIN_FOLLOW_DIST = 1
local MAX_FOLLOW_DIST = 10
local TARGET_FOLLOW_DIST = 4

local Mushasporebrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetLeader(inst)
    return inst.components.follower and inst.components.follower.leader
end

local function FindObjectToFollow(inst)
	--(inst, radius, fn, musttags, canttags, mustoneoftags)
	if not inst.followobj or not inst.followobj:IsValid() or inst.followobj:GetPosition():Dist(inst:GetPosition()) > MAX_FOLLOW_DIST + 10 then
        inst.followobj = FindEntity(inst, MAX_FOLLOW_DIST, nil, nil, nil, {"player", "character", "monster"})
	end

	return inst.followobj
end

function Mushasporebrain:OnStart()

	local root =
	PriorityNode(
	{
        Follow(self.inst, FindObjectToFollow, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
		Follow(self.inst, GetLeader, 1, 5, 7),
		--Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST,
        --    {minwalktime=50,  randwalktime=3, minwaittime=1.5, randwaittime=0.5})
		Wander(self.inst, function() if self.inst.components.follower.leader then return Vector3(self.inst.components.follower.leader.Transform:GetWorldPosition()) end end, MAX_FOLLOW_DIST- 1, {minwalktime=1, randwalktime=1, minwaittime=1, randwaittime=5})	
	}, 1)

	self.bt = BT(self.inst, root)
end

return Mushasporebrain

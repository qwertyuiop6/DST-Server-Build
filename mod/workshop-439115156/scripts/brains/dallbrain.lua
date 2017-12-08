require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
--require "behaviours/attackwall"
require "behaviours/follow"

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 6
local MAX_FOLLOW_DIST = 8

local DallBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function DallBrain:OnStart()
    local root =
        PriorityNode(
        {
			--AttackWall(self.inst),
            ChaseAndAttack(self.inst),
			       Follow(self.inst, function() return self.inst.components.follower ~= nil and self.inst.components.follower.leader or nil end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, false),
           --   Wander(self.inst, function() if not self.inst.components.follower.leader then return Vector3(self.inst.components.follower.leader.Transform:GetWorldPosition()) end end, 15, {minwalktime=.5, randwalktime=.5, minwaittime=6, randwaittime=3}),         
        },1)
    
    self.bt = BT(self.inst, root)
end

return DallBrain
require "behaviours/panic"
require "behaviours/standstill"
require "behaviours/chaseandattack"
--require "behaviours/leash"
require "behaviours/wander"
require "behaviours/follow"
local MIN_FOLLOW_DIST = 2
local TARGET_FOLLOW_DIST = 5
local MAX_FOLLOW_DIST = 9
local WANDER_DIST_DAY = 20
local WANDER_DIST_NIGHT = 5

local MoonNutDrakeBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MAX_WANDER_DIST = 5

local function ExitAction(inst)
    if not inst:HasTag("exit") then
        inst:AddTag("exit")
        inst.sg:GoToState("idle")
        inst:DoTaskInTime(.3, function(inst)
            inst.sg:GoToState("exit")
        end)
    end
end

local function GetLeader(inst)
    return inst.components.follower.leader 
end
local function GetWanderDistFn(inst)
    return TheWorld.state.isday and WANDER_DIST_DAY or WANDER_DIST_NIGHT
end

function MoonNutDrakeBrain:OnStart()
    local root = 
    PriorityNode(
    {
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
       -- Leash(self.inst, self.inst.components.knownlocations:GetLocation("spawnpoint"), 20, 5),
        ChaseAndAttack(self.inst, 8, 14),
        --StandStill(self.inst),
        --Wander(self.inst, function() return self.inst:GetPosition() end, MAX_WANDER_DIST),
	
     --  Follow(self.inst, function() return self.inst.components.follower ~= nil and self.inst.components.follower.leader or nil end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, false),
	    Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        --FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
		--FaceEntity(self.inst, GetLeader, GetLeader),	
		       Wander(self.inst, function() if self.inst.components.follower.leader then return Vector3(self.inst.components.follower.leader.Transform:GetWorldPosition()) end end, MAX_FOLLOW_DIST- 1, {minwalktime=.5, randwalktime=.5, minwaittime=6, randwaittime=3}),
      --  Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("spawnpoint") end, GetWanderDistFn),	
        DoAction(self.inst, ExitAction, "exit", true),
    }, 0.25)
	 
    self.bt = BT(self.inst, root)
end
--[[
function MoonNutDrakeBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("spawnpoint", Point(self.inst.Transform:GetWorldPosition()))
end]]

return MoonNutDrakeBrain
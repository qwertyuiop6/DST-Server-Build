require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/follow"
--require "behaviours/attackwall"
require "behaviours/runaway"
--require "behaviours/doaction"
local BrainCommon = require("brains/braincommon")

-- states
local GREETING = "greeting"
local LOITERING = "loitering"
local WANDERING = "wandering"

local STOP_RUN_DIST = 10
local SEE_PLAYER_DIST = 5
local WANDER_DIST_DAY = 20
local WANDER_DIST_NIGHT = 5
local START_FACE_DIST = 4
local KEEP_FACE_DIST = 6

local MAX_CHASE_TIME = 6

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 6
local MAX_FOLLOW_DIST = 8

local GREET_SEARCH_RADIUS = 4
local GREET_DURATION = 2

local MIN_GREET_DIST = 1
local TARGET_GREET_DIST = 3
local MAX_GREET_DIST = 5

local LOITER_SEARCH_RADIUS = 30
local TARGET_LOITER_DIST = 10
local LOITER_DURATION = TUNING.SEG_TIME * 4

local LOITER_ANCHOR_RESET_DIST = 20
local LOITER_ANCHOR_HERD_DIST = 40

local function GetFaceTargetFn(inst)
    if not(inst.components.domesticatable and inst.components.domesticatable:IsDomesticated()) then
        local target = FindClosestPlayerToInst(inst, START_FACE_DIST, true)
		return target ~= nil and not target:HasTag("notarget") and target or nil
    end
end

local function KeepFaceTargetFn(inst, target)
    return inst ~= nil
        and target ~= nil
        and inst:IsValid()
        and target:IsValid()
        and not (target:HasTag("notarget") or
                target:HasTag("playerghost"))
        and inst:IsNear(target, KEEP_FACE_DIST)
end

local function GetWanderDistFn(inst)
    return TheWorld.state.isday and WANDER_DIST_DAY or WANDER_DIST_NIGHT
end

local function GetLoiterTarget(inst)
    return FindClosestPlayerToInst(inst, LOITER_SEARCH_RADIUS, true)
end

local function GetGreetTarget(inst)
    return FindClosestPlayerToInst(inst, GREET_SEARCH_RADIUS, true)
end

local function GetGreetTargetPosition(inst)
    local greetTarget = GetGreetTarget(inst)
    return greetTarget ~= nil and greetTarget:GetPosition() or inst:GetPosition()
end

local function GetLoiterAnchor(inst)
    if inst.components.knownlocations:GetLocation("loiteranchor") == nil then
        inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())

    elseif inst.components.knownlocations:GetLocation("herd") ~= nil and inst:GetDistanceSqToPoint(inst.components.knownlocations:GetLocation("herd")) < LOITER_ANCHOR_HERD_DIST*LOITER_ANCHOR_HERD_DIST then
        inst.components.knownlocations:RememberLocation("loiteranchor", inst.components.knownlocations:GetLocation("herd"))

    elseif inst:GetDistanceSqToPoint(inst.components.knownlocations:GetLocation("loiteranchor")) > LOITER_ANCHOR_RESET_DIST*LOITER_ANCHOR_RESET_DIST then
        inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
    end

    return inst.components.knownlocations:GetLocation("loiteranchor")
end

local function TryBeginLoiterState(inst)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    if (herd and herd.components.mood and herd.components.mood:IsInMood())
        or (inst.components.mood and inst.components.mood:IsInMood()) then
        return false
    end

    if GetTime() - inst._startgreettime < GREET_DURATION then
        inst._startgreettime = GetTime() - GREET_DURATION
        return true
    end
    return false
end

local function TryBeginGreetingState(inst)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    if (herd and herd.components.mood and herd.components.mood:IsInMood())
        or (inst.components.mood and inst.components.mood:IsInMood()) then
        return false
    end

    if inst.components.domesticatable ~= nil
        and inst.components.domesticatable:GetDomestication() > 0.0
        and GetGreetTarget(inst) ~= nil then

        inst._startgreettime = GetTime()
        return true
    end
    return false
end

local function InState(inst, state)
    if inst._startgreettime == nil then
        inst._startgreettime = -1000000
    end
    local timedelta = GetTime() - inst._startgreettime
    if timedelta < GREET_DURATION then
        return state == GREETING
    elseif timedelta < LOITER_DURATION then
        return state == LOITERING
    else
        return state == WANDERING
    end
end

local function Health_switch(inst, target)
    return inst.avoid_arong
end

local function GetLeader(inst)
    return inst.components.follower ~= nil and inst.components.follower.leader or nil
end

local function GetWanderDistFn(inst)
    return TheWorld.state.isday and WANDER_DIST_DAY or WANDER_DIST_NIGHT
end

local ArongBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)
-------------------------------------------------------------------------------
--  Combat Avoidance
local COMBAT_TOO_CLOSE_DIST = 6                 -- distance for find enitities check
local COMBAT_TOO_CLOSE_DIST_SQ = COMBAT_TOO_CLOSE_DIST * COMBAT_TOO_CLOSE_DIST
local COMBAT_SAFE_TO_WATCH_FROM_DIST = 9        -- will run to this distance and watch if was too close
local COMBAT_SAFE_TO_WATCH_FROM_MAX_DIST = 13   -- combat is quite far away now, better catch up
local COMBAT_SAFE_TO_WATCH_FROM_MAX_DIST_SQ = COMBAT_SAFE_TO_WATCH_FROM_MAX_DIST * COMBAT_SAFE_TO_WATCH_FROM_MAX_DIST
local COMBAT_TIMEOUT = 6
local function _avoidtargetfn(self, target)
    if target == nil or not target:IsValid() then
        return false
    end

    local owner = self.inst.components.follower.leader
    local owner_combat = owner ~= nil and owner.components.combat or nil
    local target_combat = target.components.combat
    if owner_combat == nil or target_combat == nil then
        return false
    elseif target_combat:TargetIs(owner)
        or (target.components.grouptargeter ~= nil and target.components.grouptargeter:IsTargeting(owner)) then
        return true
    end

    local distsq = owner:GetDistanceSqToInst(target)
    if distsq >= COMBAT_SAFE_TO_WATCH_FROM_MAX_DIST_SQ then
        -- Too far
        return false
    elseif distsq < COMBAT_TOO_CLOSE_DIST_SQ and target_combat:HasTarget() then
        -- Too close to any combat
        return true
    end

    -- Is owner in combat with target?
    -- Are owner and target both in any combat?
    local t = GetTime()
    return  (   (owner_combat:IsRecentTarget(target) or target_combat:HasTarget()) and
                math.max(owner_combat.laststartattacktime, owner_combat.lastdoattacktime or 0) + COMBAT_TIMEOUT > t
            ) or
            (   owner_combat.lastattacker == target and
                owner_combat:GetLastAttackedTime() + COMBAT_TIMEOUT > t
            )
end

local function CombatAvoidanceFindEntityCheck(self)
    return function(ent)
            if _avoidtargetfn(self, ent) then
                self.inst:PushEvent("critter_avoidcombat", {avoid=true})
                self.runawayfrom = ent
                return true
            end
            return false
        end
end

local function ValidateCombatAvoidance(self)
    if self.runawayfrom == nil then
        return false
    end

    if not self.runawayfrom:IsValid() then
        self.inst:PushEvent("critter_avoidcombat", {avoid=false})
        self.runawayfrom = nil
        return false
    end

    if not self.inst:IsNear(self.runawayfrom, COMBAT_SAFE_TO_WATCH_FROM_MAX_DIST) then
        return false
    end

    if not _avoidtargetfn(self, self.runawayfrom) then
        self.inst:PushEvent("critter_avoidcombat", {avoid=false})
        self.runawayfrom = nil
        return false
    end

    return true
end

-------------------------------------------------------------------------------
function ArongBrain:OnStart()
    local root = PriorityNode(
    {
	RunAway(self.inst,  {tags={"_combat", "_health"}, notags={"wall", "INLIMBO"},fn=CombatAvoidanceFindEntityCheck(self)}, 7, 10, function(target) return Health_switch(self.inst, target) end ),
        WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
		--[[
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        IfNode(function() return self.inst.components.combat.target ~= nil end, "hastarget", AttackWall(self.inst)),
        ChaseAndAttack(self.inst, MAX_CHASE_TIME),]]
				WhileNode( function() return self.inst.components.health:GetPercent() < 0.5 and self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily", ChaseAndAttack(self.inst, 8,12)),
              WhileNode( function() return self.inst.components.health:GetPercent() < 0.5 and self.inst.components.combat.target and self.inst.components.combat:InCooldown() end, "Dodge",
                    RunAway(self.inst, function() return self.inst.components.combat.target end, 3, 10) ),
					--ChaseAndAttack(self.inst, 10,14),
					ChaseAndAttack(self.inst, 3,4),
        Follow(self.inst, function() return self.inst.components.follower ~= nil and self.inst.components.follower.leader or nil end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, false),
        --FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
		--FaceEntity(self.inst, GetLeader, GetLeader),	
        BrainCommon.AnchorToSaltlick(self.inst),

         -- hanging around herd
        ConditionNode(function() return InState(self.inst, WANDERING) and TryBeginGreetingState(self.inst) end, "Wandering"),

        -- wants to greet feeder
        WhileNode(function() return InState(self.inst, GREETING) end, "Greeting", PriorityNode{
            --Follow(self.inst, GetGreetTarget, MIN_GREET_DIST, TARGET_GREET_DIST, MAX_GREET_DIST, true),
            ActionNode(function() TryBeginLoiterState(self.inst) end, "Finish greeting")
        }),

        -- anchor to nearest saltlick
        BrainCommon.AnchorToSaltlick(self.inst),

        -- waiting for feeder
        WhileNode(function() return InState(self.inst, LOITERING) end, "Loitering", PriorityNode{
            WhileNode(function() return GetLoiterTarget(self.inst) ~= nil end, "Anyone nearby?", PriorityNode{
                FailIfSuccessDecorator( ActionNode(function() TryBeginLoiterState(self.inst) end, "Reset Loiter Time") ),
                --Follow(self.inst, GetGreetTarget, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, false),
                Wander(self.inst, function() return GetGreetTargetPosition(self.inst) end, TARGET_LOITER_DIST)
            }),
            Wander(self.inst, function() return GetLoiterAnchor(self.inst) end, GetWanderDistFn),
        }),
		
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("herd") end, GetWanderDistFn)
    }, .25)

    self.bt = BT(self.inst, root)
end

return ArongBrain

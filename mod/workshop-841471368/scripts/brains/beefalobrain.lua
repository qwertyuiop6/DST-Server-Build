require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/attackwall"
--require "behaviours/runaway"
require "behaviours/doaction"

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

local MIN_FOLLOW_DIST = 1
local TARGET_FOLLOW_DIST = 10
local MAX_FOLLOW_DIST = 12

local GREET_SEARCH_RADIUS = 15
local GREET_DURATION = 3

local MIN_GREET_DIST = 1
local TARGET_GREET_DIST = 3
local MAX_GREET_DIST = 5

local LOITER_SEARCH_RADIUS = 30
local TARGET_LOITER_DIST = 10
local LOITER_DURATION = TUNING.SEG_TIME * 4

local LOITER_ANCHOR_RESET_DIST = 20
local LOITER_ANCHOR_HERD_DIST = 40

local function GetFaceTargetFn(inst)
    if not (inst.components.domesticatable ~= nil and inst.components.domesticatable:IsDomesticated()) and
        not BrainCommon.ShouldSeekSalt(inst) then
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
        and not BrainCommon.ShouldSeekSalt(inst)
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

--通过id获取当前世界玩家
function GetTheWorldPlayerById(id)
    for _,p in pairs(AllPlayers) do
        if p.userid == id then 
            return p
        end
    end
	return nil
end

local function GetLeader(inst)
    local leader = inst.components.follower ~= nil and inst.components.follower.leader or inst.ownerlist and GetTheWorldPlayerById(inst.ownerlist.master) or nil
    return leader ~= nil and (leader.beefalo_follow and leader) or nil
end

-- 攻击主人的目标
local KEEP_ATTACKING_DIST = 30
local function KeepAttackingAction(inst)
    local leader = GetLeader(inst)
    return (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_ATTACKING_DIST))
        or (leader ~= nil and
            inst:IsNear(leader, KEEP_ATTACKING_DIST))
end

local function StartAttackingCondition(inst)
    local leader = GetLeader(inst)
    return (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("attack"))
        or (leader ~= nil and
            leader.sg ~= nil and
            leader.sg:HasStateTag("attack"))
end

local function FindLeaderToAttackAction(inst)
    local leader = GetLeader(inst)
    if leader ~= nil then
        local target = leader.sg.statemem.attacktarget
        if target ~= nil then
            if inst.components.combat and inst.components.combat.target ~= target then
                inst.components.combat:SetTarget(target)
            end
            return BufferedAction(inst, target, ACTIONS.ATTACK)
        end
    end
end

-- 攻击对主人有敌意的目标
local SEE_HOSTILE_DIST = 15
local function IsHostileAttacker(guy, inst)
    local leader = GetLeader(inst)
    return guy.components.combat and ((leader ~= nil and guy.components.combat.target == leader) or (inst.components.follower.leader ~= nil and guy.components.combat.target == inst.components.follower.leader))
end

local function FindHostileAttacker(inst)
    return FindEntity(inst, SEE_HOSTILE_DIST, IsHostileAttacker, { "_combat" })
end

local function KeepAttackerAction(inst)
    local leader = GetLeader(inst)
    return (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_ATTACKING_DIST))
        or (leader ~= nil and
            inst:IsNear(leader, KEEP_ATTACKING_DIST))
end

local function StartAttackerCondition(inst)
    return FindHostileAttacker(inst) ~= nil
end

local function FindHostileToAttackAction(inst)
    if inst.components.combat and inst.components.combat.target == nil then
        local target = FindHostileAttacker(inst)
        if target ~= nil then
            inst.components.combat:SetTarget(target)
            return BufferedAction(inst, target, ACTIONS.ATTACK)
        end
    end
end

local BeefaloBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function BeefaloBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire",
            Panic(self.inst)),
        IfNode(function() return self.inst.components.combat.target ~= nil end, "hastarget",
            AttackWall(self.inst)),
        ChaseAndAttack(self.inst, MAX_CHASE_TIME),
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, true),
        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),

        -- 攻击主人攻击的目标
        IfNode(function() return StartAttackingCondition(self.inst) end, "attack", 
            WhileNode(function() return KeepAttackingAction(self.inst) end, "keep attacking",
                LoopNode{ DoAction(self.inst, FindLeaderToAttackAction ) }
            )
        ),

        -- 攻击对主人有敌意的目标
        IfNode(function() return StartAttackerCondition(self.inst) end, "attacker", 
            WhileNode(function() return KeepAttackerAction(self.inst) end, "keep attacker",
                LoopNode{ DoAction(self.inst, FindHostileToAttackAction ) }
            )
        ),

        -- 跟随牛群
        ConditionNode(function() return InState(self.inst, WANDERING) and TryBeginGreetingState(self.inst) end, "Wandering"),

        -- 打招呼
        WhileNode(function() return InState(self.inst, GREETING) end, "Greeting", PriorityNode{
            Follow(self.inst, GetGreetTarget, MIN_GREET_DIST, TARGET_GREET_DIST, MAX_GREET_DIST, true),
            ActionNode(function() TryBeginLoiterState(self.inst) end, "Finish greeting")
        }),

        -- 锚点定向到最近的盐碱地
        BrainCommon.AnchorToSaltlick(self.inst),

        -- 等待饲养者
        WhileNode(function() return InState(self.inst, LOITERING) end, "Loitering", PriorityNode{
            WhileNode(function() return GetLoiterTarget(self.inst) ~= nil end, "Anyone nearby?", PriorityNode{
                FailIfSuccessDecorator( ActionNode(function() TryBeginLoiterState(self.inst) end, "Reset Loiter Time") ),
                Follow(self.inst, GetGreetTarget, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, false),
                Wander(self.inst, function() return GetGreetTargetPosition(self.inst) end, TARGET_LOITER_DIST)
            }),
            Wander(self.inst, function() return GetLoiterAnchor(self.inst) end, GetWanderDistFn),
        }),

        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("herd") end, GetWanderDistFn)

    }, .25)

    self.bt = BT(self.inst, root)
end

return BeefaloBrain

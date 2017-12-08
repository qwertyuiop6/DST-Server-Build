require "brains/ghosthoundbrain"
local brain = require "brains/ghosthoundbrain"
local HOUND_NEAR_LEADER_DISTANCE = 20
local assets=
{
	Asset("ANIM", "anim/ghosthound.zip"),
	Asset("SOUND", "sound/hound.fsb"),
}

local prefabs =
{
}
SetSharedLootTable( 'ghosth',
{
    })


local WAKE_TO_FOLLOW_DISTANCE = 5
--local SLEEP_NEAR_HOME_DISTANCE = 10
local SHARE_TARGET_DIST = 30
local HOME_TELEPORT_DIST = 30
--

local function ondeath(inst)
SpawnPrefab("ice_splash").Transform:SetPosition(inst:GetPosition():Get()) inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
end 
local function die(inst)
	inst.components.health:Kill()
end
local function dead(inst, data)
local leader = inst.components.follower.leader
--if inst.components.follower:IsNearLeader(HOUND_NEAR_LEADER_DISTANCE) then
if inst.components.hunger:GetPercent() <= 1 and inst.components.hunger:GetPercent() >= 0.7 then
    inst.Transform:SetScale(0.4, 0.4, 0.4)
 elseif inst.components.hunger:GetPercent() < 0.7 and inst.components.hunger:GetPercent() >= 0.5 then
    inst.Transform:SetScale(0.35, 0.35, 0.35)
elseif inst.components.hunger:GetPercent() < 0.5 and inst.components.hunger:GetPercent() >= 0.1 then
    inst.Transform:SetScale(0.3, 0.3, 0.3)
elseif inst.components.hunger:GetPercent() < 0.1 and inst.components.hunger.current > 0  then
    inst.Transform:SetScale(0.25, 0.25, 0.25)
elseif inst.components.hunger.current == 0 then
if inst.components.follower:IsNearLeader(HOUND_NEAR_LEADER_DISTANCE) then
SpawnPrefab("ice_splash").Transform:SetPosition(leader:GetPosition():Get())
leader.components.health:DoDelta(5)
end
            die(inst)
end
end



local function onkilll(inst, data)
local smallllchance = 0.1
local normalchance = 0.2
local leader = inst.components.follower.leader
if inst.components.follower:IsNearLeader(HOUND_NEAR_LEADER_DISTANCE) then
	if leader and leader:HasTag("musha") and not leader:HasTag("playerghost") then
	
	local victim = data.victim
	if not victim:HasTag("smashable") or victim:HasTag("cavedweller") or victim:HasTag("object") then
	   if not (victim:HasTag("prey") or
            victim:HasTag("veggie") or
            victim:HasTag("eyeplant") or
            victim:HasTag("insect") or			
            victim:HasTag("structure")) then
    local delta = victim.components.combat.defaultdamage * 0.25
		   if math.random() < normalchance then
    				leader.level = leader.level + 1
 leader.components.talker:Say("Extra [EXP](+1) \n".. (leader.level))

					end					
				end
		  if (victim:HasTag("prey") or
              victim:HasTag("insect") or			
            victim:HasTag("frog")) then
    local delta = victim.components.combat.defaultdamage * 0.1
		   if math.random() < smallllchance then
    				leader.level = leader.level + 1
 leader.components.talker:Say("Extra [EXP](+1) \n".. (leader.level))			
  	end	end end
	end end 
end
	
local function ShouldWakeUp(inst)
    return not inst.stop
end

local function ShouldSleep(inst)
    return inst.stop
end	

local function Onfreeze(attacked, data)
        if data and data.attacker and data.attacker.components.freezable and not data.attacker:HasTag("musha") then
            data.attacker.components.freezable:AddColdness(0.6)
            data.attacker.components.freezable:SpawnShatterFX()
        end end

local function onclose(inst)
local leader = inst.components.follower.leader
if inst.components.follower:IsNearLeader(HOUND_NEAR_LEADER_DISTANCE) then
inst.components.locomotor.runspeed = 10
end end

local function far(inst)
local leader = inst.components.follower.leader
if inst.components.follower:IsNearLeader(HOUND_NEAR_LEADER_DISTANCE) then
inst.components.locomotor.runspeed = 18
inst.components.combat:GiveUp()
end end

local function ghound_update(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 10, {"player"})
for k,v in pairs(ents) do
if inst.ghound and not inst.components.follower.leader then
v.components.leader:AddFollower(inst)
inst.components.hunger:SetRate(100/TUNING.TEENBIRD_STARVE_TIME)
elseif not inst.ghound then
inst.components.follower:SetLeader(nil)
inst.components.hunger:SetRate(0)
end end end

local function onusehound(inst, data)
if not inst.ghound then
inst.Light:Enable(true)
inst.ghound = true
inst.sg:GoToState("taunt")
inst.components.talker:Say("Follow\nSummon time(start)")
inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
inst.stop = false
if inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp()
end 
end  end
local function offusehound(inst, data)
if inst.ghound then
inst.Light:Enable(false)
inst.ghound = false
inst.components.locomotor.runspeed = 3
inst.sg:GoToState("hit")
inst.components.talker:Say("Stop\nSummon time(stop)")
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
inst.stop = true
--inst.peace = false
--inst.active_hunt = false
--inst.defense = false
end 
end 

local function OnHitvampire(inst, data)
--local vampirechance = 0.2
local other = data.target
if not (other:HasTag("smashable")) then
   --local pos = other:GetPosition()
if other and other.components.health then
   --SpawnPrefab("statue_transition").Transform:SetPosition(other:GetPosition():Get())
        inst.components.health:DoDelta(10)
elseif other and other:HasTag("musha") then
	inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
    end
end
end

local function OnNewTarget(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
    if data.target and data.target:HasTag("musha") then
	return
elseif other and other:HasTag("musha") then
	inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()

end
end
end


local function retargetfn(inst)
    local dist = TUNING.HOUND_TARGET_DIST
        -- dist = TUNING.HOUND_FOLLOWER_TARGET_DIST
        if inst.components.combat.target == inst.components.follower.leader then
            inst.components.combat:SetTarget(nil)
        end
        inst.components.follower:SetLeader(nil)
end

local function KeepTarget(isnt, target)
    return target and target:IsValid()
end


local function OnAttacked(inst, data)
	if data.attacker and data.attacker:HasTag("musha") or data.attacker:HasTag("player") then
	inst.components.machine:TurnOff()
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
	inst.components.follower:SetLeader(nil)
    end
    inst.components.combat:SuggestTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 10, function(dude) return dude:HasTag("yamche") and not dude.components.health:IsDead() end, 6)
end

local function fnghost()
  local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
      
	MakeCharacterPhysics(inst, 10, .5)
	RemovePhysicsColliders(inst)
	
    inst.DynamicShadow:SetSize(1.5, 0.5)
	inst.Transform:SetFourFaced()

    inst:AddTag("scarytoprey")
    inst:AddTag("ghound")
    --inst:AddTag("houndmound")
    inst:AddTag("companion")
    inst:AddTag("notraptrigger")
  --  inst:AddTag("character")
  
    inst:AddTag("noauradamage")
	
	inst.AnimState:SetBank("hound")
    inst.AnimState:SetBuild("ghosthound")
    inst.AnimState:PlayAnimation("idle")
	
	inst.entity:AddLight()
	inst.Light:SetRadius(.3)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.3)
    inst.Light:SetColour(50/255,50/255,50/255)
	--inst.Light:Enable(true)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
			    inst:AddComponent("talker")
    inst.components.talker.fontsize = 24
    inst.components.talker.colour = Vector3(20, 20, 100, 1)
inst.Transform:SetScale(0.3, 0.3, 0.3)

    if not TheWorld.ismastersim then
        return inst
    end
   inst.entity:SetPristine()

    inst:AddComponent("locomotor") 
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst.components.locomotor.runspeed = TUNING.HOUND_SPEED
    inst:SetStateGraph("SGdogs")
   
    inst:SetBrain(brain)
	
	inst:AddComponent("follower")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(80)
    inst:AddComponent("hunger")
	inst.components.hunger:SetMax(150)
	inst.components.hunger:SetRate(0)
inst.components.health:SetAbsorptionAmount(0.5)
					
    inst:AddComponent("inspectable")
  
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(7, 7)
    inst.components.playerprox:SetOnPlayerNear(onclose)
    inst.components.playerprox:SetOnPlayerFar(far)
	
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HOUND_DAMAGE*0.5)
    inst.components.combat:SetAttackPeriod(TUNING.ICEHOUND_ATTACK_PERIOD)
    inst.components.combat.playerdamagepercent = 0
	
	    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(0)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
    inst:AddComponent("machine")
    inst.components.machine.turnonfn = onusehound
    inst.components.machine.turnofffn = offusehound
    inst.components.machine.cooldowntime = 0

	offusehound(inst)
	inst.stop = true
	
    inst.components.combat:SetAttackPeriod(2)
  --  inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst:ListenForEvent("newcombattarget", OnNewTarget)
dead(inst)
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", ondeath)
	inst:ListenForEvent("hungerdelta", dead)
	inst:ListenForEvent("hungerdelta", ghound_update)
	inst:ListenForEvent("attacked", Onfreeze)
    inst:ListenForEvent("onhitother", OnHitvampire)
	
     inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('ghosth')
  local leader = inst.components.follower.leader
if not inst.components.follower.leader then
inst.components.hunger:SetRate(0)
end    
	inst:ListenForEvent("killed", onkilll)

	inst:DoPeriodicTask(0.3, function()
	if inst.followdog then
	inst.followdog = false
	inst.stop = false
	onusehound(inst)
	inst.components.machine:TurnOn()
	ghound_update(inst)
	end
	end)
	
    return inst
end



return Prefab ( "ghosthound2", fnghost, assets, prefabs) 

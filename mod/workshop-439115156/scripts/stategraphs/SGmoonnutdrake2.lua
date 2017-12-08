require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "action"),
}

local events =
{
    EventHandler("gotosleep", function(inst)
        if not inst.sg:HasStateTag("hidden") then
            inst.sg:GoToState("exit")
        end
    end),
    CommonHandlers.OnFreeze(),
    EventHandler("doattack", function(inst, data) 
        if not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            --target CAN go invalid because SG events are buffered
            inst.sg:GoToState(
                data.target:IsValid()
                and not inst:IsNear(data.target, 2)
                and "attack_leap"
                or "attack",
                data.target
            )
        end 
    end),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnLocomote(false, true),
}

local states =
{
	State
	{
		name = "idle",
		tags = {"idle"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.target = nil
			inst.AnimState:PlayAnimation("idle_loop")
		end,

		events =
		{
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end)
		},
	},

	State
	{
		name = "spawn",
		tags = { "busy", "hidden", "noattack" },

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("ground_enter")
		end,

		timeline =
		{
			TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_pop_small") end),
		},

		events =
		{
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("enter") 
			end)
		},
	},

	State
	{
		name = "ground_idle",
		tags = { "idle", "hidden", "noattack" },

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("ground_loop")
		end,

		timeline =
		{
		},

		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("ground_idle")
			end)
		},
	},

	State
	{
		name = "enter",
		tags = { "busy", "hidden", "noattack" },

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("enter")
		end,

		timeline =
		{
			TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_pop_large") end),
		},

		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end)
		},
	},

	State
	{
		name = "exit",
		tags = {"busy", "hidden", "noattack", "exit"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.Physics:SetMass(99999)
			inst.AnimState:PushAnimation("exit", false)
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_jump")
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_run_voice")
		end,

		timeline =
		{
			TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_intoground") end),
			TimeEvent(20*FRAMES, function(inst) RemovePhysicsColliders(inst) end),
		},

		events =
		{
			EventHandler("animqueueover", function(inst)
				inst:Remove()
			end)
		},
	},

	State
	{
		name = "attack_leap",
		tags = {"attack", "canrotate", "busy", "jumping"},

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("atk")
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_jump")
            inst.sg.statemem.target = target
        end,

        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
        end,

		timeline =
		{
            TimeEvent(3*FRAMES, function(inst) inst.Physics:SetMotorVelOverride(5,0,0) end),
            TimeEvent(12*FRAMES, function(inst)
            	inst.components.combat:DoAttack(inst.sg.statemem.target)
            	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_attack")
            end),
            TimeEvent(25*FRAMES,
				function(inst)
                    inst.Physics:ClearMotorVelOverride()
					inst.components.locomotor:Stop()
				end),
		},

		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end)
		},
	},
}

CommonStates.AddCombatStates(states,
{
	hittimeline = {},
	attacktimeline =
	{
		TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_jump") end),
		TimeEvent(12*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_attack")
			inst.components.combat:DoAttack(inst.sg.statemem.target)
		end)
	},
	deathtimeline =
	{
		TimeEvent(1*FRAMES, function(inst)
			RemovePhysicsColliders(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_die")
		end),
	},
})

CommonStates.AddWalkStates(states,
{
    walktimeline =
    {
        TimeEvent(FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_run_voice")
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/deciduous/drake_run_rustle")
        end),
    },
})
CommonStates.AddSleepStates(states)
CommonStates.AddFrozenStates(states)

return StateGraph("moonnutdrake2", states, events, "spawn", actionhandlers)

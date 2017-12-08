require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/musha_oven.zip"),
	Asset("ANIM", "anim/ui_chest_3x3.zip"),
}

local prefabs =
{
    "musha_ovenfire",
	"musha_ovenfire_cold",
    "collapse_small",
}    



local function cooked(inst)

	local container = inst.components.container

	if not inst.on_cold then
		for i = 1, container:GetNumSlots() do
	        local item = container:GetItemInSlot(i)
	     	if item then 
	     		local replacement = nil 
				if item.components.cookable or item.prefab == "log" then 
				inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 
						local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(0.5, 0.5, 0.5)
				fx.Transform:SetPosition(pos:Get())
	
        local fx2 = SpawnPrefab("small_puff")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(0, 3, 0)
		
				end
				
		     	if item.components.cookable then 
		     		replacement = item.components.cookable:GetProduct()
		     	elseif item.prefab == "log" then 
		     		replacement = "charcoal"
					
		     	elseif item.components.burnable and not item.prefab == "log" then 
		     		replacement = "ash"				
		     	end  
		     	if replacement then 
	     			local stacksize = 1 
	     			if item.components.stackable then 
	     				stacksize = item.components.stackable:StackSize()
	     			end 
	     			local newprefab = SpawnPrefab(replacement)
	     			if newprefab.components.stackable then 
	     				newprefab.components.stackable:SetStackSize(stacksize)
	     			end 
	     			container:RemoveItemBySlot(i)
	     			item:Remove()
	     			container:GiveItem(newprefab, i)
	     		end 
		     end 
		end 
		return false 
	end 
	if inst.on_cold then
		for i = 1, container:GetNumSlots() do
	        local item = container:GetItemInSlot(i)
	     	if item then 
	     		local replacement = nil 
				if item.prefab == "watermelon" or item.prefab == "butter" or item.prefab == "cave_banana" then 
				inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") 
						local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(0.5, 0.5, 0.5)
				fx.Transform:SetPosition(pos:Get())
				end
				
		     	if item.prefab == "watermelon" then 
		     		replacement = "watermelonicle"
				elseif item.prefab == "butter" then 
		     		replacement = "icecream"
				elseif item.prefab == "cave_banana" then 
		     		replacement = "bananapop"	
						     	end  
		     	if replacement then 
	     			local stacksize = 1 
	     			if item.components.stackable then 
	     				stacksize = item.components.stackable:StackSize()
	     			end 
	     			local newprefab = SpawnPrefab(replacement)
	     			if newprefab.components.stackable then 
	     				newprefab.components.stackable:SetStackSize(stacksize)
	     			end 
	     			container:RemoveItemBySlot(i)
	     			item:Remove()
	     			container:GiveItem(newprefab, i)
	     		end 
		     end 
		end 
		return false 
	end 
	end
	
local function onopen(inst) 
if not inst.burning then
inst.AnimState:SetBuild("musha_oven_open")
end
inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
	--inst.SoundEmitter:PlaySound("dontstarve/common/craftable/icebox_open")
end 

local function onclose(inst) 
if inst.burning then
cooked(inst)
end
if not inst.burning then
inst.AnimState:SetBuild("musha_oven")
end
inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
	--inst.SoundEmitter:PlaySound("dontstarve/common/craftable/icebox_close")		
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	local ash = SpawnPrefab("ash")
	ash.Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function OnHaunt(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE and
        inst.components.fueled ~= nil and
        not inst.components.fueled:IsEmpty() then
        inst.components.fueled:DoDelta(TUNING.MED_FUEL)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function onhit(inst, worker)
	inst.components.container:DropEverything()
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
end

local function onignite(inst)
inst.burning = true
inst.AnimState:SetBuild("musha_oven_open")
    if not inst.components.cooker then
        inst:AddComponent("cooker")
    end
end

local function on_fire(inst, data)
if not inst.on_fire and inst.components.burnable:IsBurning() then
	inst.components.burnable:Extinguish() inst:RemoveComponent("burnable") end
	if not inst.components.burnable then
		inst:AddComponent("burnable")
		end
inst.on_fire = true
inst.on_cold = false
inst:RemoveTag("fridge")
inst.components.talker:Say("[[Warm Fire]]\nOven-(On)")
inst.components.burnable:AddBurnFX("musha_ovenfire", Vector3(0,0,0) )
end
local function on_cold(inst, data)
if not inst.on_cold and inst.components.burnable:IsBurning() then
	inst.components.burnable:Extinguish() inst:RemoveComponent("burnable") end
	if not inst.components.burnable then
		inst:AddComponent("burnable") end
inst.on_cold = true
inst.on_fire = false
inst:AddTag("fridge")
inst.components.talker:Say("[[Cold Fire]]\nCooler Box-(On)")
inst.components.burnable:AddBurnFX("musha_ovenfire_cold", Vector3(0,0,0) )
end

local function onextinguish(inst)
inst.burning = false
inst.AnimState:SetBuild("musha_oven")
    if inst.components.cooker then
        inst:RemoveComponent("cooker")
    end
    if inst.components.fueled then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

local function fn(Sim)

   local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .3)

    inst:AddTag("campfire")
    inst:AddTag("structure")
   inst:AddTag("wildfireprotected")
   
    inst.AnimState:SetBank("chiminea")
    inst.AnimState:SetBuild("musha_oven")
    inst.AnimState:PlayAnimation("idle", false)    
    inst.MiniMapEntity:SetIcon( "musha_oven.tex" )

    -----------------------
    inst:AddComponent("burnable")
    --inst.components.burnable:SetFXLevel(2)
	
	if not inst.on_cold then
    inst.components.burnable:AddBurnFX("musha_ovenfire", Vector3(0,0,0) )
	elseif inst.on_cold then
	inst.components.burnable:AddBurnFX("musha_ovenfire_cold", Vector3(0,0,0) )
		end
   
	
	
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
		
		
		--if inst.DLC or inst.DLC2 then
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = on_cold
    inst.components.machine.turnofffn = on_fire
    inst.components.machine.cooldowntime = 0	
		--end
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 30
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 1, 1, 1)
    inst.components.talker.offset = Vector3(0,-500,0)
    inst.components.talker.symbol = "swap_object"

	   inst.entity:SetPristine()

   	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
	-------------------------
 	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
   
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    
      -------------------------
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)    

    -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(5)
    inst.components.fueled.bonusmult = 5
    inst.components.fueled.ontakefuelfn = 
	function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")  
	local fx2 = SpawnPrefab("small_puff")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(0, 3, 0)
		end
    inst.components.fueled.rate = 1

    inst.components.fueled:SetUpdateFn( function()
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
    inst.components.fueled:InitializeFuelLevel(TUNING.FIREPIT_FUEL_START)    
    
    -----------------------------

    inst:AddComponent("hauntable")
    inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_HUGE
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    -----------------------------   
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent( "onbuilt", function()
        inst.AnimState:PlayAnimation("place")
        inst.AnimState:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
    
    return inst
end

return Prefab( "common/objects/musha_oven", fn, assets, prefabs),
		MakePlacer( "common/musha_oven_placer", "chiminea", "musha_oven", "preview" ) 

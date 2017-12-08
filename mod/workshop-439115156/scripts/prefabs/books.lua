local assets =
{
    Asset("ANIM", "anim/books.zip"),
    --Asset("SOUND", "sound/common.fsb"),
}

local prefabs =
{
    "tentacle",
    "splash_ocean",
    "book_fx"
}

function tentaclesfn(inst, reader)
    local pt = Vector3(reader.Transform:GetWorldPosition())
    local numtentacles = 3

    reader.components.sanity:DoDelta(-TUNING.SANITY_HUGE)

    reader:StartThread(function()
        for k = 1, numtentacles do
        
            local theta = math.random() * 2 * PI
            local radius = math.random(3, 8)

            -- we have to special case this one because birds can't land on creep
            local result_offset = FindValidPositionByFan(theta, radius, 12, function(offset)
                local pos = pt + offset
                local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 1)
                return next(ents) == nil
            end)

            if result_offset ~= nil then
                local pos = pt + result_offset
                local tentacle = SpawnPrefab("tentacle")

                tentacle.Transform:SetPosition(pos:Get())

                for i, v in ipairs(AllPlayers) do
                    v:ShakeCamera(CAMERASHAKE.FULL, .2, .02, .25, reader, 40)
                end

                --need a better effect
                SpawnPrefab("splash_ocean").Transform:SetPosition(pos:Get())
                --PlayFX((pt + result_offset), "splash", "splash_ocean", "idle")
                tentacle.sg:GoToState("attack_pre")
            end

            Sleep(.33)
        end
    end)
    return true
end

function birdsfn(inst, reader)
    local birdspawner = TheWorld.components.birdspawner
    if birdspawner == nil then
        return false
    end

    local pt = Vector3(reader.Transform:GetWorldPosition())
    local num = 20 + math.random(10)

    reader.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
    
    --we can actually run out of command buffer memory if we allow for infinite birds
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 10, nil, nil, { "magicalbird" })
	if #ents > 30 then
		num = 0
		reader.components.talker:Say(GetString(reader.prefab, "ANNOUNCE_WAYTOOMANYBIRDS"))
	elseif #ents > 20 then
		reader.components.talker:Say(GetString(reader.prefab, "ANNOUNCE_TOOMANYBIRDS"))
		num = 10 + math.random(10)
	end
    
    if num > 0 then
		reader:StartThread(function()
			for k = 1, num do
				local pos = birdspawner:GetSpawnPoint(pt)
				if pos ~= nil then
					local bird = birdspawner:SpawnBird(pos, true)
                    if bird ~= nil then
					   bird:AddTag("magicalbird")
                    end
				end
				Sleep(math.random(.2, .25))
			end
		end)
	end
    return true
end

function firefn(inst, reader)
    local pt = Vector3(reader.Transform:GetWorldPosition())
    local num_lightnings = 16

    reader.components.sanity:DoDelta(-TUNING.SANITY_LARGE)

    reader:StartThread(function()
        for k = 0, num_lightnings do
            local rad = math.random(3, 15)
            local angle = k * 4 * PI / num_lightnings
            local pos = pt + Vector3(rad * math.cos(angle), 0, rad * math.sin(angle))
            TheWorld:PushEvent("ms_sendlightningstrike", pos)
            Sleep(math.random( .3, .5))
        end
    end)
    return true
end

function sleepfn(inst, reader)
    reader.components.sanity:DoDelta(-TUNING.SANITY_LARGE)

    local x, y, z = reader.Transform:GetWorldPosition()
    local range = 30
    local ents = TheNet:GetPVPEnabled() and
                TheSim:FindEntities(x, y, z, range, nil, { "playerghost" }, { "sleeper", "player" }) or
                TheSim:FindEntities(x, y, z, range, { "sleeper" }, { "player" })
    for i, v in ipairs(ents) do
        if v ~= reader then
            if v.components.sleeper ~= nil then
                v.components.sleeper:AddSleepiness(10, 20)
            elseif v.components.grogginess ~= nil then
                v.components.grogginess:AddGrogginess(10, 20)
            else
                v:PushEvent("knockedout")
            end
        end
    end
    return true
end

function growfn(inst, reader)
    local pt = Vector3(reader.Transform:GetWorldPosition())

    reader.components.sanity:DoDelta(-TUNING.SANITY_LARGE)

    local range = 30
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, range)
    for k, v in pairs(ents) do
        if v.components.pickable ~= nil then
            v.components.pickable:FinishGrowing()
        end

        if v.components.crop ~= nil then
            v.components.crop:DoGrow(TUNING.TOTAL_DAY_TIME * 3)
        end
        
        if v.components.growable ~= nil and v:HasTag("tree") and not v:HasTag("stump") then
            v.components.growable:DoGrowth()
        end
    end
    return true
end

function MakeBook(name, usefn, bookuses)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("books")
        inst.AnimState:SetBuild("books")
        inst.AnimState:PlayAnimation(name)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        -----------------------------------

        inst:AddComponent("inspectable")
        inst:AddComponent("book")
        inst.components.book.onread = usefn

        inst:AddComponent("inventoryitem")

        inst:AddComponent("finiteuses")
        inst.components.finiteuses:SetMaxUses(bookuses)
        inst.components.finiteuses:SetUses(bookuses)
        inst.components.finiteuses:SetOnFinished(inst.Remove)

        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)

        MakeHauntableLaunch(inst)
        AddHauntableCustomReaction(inst, function(inst, haunter)
            if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
                inst.components.book.onread(inst, haunter)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
                return true
            end
            return false
        end, true, false, true)

        return inst
    end

    return Prefab("common/"..name, fn, assets, prefabs)
end

return MakeBook("book_sleep", sleepfn, 5),
       MakeBook("book_gardening", growfn, 5),
       MakeBook("book_brimstone", firefn, 5),
       MakeBook("book_birds", birdsfn, 3),
       MakeBook("book_tentacles", tentaclesfn, 5)
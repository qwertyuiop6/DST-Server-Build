local assets=
{
    Asset("ANIM", "anim/goldstaff.zip"),
    Asset("ATLAS", "images/inventoryimages/goldstaff.xml"),
}

local prefabs = {
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "goldstaff", "swap")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
end

local function goldstafffn(staff, target, pos)
    local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 2.7)
    local caster = staff.components.inventoryitem.owner
    local talkprice = 0
    local pass = 1
    local noprice = true
    for k,v in pairs(ents) do
        if v.components.inventoryitem
        and v.components.inventoryitem.owner == nil
        and v.prefab ~= "secoin"
        and v.prefab ~= "chester_eyebone"
        and v.prefab ~= "glommerflower"
        and v.prefab ~= "hutch_fishbowl"
        and staff.components.finiteuses.current >= 1 then
            local price = 0
            local stacksize = 1
            if v.components.stackable then stacksize = v.components.stackable.stacksize end
            for i,j in pairs(TUNING.allgoods) do
                if v.prefab == j.name then
                    price = j.price/3*stacksize
                end
            end
            for i,j in pairs(TUNING.selist_low) do
                if v.prefab == j.name then
                    price = j.price/10*stacksize
                end
            end
            if price == 0 then
                price = math.random(1, 5)
            else
                noprice = false
            end

            if v.components.finiteuses and v.prefab ~= "vipcard" then
                local percent = v.components.finiteuses:GetPercent()
                price = price*percent
            end
            if v.components.fueled and v.prefab ~= "vipcard" then
                local percent = v.components.fueled:GetPercent()
                price = price*percent
            end
            if v.components.armor and v.components.armor.maxcondition > 0 and v.prefab ~= "vipcard" then
                local percent = v.components.armor:GetPercent()
                price = price*percent
            end

            if caster.components.builder and AllRecipes[v.prefab] then
                price = price * caster.components.builder.ingredientmod
            end

            price = math.ceil(price)

            talkprice = talkprice + price

            local pt = Point(v.Transform:GetWorldPosition())
            local secoin = SpawnPrefab("secoin")
            secoin.components.secoin.amount = price
            local angle = math.random()*2*PI
            secoin.Transform:SetPosition(pt.x,pt.y,pt.z)
            secoin.Physics:SetVel(2*math.cos(angle), 10, 2*math.sin(angle))
            secoin:DoTaskInTime(pass*FRAMES*3+.3, function()
                caster.components.seplayerstatus:givesecoin(secoin)
            end)
            pass = pass + 1

            staff.components.inventoryitem.owner.SoundEmitter:PlaySound("dontstarve/common/staff_dissassemble")
            if v.components.inventory then v.components.inventory:DropEverything() end
            if v.components.container then v.components.container:DropEverything() end
            staff.components.finiteuses:Use(1)
            v:Remove()
        else
           --staff.components.inventoryitem.owner.components.talker:Say("那东西不能转化成金币")
        end
    end
    if talkprice > 0 then
        SpawnPrefab("explode_small_slurtle").Transform:SetPosition(pos:Get())
        caster:DoTaskInTime(pass*FRAMES*3+.4, function()
            caster.components.talker:Say(STRINGS.SIMPLEECONOMY[10]..talkprice..STRINGS.SIMPLEECONOMY[19])
            if noprice == true then
                caster:DoTaskInTime(1, function()
                    caster.components.talker:Say(STRINGS.SIMPLEECONOMY[11])
                end)
            end
        end)
    else
        caster.components.talker:Say(STRINGS.SIMPLEECONOMY[12])
    end
end

local function onattack(self, attacker, target, projectile)
    local maxhp = 25
    local chance = 25
    if TUNING.allowgoldstaff == false then
        chance = 100
    end
    if attacker then
        if attacker.components.seplayerstatus.level >= 2 then maxhp = 100 end
        if attacker.components.seplayerstatus.level >= 3 then maxhp = 200 end
        if attacker.components.seplayerstatus.level >= 4 then maxhp = 400 end
        if attacker.components.seplayerstatus.level >= 5 then maxhp = 500 end
    end
    if target
    and target:IsValid()
    and target.components.health
    and target.components.health.currenthealth <= maxhp
    and math.random(0, 100) <= chance
    and self.inst.components.finiteuses.current >= 1
    and target.components.lootdropper
    and (target.components.freezable or target:HasTag("monster")) then
        local amount = target.components.health.maxhealth
        SpawnPrefab("explode_small_slurtle").Transform:SetPosition(target:GetPosition():Get())
        if target.components.health.currenthealth > 0 then
            target.components.combat:GetAttacked(attacker, amount)
        end
        local item = target.components.lootdropper:SpawnLootPrefab("secoin")
        item.components.secoin.amount = math.random(math.ceil(amount/16),math.ceil(amount/8))
        attacker:DoTaskInTime(.3, function()
            attacker.components.seplayerstatus:givesecoin(item)
        end)
        self.inst.components.finiteuses:Use(1)
    end
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork() 
    inst.entity:AddSoundEmitter()
    
    anim:SetBank("goldstaff")
    anim:SetBuild("goldstaff")
    anim:PlayAnimation("idle")
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/goldstaff.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("tool")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon.OnAttack = onattack

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst.components.finiteuses:SetMaxUses(35)
    inst.components.finiteuses:SetUses(35)

    if TUNING.allowgoldstaff then
        inst:AddComponent("spellcaster")
        --inst.components.spellcaster.canuseontargets = true
        --inst.components.spellcaster.canonlyuseonrecipes = true
        inst.components.spellcaster.canuseonpoint = true
        inst.components.spellcaster:SetSpellFn(goldstafffn)
    end
    
    return inst
end


return Prefab( "goldstaff", fn, assets, prefabs)
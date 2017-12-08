local assets=
{
	Asset("ANIM", "anim/vipcard.zip"),
	Asset("ATLAS", "images/inventoryimages/vipcard.xml"),
}

local function getvip(inst, owner)
    if owner then
        inst:DoTaskInTime(0, function()
            local se = nil
            if owner:HasTag("player") then
                inst._owner = owner
                se = inst._owner.components.seplayerstatus

                inst.ownerlevelup = function()
                    inst.components.finiteuses:SetUses(se.level*5)
                end

                se:OnVIP(1)
                inst.components.finiteuses:SetUses(se.level*5)
                inst:ListenForEvent("SELevelUp", inst.ownerlevelup, inst._owner)
            elseif owner.components.inventoryitem
            and owner.components.inventoryitem.owner
            and owner.components.inventoryitem.owner:HasTag("player") then
                inst._owner = owner.components.inventoryitem.owner
                se = inst._owner.components.seplayerstatus

                inst.ownerlevelup = function()
                    inst.components.finiteuses:SetUses(se.level*5)
                end

                se:OnVIP(1)
                inst.components.finiteuses:SetUses(se.level*5)
                inst:ListenForEvent("SELevelUp", inst.ownerlevelup, inst._owner)
            end
        end)
    end
end

local function removevip(self, inst, owner)
    if self.inst._owner ~= nil then
        self.inst._owner.components.seplayerstatus:OnVIP(0)
        self.inst:RemoveEventCallback("SELevelUp", self.inst.ownerlevelup, self.inst._owner)
        self.inst._owner = nil
    end
    if self.owner then
        self.owner:RemoveChild(self.inst)
    end
    self:ClearOwner()
    self.inst:ReturnToScene()
    self:WakeLivingItem()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
	
    anim:SetBank("vipcard")
    anim:SetBuild("vipcard")
    anim:PlayAnimation("idle")

    inst:AddTag("molebait")
    inst:AddTag("quakedebris")

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst._owner = nil

    inst:AddComponent("inspectable")

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(100)
    inst.components.finiteuses:SetUses(0)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/vipcard.xml"
    inst.components.inventoryitem:SetOnPutInInventoryFn(getvip)
    inst.components.inventoryitem.OnRemoved = removevip
    
    return inst
end

return Prefab( "vipcard", fn, assets) 

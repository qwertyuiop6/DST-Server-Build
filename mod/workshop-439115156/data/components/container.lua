local function ContainerPostInit(inst)

	inst._CanTakeItemInSlot = inst.CanTakeItemInSlot

	function inst:CanTakeItemInSlot(item, slot)
		if item.components and item.components.characterspecific and not item.components.characterspecific:CanPickUp(inst.opener) and not item.components.characterspecific:IsStorable() then
    		inst.components.talker:Say(item.components.characterspecific:GetComment())
    		inst.opener.components.inventory:DropItem(item)
    		return false
    	end

    	if item.components and item.components.characterspecific and not item.components.characterspecific:CanPickUp(inst.opener) and inst.type == "pack" then
    		inst.components.talker:Say(item.components.characterspecific:GetComment())
    		inst.opener.components.inventory:DropItem(item)
    		return false
    	end

    	return inst:_CanTakeItemInSlot(item, slot)
	end

	inst._GiveItem = inst.GiveItem

	function inst:GiveItem( inst, slot, src_pos )
		if not self:CanTakeItemInSlot(inst, slot) then
			return false
		end

		return self:_GiveItem(inst , slot, src_pos)
	end

	inst._TakeActiveItemFromAllOfSlot = inst.TakeActiveItemFromAllOfSlot
	
	function inst:TakeActiveItemFromAllOfSlot(slot)
		local item = nil

		if self.slots ~= nil then
			item = self.slots[slot]
		elseif self._items ~= nil then
			item = self._items[slot]
		end

		if item and item.components and item.components.characterspecific and not item.components.characterspecific:CanPickUp(self.opener) then
			inst.opener.components.talker:Say(item.components.characterspecific:GetComment())
    		return 
    	end

		inst:_TakeActiveItemFromAllOfSlot(slot)
	end

	inst._SwapActiveItemWithSlot = inst.SwapActiveItemWithSlot

	function inst:SwapActiveItemWithSlot(slot)
		local item = nil

		if self.slots ~= nil then
			item = self.slots[slot]
		elseif self._items ~= nil then
			item = self._items[slot]
		end

		if item and item.components and item.components.characterspecific and not item.components.characterspecific:CanPickUp(self.opener) then
			inst.opener.components.talker:Say(item.components.characterspecific:GetComment())
    		return 
    	end

		inst:_SwapActiveItemWithSlot(slot)
	end

	inst._MoveItemFromAllOfSlot = inst.MoveItemFromAllOfSlot

	function inst:MoveItemFromAllOfSlot(slot, container)
		local item = nil

		if self.slots ~= nil then
			item = self.slots[slot]
		elseif self._items ~= nil then
			item = self._items[slot]
		end

		if item and item.components and item.components.characterspecific and not item.components.characterspecific:CanPickUp(self.opener) then
			inst.opener.components.talker:Say(item.components.characterspecific:GetComment())
    		return 
    	end

		inst:_MoveItemFromAllOfSlot(slot, container)
	end


	return inst
end

AddComponentPostInit("container", ContainerPostInit)
AddComponentPostInit("container_relica", ContainerPostInit)
AddPrefabPostInit("container_classified", ContainerPostInit)
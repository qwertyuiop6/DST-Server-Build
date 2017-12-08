local CharacterSpecific_musha = Class(function(self, inst)
    self.inst = inst

    self.character = nil
    self.storable = false
    self.comment = "That does not belong to me."
end)

function CharacterSpecific_musha:CanPickUp(doer)
	if doer and doer.prefab ~= self.character then
		return false
	end

	return true
end

function CharacterSpecific_musha:SetOwner(name)
    self.character = name
end

function CharacterSpecific_musha:IsStorable()
	return self.storable
end

function CharacterSpecific_musha:SetStorable(value)
	self.storable = value
end

function CharacterSpecific_musha:GetComment()
	return self.comment
end

function CharacterSpecific_musha:SetComment(comment)
	self.comment = comment
end

return CharacterSpecific_musha
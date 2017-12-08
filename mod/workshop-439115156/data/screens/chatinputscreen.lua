local function ChatPostConstruct(inst)
	function inst:OnBecomeActive()
		SetPause(true)

		inst._base.OnBecomeActive(inst)

		inst.chat_edit:SetFocus()
		inst.chat_edit:SetEditing(true)
		TheFrontEnd:LockFocus(true)
	end

	function inst:OnBecomeInactive()
    	SetPause(false)

    	inst._base.OnBecomeInactive(self)

    	if inst.runtask ~= nil then
        	inst.runtask:Cancel()
        	inst.runtask = nil
    	end
	end

	return inst
end


AddClassPostConstruct("screens/chatinputscreen", ChatPostConstruct)
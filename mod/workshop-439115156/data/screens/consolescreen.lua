local function ConsolePostConstruct(inst)

	function inst:OnBecomeActive()
		SetPause(true)

		inst._base.OnBecomeActive(inst)
		TheFrontEnd:ShowConsoleLog()

		inst.console_edit:SetFocus()
		inst.console_edit:SetEditing(true)
		self:ToggleRemoteExecute(true)
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

AddClassPostConstruct("screens/consolescreen", ConsolePostConstruct)
local function OnHealthDirty(inst)
    inst.components.healthinfo_copy.text =  inst.components.healthinfo_copy._text:value()
end

local HealthInfo_Copy = Class(function(self, inst)
    self.inst = inst
    self.widget = nil
    self.text = ""
    self._text = net_string(inst.GUID, "healthinfo_copy._text", "healthdirty")

    if not TheWorld.ismastersim then
        inst:ListenForEvent("healthdirty", OnHealthDirty)
    end
end)

function HealthInfo_Copy:SetText( text )
    if text == nil then
        self.text = "[1/1]"
        self._text:set("[1/1]")
    else
        self.text = text
        self._text:set(text)
    end
end

function HealthInfo_Copy:OnSave()
    return
        self.text ~= nil
        and {
                text = self.text
            }
        or nil
end

function HealthInfo_Copy:OnLoad(data)
    if data ~= nil and data.text ~= nil then
        self.text = data.text
    end
end

return HealthInfo_Copy
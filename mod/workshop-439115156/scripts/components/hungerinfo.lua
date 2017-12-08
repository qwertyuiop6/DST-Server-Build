local function Onhungerdirty(inst)
    inst.components.hungerinfo.text =  inst.components.hungerinfo._text:value()
end

local Hungerinfo = Class(function(self, inst)
    self.inst = inst
    self.widget = nil
    self.text = ""
    self._text = net_string(inst.GUID, "hungerinfo._text", "hungerdirty")

    if not TheWorld.ismastersim then
        inst:ListenForEvent("hungerdirty", Onhungerdirty)
    end
end)

function Hungerinfo:SetText( text )
    if text == nil then
        self.text = "[1/1]"
        self._text:set("[1/1]")
    else
        self.text = text
        self._text:set(text)
    end
end

function Hungerinfo:OnSave()
    return
        self.text ~= nil
        and {
                text = self.text
            }
        or nil
end

function Hungerinfo:OnLoad(data)
    if data ~= nil and data.text ~= nil then
        self.text = data.text
    end
end

return Hungerinfo
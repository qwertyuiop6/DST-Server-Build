-- local info = debug.getinfo(1)
-- source = info.source
-- source = string.gsub(source, MODS_ROOT, "")
-- local dirs = string.split(source, "/")
-- local modname = dirs[1]
-- local minotaur_destroy = GetModConfigData("minotaur_destroy", modname)

local GD_Workable = Class(function(self, inst)
    self.inst = inst
    self.workleft = 10
    self.maxwork = -1
    self.savestate = false
    self.workable = false
end)

function GD_Workable:OnRemoveFromEntity()
end

function GD_Workable:GetDebugString()
end

function GD_Workable:SetWorkAction(act)
end

function GD_Workable:GetWorkAction()
end

function GD_Workable:Destroy(destroyer)
end

function GD_Workable:SetWorkable(able)
end

function GD_Workable:SetWorkLeft(work)
    --print("哦吼,打空了")
    -- if self.inst.prefab == "ancient_altar_broken" and self.inst.components.hammerworkable ~= nil and self.inst.components.hammerworkable.workleft ~= nil and work > self.inst.components.hammerworkable.workleft then
    --     self.inst.components.hammerworkable:SetWorkLeft(work)
    -- end
end

function GD_Workable:CanBeWorked()
    return false
end

function GD_Workable:SetOnLoadFn(fn)
end

function GD_Workable:SetMaxWork(work)
end

function GD_Workable:OnSave()
end

function GD_Workable:OnLoad(data)
end

function GD_Workable:WorkedBy(worker, numworks)
end

function GD_Workable:SetOnWorkCallback(fn)
end

function GD_Workable:SetOnFinishCallback(fn)
end

return GD_Workable

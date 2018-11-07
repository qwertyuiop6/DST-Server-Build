local Save_Beefalo = Class(function(self, inst)
    self.inst = inst
	self.isRiding = false
end,
nil,
{
})

function Save_Beefalo:SaveBeefalo()
	self.isRiding = self.inst.components.rider:IsRiding()
	local mount = nil
	local beefalo = nil
	if self.isRiding then
		mount = self.inst.components.rider:GetMount()
	end

	if mount ~= nil then
		beefalo = mount
		-- 下坐骑,系统rider组件会在玩家下线时保存牛的数据并在载入时读取,防止rider组件做额外的操作
		self.inst.components.rider:Dismount()
	elseif self.inst.beefalo ~= nil and self.inst.beefalo:IsValid() then
		beefalo = self.inst.beefalo
		-- 如果正在被骑,抖下骑手
		beefalo.components.rideable:Buck(nil, true)
	else
		self.isRiding = false
		local x,y,z = self.inst.Transform:GetWorldPosition()
		--local ents = TheSim:FindEntities(x, y, z, 20, {"beefalo"})
		local ents = TheSim:FindEntities(x, y, z, 20)
		for _,ent in pairs(ents) do
			if ent.components.domesticatable and ent.components.rideable and not ent.components.rideable:IsBeingRidden()
			and ent.ownerlist ~= nil and ent.ownerlist.master == self.inst.userid then
				beefalo = ent
				break
			end
		end	
	end
	
	if beefalo and beefalo.ownerlist and beefalo.ownerlist.master == self.inst.userid then
		self.saved_beefalo = beefalo
		self.beefalo_save = beefalo:GetSaveRecord()
		self.beefalo_saddle_save = beefalo.components.rideable:IsSaddled() and beefalo.components.rideable.saddle:GetSaveRecord() or nil
		beefalo.persists = false
		if not self.isRiding then
			local fx = SpawnPrefab("spawn_fx_medium")
			if fx ~= nil then
				fx.Transform:SetPosition(beefalo.Transform:GetWorldPosition())
			end
		end

		if beefalo.components.colourtweener == nil then
			beefalo:AddComponent("colourtweener")
		end
		
		beefalo.components.colourtweener:StartTween({ 0, 0, 0, 1 }, 13 * FRAMES, beefalo.Remove)
	end
end

function Save_Beefalo:OnSave()
	return {beefalo = self.beefalo_save, beefalo_saddle = self.beefalo_saddle_save, isRiding = self.isRiding}
end

function Save_Beefalo:OnLoad(data)
	if data.beefalo then
		local beefalo = SpawnSaveRecord(data.beefalo)
		self.inst.beefalo = beefalo
		self.inst.beefalo_follow = true
		if self.inst.migrationpets ~= nil then
			table.insert(self.inst.migrationpets, beefalo)
		end
		if data.isRiding then
			if not beefalo.components.rideable:IsSaddled() and data.beefalo_saddle ~= nil then
				beefalo.components.rideable.saddle = SpawnSaveRecord(data.beefalo_saddle)
			end

			if beefalo.components.rideable:IsSaddled() then
				self.inst:DoTaskInTime(0, function() self.inst.components.rider:Mount(beefalo, true) end)
			else
				self.inst:DoTaskInTime(0, function()
					local fx = SpawnPrefab("spawn_fx_medium")
					if fx ~= nil then
						fx.Transform:SetPosition(beefalo.Transform:GetWorldPosition())
					end
				end)
			end
		else
			self.inst:DoTaskInTime(0, function()
				-- 距离主人超过30码
				if not beefalo:IsNear(self.inst, 30) then
					local inst_pos = self.inst:GetPosition()
					beefalo.Transform:SetPosition(inst_pos:Get())
				end

				local fx = SpawnPrefab("spawn_fx_medium")
				if fx ~= nil then
					fx.Transform:SetPosition(beefalo.Transform:GetWorldPosition())
				end
			end)
		end
	end
end

return Save_Beefalo
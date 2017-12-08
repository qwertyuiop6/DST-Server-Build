require "SEscripts/itemlist"

local seworldstatus = Class(function(self, inst)
    self.inst = inst

    TUNING.selist_food = {}
	TUNING.selist_cloth = {}
	TUNING.selist_smithing = {}
	TUNING.selist_resource = {}
	TUNING.selist_special = {}

	for n=1, #selist_food do
		TUNING.selist_food[n] = {}
		TUNING.selist_food[n].name = selist_food[n].name
		TUNING.selist_food[n].price = selist_food[n].price
	end
	for n=1, #selist_cloth do
		TUNING.selist_cloth[n] = {}
		TUNING.selist_cloth[n].name = selist_cloth[n].name
		TUNING.selist_cloth[n].price = selist_cloth[n].price
	end
	for n=1, #selist_smithing do
		TUNING.selist_smithing[n] = {}
		TUNING.selist_smithing[n].name = selist_smithing[n].name
		TUNING.selist_smithing[n].price = selist_smithing[n].price
	end
	for n=1, #selist_resource do
		TUNING.selist_resource[n] = {}
		TUNING.selist_resource[n].name = selist_resource[n].name
		TUNING.selist_resource[n].price = selist_resource[n].price
	end
	for n=1, #selist_special do
		TUNING.selist_special[n] = {}
		TUNING.selist_special[n].name = selist_special[n].name
		TUNING.selist_special[n].price = selist_special[n].price
	end

	--点金法杖低价分解珍贵品和专属装备
	TUNING.selist_low = {}
	for n=1, #selist_precious do
	    table.insert(TUNING.selist_low, selist_precious[n])
	end
	for n=1, #selist_special do
	    table.insert(TUNING.selist_low, selist_special[n])
	end
	for n=1, #selist_blueprint do
	    table.insert(TUNING.selist_low, selist_blueprint[n])
	end

	TUNING.SEseasonchange = false

    self:changelist()
    self:seasoncheck()
end)

function seworldstatus:changelist()
	--判定张跌
	if TheWorld.components.worldstate.data.season == "spring" then
		TUNING.seseasonfood = .5 TUNING.seseasoncloth = 1 TUNING.seseasonsmithing = 1 TUNING.seseasonresource = 1
	end
	if TheWorld.components.worldstate.data.season == "summer" then
		TUNING.seseasonfood = 1 TUNING.seseasoncloth = .5 TUNING.seseasonsmithing = 1.5 TUNING.seseasonresource = 1.5
	end
	if TheWorld.components.worldstate.data.season == "autumn" then
		TUNING.seseasonfood = 1 TUNING.seseasoncloth = 1 TUNING.seseasonsmithing = 1 TUNING.seseasonresource = .5
	end
	if TheWorld.components.worldstate.data.season == "winter" then
		TUNING.seseasonfood = 1.5 TUNING.seseasoncloth = 1.5 TUNING.seseasonsmithing = .5 TUNING.seseasonresource = 1
	end

	--改变价格
	for k,v in pairs(selist_food) do TUNING.selist_food[k].price = math.ceil(v.price*TUNING.seseasonfood) end
	for k,v in pairs(selist_cloth) do TUNING.selist_cloth[k].price = math.ceil(v.price*TUNING.seseasoncloth) end
	for k,v in pairs(selist_smithing) do TUNING.selist_smithing[k].price = math.ceil(v.price*TUNING.seseasonsmithing) end
	for k,v in pairs(selist_resource) do TUNING.selist_resource[k].price = math.ceil(v.price*TUNING.seseasonresource) end

	--合并清单供点金法杖使用
	TUNING.allgoods = {}
	for n=1, #TUNING.selist_food do
	    table.insert(TUNING.allgoods, TUNING.selist_food[n])
	end
	for n=1, #TUNING.selist_cloth do
	    table.insert(TUNING.allgoods, TUNING.selist_cloth[n])
	end
	for n=1, #TUNING.selist_smithing do
	    table.insert(TUNING.allgoods, TUNING.selist_smithing[n])
	end
	for n=1, #TUNING.selist_resource do
	    table.insert(TUNING.allgoods, TUNING.selist_resource[n])
	end

	--ui辅助
	if TUNING.SEseasonchange == false then
		TUNING.SEseasonchange = true
	else
		TUNING.SEseasonchange = false
	end
end

function seworldstatus:seasoncheck()
	TheWorld:ListenForEvent("seasontick", function()
		self:changelist()
	end)
end

return seworldstatus
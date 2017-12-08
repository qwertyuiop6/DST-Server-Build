require "SEscripts/itemlist"

local function seccoin(self,coin) self.inst.seccoin:set(coin) end
local function secexp(self,exp) self.inst.secexp:set(exp) end
local function seclevel(self,level) self.inst.seclevel:set(level) end
local function secvip(self,vip) self.inst.secvip:set(vip) end
local function secprecious(self,precious) self.inst.secprecious:set(precious) end
local function secpreciouschange(self,preciouschange) self.inst.secpreciouschange:set(preciouschange) end
local function secsoundm(self,soundm) self.inst.secsoundm:set(soundm) end

local seplayerstatus = Class(function(self, inst)
    self.inst = inst
    self.coin = 200
    self.exp = 0
    self.level = 1
    self.vip = 0
    self.discount = (1-self.level*5/100)^self.vip
    self.slist = {}
    self.precious = {}
    self:preciousbuild()

    self.yes = false

    self.preciouschange = false
    self.soundm = false
    self.day = 0
end,
nil,
{
	coin = seccoin,
	exp = secexp,
	level = seclevel,
	vip = secvip,
	precious = secprecious,
	preciouschange = secpreciouschange,
	soundm = secsoundm,
})

function seplayerstatus:numget()
	local num = math.random(#selist_precious)
	local check = false
    for i=1, #self.slist do
    	if num == self.slist[i] then
    		check = true
		end
	end
	if check == true then
		return self:numget()
	else
		return num
	end
end

function seplayerstatus:preciousbuild()
	self.slist = {}
	for i=1, 10+4*self.level do
		if i == 1 then
			table.insert(self.slist, 70)
		else
	    	table.insert(self.slist, self:numget())
	    end
	end
	self.precious = self.slist
end

function seplayerstatus:OnSave()
    local data = {
        coin = self.coin,
        exp = self.exp,
        level = self.level,
        yes = self.yes,
        precious = self.precious,
        day = self.day,
    }
    return data
end

function seplayerstatus:OnLoad(data)
    self.coin = data.coin or 0
    self.exp = data.exp or 0
    self.level = data.level or 0
    self.yes = data.yes or false
    if data.precious and #data.precious ~= 0 then
    	self.precious = data.precious
	else
    	self:preciousbuild()
    end
    self.day = data.day or 0
end

function seplayerstatus:DoDeltaCoin(amount)
	if amount < 0 then
		self.coin = self.coin + math.ceil(amount*self.discount)
	else
		self.coin = self.coin + amount
		self.inst.components.talker:Say(STRINGS.SIMPLEECONOMY[9]..amount..STRINGS.SIMPLEECONOMY[18])
	end
	if self.coin >= 999999 then self.coin = 999999 end
	self.inst:PushEvent("SEDoDeltaCoin")

    if self.soundm == false then
        self.soundm = true
    else
        self.soundm = false
    end

	self:DoDeltaExp(math.abs(amount))
end

function seplayerstatus:DoDeltaExp(amount)
	if self.level < 5 then
		self.exp = self.exp + amount
		self.inst:PushEvent("SEDoDeltaExp")
		if self.exp >= (self.level+1)^3*1000 then
			local a = self.exp-(self.level+1)^3*1000
			self.exp = 0
			self.level = self.level + 1
			self.inst:PushEvent("SELevelUp")
			self.inst:DoTaskInTime(1, function()
				self.inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				self.inst.components.talker:Say(STRINGS.SIMPLEECONOMY[13])
			end)
			self:OnVIP(self.vip)
			self:DoDeltaExp(a)
		end
	else
		self.exp = 125000
	end
end

function seplayerstatus:OnVIP(value)
	self.vip = value
	self.discount = (1-self.level*5/100)^self.vip
end

function seplayerstatus:givesecoin(secoin)
	local price = 0
	--local full = self.inst.components.inventory:IsFull()
	--local backfull = false
	--for k,v in pairs(self.inst.components.inventory.opencontainers) do
    --    if k and k:HasTag("backpack") and k.components.container and k.components.container:IsFull() then
    --    	backfull = true
    --    end
    --end
    --self.inst.components.inventory:GiveItem(secoin, nil, pos)
	if secoin ~= nil then
		price = secoin.components.secoin.amount
        local x1,y1,z1 = self.inst.Transform:GetWorldPosition()
        local x0,y0,z0 = secoin.Transform:GetWorldPosition()
        local x,y,z = Vector3(0,0,0)
        local maxtime = 5
        for i=1, maxtime do
        	self.inst:DoTaskInTime(FRAMES*i, function()
        		if secoin == nil then return end
        		x1,y1,z1 = self.inst.Transform:GetWorldPosition()
        		x0,y0,z0 = secoin.Transform:GetWorldPosition()
        		x = x1 - x0
        		y = y1 - y0
        		z = z1 - z0
        		secoin.Transform:SetPosition(x/(maxtime-i)+x0,y/(maxtime-i)+y0,z/(maxtime-i)+z0)
        		if i == maxtime then
					self:DoDeltaCoin(price)
        			secoin:Remove()
        		end
    		end)
        end
	end
end

function seplayerstatus:Init(inst)
    inst:DoTaskInTime(5, function()
        if inst.components.seplayerstatus.yes ~= true then
            inst.components.seplayerstatus.yes = true
            local item = SpawnPrefab("goldstaff")
            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
            inst.components.talker:Say(STRINGS.SIMPLEECONOMY[1])
        end
    end)
    inst:ListenForEvent("cycleschanged", function()
    	self.day = self.day + 1
    	if self.day >= 3 then
    		self.day = 0
	    	self:preciousbuild()
	    	if self.preciouschange == true then
	    		self.preciouschange = false
	    	else
	    		self.preciouschange = true
	    	end
	    end
	end, TheWorld)
end

return seplayerstatus
--GetPlayer().components.seplayerstatus:DoDeltaCoin(25000)
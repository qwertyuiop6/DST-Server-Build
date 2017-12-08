local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local AnimButton = require "widgets/animbutton"
local HoverText = require "widgets/hoverer"
local ItemSlot = require "widgets/itemslot"
require "SEscripts/itemlist"

local uiseconomy = Class(Widget, function(self, owner)
	Widget._ctor(self, "uiseconomy")
	self.owner = owner
	self.numpage = 1
	self.mainui = self:AddChild(Widget("mainui"))
	self.mainui:SetScale(.75, .75, 1)
	self.mainui:SetPosition(0,20,0)
	self.mainui:Hide()

self.mainui.bg = self.mainui:AddChild(Image("images/sehud/bg.xml", "bg.tex"))
	self.mainui.bg:SetTint(1,1,1,0.95)
	self.mainui.bg:SetPosition(0, 45, 0)

	self.mainui.bg.title = self.mainui.bg:AddChild(Image("images/sehud/title_food.xml", "title_food.tex"))
	self.mainui.bg.title:SetPosition(0, 246, 0)

self.mainui.status = self.mainui:AddChild(Widget("status"))
	self.mainui.status.bg = self.mainui.status:AddChild(Image("images/sehud/status_"..TUNING.SElan..".xml", "status_"..TUNING.SElan..".tex"))
	self.mainui.status:SetPosition(410, 25, 0)

	self.mainui.status.coinamount = self.mainui.status:AddChild(Widget("coinamount"))
	self.mainui.status.coinamount:SetPosition(-110, 159, 0)
	self.mainui.status.coinamount:SetScale(1, 1, 1)

	self.mainui.status.coinamount.num = {}
	for i=1, 6 do
		self.mainui.status.coinamount.num[i] = self.mainui.status.coinamount:AddChild(Image("images/sehud/bignums/0.xml", "0.tex"))
		self.mainui.status.coinamount.num[i]:SetPosition(i*17, 0, 0)
	end
	self:displaycoinamount(self.mainui.status.coinamount.num)

	self.mainui.status.level = {}
	for i=1, 5 do
		self.mainui.status.level[i] = self.mainui.status:AddChild(Image("images/sehud/level_dact.xml", "level_dact.tex"))
		self.mainui.status.level[i]:SetPosition(-130+(i-1)*23, 87, 0)
	end

	self.mainui.status.vipinfo = self.mainui.status:AddChild(Image("images/sehud/vip0.xml", "vip0.tex"))
	self.mainui.status.vipinfo:SetPosition(0, 66, 0)

	self.mainui.status.swdjinfo = self.mainui.status:AddChild(Image("images/sehud/swdj_"..TUNING.SElan.."1.xml", "swdj_"..TUNING.SElan.."1.tex"))
	self.mainui.status.swdjinfo:SetPosition(0, 66, 0)

	self.mainui.status.exp = self.mainui.status:AddChild(Image("images/sehud/exp_dact.xml", "exp_dact.tex"))
	self.mainui.status.exp:SetPosition(-115, 64, 0)
	self.mainui.status.exp:SetClickable(false)

	self.mainui.status.expact = self.mainui.status:AddChild(Image("images/sehud/exp_act.xml", "exp_act.tex"))
	self.mainui.status.expact:SetPosition(self.mainui.status.exp:GetPosition().x,self.mainui.status.exp:GetPosition().y, 0)
	self.mainui.status.expact:SetClickable(false)

	self.mainui.status.expmask = self.mainui.status:AddChild(Image("images/sehud/expmask.xml", "expmask.tex"))
	self.mainui.status.expmask:SetPosition(0, 64, 0)
	self.mainui.status.expmask:SetTint(1,1,1,0)
	--self.mainui.status.expmask:SetHoverText(self.owner.secexp:value().."/"..(self.owner.seclevel:value()+1)^3*1000)

	self.mainui.status.specialitem = self.mainui.status:AddChild(Widget("specialitem"))
	self.mainui.status.specialitem:SetPosition(0, -84, 0)
	self.spitemslot = {}
	self:spitembuild(73)

self.coinamount = self:AddChild(Widget("coinamount"))
	self.coinamount:SetPosition(-820, 325, 0)
	self.coinamount:SetScale(.8, .8, 1)
	self.coinamount:SetClickable(false)

	self.coinamount.icon = self.coinamount:AddChild(Image("images/sehud/hudcoin.xml", "hudcoin.tex"))
	self.coinamount.icon:SetPosition(-10, 0, 0)
	self.coinamount.icon:SetScale(.2, .2, 1)

	self.coinamount.num = {}
	for i=1, 6 do
		self.coinamount.num[i] = self.coinamount:AddChild(Image("images/sehud/bignums/0.xml", "0.tex"))
		self.coinamount.num[i]:SetPosition(i*17, 0, 0)
	end
	self:displaycoinamount(self.coinamount.num)

self.mainbutton = self:AddChild(ImageButton("images/sehud/mainbutton.xml", "mainbutton.tex"))
	self.mainbutton:SetPosition(-815, 370, 0)
    self.mainbutton:SetNormalScale(1,1,1)
    self.mainbutton:SetFocusScale(1,1,1)
    self.mainbutton:SetHoverText(STRINGS.SIMPLEECONOMY[2])
    self.mainbutton:SetOnGainFocus(function() self.mainbutton:ScaleTo(1,1.15,.125) self.mainbutton.new.middle = -15 end)
	self.mainbutton:SetOnLoseFocus(function() self.mainbutton:ScaleTo(1.15,1,.25) self.mainbutton.new.middle = 15 end)
	self.cooldown = true
    self.mainbutton:SetOnClick(function()
		if TheInput:IsKeyDown(KEY_CTRL) then
			if self.cooldown then
				if TheInput:IsKeyDown(KEY_SHIFT) then
					TheNet:Say(STRINGS.LMB..STRINGS.SIMPLEECONOMY[14]..self.owner.seccoin:value()..STRINGS.SIMPLEECONOMY[15], true)
				else
					TheNet:Say(STRINGS.LMB..STRINGS.SIMPLEECONOMY[16]..self.owner.seccoin:value()..STRINGS.SIMPLEECONOMY[17], false)
				end
				self.cooldown = false
				self.owner:DoTaskInTime(5, function() self.cooldown = true end)
			end
		else
			if self.mainui.shown then
	    		self:onclose()
	    	else
	    		self:onopen()
	    	end
	    end
	end)

	self.mainbutton.new = self.mainbutton:AddChild(Image("images/sehud/new.xml", "new.tex"))
	self.mainbutton.new.middle = 15
	self.mainbutton.new:SetPosition(15, self.mainbutton.new.middle, 0)
	self.mainbutton.new:SetClickable(false)
	self.mainbutton.new:Hide()
	self.mainbuttonnewmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.mainbuttonnewmove == true then
			self.mainbutton.new:MoveTo(Vector3(15, self.mainbutton.new.middle-2, 0), Vector3(15, self.mainbutton.new.middle+2, 0), .25)
			self.mainbuttonnewmove = false
		else
			self.mainbutton.new:MoveTo(Vector3(15, self.mainbutton.new.middle+2, 0), Vector3(15, self.mainbutton.new.middle-2, 0), .25)
			self.mainbuttonnewmove = true
		end
	end)

self.mainui.goodslist = self.mainui:AddChild(Widget("goodslist"))
	self.mainui.goodslist:SetPosition(-530, 190, 0)
	self.mainui.goodslist:SetScale(.99,.99,1)
	self.listslot = {}
	self:buildlist("food")
	self.title = "food"

self.mainui.buttonfood = self.mainui:AddChild(ImageButton("images/sehud/food_act_"..TUNING.SElan..".xml", "food_act_"..TUNING.SElan..".tex"))
    self.mainui.buttonfood:SetPosition(-530, -315, 0)
    self.mainui.buttonfood:SetNormalScale(1,1,1)
    self.mainui.buttonfood:SetFocusScale(1,1,1)
    self.mainui.buttonfood:SetOnGainFocus(function() self.mainui.buttonfood:ScaleTo(1,1.15,.125) end)
	self.mainui.buttonfood:SetOnLoseFocus(function() self.mainui.buttonfood:ScaleTo(1.15,1,.25) end)
    self.mainui.buttonfood:SetOnClick(function()
    	self.numpage = 1
    	self:buildbutton("food")
	end)

	self.mainui.buttonfood.uplow = self.mainui.buttonfood:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttonfood.uplow:SetPosition(20, 20, 0)
	self.mainui.buttonfood.uplow:SetClickable(false)
	self.mainui.buttonfood.uplow:Hide()
	self.buttonfoodmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonfoodmove == true then
			self.mainui.buttonfood.uplow:MoveTo(Vector3(20, 20-2, 0), Vector3(20, 20+2, 0), .25)
			self.buttonfoodmove = false
		else
			self.mainui.buttonfood.uplow:MoveTo(Vector3(20, 20+2, 0), Vector3(20, 20-2, 0), .25)
			self.buttonfoodmove = true
		end
	end)

self.mainui.buttoncloth = self.mainui:AddChild(ImageButton("images/sehud/cloth_dact_"..TUNING.SElan..".xml", "cloth_dact_"..TUNING.SElan..".tex"))
    self.mainui.buttoncloth:SetPosition(-440, -315, 0)
    self.mainui.buttoncloth:SetNormalScale(1,1,1)
    self.mainui.buttoncloth:SetFocusScale(1,1,1)
    self.mainui.buttoncloth:SetOnGainFocus(function() self.mainui.buttoncloth:ScaleTo(1,1.15,.125) end)
	self.mainui.buttoncloth:SetOnLoseFocus(function() self.mainui.buttoncloth:ScaleTo(1.15,1,.25) end)
    self.mainui.buttoncloth:SetOnClick(function()
    	self.numpage = 1
    	self:buildbutton("cloth")
	end)

	self.mainui.buttoncloth.uplow = self.mainui.buttoncloth:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttoncloth.uplow:SetPosition(20, 20, 0)
	self.mainui.buttoncloth.uplow:SetClickable(false)
	self.mainui.buttoncloth.uplow:Hide()
	self.buttonclothmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonclothmove == true then
			self.mainui.buttoncloth.uplow:MoveTo(Vector3(20, 20-2, 0), Vector3(20, 20+2, 0), .25)
			self.buttonclothmove = false
		else
			self.mainui.buttoncloth.uplow:MoveTo(Vector3(20, 20+2, 0), Vector3(20, 20-2, 0), .25)
			self.buttonclothmove = true
		end
	end)

self.mainui.buttonsmithing = self.mainui:AddChild(ImageButton("images/sehud/smithing_dact_"..TUNING.SElan..".xml", "smithing_dact_"..TUNING.SElan..".tex"))
    self.mainui.buttonsmithing:SetPosition(-350, -315, 0)
    self.mainui.buttonsmithing:SetNormalScale(1,1,1)
    self.mainui.buttonsmithing:SetFocusScale(1,1,1)
    self.mainui.buttonsmithing:SetOnGainFocus(function() self.mainui.buttonsmithing:ScaleTo(1,1.15,.125) end)
	self.mainui.buttonsmithing:SetOnLoseFocus(function() self.mainui.buttonsmithing:ScaleTo(1.15,1,.25) end)
    self.mainui.buttonsmithing:SetOnClick(function()
    	self.numpage = 1
    	self:buildbutton("smithing")
	end)

	self.mainui.buttonsmithing.uplow = self.mainui.buttonsmithing:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttonsmithing.uplow:SetPosition(20, 20, 0)
	self.mainui.buttonsmithing.uplow:SetClickable(false)
	self.mainui.buttonsmithing.uplow:Hide()
	self.buttonsmithingmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonsmithingmove == true then
			self.mainui.buttonsmithing.uplow:MoveTo(Vector3(20, 20-2, 0), Vector3(20, 20+2, 0), .25)
			self.buttonsmithingmove = false
		else
			self.mainui.buttonsmithing.uplow:MoveTo(Vector3(20, 20+2, 0), Vector3(20, 20-2, 0), .25)
			self.buttonsmithingmove = true
		end
	end)

self.mainui.buttonresource = self.mainui:AddChild(ImageButton("images/sehud/resource_dact_"..TUNING.SElan..".xml", "resource_dact_"..TUNING.SElan..".tex"))
    self.mainui.buttonresource:SetPosition(-260, -315, 0)
    self.mainui.buttonresource:SetNormalScale(1,1,1)
    self.mainui.buttonresource:SetFocusScale(1,1,1)
    self.mainui.buttonresource:SetOnGainFocus(function() self.mainui.buttonresource:ScaleTo(1,1.15,.125) end)
	self.mainui.buttonresource:SetOnLoseFocus(function() self.mainui.buttonresource:ScaleTo(1.15,1,.25) end)
    self.mainui.buttonresource:SetOnClick(function()
    	self.numpage = 1
    	self:buildbutton("resource")
	end)

	self.mainui.buttonresource.uplow = self.mainui.buttonresource:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttonresource.uplow:SetPosition(20, 20, 0)
	self.mainui.buttonresource.uplow:SetClickable(false)
	self.mainui.buttonresource.uplow:Hide()
	self.buttonresourcemove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonresourcemove == true then
			self.mainui.buttonresource.uplow:MoveTo(Vector3(20, 20-2, 0), Vector3(20, 20+2, 0), .25)
			self.buttonresourcemove = false
		else
			self.mainui.buttonresource.uplow:MoveTo(Vector3(20, 20+2, 0), Vector3(20, 20-2, 0), .25)
			self.buttonresourcemove = true
		end
	end)

self.mainui.buttonprecious = self.mainui:AddChild(ImageButton("images/sehud/precious_dact_"..TUNING.SElan..".xml", "precious_dact_"..TUNING.SElan..".tex"))
    self.mainui.buttonprecious:SetPosition(-170, -315, 0)
    self.mainui.buttonprecious:SetNormalScale(1,1,1)
    self.mainui.buttonprecious:SetFocusScale(1,1,1)
    self.mainui.buttonprecious:SetOnGainFocus(function() self.mainui.buttonprecious:ScaleTo(1,1.15,.125) end)
	self.mainui.buttonprecious:SetOnLoseFocus(function() self.mainui.buttonprecious:ScaleTo(1.15,1,.25) end)
    self.mainui.buttonprecious:SetOnClick(function()
    	self.numpage = 1
    	self:buildbutton("precious")
	end)

	self.mainui.buttonprecious.new = self.mainui.buttonprecious:AddChild(Image("images/sehud/new.xml", "new.tex"))
	self.mainui.buttonprecious.new:SetPosition(20, 20, 0)
	self.mainui.buttonprecious.new:SetClickable(false)
	self.mainui.buttonprecious.new:Hide()
	self.preciousnewmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.preciousnewmove == true then
			self.mainui.buttonprecious.new:MoveTo(Vector3(20, 20-2, 0), Vector3(20, 20+2, 0), .25)
			self.preciousnewmove = false
		else
			self.mainui.buttonprecious.new:MoveTo(Vector3(20, 20+2, 0), Vector3(20, 20-2, 0), .25)
			self.preciousnewmove = true
		end
	end)

self.mainui.infopage = self.mainui:AddChild(Image("images/sehud/infopage_"..TUNING.SElan..".xml", "infopage_"..TUNING.SElan..".tex"))
	self.mainui.infopage:SetPosition(0, 0, 0)
	self.mainui.infopage:Hide()

self.mainui.close = self.mainui:AddChild(ImageButton("images/sehud/close.xml", "close.tex"))
    self.mainui.close:SetPosition(-25, -315, 0)
    self.mainui.close:SetNormalScale(1,1,1)
    self.mainui.close:SetFocusScale(1,1,1)
    self.mainui.close:SetHoverText(STRINGS.SIMPLEECONOMY[5])
    self.mainui.close:SetOnGainFocus(function() self.mainui.close:ScaleTo(1,1.15,.125) end)
	self.mainui.close:SetOnLoseFocus(function() self.mainui.close:ScaleTo(1.15,1,.25) end)
    self.mainui.close:SetOnClick(function()
    	self:onclose()
	end)

self.mainui.infobutton = self.mainui:AddChild(ImageButton("images/sehud/infobutton.xml", "infobutton.tex"))
    self.mainui.infobutton:SetPosition(-80, -315, 0)
    self.mainui.infobutton:SetNormalScale(1,1,1)
    self.mainui.infobutton:SetFocusScale(1,1,1)
    self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[3])
    self.mainui.infobutton:SetOnGainFocus(function() self.mainui.infobutton:ScaleTo(1,1.15,.125) end)
	self.mainui.infobutton:SetOnLoseFocus(function() self.mainui.infobutton:ScaleTo(1.15,1,.25) end)
    self.mainui.infobutton:SetOnClick(function()
    	if self.mainui.infopage.shown then
    		self.mainui.infobutton:SetTextures("images/sehud/infobutton.xml", "infobutton.tex")
	    	self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[3])
    		self.mainui.goodslist:Show()
	    	self.mainui.status:Show()
	    	self.mainui.next:Show()
	    	self.mainui.back:Show()
	    	self.mainui.infopage:Hide()
	    else
    		self.mainui.infobutton:SetTextures("images/sehud/infoback.xml", "infoback.tex")
	    	self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[4])
	    	self.mainui.goodslist:Hide()
	    	self.mainui.status:Hide()
	    	self.mainui.next:Hide()
	    	self.mainui.back:Hide()
	    	self.mainui.infopage:Show()
	    end
	end)

self.mainui.next = self.mainui:AddChild(ImageButton("images/sehud/next.xml", "next.tex"))
    self.mainui.next:SetPosition(170, -200, 0)
    self.mainui.next:SetNormalScale(1,1,1)
    self.mainui.next:SetFocusScale(1,1,1)
    self.mainui.next:SetHoverText(STRINGS.SIMPLEECONOMY[6])
	self.mainui.next.image:SetTint(1,1,1,1)
    self.mainui.next:SetOnGainFocus(function() self.mainui.next:ScaleTo(1,1.15,.125) end)
	self.mainui.next:SetOnLoseFocus(function() self.mainui.next:ScaleTo(1.15,1,.25) end)
    self.mainui.next:SetOnClick(function()
    	if self.numpage < self.maxpage then
    		self.numpage = self.numpage + 1
    		self:buildlist(self.title)
    		self.mainui.back.image:SetTint(1,1,1,1)
    		if self.numpage >= self.maxpage then
    			self.mainui.next.image:SetTint(1,1,1,.5)
    		end
    	end
	end)

self.mainui.back = self.mainui:AddChild(ImageButton("images/sehud/back.xml", "back.tex"))
    self.mainui.back:SetPosition(120, -200, 0)
    self.mainui.back:SetNormalScale(1,1,1)
    self.mainui.back:SetFocusScale(1,1,1)
    self.mainui.back:SetHoverText(STRINGS.SIMPLEECONOMY[7])
    self.mainui.back.image:SetTint(1,1,1,.5)
    self.mainui.back:SetOnGainFocus(function() self.mainui.back:ScaleTo(1,1.15,.125) end)
	self.mainui.back:SetOnLoseFocus(function() self.mainui.back:ScaleTo(1.15,1,.25) end)
    self.mainui.back:SetOnClick(function()
    	if self.numpage > 1 then
    		self.numpage = self.numpage - 1
    		self:buildlist(self.title)
    		self.mainui.next.image:SetTint(1,1,1,1)
    		if self.numpage <= 1 then
    			self.mainui.back.image:SetTint(1,1,1,.5)
    		end
    	end
	end)

self.owner:DoTaskInTime(.2, function()
		--self.numpage = 1
		--self:loadlist()
		--self:loadcoinlist()
		--self.maxnumpage = math.ceil(#self.achivlist/14)
		--self.achivlistbg = {}
		--self.achivlisttile = {}
		--self.coinlistbutton = {}
		--self:build()
		--self:coinbuild()
		self.vip = -1
		self.money = 0
		self.level = 0
		self.secpreciouschange = false
		self.seasonchange = false
		self.soundm = false
		self:uplowchange()
		self:StartUpdating()
	end)
end)

function uiseconomy:OnUpdate(dt)
	if self.money ~= self.owner.seccoin:value() then
		self:displaycoinamount(self.coinamount.num)
		self:displaycoinamount(self.mainui.status.coinamount.num)
		self.money = self.owner.seccoin:value()
	end
	if self.level ~= self.owner.seclevel:value() then
		for i=1, 5 do
			if self.owner.seclevel:value() >= i then
				self.mainui.status.level[i]:SetTexture("images/sehud/level_act.xml", "level_act.tex")
			else
				self.mainui.status.level[i]:SetTexture("images/sehud/level_dact.xml", "level_dact.tex")
			end
		end
		self.mainui.status.swdjinfo:SetTexture("images/sehud/swdj_"..TUNING.SElan..self.owner.seclevel:value()..".xml", "swdj_"..TUNING.SElan..self.owner.seclevel:value()..".tex")
		self.mainui.status.vipinfo:SetTexture("images/sehud/vip"..(self.owner.seclevel:value()*self.owner.secvip:value())..".xml", "vip"..(self.owner.seclevel:value()*self.owner.secvip:value())..".tex")
		self.level = self.owner.seclevel:value()
	end
	if self.vip ~= self.owner.secvip:value() then
		self.mainui.status.vipinfo:SetTexture("images/sehud/vip"..(self.owner.seclevel:value()*self.owner.secvip:value())..".xml", "vip"..(self.owner.seclevel:value()*self.owner.secvip:value())..".tex")
		self.vip = self.owner.secvip:value()
	end
	local currentexp = self.owner.secexp:value()
	local maxexp = (self.owner.seclevel:value()+1)^3*1000
	if self.owner.seclevel:value() >= 5 then maxexp = self.owner.seclevel:value()^3*1000 end
	local percent = math.ceil(currentexp/maxexp*100)/100
	self.mainui.status.expact:SetScale(percent, 1, 1)
	self.mainui.status.expmask:SetHoverText(currentexp.."/"..maxexp)
	if self.secpreciouschange ~= self.owner.secpreciouschange:value() then
		if self.title == "precious" then
			self:buildlist(self.title)
		end
		if not self.mainui.shown then
			self.mainbutton.new:Show()
			self.mainui.buttonprecious.new:Show()
		else
			self.mainui.buttonprecious.new:Show()
		end
		self.secpreciouschange = self.owner.secpreciouschange:value()
	end
	if self.seasonchange ~= TUNING.SEseasonchange then
		self:uplowchange()
		self.seasonchange = TUNING.SEseasonchange
	end
	if self.soundm ~= self.owner.secsoundm:value() then
		--TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
		TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/research_available")
		self.soundm = self.owner.secsoundm:value()
	end
end

function uiseconomy:uplowchange()
	local buttonname = {"food", "cloth", "smithing", "resource"}
	for i=1, #buttonname do
		local seasont = nil
		local buttont = nil
		if buttonname[i] == "food" then seasont = TUNING.seseasonfood buttont = self.mainui.buttonfood end
		if buttonname[i] == "cloth" then seasont = TUNING.seseasoncloth buttont = self.mainui.buttoncloth end
		if buttonname[i] == "smithing" then seasont = TUNING.seseasonsmithing buttont = self.mainui.buttonsmithing end
		if buttonname[i] == "resource" then seasont = TUNING.seseasonresource buttont = self.mainui.buttonresource end
		if seasont == 1 then
			buttont.uplow:Hide()
		end
		if seasont == .5 then
			buttont.uplow:Show()
			buttont.uplow:SetTexture("images/sehud/low.xml", "low.tex")
		end
		if seasont == 1.5 then
			buttont.uplow:Show()
			buttont.uplow:SetTexture("images/sehud/up.xml", "up.tex")
		end
	end
	self:buildlist(self.title)
end

function uiseconomy:buildlist(title)
	local list = {}
	if title == "food" then list = TUNING.selist_food end
	if title == "cloth" then list = TUNING.selist_cloth end
	if title == "smithing" then list = TUNING.selist_smithing end
	if title == "resource" then list = TUNING.selist_resource end
	--if title == "precious" then list = TUNING.selist_precious end
	if title == "precious" then
		local secp = self.owner.secprecious:value()
		for i=1, 10+4*self.owner.seclevel:value() do
			table.insert(list, selist_precious[secp[i]])
		end
	end
	self.maxpage = math.ceil(#list/48)

	self.mainui.goodslist:KillAllChildren()

	local x = 0
	local y = 0
	for i = 1+48*(self.numpage-1), math.min(#list, 48*(1+self.numpage-1)) do
		if math.ceil((i-48*(self.numpage-1))/10) ~= math.ceil((i-48*(self.numpage-1)-1)/10) then x = 0 else x = x + 80 end
		y = -100*(math.ceil((i-48*(self.numpage-1))/10)-1)
		
		self.listslot[i] = self.mainui.goodslist:AddChild(ImageButton("images/sehud/slotbg_normal.xml", "slotbg_normal.tex"))
		if title == "food" then
			self.listslot[i]:SetTextures("images/sehud/slotbg_fresh.xml", "slotbg_fresh.tex")
		end
	    self.listslot[i]:SetPosition(x, y, 0)
	    self.listslot[i]:SetNormalScale(1,1,1)
	    self.listslot[i]:SetFocusScale(1,1,1)
	    self.listslot[i]:SetOnGainFocus(function() self.listslot[i]:ScaleTo(1,1.15,.125) end)
		self.listslot[i]:SetOnLoseFocus(function() self.listslot[i]:ScaleTo(1.15,1,.25) end)

		self.listslot[i].im = self.listslot[i]:AddChild(Image("images/inventoryimages.xml", list[i].name..".tex"))
		self.listslot[i].im:SetPosition(0, 10, 0)
		self.listslot[i].im:SetScale(.95,.95,1)

		if list[i].name == "blueprint" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[8])
		else
			self.listslot[i]:SetHoverText(STRINGS.NAMES[string.upper(list[i].name)])
		end
		local p1 = self.listslot[i].hovertext:GetPosition()
		local p2 = self.listslot[i].hovertext_bg:GetPosition()
		self.listslot[i].hovertext:SetPosition(p1.x,p1.y+30,p1.z)
		self.listslot[i].hovertext_bg:SetPosition(p2.x,p2.y+30,p2.z)

		self.listslot[i].num1 = self.listslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.listslot[i].num1:SetPosition(3, -33, 0)
		self.listslot[i].num1:SetScale(1.15, 1.15, 1)
		self.listslot[i].num2 = self.listslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.listslot[i].num2:SetPosition(11, -33, 0)
		self.listslot[i].num2:SetScale(1.15, 1.15, 1)
		self.listslot[i].num3 = self.listslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.listslot[i].num3:SetPosition(19, -33, 0)
		self.listslot[i].num3:SetScale(1.15, 1.15, 1)
		self.listslot[i].num4 = self.listslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.listslot[i].num4:SetPosition(27, -33, 0)
		self.listslot[i].num4:SetScale(1.15, 1.15, 1)
		local m = list[i].price
		local num1 = 0
		local num2 = 0
		local num3 = 0
		local num4 = 0
		if m >= 1000 then
			num1 = math.floor(m/1000)
			num2 = math.floor((m - num1*1000)/100)
			num3 = math.floor((m - num1*1000 - num2*100)/10)
			num4 = math.floor((m - num1*1000 - num2*100 - num3*10)/1)
		end
		if m >= 100 and m < 1000 then
			num1 = 0
			num2 = math.floor(m/100)
			num3 = math.floor((m - num2*100)/10)
			num4 = math.floor((m - num2*100 - num3*10)/1)
			self.listslot[i].num1:Hide()
		end
		if m >= 10 and m < 100 then
			num1 = 0
			num2 = 0
			num3 = math.floor(m/10)
			num4 = math.floor((m - num3*10)/1)
			self.listslot[i].num1:Hide()
			self.listslot[i].num2:Hide()
		end
		if m < 10 then
			num1 = 0
			num2 = 0
			num3 = 0
			num4 = m
			self.listslot[i].num1:Hide()
			self.listslot[i].num2:Hide()
			self.listslot[i].num3:Hide()
		end
		self.listslot[i].num1:SetTexture("images/sehud/numbers/"..num1..".xml", num1..".tex")
		self.listslot[i].num2:SetTexture("images/sehud/numbers/"..num2..".xml", num2..".tex")
		self.listslot[i].num3:SetTexture("images/sehud/numbers/"..num3..".xml", num3..".tex")
		self.listslot[i].num4:SetTexture("images/sehud/numbers/"..num4..".xml", num4..".tex")
		--self.listslot[i]:SetOnClick(function()
	    --	SendModRPCToServer(MOD_RPC["SimpleEconomy"]["buy"], list[i].name, list[i].price, false)
		--end)
		self.listslot[i].OnControl = function(self, control, down)
			if not self:IsEnabled() or not self.focus or self:IsSelected() then return end
			if control == CONTROL_ACCEPT or control == CONTROL_SECONDARY then
				if down then
					TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
					self.o_pos = self:GetLocalPosition()
					self:SetPosition(self.o_pos + self.clickoffset)
					self.down = true
					if self.whiledown then
						self:StartUpdating()
					end
					if self.ondown then
						self.ondown()
					end
				else
					if self.down then
						self.down = false
						self:SetPosition(self.o_pos)
						if control == CONTROL_ACCEPT then
							SendModRPCToServer(MOD_RPC["SimpleEconomy"]["buy"], list[i].name, list[i].price, false)
						elseif control == CONTROL_SECONDARY then
							SendModRPCToServer(MOD_RPC["SimpleEconomy"]["buy"], list[i].name, list[i].price, true)
						end
						self:StopUpdating()
					end
				end
				return true
			end
		end
	end
end

function uiseconomy:spitembuild(distance)
	local list = TUNING.selist_special

	self.mainui.status.specialitem:KillAllChildren()

	local x = 0
	for i = 1, #list do
		x = distance*(i-2.5)
		
		self.spitemslot[i] = self.mainui.status.specialitem:AddChild(ImageButton("images/sehud/slotbg_special.xml", "slotbg_special.tex"))
	    self.spitemslot[i]:SetPosition(x, 0, 0)
	    self.spitemslot[i]:SetNormalScale(1,1,1)
	    self.spitemslot[i]:SetFocusScale(1,1,1)
	    self.spitemslot[i]:SetOnGainFocus(function() self.spitemslot[i]:ScaleTo(1,1.15,.125) end)
		self.spitemslot[i]:SetOnLoseFocus(function() self.spitemslot[i]:ScaleTo(1.15,1,.25) end)

		self.spitemslot[i].im = self.spitemslot[i]:AddChild(Image("images/inventoryimages/"..list[i].name..".xml", list[i].name..".tex"))
		self.spitemslot[i].im:SetPosition(0, 10, 0)
		self.spitemslot[i].im:SetScale(.95,.95,1)

		self.spitemslot[i]:SetHoverText(STRINGS.NAMES[string.upper(list[i].name)])
		local p1 = self.spitemslot[i].hovertext:GetPosition()
		local p2 = self.spitemslot[i].hovertext_bg:GetPosition()
		self.spitemslot[i].hovertext:SetPosition(p1.x,p1.y+30,p1.z)
		self.spitemslot[i].hovertext_bg:SetPosition(p2.x,p2.y+30,p2.z)

		self.spitemslot[i].num1 = self.spitemslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.spitemslot[i].num1:SetPosition(3, -33, 0)
		self.spitemslot[i].num1:SetScale(1.15, 1.15, 1)
		self.spitemslot[i].num2 = self.spitemslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.spitemslot[i].num2:SetPosition(11, -33, 0)
		self.spitemslot[i].num2:SetScale(1.15, 1.15, 1)
		self.spitemslot[i].num3 = self.spitemslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.spitemslot[i].num3:SetPosition(19, -33, 0)
		self.spitemslot[i].num3:SetScale(1.15, 1.15, 1)
		self.spitemslot[i].num4 = self.spitemslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
		self.spitemslot[i].num4:SetPosition(27, -33, 0)
		self.spitemslot[i].num4:SetScale(1.15, 1.15, 1)
		local m = list[i].price
		local num1 = 0
		local num2 = 0
		local num3 = 0
		local num4 = 0
		if m >= 1000 then
			num1 = math.floor(m/1000)
			num2 = math.floor((m - num1*1000)/100)
			num3 = math.floor((m - num1*1000 - num2*100)/10)
			num4 = math.floor((m - num1*1000 - num2*100 - num3*10)/1)
		end
		if m >= 100 and m < 1000 then
			num1 = 0
			num2 = math.floor(m/100)
			num3 = math.floor((m - num2*100)/10)
			num4 = math.floor((m - num2*100 - num3*10)/1)
			self.spitemslot[i].num1:Hide()
		end
		if m >= 10 and m < 100 then
			num1 = 0
			num2 = 0
			num3 = math.floor(m/10)
			num4 = math.floor((m - num3*10)/1)
			self.spitemslot[i].num1:Hide()
			self.spitemslot[i].num2:Hide()
		end
		if m < 10 then
			num1 = 0
			num2 = 0
			num3 = 0
			num4 = m
			self.spitemslot[i].num1:Hide()
			self.spitemslot[i].num2:Hide()
			self.spitemslot[i].num3:Hide()
		end
		self.spitemslot[i].num1:SetTexture("images/sehud/numbers/"..num1..".xml", num1..".tex")
		self.spitemslot[i].num2:SetTexture("images/sehud/numbers/"..num2..".xml", num2..".tex")
		self.spitemslot[i].num3:SetTexture("images/sehud/numbers/"..num3..".xml", num3..".tex")
		self.spitemslot[i].num4:SetTexture("images/sehud/numbers/"..num4..".xml", num4..".tex")
		self.spitemslot[i]:SetOnClick(function()
	    	--SendModRPCToServer(MOD_RPC["SimpleEconomy"][list[i].name])
	    	SendModRPCToServer(MOD_RPC["SimpleEconomy"]["buy"], list[i].name, list[i].price)
		end)
	end
end

function uiseconomy:buildbutton(title)
	self.mainui.buttonfood:SetTextures("images/sehud/food_dact_"..TUNING.SElan..".xml", "food_dact_"..TUNING.SElan..".tex")
	self.mainui.buttoncloth:SetTextures("images/sehud/cloth_dact_"..TUNING.SElan..".xml", "cloth_dact_"..TUNING.SElan..".tex")
	self.mainui.buttonsmithing:SetTextures("images/sehud/smithing_dact_"..TUNING.SElan..".xml", "smithing_dact_"..TUNING.SElan..".tex")
	self.mainui.buttonresource:SetTextures("images/sehud/resource_dact_"..TUNING.SElan..".xml", "resource_dact_"..TUNING.SElan..".tex")
	self.mainui.buttonprecious:SetTextures("images/sehud/precious_dact_"..TUNING.SElan..".xml", "precious_dact_"..TUNING.SElan..".tex")
	if title == "food" then
		self.mainui.buttonfood:SetTextures("images/sehud/food_act_"..TUNING.SElan..".xml", "food_act_"..TUNING.SElan..".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_food.xml", "title_food.tex")
		if self.title == "precious" then self.mainui.buttonprecious.new:Hide() end
		--local pb = self.mainui.buttonfood:GetPosition()
		--self.mainui.buttonfood:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "cloth" then
		self.mainui.buttoncloth:SetTextures("images/sehud/cloth_act_"..TUNING.SElan..".xml", "cloth_act_"..TUNING.SElan..".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_cloth.xml", "title_cloth.tex")
		if self.title == "precious" then self.mainui.buttonprecious.new:Hide() end
		--local pb = self.mainui.buttoncloth:GetPosition()
		--self.mainui.buttoncloth:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "smithing" then
		self.mainui.buttonsmithing:SetTextures("images/sehud/smithing_act_"..TUNING.SElan..".xml", "smithing_act_"..TUNING.SElan..".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_smithing.xml", "title_smithing.tex")
		if self.title == "precious" then self.mainui.buttonprecious.new:Hide() end
		--local pb = self.mainui.buttonsmithing:GetPosition()
		--self.mainui.buttonsmithing:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "resource" then
		self.mainui.buttonresource:SetTextures("images/sehud/resource_act_"..TUNING.SElan..".xml", "resource_act_"..TUNING.SElan..".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_resource.xml", "title_resource.tex")
		if self.title == "precious" then self.mainui.buttonprecious.new:Hide() end
		--local pb = self.mainui.buttonresource:GetPosition()
		--self.mainui.buttonresource:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "precious" then
		self.mainui.buttonprecious:SetTextures("images/sehud/precious_act_"..TUNING.SElan..".xml", "precious_act_"..TUNING.SElan..".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_precious.xml", "title_precious.tex")
		self.mainui.buttonprecious.new:Hide()
		--local pb = self.mainui.buttonprecious:GetPosition()
		--self.mainui.buttonprecious:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end

	self.numpage = 1
	self.title = title

	self.mainui.goodslist:Show()
	self.mainui.status:Show()
	self.mainui.next:Show()
	self.mainui.back:Show()
	self.mainui.infopage:Hide()
	self.mainui.infobutton:SetTextures("images/sehud/infobutton.xml", "infobutton.tex")
	self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[3])

	self:buildlist(title)
	self.mainui.back.image:SetTint(1,1,1,.5)
	if self.numpage >= self.maxpage then
		self.mainui.next.image:SetTint(1,1,1,.5)
	else
		self.mainui.next.image:SetTint(1,1,1,1)
	end
end

function uiseconomy:OnControl(control, down)
	if uiseconomy._base.OnControl(self,control, down) then
		return true
	end

	if not down then
		if (control == CONTROL_PAUSE or control == CONTROL_CANCEL) and self.mainui.shown then
			self:onclose()
		end
	end

	return true
end

function uiseconomy:onclose()
	self.mainui:ScaleTo(1,.25,.25)
	self.owner:DoTaskInTime(.125, function() self.mainui:Hide() end)
	if self.title == "precious" then self.mainui.buttonprecious.new:Hide() end
	self.mainbutton.new:Hide()
end

function uiseconomy:onopen()
	self.mainui:Show()
	self.mainui:ScaleTo(.75,1,.125)
	self.mainbutton.new:Hide()
end

function uiseconomy:displaycoinamount(child)
	local m = self.owner.seccoin:value()
	local num1 = 0
	local num2 = 0
	local num3 = 0
	local num4 = 0
	local num5 = 0
	local num6 = 0
	local x = 17
	if m >= 100000 then
		num1 = math.floor(m/100000)
		num2 = math.floor((m - num1*100000)/10000)
		num3 = math.floor((m - num1*100000 - num2*10000)/1000)
		num4 = math.floor((m - num1*100000 - num2*10000 - num3*1000)/100)
		num5 = math.floor((m - num1*100000 - num2*10000 - num3*1000 - num4*100)/10)
		num6 = math.floor((m - num1*100000 - num2*10000 - num3*1000 - num4*100 - num5*10)/1)
		child[1]:Show()
		child[2]:Show()
		child[3]:Show()
		child[4]:Show()
		child[5]:Show()
		for i=1, 6 do
			child[i]:SetPosition(x*(i-0),0,0)
		end
	end
	if m >= 10000 and m < 100000 then
		num1 = 0
		num2 = math.floor(m/10000)
		num3 = math.floor((m - num2*10000)/1000)
		num4 = math.floor((m - num2*10000 - num3*1000)/100)
		num5 = math.floor((m - num2*10000 - num3*1000 - num4*100)/10)
		num6 = math.floor((m - num2*10000 - num3*1000 - num4*100 - num5*10)/1)
		child[1]:Hide()
		child[2]:Show()
		child[3]:Show()
		child[4]:Show()
		child[5]:Show()
		for i=1, 6 do
			child[i]:SetPosition(x*(i-1),0,0)
		end
	end
	if m >= 1000 and m < 10000 then
		num1 = 0
		num2 = 0
		num3 = math.floor(m/1000)
		num4 = math.floor((m - num3*1000)/100)
		num5 = math.floor((m - num3*1000 - num4*100)/10)
		num6 = math.floor((m - num3*1000 - num4*100 - num5*10)/1)
		child[1]:Hide()
		child[2]:Hide()
		child[3]:Show()
		child[4]:Show()
		child[5]:Show()
		for i=1, 6 do
			child[i]:SetPosition(x*(i-2),0,0)
		end
	end
	if m >= 100 and m < 1000 then
		num1 = 0
		num2 = 0
		num3 = 0
		num4 = math.floor(m/100)
		num5 = math.floor((m - num4*100)/10)
		num6 = math.floor((m - num4*100 - num5*10)/1)
		child[1]:Hide()
		child[2]:Hide()
		child[3]:Hide()
		child[4]:Show()
		child[5]:Show()
		for i=1, 6 do
			child[i]:SetPosition(x*(i-3),0,0)
		end
	end
	if m >= 10 and m < 100 then
		num1 = 0
		num2 = 0
		num3 = 0
		num4 = 0
		num5 = math.floor(m/10)
		num6 = math.floor((m - num5*10)/1)
		child[1]:Hide()
		child[2]:Hide()
		child[3]:Hide()
		child[4]:Hide()
		child[5]:Show()
		for i=1, 6 do
			child[i]:SetPosition(x*(i-4),0,0)
		end
	end
	if m < 10 then
		num1 = 0
		num2 = 0
		num3 = 0
		num4 = 0
		num5 = 0
		num6 = m
		child[1]:Hide()
		child[2]:Hide()
		child[3]:Hide()
		child[4]:Hide()
		child[5]:Hide()
		for i=1, 6 do
			child[i]:SetPosition(x*(i-5),0,0)
		end
	end
	child[1]:SetTexture("images/sehud/bignums/"..num1..".xml", num1..".tex")
	child[2]:SetTexture("images/sehud/bignums/"..num2..".xml", num2..".tex")
	child[3]:SetTexture("images/sehud/bignums/"..num3..".xml", num3..".tex")
	child[4]:SetTexture("images/sehud/bignums/"..num4..".xml", num4..".tex")
	child[5]:SetTexture("images/sehud/bignums/"..num5..".xml", num5..".tex")
	child[6]:SetTexture("images/sehud/bignums/"..num6..".xml", num6..".tex")
end

return uiseconomy
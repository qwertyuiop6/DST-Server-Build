local _G = GLOBAL
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

local LAN_ = GetModConfigData('Language')
if LAN_ then
	require 'SEscripts/strings_cn'
	TUNING.SElan = "cn"
else
	require 'SEscripts/strings_en'
	TUNING.SElan = "en"
end

if GetModConfigData('Disintegrate') then
    TUNING.allowgoldstaff = true
else
    TUNING.allowgoldstaff = false
end

PrefabFiles = {
	"secoin",
    "stealer",
    "goldstaff",
    "vipcard",
    "luckamulet",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/secoin.xml"),
    Asset("IMAGE", "images/inventoryimages/secoin.tex"),

    Asset("ATLAS", "images/sehud/mainbutton.xml"),
    Asset("IMAGE", "images/sehud/mainbutton.tex"),

	Asset("ATLAS", "images/sehud/bg.xml"),
    Asset("IMAGE", "images/sehud/bg.tex"),

    Asset("ATLAS", "images/sehud/exp_act.xml"),
    Asset("IMAGE", "images/sehud/exp_act.tex"),

    Asset("ATLAS", "images/sehud/exp_dact.xml"),
    Asset("IMAGE", "images/sehud/exp_dact.tex"),

    Asset("ATLAS", "images/sehud/expmask.xml"),
    Asset("IMAGE", "images/sehud/expmask.tex"),

    Asset("ATLAS", "images/sehud/level_act.xml"),
    Asset("IMAGE", "images/sehud/level_act.tex"),

    Asset("ATLAS", "images/sehud/level_dact.xml"),
    Asset("IMAGE", "images/sehud/level_dact.tex"),

    Asset("ATLAS", "images/sehud/status_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/status_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/hudcoin.xml"),
    Asset("IMAGE", "images/sehud/hudcoin.tex"),

    Asset("ATLAS", "images/sehud/title_food.xml"),
    Asset("IMAGE", "images/sehud/title_food.tex"),
    Asset("ATLAS", "images/sehud/title_cloth.xml"),
    Asset("IMAGE", "images/sehud/title_cloth.tex"),
    Asset("ATLAS", "images/sehud/title_smithing.xml"),
    Asset("IMAGE", "images/sehud/title_smithing.tex"),
    Asset("ATLAS", "images/sehud/title_resource.xml"),
    Asset("IMAGE", "images/sehud/title_resource.tex"),
    Asset("ATLAS", "images/sehud/title_precious.xml"),
    Asset("IMAGE", "images/sehud/title_precious.tex"),

    Asset("ATLAS", "images/sehud/slotbg_normal.xml"),
    Asset("IMAGE", "images/sehud/slotbg_normal.tex"),

    Asset("ATLAS", "images/sehud/slotbg_special.xml"),
    Asset("IMAGE", "images/sehud/slotbg_special.tex"),

    Asset("ATLAS", "images/sehud/slotbg_fresh.xml"),
    Asset("IMAGE", "images/sehud/slotbg_fresh.tex"),

    Asset("ATLAS", "images/sehud/back.xml"),
    Asset("IMAGE", "images/sehud/back.tex"),

    Asset("ATLAS", "images/sehud/next.xml"),
    Asset("IMAGE", "images/sehud/next.tex"),

    Asset("ATLAS", "images/sehud/close.xml"),
    Asset("IMAGE", "images/sehud/close.tex"),

    Asset("ATLAS", "images/sehud/infobutton.xml"),
    Asset("IMAGE", "images/sehud/infobutton.tex"),

    Asset("ATLAS", "images/sehud/infoback.xml"),
    Asset("IMAGE", "images/sehud/infoback.tex"),

    Asset("ATLAS", "images/sehud/infopage_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/infopage_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/new.xml"),
    Asset("IMAGE", "images/sehud/new.tex"),

    Asset("ATLAS", "images/sehud/up.xml"),
    Asset("IMAGE", "images/sehud/up.tex"),

    Asset("ATLAS", "images/sehud/low.xml"),
    Asset("IMAGE", "images/sehud/low.tex"),

    Asset("ATLAS", "images/sehud/food_act_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/food_act_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/food_dact_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/food_dact_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/cloth_act_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/cloth_act_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/cloth_dact_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/cloth_dact_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/smithing_act_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/smithing_act_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/smithing_dact_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/smithing_dact_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/resource_act_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/resource_act_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/resource_dact_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/resource_dact_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/precious_act_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/precious_act_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/precious_dact_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/precious_dact_"..TUNING.SElan..".tex"),

    Asset("ATLAS", "images/sehud/swdj_"..TUNING.SElan.."1.xml"),
    Asset("IMAGE", "images/sehud/swdj_"..TUNING.SElan.."1.tex"),
    Asset("ATLAS", "images/sehud/swdj_"..TUNING.SElan.."2.xml"),
    Asset("IMAGE", "images/sehud/swdj_"..TUNING.SElan.."2.tex"),
    Asset("ATLAS", "images/sehud/swdj_"..TUNING.SElan.."3.xml"),
    Asset("IMAGE", "images/sehud/swdj_"..TUNING.SElan.."3.tex"),
    Asset("ATLAS", "images/sehud/swdj_"..TUNING.SElan.."4.xml"),
    Asset("IMAGE", "images/sehud/swdj_"..TUNING.SElan.."4.tex"),
    Asset("ATLAS", "images/sehud/swdj_"..TUNING.SElan.."5.xml"),
    Asset("IMAGE", "images/sehud/swdj_"..TUNING.SElan.."5.tex"),

    Asset("ATLAS", "images/sehud/vip0.xml"),
    Asset("IMAGE", "images/sehud/vip0.tex"),
    Asset("ATLAS", "images/sehud/vip1.xml"),
    Asset("IMAGE", "images/sehud/vip1.tex"),
    Asset("ATLAS", "images/sehud/vip2.xml"),
    Asset("IMAGE", "images/sehud/vip2.tex"),
    Asset("ATLAS", "images/sehud/vip3.xml"),
    Asset("IMAGE", "images/sehud/vip3.tex"),
    Asset("ATLAS", "images/sehud/vip4.xml"),
    Asset("IMAGE", "images/sehud/vip4.tex"),
    Asset("ATLAS", "images/sehud/vip5.xml"),
    Asset("IMAGE", "images/sehud/vip5.tex"),

    Asset("ATLAS", "images/sehud/numbers/0.xml"),
    Asset("IMAGE", "images/sehud/numbers/0.tex"),
    Asset("ATLAS", "images/sehud/numbers/1.xml"),
    Asset("IMAGE", "images/sehud/numbers/1.tex"),
    Asset("ATLAS", "images/sehud/numbers/2.xml"),
    Asset("IMAGE", "images/sehud/numbers/2.tex"),
    Asset("ATLAS", "images/sehud/numbers/3.xml"),
    Asset("IMAGE", "images/sehud/numbers/3.tex"),
    Asset("ATLAS", "images/sehud/numbers/4.xml"),
    Asset("IMAGE", "images/sehud/numbers/4.tex"),
    Asset("ATLAS", "images/sehud/numbers/5.xml"),
    Asset("IMAGE", "images/sehud/numbers/5.tex"),
    Asset("ATLAS", "images/sehud/numbers/6.xml"),
    Asset("IMAGE", "images/sehud/numbers/6.tex"),
    Asset("ATLAS", "images/sehud/numbers/7.xml"),
    Asset("IMAGE", "images/sehud/numbers/7.tex"),
    Asset("ATLAS", "images/sehud/numbers/8.xml"),
    Asset("IMAGE", "images/sehud/numbers/8.tex"),
    Asset("ATLAS", "images/sehud/numbers/9.xml"),
    Asset("IMAGE", "images/sehud/numbers/9.tex"),

    Asset("ATLAS", "images/sehud/bignums/0.xml"),
    Asset("IMAGE", "images/sehud/bignums/0.tex"),
    Asset("ATLAS", "images/sehud/bignums/1.xml"),
    Asset("IMAGE", "images/sehud/bignums/1.tex"),
    Asset("ATLAS", "images/sehud/bignums/2.xml"),
    Asset("IMAGE", "images/sehud/bignums/2.tex"),
    Asset("ATLAS", "images/sehud/bignums/3.xml"),
    Asset("IMAGE", "images/sehud/bignums/3.tex"),
    Asset("ATLAS", "images/sehud/bignums/4.xml"),
    Asset("IMAGE", "images/sehud/bignums/4.tex"),
    Asset("ATLAS", "images/sehud/bignums/5.xml"),
    Asset("IMAGE", "images/sehud/bignums/5.tex"),
    Asset("ATLAS", "images/sehud/bignums/6.xml"),
    Asset("IMAGE", "images/sehud/bignums/6.tex"),
    Asset("ATLAS", "images/sehud/bignums/7.xml"),
    Asset("IMAGE", "images/sehud/bignums/7.tex"),
    Asset("ATLAS", "images/sehud/bignums/8.xml"),
    Asset("IMAGE", "images/sehud/bignums/8.tex"),
    Asset("ATLAS", "images/sehud/bignums/9.xml"),
    Asset("IMAGE", "images/sehud/bignums/9.tex"),
}

--载入清单
modimport("scripts/SEscripts/itemlist.lua")

--角色交易属性
AddPlayerPostInit(function(inst)
    inst.seccoin = GLOBAL.net_int(inst.GUID,"seccoin")
    inst.secexp = GLOBAL.net_int(inst.GUID,"secexp")
    inst.seclevel = GLOBAL.net_shortint(inst.GUID,"seclevel")
    inst.secvip = GLOBAL.net_shortint(inst.GUID,"secvip")
    inst.secprecious = GLOBAL.net_bytearray(inst.GUID,"secprecious")
    inst.secpreciouschange = GLOBAL.net_bool(inst.GUID, "secpreciouschange")
    inst.secsoundm = GLOBAL.net_bool(inst.GUID, "secsoundm", "secsoundm")
    inst:AddComponent("seplayerstatus")
    if not GLOBAL.TheNet:GetIsClient() then
        inst.components.seplayerstatus:Init(inst)
    end
end)

--全局经济数据
AddPrefabPostInit("forest", function() GLOBAL.TheWorld:AddComponent("seworldstatus") end)
AddPrefabPostInit("cave", function() GLOBAL.TheWorld:AddComponent("seworldstatus") end)

--设置modrpc
AddModRPCHandler("SimpleEconomy", "buy", function(player, iname, iprice, more)
    local iiname = iname
    local amount = 1
    if more then amount = 10 end

    if iname == "blueprint" and math.random(0, 40) <= 1 then
        iiname = selist_blueprint[math.random(#selist_blueprint)].name
    end
    
    if player.components.health.currenthealth > 0 and not player:HasTag("playerghost") then
        local discount = player.components.seplayerstatus.discount
        if player.components.seplayerstatus.coin >= math.ceil(iprice*discount*amount) then
            for i=1, amount do
                local item = GLOBAL.SpawnPrefab(iiname)
                player.components.inventory:GiveItem(item, nil, player:GetPosition())
            end
            player.components.seplayerstatus:DoDeltaCoin(-iprice*amount)
        end
    else
        local discount = player.components.seplayerstatus.discount
        if player.components.seplayerstatus.coin >= math.ceil(iprice*discount) then
            local pt = Point(player.Transform:GetWorldPosition())
            for i=1, amount do
                local angle = math.random()*2*GLOBAL.PI
                local loots = GLOBAL.SpawnPrefab(iiname)
                loots.Transform:SetPosition(pt.x,pt.y,pt.z)
                loots.Physics:SetVel(2*math.cos(angle), 10, 2*math.sin(angle))
            end
            player.components.seplayerstatus:DoDeltaCoin(-iprice*amount)
        end
    end
end)

--UI尺寸
local function ScaleUI(self, screensize)
	local hudscale = self.top_root:GetScale()
	self.uiseconomy:SetScale(.75*hudscale.x,.75*hudscale.y,1)
end

--UI
local uiseconomy = require("widgets/uiseconomy")
local function Adduiseconomy(self)
    self.uiseconomy = self.top_root:AddChild(uiseconomy(self.owner))
    local screensize = {GLOBAL.TheSim:GetScreenSize()}
    ScaleUI(self, screensize)
    self.uiseconomy:SetHAnchor(0)
    self.uiseconomy:SetVAnchor(0)
    --H: 0=中间 1=左端 2=右端
    --V: 0=中间 1=顶端 2=底端
    self.uiseconomy:MoveToFront()
    local OnUpdate_base = self.OnUpdate
	self.OnUpdate = function(self, dt)
		OnUpdate_base(self, dt)
		local curscreensize = {GLOBAL.TheSim:GetScreenSize()}
		if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
			ScaleUI(self)
            screensize = curscreensize
		end
	end
end
AddClassPostConstruct("widgets/controls", Adduiseconomy)
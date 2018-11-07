_G = GLOBAL
--local BRANCH =_G.BRANCH
--local BRA = ""
--判断游戏分支部分

ISPLAYINGNOW = ( _G.TheNet:GetIsClient() or _G.TheNet:GetIsServer() )
local LANG = GetModConfigData("LANG")
local SMALL_TEXTURES = GetModConfigData("SMALL_TEXTURES")
local langname = { "chs", "[Chinses] 所选语言不存在或无法加载，默认加载简体翻译成功！", }
local choose =
{
	["simplified"] = { "chs", "[Chinses] 加载简体翻译成功！", },
	["traditional"] = { "cht", "[Chinses] 載入繁體翻譯成功！", },
	["schinese"] = { "chs", "[Chinses] 据STEAM语言加载简体翻译成功！", },
	["tchinese"] = { "cht", "[Chinses] 據STEAM語言載入繁體翻譯成功！", },
}

--[[
if BRANCH == "release" then 
	print("[Chinese] 检测到当前运行版本为正式版。")
else
	print("[Chinese] 检测到当前运行版本为测试版。")
	BRA = "_beta"
end
]]
--判断游戏分支部分

if LANG ~= "auto" then
--主要功能
	--if LANG ~= "default" then
		langname = choose[LANG] or langname
	--else
		--print("[Chinses] Do not load any translation.")
		--return
	--end
else
	local steamlang = _G.TheNet:GetLanguageCode()
	langname = choose[steamlang] or langname
end

local pofilename = "DST_"..langname[1]..".po"
--local pofilename = "DST_"..langname[1]..BRA..".po"
--判断游戏分支部分
LoadPOFile(pofilename, langname[1])
print(langname[2])


if SMALL_TEXTURES and not ISPLAYINGNOW then
-- 自动关闭小贴图（By Skull）
	if _G.TheNet:GetIsServer() and _G.TheNet:GetServerIsDedicated() then
		print("[Chinese] 检测到当前程序为服务端，无需加载自动关闭小贴图功能！")
		return
	end

	AddClassPostConstruct("widgets/loadingwidget", function(self, ...)
		if _G.TheFrontEnd and _G.TheFrontEnd:GetGraphicsOptions() and _G.TheFrontEnd:GetGraphicsOptions():IsSmallTexturesMode() then
			_G.TheFrontEnd:GetGraphicsOptions():SetSmallTexturesMode( false )
			print("[Chinese] 已自动关闭小贴图!!")
		end
	end)

end


--[[
----------------------------------------------------------------------------------------------------------------------
--修复世界的标题和描述

local PresetLevels = {}
for i,v in pairs(_G.STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS) do
	PresetLevels[v] = _G.LanguageTranslator.languages[_G.LanguageTranslator.defaultlang]["STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.".._G.TrimString(string.upper(i)) ] or v
end
for i,v in pairs(_G.STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC) do
	PresetLevels[v] = _G.LanguageTranslator.languages[_G.LanguageTranslator.defaultlang]["STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.".._G.TrimString(string.upper(i))] or v
end

AddClassPostConstruct("widgets/customizationtab", function(self)
	local oldUpdateMultilevelUI = self.UpdateMultilevelUI
	function self:UpdateMultilevelUI()
		oldUpdateMultilevelUI(self)
		self.presettitle:SetString(string.gsub( self.presettitle:GetString() , 'Presets' , '预设'))
	end

	local oldUpdatePresetInfo = self.UpdatePresetInfo
	function self:UpdatePresetInfo(level)
		oldUpdatePresetInfo(self, level)
		self.presetdesc:SetString( PresetLevels[self.presetdesc:GetString()] or self.presetdesc:GetString() )
		self.presetspinner.spinner:UpdateText( PresetLevels[self.presetspinner.spinner:GetText()] or self.presetspinner.spinner:GetText() )
	end

end)

--By Skull
----------------------------------------------------------------------------------------------------------------------
]]
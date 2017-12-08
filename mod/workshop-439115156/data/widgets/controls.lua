local _visibility_hud = false

local function OnKeyPressed(key)
	--if data.inst == GLOBAL.ThePlayer then
		if key == KEY_H then
			if _visibility_hud then
				ThePlayer.HUD:Toggle(0)
				_visibility_hud = not _visibility_hud
			else
				ThePlayer.HUD:Toggle(1)
				_visibility_hud = not _visibility_hud
			end
		end
	--end
end

local function OnRawKey(key, down)
  	if (key and not down) and not IsPaused() then
      --	OnKeyPressed(key)
  	end
end

local function ControlsPostConstruct(inst)
	inst.handler = TheInput:AddKeyHandler(function(key, down) OnRawKey(key, down) end )
end
AddClassPostConstruct("widgets/controls", ControlsPostConstruct)
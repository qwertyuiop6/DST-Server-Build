--[[	Copyright (c) 2015 Kzisor/Ysovuka	]]
local _G = _G or GLOBAL
local assert = _G.assert
local rawget = assert( _G.rawget )
local setmetatable = assert( _G.setmetatable )
local setfenv = assert( _G.setfenv )

-- Create the table to clone the global variables.
return function(env)

env = setmetatable(env, {
	__index = _G and function(t, k)
		local v = rawget(t, k)

		if v == nil then
			return rawget(_G, k) or rawget(env, k)
		end

		return v 
	end,
})

if setfenv then
	setfenv(1, env)
end

return env

end
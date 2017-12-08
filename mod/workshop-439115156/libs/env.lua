--[[	Copyright (c) 2015 Kzisor/Ysovuka	]]
local _G = _G or GLOBAL
local _M = env

local assert = _G.assert
local error = assert( _G.error )
local rawget = assert( _G.rawget )
local setmetatable = assert( _G.setmetatable )
local setfenv = assert( _G.setfenv )

--[[
	The following is to prevent this file from being ran more than once.

	This is necessary to allow it to be loaded both from modmain.lua,
	modworldgenmain.lua and other mods, without the former load overriding
	the latter.
]]
local _IDENTIFIER = "mod.environment"

if _G.rawget(_G.package.loaded, _IDENTIFIER) then
	return _G.package.loaded[_IDENTIFIER]
end


local function preload_searcher(self, name)
	return self.package.preload[name] ~= nil and self.package.preload[name] or "No field package[ '"..name.."' ] found."
end

local function default_searcher(self, name)
	name = name:gsub("[.\\]", "/")

	local fail_pieces = {}

	for pathspec in self.package.path:gmatch("[^;]+") do
		local path = pathspec:gsub("%?", name, 1)

		if _G.kleifileexists(path) then
			local fn = _G.kleiloadlua(path)

			return type(fn) == "function" and fn or error(tostring(fn or "Unknown error"), 3)
		else
			table.insert(fail_pieces, "\tNo file '"..path.."' found.")
		end
	end

	return table.concat(fail_pieces, "\n")
end

-- Create the table to clone the global variables.
local function CreateNewEnvironment(env)
	setmetatable(env, {
		__index = _G and function(t, k)
				return rawget(t, k) or rawget(_G, k) or rawget(env, k)
			end,
		})

	return env
end

local Requirer = Class(function(self, default_env, load_once)
	default_env = CreateNewEnvironment(default_env or _G)

	self.package =
	{
		path = MODROOT.."?.lua",
		searchers = { preload_searcher, default_searcher },
		preload = {},
		loaded = {},
	}
	self.package.loaders = self.package.searchers

	function self:GetDefaultEnvironment()
		return default_env
	end
end)

function Requirer:GetEnvironment()
	return self.env or self:GetDefaultEnvironment()
end

function Requirer:SetEnviornment(env)
	self.env = env
end

function Requirer:__call(name)
	if self.package.loaded[name] then
		return self.package.loaded[name]
	elseif _G.package.loaded[name] then
		return _G.package.loaded[name]
	else
		local fail_pieces = {}

		for _, searcher in ipairs(self.package.searchers) do
			local fn = searcher(self, name)

			if type(fn) == "function" then
				_G.setfenv(fn, self:GetEnvironment())

				self.package.loaded[name] = fn(name) or self.package.loaded[name] or true

				_G.package.loaded[name] = self.package.loaded[name]

				return self.package.loaded[name]
			elseif type(fn) == "string" then
				table.insert(fail_pieces, fn)
			end
		end

		table.insert(fail_pieces, 1, ("Mod module '%s' not found:"):format(name))

		return error(table.concat(fail_pieces, "\n"), 2)
	end
end

function Requirer:ExportAs(id)
	_G.package.loaded[id] = self
end

local ModRequirer = Class(Requirer, function(self)
	Requirer._ctor(self, _M)
end)

function ModRequirer:GetModEnvironment()
	return self:GetDefaultEnvironment()
end

function ModRequirer:GetModInfo()
	return self:GetModEnvironment().modinfo
end

use = ModRequirer()
_G[_IDENTIFIER] = use

function _G.IsDontStarveTogether()
	return kleifileexists("scripts/networking.lua") and true or false
end

return use
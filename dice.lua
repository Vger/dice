#!/usr/local/bin/lua52

do
	-- Assume some of the needed libraries are placed relative to
	-- where this main script lives.
	local dir = arg[0]:match("^(.*)/[^/]*$")
	if dir and dir ~= '.' then
		package.path = dir .. '/?.lua;' .. dir .. '/?/init.lua;' .. package.path
		package.cpath = dir .. '/?.so;' .. package.cpath
	end
end

local success, diceware = pcall(require, "diceware")
if not success then
	diceware = {}
end

local function num_dices()
	for k in pairs(diceware) do
		if type(k) == "string" and k:match("^[1-6]*$") then
			return #k
		end
		if type(k) == "number" and k > 0 then
			local s = string.format("%d", k)
			if tonumber(s) == k then
				return #s
			end
		end
	end
	return 1
end

local num_symbols = ...
num_symbols = tonumber(num_symbols) or 1

local dices = num_dices()
local f = assert(io.open("/dev/urandom"))

for i = 1, num_symbols do
	local ch = f:read(dices)
	local dice_result = ""
	for i=1, dices do
		dice_result = dice_result .. string.byte(ch, i) % 6 + 1
	end

	local dice_name = diceware[dice_result] or diceware[tonumber(dice_result)]
	if dice_name then
		print(dice_result, dice_name)
	else
		print(dice_result)
	end
end
f:close()

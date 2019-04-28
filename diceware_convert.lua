#!/usr/bin/env lua

-- Convert diceware file to a lua file
-- http://world.std.com/%7Ereinhold/diceware.html

local infile = assert(io.open(..., "r"))

local outfile = assert(io.open("diceware.lua", "w"))

local line = infile:read("*l")
local num_dices = nil

outfile:write("return {\n")
while line ~= nil do
	local figures, symbol = line:match("([1-6]+)%s*(%S+)")
	if figures and symbol then
		if num_dices == nil then
			num_dices = #figures
		elseif #figures == num_dices then
			outfile:write("[" .. figures .. "] = " .. string.format("%q", symbol) .. ",\n")
		end
	end
	line = infile:read("*l")
end
outfile:write("}")
outfile:close()
infile:close()

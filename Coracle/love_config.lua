--[[
	
	
]]--
require "Coracle/colour"
class('LoveConfig').extends()

function LoveConfig:init(config)
	LoveConfig.super.init()
	
	if cofig == nil then
		self:default()
	else
		--todo
	end
end

function LoveConfig:setFont(font)
	love.graphics.setFont(font)
end

function LoveConfig:initFont(path, size)
	local font = love.graphics.newFont(path, size)
	font:setFilter("linear", "linear", 4)
	love.graphics.setFont(font)
end

function LoveConfig:default()
	love.graphics.setNewFont(12)
	local font = love.graphics.getFont()
	font:setFilter("linear", "linear", 4)
	love.graphics.setColor(rgb("#ffffff"))
	love.graphics.setBackgroundColor(rgb("#333333"))
end


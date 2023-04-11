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
	love.graphics.setFont(love.graphics.newFont(path, size))
end

function LoveConfig:default()
	love.graphics.setNewFont(24)
	love.graphics.setColor(rgb("#ffffff"))
	love.graphics.setBackgroundColor(rgb("#333333"))
end


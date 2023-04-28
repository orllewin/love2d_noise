--[[
	

	
]]--

require "Coracle/coracle"
require "Coracle/Views/view_utils"
require "Coracle/colour"
require "Coracle/Shapes/rectangle"

class('ToggleButton').extends()

function ToggleButton:init(label, offColour, onColour, x, y, width, height, onClick)
	ToggleButton.super.init()
	
	self.colour = colour
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.onClick = onClick
	
	self.active = false
	
	self.yOffset = 0

	local lineWidth = love.graphics.getLineWidth()
	self.canvasOffset = lineWidth/2
	
	self.offCanvas = love.graphics.newCanvas(width + lineWidth, height + lineWidth)
	love.graphics.setCanvas(self.offCanvas)
	love.graphics.setColor(rgb(offColour)) 	
	coracle.graphics.rectangle('fill', self.canvasOffset, self.canvasOffset, width, height, 7, "canvas"):draw()
	love.graphics.setColor(rgb("#333333")) 
	local font = love.graphics.getFont()
	local labelWidth = font:getWidth(label)
	love.graphics.print(label, width/2 - (labelWidth/2) + self.canvasOffset, height/2 - (font:getHeight()/2) - 1 + self.canvasOffset)
	love.graphics.setCanvas() 	
	love.graphics.setColor(white()) 
	
	self.onCanvas = love.graphics.newCanvas(width + lineWidth, height + lineWidth)
	love.graphics.setCanvas(self.onCanvas)
	love.graphics.setColor(rgb(onColour)) 	
	coracle.graphics.rectangle('fill', self.canvasOffset, self.canvasOffset, width, height, 7, "canvas"):draw()
	love.graphics.setColor(rgb("#333333")) 
	local font = love.graphics.getFont()
	local labelWidth = font:getWidth(label)
	love.graphics.print(label, width/2 - (labelWidth/2) + self.canvasOffset, height/2 - (font:getHeight()/2) - 1 + self.canvasOffset)
	love.graphics.setCanvas() 	
	love.graphics.setColor(white()) 
end

function ToggleButton:contains(x, y)
	return inBounds(x, y, self.x + (self.width/2), self.y + (self.height/2), self.width, self.height)
end

function ToggleButton:clickDown()
	self.yOffset = 2
end

function ToggleButton:clickUp()
	self.yOffset = 0
	if self.onClick ~= nil then self.onClick() end
	
	self.active = not self.active
	self:draw()
end

function ToggleButton:off()
	self.active = false
end

function ToggleButton:on()
	self.active = true
end

function ToggleButton:draw()
	if self.active then
		love.graphics.draw(self.onCanvas, self.x - self.canvasOffset, self.y - self.canvasOffset + self.yOffset)
	else
		love.graphics.draw(self.offCanvas, self.x - self.canvasOffset, self.y - self.canvasOffset + self.yOffset)
	end
	
end
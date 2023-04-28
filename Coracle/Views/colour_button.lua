--[[
	

	
]]--

require "Coracle/coracle"
require "Coracle/Views/view_utils"
require "Coracle/colour"
require "Coracle/Shapes/rectangle"

class('ColourButton').extends()

function ColourButton:init(label, colour, x, y, width, height, onClick)
	ColourButton.super.init()
	
	self.colour = colour
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.onClick = onClick
	
	self.yOffset = 0

local lineWidth = love.graphics.getLineWidth()
	self.canvasOffset = lineWidth/2
	self.canvas = love.graphics.newCanvas(width + lineWidth, height + lineWidth)

	love.graphics.setCanvas(self.canvas)

	love.graphics.setColor(rgb(self.colour)) 	
	coracle.graphics.rectangle('fill', self.canvasOffset, self.canvasOffset, width, height, 7, "canvas"):draw()


	love.graphics.setColor(rgb("#4e4e4e")) 
	local font = love.graphics.getFont()
	local labelWidth = font:getWidth(label)
	love.graphics.print(label, width/2 - (labelWidth/2) + self.canvasOffset, height/2 - (font:getHeight()/2) - 1 + self.canvasOffset)
	love.graphics.setCanvas() 	
	love.graphics.setColor(white()) 
end

function ColourButton:contains(x, y)
	return inBounds(x, y, self.x + (self.width/2), self.y + (self.height/2), self.width, self.height)
end

function ColourButton:clickDown()
	self.yOffset = 2
end

function ColourButton:clickUp()
	self.yOffset = 0
	if self.onClick ~= nil then self.onClick() end
end

function ColourButton:draw()
	love.graphics.draw(self.canvas, self.x - self.canvasOffset, self.y - self.canvasOffset + self.yOffset)
end
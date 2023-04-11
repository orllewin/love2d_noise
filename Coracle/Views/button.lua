--[[
	

	
]]--

require "Coracle/Views/view_utils"
require "Coracle/colour"

class('Button').extends()

function Button:init(label, x, y, width, height, onClick)
	Button.super.init()
	
	self.label = label
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.onClick = onClick
	
	self.yOffset = 0
	
	self.canvas = love.graphics.newCanvas(width, height)
	love.graphics.setCanvas(self.canvas)
	love.graphics.setColor(white()) 
	love.graphics.rectangle('fill', 0, 0, width, height, 6, 6)
	
	love.graphics.setColor(rgb("#1d1d1d")) 
	local font = love.graphics.getFont()
	local labelWidth = font:getWidth(label)
	love.graphics.print(self.label, width/2 - (labelWidth/2), height/2 - (font:getHeight()/2) + 1)
	love.graphics.setColor(white()) --reset colour?
	love.graphics.setCanvas() 
	
end

function Button:contains(x, y)
	return inBounds(x, y, self.x, self.y, self.width, self.height)
end

function Button:clickDown()
	self.yOffset = 3
end

function Button:clickUp()
	self.yOffset = 0
	if self.onClick ~= nil then self.onClick() end
end

function Button:draw()
	love.graphics.draw(self.canvas, self.x - (self.width/2), self.y - (self.height/2) + self.yOffset)
	--love.graphics.print(self.label, self.x, self.y)
end
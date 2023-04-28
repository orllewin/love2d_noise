--[[
	

	
]]--

require "Coracle/Views/view_utils"
require "Coracle/colour"
require "Coracle/math"

class('Slider').extends()

local trackHeight = 3
local caretRadius = 9

function Slider:init(value, x, y, width, height, onClick)
	Slider.super.init()
	
	self.value = value
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.onClick = onClick
	
	self.tracking = false
	self.isHovering = false
		
	self:redraw()
	
end

function Slider:redraw()
	if self.canvas ~= nil then self.canvas:release() end
	self.canvas = love.graphics.newCanvas(self.width, self.height)
	love.graphics.setCanvas(self.canvas)
	
	love.graphics.setColor(whiteAlpha(0.7)) 
	love.graphics.rectangle('fill', 0, self.height/2 - (trackHeight/2), self.width, trackHeight)
	
	love.graphics.setColor(white()) 	
	self.handleX = map(self.value, 0.0, 1.0, 0.0, self.width)
	local cX = math.min(self.handleX, self.width - caretRadius)
	cX = math.max(cX, caretRadius)
	love.graphics.circle('fill', cX, self.height/2, caretRadius, 30)
	love.graphics.circle('line', cX, self.height/2, caretRadius, 30)
		
	love.graphics.setColor(white()) --reset colour?
	love.graphics.setCanvas() 
end

function Slider:contains(x, y)
	self.isHovering = inBounds(x, y, (self.x + self.handleX), self.y + self.height/2, caretRadius * 4, self.height)
	if self.isHovering == false then self.tracking = false end
	return self.isHovering
end

function Slider:slide(x, y)
	if self.tracking == false then return end
	self.value = map(x - self.x, 0.0, self.width, 0.05, 1.0)
	self:redraw()
	if self.onClick ~= nil then self.onClick(self.value) end
end

function Slider:clickDown()
	self.tracking = true
end

function Slider:clickUp()
	self.tracking = false
end

function Slider:draw()
	love.graphics.draw(self.canvas, self.x, self.y)
end
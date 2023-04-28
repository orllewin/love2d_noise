class('Label').extends()

function Label:init(label, x, y, colour)
	Label.super.init()
	
	self.x = x
	self.y = y
	
	self.colour = colour
	
	self:setText(label)
end

function Label:setText(text)
	local font = love.graphics.getFont()
	local width = font:getWidth(text)
	local height = font:getHeight()
	
	local r, g, b, a = love.graphics.getColor()
	
	self.canvas = love.graphics.newCanvas(width, height)
	love.graphics.setCanvas(self.canvas)
	love.graphics.push()
	love.graphics.setColor(self.colour)
	love.graphics.print(text, 0, 0)
	love.graphics.pop()
	love.graphics.setCanvas()
	
	love.graphics.setColor(r, g, b, a)
end

function Label:draw()
	love.graphics.draw(self.canvas, self.x, self.y)
end
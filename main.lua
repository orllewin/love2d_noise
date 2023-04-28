require 'globals'
require "Coracle/object"
require "Coracle/coracle"
require "Coracle/love_config"
require "Coracle/Views/view_manager"
require "Coracle/Views/button"
require "Coracle/Views/colour_button"
require "Coracle/Views/toggle_button"
require "Coracle/Views/slider"
require "Coracle/Shapes/rectangle"
require "Coracle/Shapes/line"
require "Noise/noise"


love.graphics.setDefaultFilter("linear", "linear")

local config = LoveConfig()
local viewManager = ViewManager()
local noise = Noise()
local pitch = 0.8

local segmentColour = "#efefef"
love.graphics.setColor(rgb(bg)) 
local segmentedBackground = Rectangle('fill', 5, 70, 310, 40, 7, 'canvas')

--320x115
local line1 = Line(109, 80, 106, 100, div)
local line2 = Line(212, 80, 212, 100, div)

local brownButton = nil
local pinkButton = nil
local whiteButton = nil

local title = "Noise"

function play(type)
	noise:setMode(type)
	noise:play()
	noise:setPitch(pitch)
	noise:setLowPass(0.1)
end

function love.load()
	config:initFont("Fonts/SFPro/SF-Pro-Display-Regular.otf", 15)
	viewManager:setConfig(config)
	
	viewManager:add(Slider(0.8, 10, 30, 300, 40, function(value) 
		pitch = value
		noise:setPitch(pitch)
	end))
	
	local buttonWidth = 95
	local buttonHeight = 30
	local buttonY = 75
	local buttonMargin = (320 - (buttonWidth*3))/3
	
	local titleLabel = coracle.views.label(title, 10, 10, rgb("#444444"))
	
	
	viewManager:add(titleLabel)
	
	love.graphics.setLineWidth(1)
	
	brownButton = ToggleButton("Brown", bg, brown,  10, buttonY, buttonWidth, buttonHeight, function() 
		play("brown")
		line1:hide()
		line2:show()
		pinkButton:off()
		whiteButton:off()
	end)
	
	viewManager:add(brownButton)
	
	pinkButton = ToggleButton("Pink", bg, pink, 	113, buttonY, buttonWidth, buttonHeight, function() 
		play("pink")
		line1:hide()
		line2:hide()
		brownButton:off()
		whiteButton:off()
	end)

	viewManager:add(pinkButton)
	
	whiteButton = ToggleButton("White", bg, whitee, 216, buttonY, buttonWidth, buttonHeight, function() 
		play("white")
		line1:show()
		line2:hide()
		brownButton:off()
		pinkButton:off()
	end)
	viewManager:add(whiteButton)
end	



function love.update(dt)
	noise:update(dt)
end

function love.draw()
	
	 segmentedBackground:draw()
	
	 viewManager:drawViews()
	 
	 line1:draw()
	 line2:draw()
end

function love.mousepressed(x, y, button)
	if button == 1 then viewManager:clickDown(x, y) end
end

function love.mousereleased(x, y, button)
	 if button == 1 then viewManager:clickUp(x, y) end
end

function love.mousemoved(x, y, dx, dy, istouch)
	viewManager:mousemoved(x, y, dx, dy, istouch)
end

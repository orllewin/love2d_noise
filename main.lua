require "Coracle/object"
require "Coracle/coracle"
require "Coracle/love_config"
require "Coracle/Views/view_manager"
require "Coracle/Views/button"
require "Coracle/Views/colour_button"
require "Coracle/Views/slider"
require "Noise/noise"


love.graphics.setDefaultFilter("linear", "linear")

local config = LoveConfig()
local viewManager = ViewManager()
local noise = Noise()
local pitch = 0.8

local title = "noise"

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
	
	local titleLabel = coracle.views.label(title, 10, 10)
	
	viewManager:add(titleLabel)
	
	love.graphics.setLineWidth(1)
	
	viewManager:add(ColourButton("brown", "#755e41", 10, buttonY, buttonWidth, buttonHeight, function() 
		play("brown")
		--love.graphics.setBackgroundColor(rgb("#5e493b"))
		titleLabel:setText("noise: brown")
	end))

	viewManager:add(ColourButton("pink", "#8f597a", 	113, buttonY, buttonWidth, buttonHeight, function() 
		play("pink")
		--love.graphics.setBackgroundColor(rgb("#5e384f"))
		titleLabel:setText("noise: pink")
	end))
	viewManager:add(ColourButton("white", "#adadad", 216, buttonY, buttonWidth, buttonHeight, function() 
		play("white")
		--love.graphics.setBackgroundColor(rgb("#454545"))
		titleLabel:setText("noise: white")
	end))
end	



function love.update(dt)
	noise:update(dt)
end

function love.draw()
	
	 
	 viewManager:drawViews()
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

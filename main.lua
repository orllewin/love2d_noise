require "Coracle/object"
require "Coracle/love_config"
require "Coracle/Views/view_manager"
require "Coracle/Views/button"
require "Coracle/Views/slider"
require "Noise/noise"

local config = LoveConfig()
local viewManager = ViewManager()
local noise = Noise()
local pitch = 0.8

function play(type)
	noise:setMode(type)
	noise:play()
	noise:setPitch(pitch)
	noise:setLowPass(0.1)
end

function love.load()
	config:initFont("Fonts/Proggy/proggy-square-rr.ttf", 32)
	viewManager:setConfig(config)
	
	viewManager:add(Slider(0.8, 160, 55, 300, 40, function(value) 
		pitch = value
		noise:setPitch(pitch)
	end))
	viewManager:add(Button("Brown", 055, 100, 100, 40, function() 
		play("brown")
	end))
	viewManager:add(Button("Pink", 	160, 100, 100, 40, function() 
		play("pink")
	end))
	viewManager:add(Button("White", 265, 100, 100, 40, function() 
		play("white")
	end))
end	



function love.update(dt)
	noise:update(dt)
end

function love.draw()
	 love.graphics.print("noise", 10, 10)
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

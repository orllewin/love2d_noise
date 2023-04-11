--[[
	
	Generates Brown, White, or Pink noise.
	Adapted from Denver: https://github.com/superzazu/denver.lua/blob/master/denver.lua
	
]]--
require "Coracle/math"

class('Noise').extends()

local samplerate = 44100
local seconds = 3.0

function Noise:init()
	Noise.super.init()
	
	self.prevBrownNoiseFrame = 0
	self.pink0 = 0
	self.pink1 = 0
	self.pink2 = 0
	self.pink3 = 0
	self.pink4 = 0
	self.pink5 = 0
	self.pink6 = 0
	
	self.noiseX = 0.0
	self.pitch = 0.5
	self.minPitch = 1.0
	self.maxPitch = 0.0
	self.wanderingPitch = true
	
	self.source = love.audio.newQueueableSource(samplerate, 16, 1, 4)
end

function Noise:setMode(type)
	local pitch = self.source:getPitch()
	self.source:stop()
	self.source:release()
	self.source = love.audio.newQueueableSource(samplerate, 16, 1, 4)
	if type == "brown" then
		self.type = 1
		self:queueBrownBuffer()
	elseif type == "white" then
		self.type = 2
		self:queueWhiteBuffer()
	elseif type == "pink" then
		self.type = 3
		self:queuePinkBuffer()
	else
		--default to brown
		self.type = 1
		self:queueBrownBuffer()
	end
end

function Noise:play()
	love.audio.play(self.source)
end

function Noise:setPitch(pitch) 
	self.wanderingPitch = false
	self.source:setPitch(pitch) 
end

function Noise:setLowPass(value)
	self.source:setFilter({
		type = "lowpass", 
		volume = 1.0,
		highgain = value
	})
end

function Noise:setHighPass(value)
	self.source:setFilter({
		type = "highpass", 
		volume = 1.0,
		lowgain = value
	})
end

function Noise:update(dt)
		if self.source:getFreeBufferCount() > 0 then
			if self.type == 1 then
				self:queueBrownBuffer()
			elseif self.type == 2 then
				self:queueWhiteBuffer()
			elseif self.type == 3 then
				self:queuePinkBuffer()
			end
	end
	
	if self.wanderingPitch == true then
		self.noiseX = self.noiseX + 0.0005
		self.pitch = love.math.noise( self.noiseX + 0.1, 1, 1, 1 )
		self.pitch = round(self.pitch, 1)
		self.pitch = map(self.pitch, 0.0, 1.0, 0.1, 0.6)
		if self.pitch < self.minPitch  then self.minPitch = self.pitch end
  	if self.pitch > self.maxPitch  then self.maxPitch = self.pitch end
		self.source:setPitch(self.pitch)
	end
end

function Noise:queueWhiteBuffer()
	local audio = love.sound.newSoundData(seconds * samplerate, samplerate, 16, 1)
		
	for i=0, seconds * samplerate - 1 do
			audio:setSample(i, (math.random() * 2 - 1) * 0.08 )
	end
	
	local queued = self.source:queue(audio, seconds * samplerate)
end

function Noise:queuePinkBuffer()
	local audio = love.sound.newSoundData(seconds * samplerate, samplerate, 16, 1)
		
	for i=0, seconds * samplerate - 1 do
			audio:setSample(i, self:pinkNoiseFrame())
	end
	
	local queued = self.source:queue(audio, seconds * samplerate)
end

function Noise:pinkNoiseFrame()
	local white = math.random() * 2 - 1
	self.pink0 = 0.99886 * self.pink0 + white * 0.0555179
	self.pink1 = 0.99332 * self.pink1 + white * 0.0750759
	self.pink2 = 0.96900 * self.pink2 + white * 0.1538520
	self.pink3 = 0.86650 * self.pink3 + white * 0.3104856
	self.pink4 = 0.55000 * self.pink4 + white * 0.5329522
	self.pink5 = -0.7616 * self.pink5 - white * 0.0168980
	
	local pink = self.pink0 + self.pink1 + self.pink2 + self.pink3 + self.pink4 + self.pink5 + self.pink6 + white * 0.5362
	
	self.pink6 = white * 0.115926
	
	return pink * 0.04 
end

function Noise:queueBrownBuffer()
	local audio = love.sound.newSoundData(seconds * samplerate, samplerate, 16, 1)
	
	for i=0, seconds * samplerate - 1 do
			audio:setSample(i, self:brownNoiseFrame() * 0.3)
	end
	
	local queued = self.source:queue(audio, seconds * samplerate)
end

function Noise:brownNoiseFrame()
	local white = math.random() * 2 - 1
	local out = (self.prevBrownNoiseFrame + (0.02 * white)) / 1.02
	self.prevBrownNoiseFrame = out
	return out * 3.5 -- (roughly) compensate for gain
end
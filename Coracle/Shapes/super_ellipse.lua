class('Superellipse').extends()

function Superellipse:init(mode, x, y, width, height, n)
	Superellipse.super.init()
	
	self.mode = mode	
	local tau = 6.2831855
	
	self.vertices = {}
	
	for i=0,tau,tau/50 do
		
		local c = math.cos(i)
		local s = math.sin(i)
		
		local vX = x + width/2 + (math.abs(c)^(2.0/n)) * width/2 * self:sign(c)
		local vY = y + height/2 +  (math.abs(s)^(2.0/n)) * height/2 * self:sign(s)
		
		table.insert(self.vertices, vX)
		table.insert(self.vertices, vY)
	end
	
	love.graphics.polygon(self.mode, self.vertices)
end

function Superellipse:sign(number)
		if number > 0 then
				return 1
		 elseif number < 0 then
				return -1
		 else
				return 0
		 end
end
require "Coracle/mouse"

class('ViewManager').extends()

local isSliding = false

function ViewManager:init()
	ViewManager.super.init()
	
	self.views = {}
	self.mouse = Mouse()
end

function ViewManager:setConfig(config)
	self.config = config
end

function ViewManager:add(view)
	table.insert(self.views, view)
end

function ViewManager:clickDown(x, y)
	local handled = false
	for i=1,#self.views do
		local view = self.views[i]
		if view.clickDown ~= nil then
			if view:contains(x, y) then
				view:clickDown()
				handled = true
				
				if view.slide ~= nil then
					isSliding = true
				end
				break
			end
		end
	end
	return handled
end

function ViewManager:mousemoved(x, y, dx, dy, istouch)
	 if isSliding == true then
		if self.hoverView.slide ~= nil then self.hoverView:slide(x, y) end
	else
		if self:hoverClickable(x, y) then
			self.mouse:hoverClickable()
		else
			self.mouse:reset()
		end
	end
end

function ViewManager:hoverClickable(x, y)
	local isHover = false
	for i=1,#self.views do
		local view = self.views[i]
			if view.clickUp ~= nil and view:contains(x, y) then
				self.hoverView = view
				isHover = true
				break
		end
	end
	
	return isHover
end


function ViewManager:clickUp(x, y)
	if isSliding == true then
		isSliding = false
	end
	
	local handled = false
	for i=1,#self.views do
		local view = self.views[i]
		if view.clickUp ~= nil then
			if view:contains(x, y) then
				view:clickUp()
				handled = true
				break
			end
		end
	end
	return handled
end

function ViewManager:drawViews()
	for i=1,#self.views do
		self.views[i]:draw()
	end
end
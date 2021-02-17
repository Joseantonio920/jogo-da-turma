local button={}
function button:new(x, y, w, h)
	local new={x=x, y=y, w=w, h=h, p=0, a=0-100}
	local down=false
	
	function new:down()
		return down
	end
	function new:draw()
		love.graphics.setColor(1-(self.p/100), 1-(self.p/100), 1-(self.p/100), 1-(self.a/100))
		
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		love.graphics.setColor(1, 1, 1)
	end
	function new:update(dt)
		down=false
		
		self.p=0
		if self.a<95 then
			self.a=self.a+0.6
		end
		local touches=love.touch.getTouches()
		for i, id in ipairs(touches) do
			local x, y=love.touch.getPosition(id)
			x, y=x/sx, y/sy
			if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h then
				down=true
				self.p=50
				self.a=-100
			end
		end
		
	end
	return new
end
return button
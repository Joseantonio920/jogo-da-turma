local block={}

function block:new(x, y)
	local b={
		x=x,
		y=y,
		w=16,
		h=16,
		col=true,
		obj="block",
	}
	function b:draw()
		love.graphics.rectangle("fill", self.x-self.w/2, self.y-self.h/2, self.w, self.h)
	end
	function b:update(dt)
		
	end
	
	return b
end

return block
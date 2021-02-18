local bullet={}

function bullet:new(x, y, vx, vy)
	local b={
		x=x,
		y=y,
		w=16,
		h=4,
		col=true,
		obj="shuriken",
		
		t=1,
		spd=8
	}
	local vetor=(vx^2+vy^2)^0.5
	
	local xv=vx/vetor
	local yv=vy/vetor
	
	function b:draw()
		love.graphics.rectangle("fill", self.x-self.w/2, self.y-self.h/2, self.w, self.h)
	end
	function b:update(dt)
		self.x=self.x+xv*self.spd
		self.y=self.y+yv*self.spd
		
		self.t=self.t-dt
	end
	
	return b
end

return bullet
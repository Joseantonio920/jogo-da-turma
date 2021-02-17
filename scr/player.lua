local player={}

player.img=love.graphics.newImage("res/player.png")
function player:new(x, y)
	local p={
		x=x,
		y=y,
		w=16,
		h=16,
		col=true,
		obj="player",
		
		anim={
			idle=anim:new(player.img, {0, 1, 1, 0}, {16, 16}, 0.25),
			run=anim:new(player.img, {0, 0, 7, 0}, {16, 16}, 0.1),
			down=anim:new(player.img, {0, 2, 1, 0}, {16, 16}, 0.1),
			up=anim:new(player.img, {0, 3, 1, 0}, {16, 16}, 0.1)
		},
		
		c={
			left=0,
			right=0,
			jump=0
		},
		
		type="idle",
		
		hspd=0,
		vspd=0,
		spd=4,
		
		v=1,
		j=0,
		
		coodown=0,
		shuriks={}
	}
	
	function p:draw()
		if self.type=="idle" then
			love.graphics.draw(self.anim.idle.img, self.anim.idle.quad, self.x, self.y, 0, self.v*1, 1, 8, 8)
		elseif self.type=="run" then
			love.graphics.draw(self.anim.run.img, self.anim.run.quad, self.x, self.y, 0, self.v*1, 1, 8, 8)
		elseif self.type=="up" then
			love.graphics.draw(self.anim.up.img, self.anim.up.quad, self.x, self.y, 0, self.v*1, 1, 8, 8)
		elseif self.type=="down" then
			love.graphics.draw(self.anim.down.img, self.anim.down.quad, self.x, self.y, 0, self.v*1, 1, 8, 8)
		end
		
		for i, s in ipairs(self.shuriks) do
			s:draw()
		end
		
		love.graphics.print(#self.shuriks, p.x, p.y-p.h/2-font:getHeight(tostring(#self.shuriks))/2, 0, 1, 1, font:getWidth(tostring(#self.shuriks))/2, font:getHeight(tostring(#self.shuriks))/2)
		
		--love.graphics.rectangle("line", self.x-self.w/2, self.y-self.h/2, self.w, self.h)
	end
	function p:update(dt)
		--botoes
		if left:down() then
			p.c.left=1
		end
		if right:down() then
			p.c.right=1
		end
		if jump:down() then
			p.c.jump=1
		end
		
		if shurik:down() and self.coodown<=0 then
			table.insert(self.shuriks, shurikens:new(self.x+self.v*12, self.y, self.v, 0))
			self.coodown=0.1
		end
		
		for i, s in ipairs(self.shuriks) do
			s:update(dt)
			if mundo:col(s, s.x, s.y) then
				table.remove(self.shuriks, i)
			end
			if s.t<=0 then
				table.remove(self.shuriks, i)
			end
		end
		
		self.coodown=self.coodown-dt
		--flip image e anim
		if self.hspd~=0 then
			self.v=sign(self.hspd)
			self.type="run"
		end
		if self.j>0 then
			if self.hspd~=0 then
				self.type="run"
			else
				self.type="idle"
			end
		else
			if self.vspd>0 then
				self.type="down"
			elseif self.vspd<0 then
				self.type="up"
			end
		end
		
		if self.type=="idle" then 
			self.anim.idle:update(dt)
		elseif self.type=="run" then
			self.anim.run:update(dt)
		elseif self.type=="up" then
			self.anim.up:update(dt)
		elseif self.type=="down" then
			self.anim.down:update(dt)
		end
		--gravidade e movimentação e colisao
		if self.vspd<8 then
			self.vspd=self.vspd+1.2
		end
		self.hspd=(self.c.right-self.c.left)*self.spd
		
		self.j=self.j-dt
		if mundo:col(self, self.x, self.y+1) then
			self.j=0.1
		end
		if self.c.jump>0 and self.j>0 then
			self.vspd=-self.c.jump*8
		end
		
		if mundo:col(self, self.x+self.hspd, self.y) then
			while not mundo:col(self, self.x+sign(self.hspd), self.y) do
				self.x=self.x+sign(self.hspd)
			end
			self.hspd=0
		end
		self.x=self.x+self.hspd
		if mundo:col(self, self.x, self.y+self.vspd) then
			while not mundo:col(self, self.x, self.y+sign(self.vspd)) do
				self.y=self.y+sign(self.vspd)
			end
			self.vspd=0
		end
		self.y=self.y+self.vspd
		
		--cam
		cam:setPos(w/2-self.x, h/2-self.y)
		--mudando variaveis
		self.c.left=0
		self.c.right=0
		self.c.jump=0
	end
	
	return p
end

return player
local anim={}

function anim:new(img, pos, tam, fps)
	local a={
		img=img,
		quad=love.graphics.newQuad(pos[1]*tam[1], pos[2]*tam[2], tam[1], tam[2], img:getDimensions()),
		temp=0,
		fps=fps,
		
		posx=pos[1],
		posy=pos[2],
		
		initx=pos[1],
		inity=pos[2],
		
		tam=tam,
		tamx=pos[1]+pos[3],
		tamy=pos[2]+pos[4]
	}
	function a:update(dt)
		self.temp=self.temp+dt
		if self.temp>=self.fps then
			self.posx=self.posx+1
			self.temp=0
		end
		if self.posx>self.tamx then
			self.posy=self.posy+1
			self.posx=self.initx
		end
		
		if self.posy>self.tamy then
			self.posx=self.initx
			self.posy=self.inity
		end
		self.quad:setViewport(self.posx*self.tam[1], self.posy*self.tam[2], self.tam[1], self.tam[2])
	end
	
	return a
end

return anim
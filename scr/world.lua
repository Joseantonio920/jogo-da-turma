local world={}

local player=require "scr/player"
local block=require "scr/block"
function world:new(path)
	local m={}
	
	local imgdata=love.image.newImageData(path)
	local img=love.graphics.newImage(imgdata)
	
	--objetos
	m.obj={}
	for x=0, img:getWidth()-1 do
		for y=0, img:getHeight()-1 do
			local r, g, b, a=imgdata:getPixel(x, y)
			r, g, b, a=math.floor(r*255), math.floor(g*255), math.floor(b*255), math.floor(a*255)
			
			if r==0 and g==255 and b==0 and a==255 then
				table.insert(m.obj, player:new((x*16)+8, (y*16)+8))
			end
			if r==0 and g==0 and b==0 and a==255 then
				table.insert(m.obj, block:new((x*16)+8, (y*16)+8))
			end
		end
	end
	--desenhando
	function m:draw()
		for i, obj in ipairs(m.obj) do
			obj:draw()
		end
	end
	--atualizando
	function m:update(dt)
		for i, obj in ipairs(m.obj) do
			obj:update(dt)
		end
	end
	--verificacao com colisao
	function m:col(obj, x, y)
		local col=false
		
		for i, obj2 in ipairs(m.obj) do
			if obj~=obj2 and obj.col and obj2.col and (x-obj.w/2<obj2.x+obj2.w/2 and x+obj.w/2>obj2.x-obj2.w/2 and y-obj.h/2<obj2.y+obj2.h/2 and y+obj.h/2>obj2.y-obj2.h/2) then
				col=true
			end
		end
		
		return col
	end
	
	return m
end
return world
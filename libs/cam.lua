local cam={}

local x=0
local y=0
function cam:setPos(xx, yy)
	x=xx
	y=yy
end
function cam:func()
	love.graphics.translate(x, y)
end
function cam:reset()
	love.graphics.translate(-x, -y)
end

return cam
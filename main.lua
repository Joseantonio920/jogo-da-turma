--inicializando variaveis e funcoes
font=love.graphics.newFont("fonts/PICO-8.ttf", 8)--love.graphics.getFont()
love.graphics.setFont(font)

function sign(num)
	return num>0 and 1 or num<0 and -1 or num==0 and 0
end
function rotate(x, y, r)
	local xx=x*math.cos(r)-y*math.sin(r)
	local yy=x*math.sin(r)+y*math.cos(r)
	
	return xx, yy
end

width, height=512, 256
local canvas=love.graphics.newCanvas(256, 256)
w, h=canvas:getDimensions()
sx, sy=love.graphics.getWidth()/width, love.graphics.getHeight()/height
love.graphics.setDefaultFilter("nearest")

--carregando arquivos, botoes e mundo
local button=require "libs/button"
left=button:new(16, height-64, 32, 32)
right=button:new(64, height-64, 32, 32)
jump=button:new(width-64, height-64, 32, 32)
shurik=button:new(width-64, height-128, 32, 32)
local world=require "scr/world"
cam=require "libs/cam"
anim=require "libs/anim"
bullet=require "scr/bullet"
mundo=world:new("mapas/2.png")

function love.draw()
	--telinha
	love.graphics.setCanvas(canvas)
	love.graphics.clear(25/255, 25/255, 25/255)
	
	cam:func()
	mundo:draw()
	cam:reset()
	love.graphics.rectangle("line", 0, 0, w, h)
	love.graphics.setCanvas()
	
	--desenhando telinha
	love.graphics.scale(sx, sy)
	love.graphics.draw(canvas, width/2, height/2, 0, 1, 1, w/2, h/2)
	--buttons
	left:draw()
	right:draw()
	jump:draw()
	shurik:draw()
end
function love.update(dt)
	--atualizando o mundo
	mundo:update(dt)
	
	--atualizando os botoes
	left:update(dt)
	right:update(dt)
	jump:update(dt)
	shurik:update(dt)
end
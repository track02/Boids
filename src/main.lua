local boid = require('boid')
local brules = require('boidrules')

local winh = 600
local winw = 800

boidTable = {}

function love.conf(t)

	t.window.width = 800
	t.window.height = 600
	t.console = true

end

function love.load()

	createBoids(50)

end

function love.update(dt)

	for i = 1, #boidTable, 1 do

		sepVel = {x = 0, y = 0}
		alnVel = {x = 0, y = 0}
		cohVel = {x = 0, y = 0}

		--boidTable[i].updateVelocity()

		boidTable[i].updatePosition()

	end
end


function love.keypressed(key, isrepeat)

end

function love.keyreleased(key)

end

function love.mousereleased(x,y, button)

	for i = 1, #boidTable, 1 do
		boidTable[i].updateTarget(x,y)
	end
end

function love.draw()

	for i = 1, #boidTable, 1 do 

		position = boidTable[i].getPosition()
		love.graphics.circle("fill", position.x, position.y, 5, 10)

	end	
end

function createBoids(noBoids)

	for i = 1, noBoids, 1 do

		x = math.random(0, winw)
		y = math.random(0, winh)

		table.insert(boidTable, boid.new(x, y))

	end	
end	
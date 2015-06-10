local boid = require('boid')
local brules = require('boidrules')
local obs = require('obstacle')

local winh = 600
local winw = 800

boidTable = {}
obsTable = {}

function love.conf(t)

	t.window.width = 800
	t.window.height = 600
	t.console = true

end

function love.load()

	createBoids(25)

end

function love.update(dt)


	for i = 1, #boidTable, 1 do

		neighbours = brules.findNeighbours(boidTable[i], boidTable)


		sepVel = brules.separation(boidTable[i], boidTable)
		avdVel = brules.avoidance(boidTable[i], obsTable)
		alnVel = brules.alignment(boidTable[i], boidTable)
		cohVel = brules.cohesion(boidTable[i], boidTable)

		boidTable[i].updateVelocity(sepVel)
		boidTable[i].updateVelocity(avdVel)
		boidTable[i].updateVelocity(alnVel)
		boidTable[i].updateVelocity(cohVel)


		boidTable[i].updatePosition()

	end
end


function love.keypressed(key, isrepeat)

end

function love.keyreleased(key)

end

function love.mousereleased(x,y, button)


	if(button == 'l') then
		for i = 1, #boidTable, 1 do
			boidTable[i].updateTarget(x,y)
		end
	else
		createObstacle(x,y)
	end	


end

function love.draw()

	drawBoids()
	drawObstacles()

end

function createBoids(noBoids)

	for i = 1, noBoids, 1 do

		x = math.random(0, winw)
		y = math.random(0, winh)

		table.insert(boidTable, boid.new(x, y))

	end	
end	

function createObstacle(x,y)
	table.insert(obsTable, obs.new(x,y))
end	

function drawBoids()
	for i = 1, #boidTable, 1 do 

		position = boidTable[i].getPosition()
		love.graphics.circle("fill", position.x, position.y, 5, 10)

	end	
end

function drawObstacles()


	for i = 1, #obsTable, 1 do 	
		position = obsTable[i].getPosition()
		love.graphics.circle("fill", position.x, position.y, obsTable[i].getRadius(), 10)

	end	
end	

local boid = {} --Table representing class
local vo = require('vector_ops')

function boid.new(startx, starty)
	local self = {}

	--Current position x,y
	local position = {x = startx, y = starty}

	--Target position x,y
	local target = {x = 0, y = 0}

	--Velocity x,y
	local velocity = {x = 0, y = 0}

	--Step count
	local maxsteps = 1000
	local steps = 0

	function self.getPosition()
		return position
	end

	function self.updatePosition()
		 position = vo.add(position, velocity)
		steps = steps + 1

		--Reached goal - recalculate velocity to stay near it!
		if(steps >= maxsteps) then
			self.calcVelocity()
		end

	end	

	function self.updateTarget(targetx, targety)
		target.x = targetx
		target.y = targety
		self.calcVelocity()		
	end	

	function self.calcVelocity()
		velocity = vo.scalarDiv(vo.subtract(target, position), maxsteps) -- reach goal in 1000 steps
		steps = 0
	end	


	function self.updateVelocity(vel)
		velocity = vo.add(velocity, vel)
	end	


	return self
end

return boid
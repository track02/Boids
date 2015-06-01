local boidrules = {}
local vop = require('vector_ops')

function boidrules.separation(boid, boids)

	v = {x = 0, y = 0}

	bv1 = boid.getPosition()
	distance = 50

	for i = 1, i < #boids, 1 do 

		bv2 = boids[i].getPosition()

		if(bv1 ~= bv2) then

			if(vop.distance(bv1, bv2) < distance) then
				v = vop.subtract(v, vop.subtract(bv1, bv2))
			end	

		end
	end	

	return v

end 


return boidrules


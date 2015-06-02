local boidrules = {}
local vop = require('vector_ops')


function boidrules.cohesion(boid, boids)

	v = {x = 0, y = 0}

	bv1 = boid.getPosition()

	steps = 1000

	for i = 1, #boids, 1 do

			bv2 = boids[i].getPosition()

			if(bv1 ~= bv2) then
				v = vop.add(v, bv2)
			end
	end

	v = vop.scalarDiv(v, #boids - 1)
	v = vop.subtract(v, bv1)
	v = vop.scalarDiv(v,steps)
	return v

end


function boidrules.separation(boid, boids)

	v = {x = 0, y = 0}

	bv1 = boid.getPosition()
	distance = 5

	for i = 1, #boids, 1 do 

		bv2 = boids[i].getPosition()

		if(bv1 ~= bv2) then

			if(vop.distance(bv1, bv2) < distance) then
				
				bvdiff = vop.subtract(bv2, bv1)
				v = vop.subtract(v, bvdiff)


			end	

		end
	end	

	return v

end 


function boidrules.alignment(boid, boids)

	v = {x=0, y=0}
	bp1 = boid.getPosition()
	bv1 = boid.getVelocity()

	for i = 1, #boids, 1 do

		bp2 = boids[i].getPosition()
		bv2 = boids[i].getVelocity()

		if(bp1 ~= bp2) then
			v = vop.add(v, bv2)
		end
	end

	v = vop.scalarDiv(v, #boids - 1)
	v = vop.subtract(v, bv1)
	v = vop.scalarDiv(v, 8)
	return v

end


return boidrules


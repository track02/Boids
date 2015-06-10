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
	separationdistance = 50

	for i = 1, #boids, 1 do 

		bv2 = boids[i].getPosition()

		if(bv1 ~= bv2) then

			if(vop.distance(bv1, bv2) < separationdistance) then
				
				bvdiff = vop.subtract(bv2, bv1) --Distance between the two
				v1 = vop.subtract(v, bvdiff)
				v1 = vop.normalise(v1)
				v1 = vop.scalarDiv(v1, vop.distance(bv1,bv2))
				v = vop.add(v, v1)

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

function boidrules.findNeighbours(boid, boids)

	neighbourTable = {}
	
	bp1 = boid.getPosition()

	neighbourRange = 30


	for i = 1, #boids, 1 do

		bp2 = boids[i].getPosition()

		if(bp1 ~= bp2) then
			
			if(vop.distance(bp1, bp2) <= neighbourRange) then
				table.insert(neighbourTable, boids[i])
			end			

		end	
	end

	return neighbourTable

end	



function boidrules.avoidance(boid, obs)

	v = {x = 0, y = 0}

	bv1 = boid.getPosition()
	separationdistance = 100

	for i = 1, #obs, 1 do 

		bv2 = obs[i].getPosition()


		if(vop.distance(bv1, bv2) < separationdistance) then
			
			bvdiff = vop.subtract(bv2, bv1) --Distance between the two
			v1 = vop.subtract(v, bvdiff)
			v1 = vop.normalise(v1)
			v1 = vop.scalarDiv(v1, vop.distance(bv1,bv2))
			v = vop.add(v, v1)

		end			
	end	


	return v

end 



return boidrules


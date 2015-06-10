local obstacle = {}

function obstacle.new(startx,starty)

	local self = {}
	local position = {x=startx, y=starty}
	local radius = 10


	function self.getPosition()
		return position
	end

	function self.getRadius()
		return radius
	end

	return self
end


return obstacle
Bird = {}
Bird.__index = Bird

function Bird:create()
	local bird = {}
	setmetatable(bird, Bird)
	bird.imageDown = love.graphics.newImage("assets/sprites/bluebird-downflap.png")
	bird.imageMid = love.graphics.newImage("assets/sprites/bluebird-midflap.png")
	bird.imageUp = love.graphics.newImage("assets/sprites/bluebird-upflap.png")
	bird.x = (width - bird.imageDown:getWidth()) / 2
	bird.y = (height - bird.imageDown:getHeight()) * 3 / 5 - 1
	bird.gravity = 20
	bird.velocity = 0
	return bird
end

function Bird:update(dt)
	self.velocity = self.velocity +  self.gravity * dt
	if love.mouse.isDown(1) then
		self.velocity = -5
	end
	self.y = self.y + self.velocity
end

function Bird:draw()
	if bird.velocity < 0 then
		love.graphics.draw(bird.imageDown, bird.x, bird.y)
	end
	if bird.velocity == 0 then
		love.graphics.draw(bird.imageMid, bird.x, bird.y)
	end
	if bird.velocity > 0 then
		love.graphics.draw(bird.imageUp, bird.x, bird.y)
	end
end

function Bird:checkCollision()
	if bird.y <= 0 or bird.y >= base.y - bird.imageDown:getHeight() + 1
	then
		return true
	else 
		return false
	end
	--bird.y >= pipe.y or bird.y <= pipe.y + pipe.width
	--and bird.x <= pipe.x or bird.x >= pipe.x + pipe.height
end

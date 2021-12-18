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
	self.velocity = self.velocity + self.gravity * dt
	if love.mouse.isDown(1) then
		self.velocity = -5
	end
	self.y = self.y + self.velocity
end

function Bird:draw()
	if self.velocity < 0 then
		love.graphics.draw(bird.imageDown, self.x, self.y)
	end
	if self.velocity == 0 then
		love.graphics.draw(bird.imageMid, self.x, self.y)
	end
	if self.velocity > 0 then
		love.graphics.draw(bird.imageUp, self.x, self.y)
	end
end

function Bird:checkCollision()
	if self.y <= 0 or self.y + self.imageDown:getHeight() >= base.y	then
		return true
	else 
		return false
	end

end

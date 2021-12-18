Pipe = {}
Pipe.__index = Pipe

function Pipe:create(x, y)
	local pipe = {}
	setmetatable(pipe, Pipe)
    pipe.path = "assets/sprites/pipe-green.png"
	pipe.image = love.graphics.newImage(pipe.path)
    pipe.height = pipe.image:getHeight()
    pipe.width = pipe.image:getWidth()
	pipe.x = x
	pipe.y = y - width
    pipe.speed = 0.5
    pipe.interval = 60
    pipe.rand = math.random(-150, 70)
	return pipe
end

function Pipe:update(dt)
    self.x = self.x - self.speed
    if self.x == -width then
        self.x = background:getWidth()
    end
end

function Pipe:draw()
    love.graphics.draw(self.image, self.x, self.y + self.interval + self.rand)
    love.graphics.draw(self.image, self.x + self.width, self.y - self.interval + self.rand, 3.14)
end

function Pipe:checkCollision()
    if (bird.x + bird.imageDown:getWidth() >= self.x and bird.x <= self.x + self.width) and 
    (bird.y <= self.y - self.interval + self.rand or bird.y + bird.imageDown:getHeight() >= self.y + self.interval + self.rand) then
		return true
	else 
		return false
	end
end


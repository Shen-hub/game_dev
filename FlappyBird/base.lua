Base = {}
Base.__index = Base

function Base:create()
	local base = {}
	setmetatable(base, Base)
    base.path = "assets/sprites/base.png"
	base.image = love.graphics.newImage(base.path)
	base.image1 = love.graphics.newImage(base.path)
    base.height = base.image:getHeight()
    base.width = base.image:getWidth()
	base.x = 0
	base.y = height - base.height
    base.speed = 0.5
	return base
end

function Base:update(dt)
	self.x = self.x - self.speed
    if self.x <= -width then
        self.x = 0
    end
end

function Base:draw()
	love.graphics.draw(base.image, base.x, base.y)
	love.graphics.draw(base.image1, base.x + width, base.y)
end

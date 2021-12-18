Particle = {}
Particle.__index = Particle

function Particle:create(location, size, velocity, type)
    local particle = {}
    setmetatable(particle, Particle)

    particle.location = location
    particle.size = size
    particle.type = type
    particle.acceleration = Vector:create(0, 0.1)
    particle.velocity = velocity
    particle.lifespan = 100
    particle.decay = math.random(3, 8) / 10
    particle.active = false

    return particle
end

function Particle:update()
    if (self.active) then
        self.velocity:add(self.acceleration)
        self.location:add(self.velocity)
        self.lifespan = self.lifespan - self.decay
    end
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:isDead()
    return self.lifespan < 0
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    if self.active then
        love.graphics.setColor(255, 0, 0, self.lifespan / 100)
    else
        love.graphics.setColor(1, 1, 1, self.lifespan / 100)
    end
    
    if (self.type == "h") then
        love.graphics.line(
            self.location.x - self.size / 2,
            self.location.y,
            self.location.x + self.size / 2,
            self.location.y
        )
    elseif (self.type == "v") then
        love.graphics.line(
            self.location.x,
            self.location.y - self.size / 2,
            self.location.x,
            self.location.y + self.size / 2
        )
    end
    love.graphics.setColor(r, g, b, a)
end


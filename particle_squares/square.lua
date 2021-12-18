Square = {}
Square.__index = Square

function Square:create(loc, cls, size)
    local square = {}
    setmetatable(square, Square)

    square.cls = cls or Particle
    square.location = loc
    square.size = size or 10
    square.particleLimit = lmt or 10

    square.particles = {}
    square.active = false
    local vec_y = Vector:create(0, square.size / 2)
    local vec_x = Vector:create(square.size / 2, 0)

    square.particles[0] =
        square.cls:create(
        square.location:copy() - vec_y,
        size,
        Vector:create(math.random(-100, 100) / 100, math.random(-400, 0) / 100),
        "h"
    )
    square.particles[1] =
        square.cls:create(
        square.location:copy() + vec_x,
        size,
        Vector:create(math.random(0, 200) / 100, math.random(-100, 100) / 100),
        "v"
    )
    square.particles[2] =
        square.cls:create(
        square.location:copy() + vec_y,
        size,
        Vector:create(math.random(-100, 100) / 100, math.random(0, 50) / 100),
        "h"
    )
    square.particles[3] =
        square.cls:create(
        square.location:copy() - vec_x,
        size,
        Vector:create(math.random(-200, 0) / 100, math.random(-100, 100) / 100),
        "v"
    )
    
    return square
end

function Square:draw()
    for k, v in pairs(self.particles) do
        v:draw()
    end
end

function Square:update()
    for k, v in pairs(self.particles) do
        v:update()
    end
end

function Square:checkClick(x, y)
    if
        (x > self.location.x - (self.size / 2) and x < self.location.x + (self.size / 2) and
            y > self.location.y - (self.size / 2) and
            y < self.location.y + (self.size / 2))
     then
        for k, v in pairs(self.particles) do
            v.active = true
        end
    end
end
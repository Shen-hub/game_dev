require "vector"
require "particle"
require "square"

function love.load()
    math.randomseed(os.time())

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    squares = {}

    for i = 1, 30 do
        squares[i] = Square:create(Vector:create(math.random(0, width), math.random(0, height)), Particle, math.random(10, 200))
    end
end

function love.update(dt)
    for k, v in pairs(squares) do
        v:update()
    end
end

function love.draw()
    for k, v in pairs(squares) do
        v:draw()
    end
end

function love.mousepressed( x, y, button )
    for k, v in pairs(squares) do
        v:checkClick(x, y)
    end
end

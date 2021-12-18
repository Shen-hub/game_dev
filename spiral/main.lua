require("vector")
require("flowmap")
require("vehicle")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    flow = FlowMap:create(50, 40)
    flow:init()

    vehicle = Vehicle:create(width / 2, height / 2)
    vehicle.velocity.x = 2
    vehicle.velocity.y = 2
end

function love.update(dt)

    vehicle:borders()
    vehicle:follow(flow)
    vehicle:update()

end

function love.draw()
    flow:draw()
    vehicle:draw()
end

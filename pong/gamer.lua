Gamer = {}
Gamer.__index = Gamer

function Gamer:create(position, velocity)
    local gamer = {}
    setmetatable(gamer, Gamer)

    gamer.position = position
    gamer.velocity = velocity

    gamer.limit = velocity

    gamer.height = 40

    return gamer
end

function Gamer:update()
    self.velocity:limit(limit*1.8)
    self.position = self.position + self.velocity
end


function Gamer:up()
   self.position.y = self.position.y - limit*3
end

function Gamer:down()
   self.position.y = self.position.y + limit*3
end

function Gamer:draw()
    love.graphics.rectangle( "fill", self.position.x, self.position.y-self.height/2, 10, self.height )
end

function Gamer:seek(ball)
    self.velocity.y =  ball.velocity.y
end

function Gamer:check_boundaries()
 
    if (self.position.y+self.height/2 >= height-50) then 
        self.position.y =  height-76
    end
    if (self.position.y-self.height/2 <= 50) then
        self.position.y =  76
    end
end





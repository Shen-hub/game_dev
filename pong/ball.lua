Ball = {}
Ball.__index = Ball

function Ball:create(velocity, position)
    local ball = {}
    setmetatable(ball, Ball)
    ball.start_position = position
    ball.velocity = velocity
    ball.position = position
    return ball
end

function Ball:update()
    self.velocity:limit(10)
    self.position  = self.position + self.velocity
end

function Ball:draw()
    love.graphics.circle( "fill", self.position.x, self.position.y, 10)
end

function Ball:check_boundaries()
    if self.position.x+10 > width-50 or  self.position.x-10 <= 50 then
        self.velocity.x =  self.velocity.x*-1
        pong:play("resources/pong.wav")
    end

    if self.position.y+10 > height-50 or  self.position.y-10 <= 50 then
        self.velocity.y =  self.velocity.y*-1
        pong:play("resources/pong.wav")
    end
end


function Ball:check_gamer(gamer)
    if ((gamer.position.y - gamer.height) < self.position.y and
        (gamer.position.y + gamer.height) > self.position.y and
        math.abs(self.position.x - gamer.position.x) <= 10 ) then
        self.velocity.x = self.velocity.x*-1
        self.velocity = self.velocity + gamer.velocity

        pong:play("resources/pong.wav")
    end
end

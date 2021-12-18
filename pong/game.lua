Game = {}
Game.__index = Game

function Game:create(gwidth, gheight)
    local game = {}
    setmetatable(game, Game)
    game.width = gwidth
    game.height = gheight
    game.status_map = {"gaming", "computer_win", "gamer_win", "pause"}
    game.current_status = "pause"
    limit = 2

    game.additional_text = "Press SPACE to start game!"
    position_gamer = Vector:create(100,height/2)
    velocity_gamer = Vector:create(0, 0)
    game.gamer = Gamer:create(position_gamer,velocity_gamer )

    position_computer = Vector:create(width-100,height/2)
    velocity_computer = Vector:create(0, 0)
    game.computer = Gamer:create(position_computer, velocity_computer)

    position = Vector:create(width/2, height/2)
    velocity = Vector:create(0, 0)
    game.ball = Ball:create(velocity, position)

    game.gamer_point = 0
    game.computer_point = 0


    return game
end

function Game:pause()

    game.current_status = "pause" 
    game.additional_text = "Press SPACE to start game!"
    position_gamer = Vector:create(100,height/2)
    velocity_gamer = Vector:create(0, 0)
    game.gamer = Gamer:create(position_gamer,velocity_gamer )

    position_computer = Vector:create(width-100,height/2)
    velocity_computer = Vector:create(0, 0)
    game.computer = Gamer:create(position_computer, velocity_computer)

    position = Vector:create(width/2, height/2)
    velocity = Vector:create(0, 0)
    game.ball = Ball:create(velocity, position)
end

function Game:gaming()   
    game.current_status = "gaming" 
    position = Vector:create(width/2, height/2)
    velocity = Vector:create(limit, limit)
    game.ball = Ball:create(velocity, position)
    self.additional_text = ""
end

function Game:computer_win()  
    game.current_status = "computer_win" 
    game.computer_point = game.computer_point + 1
    game:pause()
    self.additional_text = "Computer get point!\n Press SPACE for continue. "
    limit = limit + 0.2
end

function Game:gamer_win() 
    game.current_status = "gamer_win"
    game.gamer_point = game.gamer_point + 1  
    game:pause()
    self.additional_text = "Gamer get point! \n Press SPACE for continue."
    limit = limit + 0.2

   
end

function Game:global_end() 

    game:pause()

    if game.gamer_point > game.computer_point then
        self.additional_text = "YOU ARE WIN!\n Press SPACE for new game."
        victory:play("resources//victory.wav")
    end

    if game.computer_point > game.gamer_point then
        self.additional_text = "YOU ARE LOOS!\n Press SPACE for new game."
        gameover:play("resources//gameover.wav")
    end

    if game.gamer_point == game.computer_point then
        self.additional_text = "DEAD HEAT!\n Press SPACE for new game."
    end

    limit = 2
    
    game.gamer_point = 0
    game.computer_point = 0
     
  
   
end

function Game:update()

    self.ball:update()
    self.ball:check_boundaries()
    self.ball:check_gamer(self.gamer)
    self.ball:check_gamer(self.computer)
    self.gamer:update()
    self.gamer:check_boundaries() 
    self.computer:seek(self.ball)  
    self.computer:check_boundaries()
    
    self.computer:update()

if self.computer_point == 9 or self.gamer_point == 9 then
        self:global_end()

elseif self.ball.position.x > self.computer.position.x then
        self:gamer_win()
    

elseif self.ball.position.x < self.gamer.position.x then
      self:computer_win()
   end

   
    
end

function Game:draw()
    love.graphics.rectangle( "line", 50, 50, self.width/2, self.height )
    love.graphics.rectangle( "line", 50, 50, self.width, self.height )

    love.graphics.print(self.gamer_point, 200, 100)
    love.graphics.print(self.computer_point, width-200, 100)
    love.graphics.printf(self.additional_text, 0,200, width, "center")

    self.ball:draw()
    self.gamer:draw()
    self.computer:draw()
end

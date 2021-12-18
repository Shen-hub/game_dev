require("vector")
require("gamer")
require("ball")
require("game")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
   
    love.graphics.setNewFont("resources/AtariClassic-Regular.ttf", 20)
    game = Game:create(width-100, height-100)

    pong = love.audio.newSource("resources/pong.wav", "static")
    victory = love.audio.newSource("resources/victory.wav", "static")
    gameover = love.audio.newSource("resources/gameover.wav", "static")
end

function love:update()

    game:update()

    if love.keyboard.isDown( "up" ) then
        game.gamer:up()
    end

    if love.keyboard.isDown( "down" ) then
        game.gamer:down()
    end

    if love.keyboard.isDown( "space" ) and game.current_status == "pause" then
        game:gaming()
    end


end

function love.draw()
    game:draw()
end


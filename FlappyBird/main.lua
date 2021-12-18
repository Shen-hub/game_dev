require("bird")
require("base")
require("pipe")

function love.load()
    love.window.setTitle("Flappy Bird")
    background = love.graphics.newImage("assets/sprites/background-day.png")
    width = background:getWidth()
    height = background:getHeight()
    love.window.setMode(width, height)
    message = love.graphics.newImage("assets/sprites/message.png")
    bird = Bird:create()
    base = Base:create()
    
    --трубы
    pipes = {}
    pipes[1] = Pipe:create(width, height)
    pipes[2] = Pipe:create(width + width/2 + pipes[1].width, height)

    --загружаем цифры для счёта
    images = {}
    for i = 1, 10 do
        path = "assets/sprites/" .. (i-1) .. ".png"
        images[i] = love.graphics.newImage(path)
    end

    score = 0
    str = ""

    gameover = love.graphics.newImage("assets/sprites/gameover.png")
    game_status = 0
end

function love.update(dt)
    if game_status == 1 then
        --проверка коллизии
        if bird:checkCollision() then
            game_status = 2
        end
        
        --обновление птицы и нижней платформы
        bird:update(dt)
        base:update(dt)
        
        for i, pipe in pairs(pipes) do
            pipe:update(dt)
        end
        --проверка на преодоление трубы
        if bird.x == pipes[1].x + pipes[1].width  then
            score = score + 1
        end
        if bird.x == pipes[2].x + pipes[2].width  then
            score = score + 1
        end

        --проверка на вышедшую трубу за границу экрана и пересоздание новой трубы
        if pipes[1].x + pipes[1].width <= 0 then
            pipes[1] = Pipe:create(width + pipes[2].width,  height)
        end
        if pipes[2].x + pipes[2].width <= 0 then
            pipes[2] = Pipe:create(width + pipes[1].width, height)
        end
    end
end

function love.draw()
    --начало игры
    if game_status == 0 then
        love.graphics.clear()
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(message, (width - message:getWidth()) / 2, (height - message:getHeight()) / 2)
        bird:draw()
        base:draw()
    end
    --игра
    if game_status == 1 then
        love.graphics.clear()
        love.graphics.draw(background, 0, 0)
        bird:draw()
        for i, pipe in pairs(pipes) do
            pipe:draw()
        end
        base:draw()
        --отображение счёта
        
        if score < 10 then
            love.graphics.draw(images[score+1], 10, 10)
        else 
            str = tostring(score)
            print (string.len(str))
            for i = 1, string.len(str) do
                love.graphics.draw(images[tonumber(string.sub(str, i, i))+1], 10 + (i-1) * 30, 10)
            end
        end
    end
    --конец игры
    if game_status == 2 then
        love.graphics.clear()
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(gameover, (width - gameover:getWidth()) / 2, (height - gameover:getHeight()) / 2)
    end
end

--проверка нажатия
function love.mousepressed(x, y, button)
    if button == 1 and game_status == 0  then 
        game_status = 1
    end
    
    --сброс параметров при перезапуске
    if button == 1 and game_status == 2  then 
        game_status = 0
        bird.y = (height - bird.imageDown:getHeight()) * 3 / 5 - 1
        bird.velocity = 0
        pipes[1].x = width
        pipes[2].x = width + width/2 + pipes[1].width
        score = 0
    end
 end

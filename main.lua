function love.load()
    Object = require "rep/classic"
    tile_size = 50
    x_tiles = love.graphics.getWidth() / tile_size
    y_tiles = love.graphics.getHeight() / tile_size
    colored_tiles = {}

    --rectangle class
    Rect = Object:extend()

    function Rect:new(x, y)
        self.x = x
        self.y = y
    end
    
end

function love.update(dt)
    mouse_x = love.mouse.getX()
    mouse_y = love.mouse.getY()
    tile_x = math.floor(mouse_x / tile_size)
    tile_y = math.floor(mouse_y / tile_size)
    current_rect = Rect(tile_x, tile_y)

    left_pressed = love.mouse.isDown(1)
    right_pressed = love.mouse.isDown(2)

    --coloring a tile
    if left_pressed then
        table.insert(colored_tiles, current_rect)
    end

    --erasing a tile
    if right_pressed then
        local removeIndex = nil
        for i, v in pairs(colored_tiles) do
            if v.x == current_rect.x and v.y == current_rect.y then
                removeIndex = i
                break
            end
        end
        if removeIndex then
            table.remove(colored_tiles, removeIndex)
        end
    end

    --erasing all tiles
    if love.keyboard.isDown("a") then
        colored_tiles = {}
    end

    --quitting
    if love.keyboard.isDown("q") then
        love.event.quit()
    end

end

function love.draw()

    --drawing the colored tiles
    love.graphics.setColor(1, 0, 0)
    for _, v in pairs(colored_tiles) do
        love.graphics.rectangle("fill", v.x*tile_size, v.y*tile_size, tile_size, tile_size)
    end

    --highlighting the current tile
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", tile_x*tile_size, tile_y*tile_size, tile_size, tile_size)

    --drawing coordinates
    love.graphics.setColor(0, 1, 0)
    love.graphics.print((tile_x.. " ".. tile_y.. " "))

end

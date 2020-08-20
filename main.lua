require('player')
require('utils')
require('enemy')

Gamestate = require('libs/hump/gamestate')
bump = require('libs/bump')
sti = require("libs/sti")
anim8 = require("libs/anim8")

local menu = {}
local game = {}

function menu:draw()
	love.graphics.printf({{255,255,255,1}, 'The Legend of Shifu'},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
    love.graphics.printf({{255,255,255,1}, "Press Enter to continue"},0,WIN_HEIGHT/3+32,WIN_WIDTH,"center")
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(game)
    end
end

function game:enter()
	-- reset score
	score = 0
    -- load world
	world = bump.newWorld()
	map = sti(PATH_LEVEL1, {COLLISION_MODE})
	map:bump_init(world)
	-- adds custom layers
	playerLayer = map:addCustomLayer("sprites", 5)
	enemiesLayer = map:addCustomLayer("enemies", 6)
	-- init player and enemies
	initPlayer(map, world, playerLayer)
	initEnemies(map, world, enemiesLayer)
end

function love.load()
	-- menu
	Gamestate.registerEvents()
    Gamestate.switch(menu)
	-- load gamepad
	local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]
	-- font
    font = love.graphics.newFont(18)
    love.graphics.setFont(font)
end

function game:keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end
end

function game:update(dt)
	map:update(dt)
end

function game:draw()
	-- love.graphics.scale(SCALE, SCALE)
	local tx, ty = getScaleTransformations(map)
	map:draw(tx, ty, SCALE, SCALE);
	if ENABLE_DEBUG then
		map:bump_draw(world, tx, ty, SCALE, SCALE)
	end
	-- score
	love.graphics.print({{255,255,255,1}, 'score: '..math.floor(score)},0,0)
end


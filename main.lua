require('player')
require('utils')
require('enemy')

Gamestate = require('libs/hump/gamestate')
bump = require('libs/bump')
sti = require("libs/sti")
anim8 = require("libs/anim8")

menu = {}
game = {}

function menu:enter()
	icon = love.graphics.newImage(PATH_ICON)
end

function menu:draw()
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'The Legend of Shifu'},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Enter or A button to continue"},0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Escape or Y button to quit"},0,WIN_HEIGHT/3+128,WIN_WIDTH,"center")
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(game)
	end
	if key == "escape" then
	   love.event.quit()
	end
end

function menu:update(dt)
	if joystick and joystick:isGamepadDown('a') then
		Gamestate.switch(game)
	end
	if joystick and joystick:isGamepadDown('y') then
		love.event.quit()
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
    font = love.graphics.newFont(FONT_SIZE)
    love.graphics.setFont(font)
end

function game:keyreleased(key, code)
	if key == "escape" then
		Gamestate.switch(menu)
	end
end

function game:update(dt)
	if joystick and joystick:isGamepadDown('start') then
		Gamestate.switch(menu)
	end
	map:update(dt)
end

function game:draw()
	-- love.graphics.scale(SCALE, SCALE)
	local tx, ty = getScaleTransformations(map)
	map:draw(tx, ty, SCALE, SCALE);
	if ENABLE_DEBUG then
		map:bump_draw(world, tx, ty, SCALE, SCALE)
	end
	-- hud
	love.graphics.print({{255,255,255,1}, 'score: '..math.floor(score)},0,0)
	love.graphics.print({{255,255,255,1}, 'lifes: '..math.floor(playerLayer.player.life)},0,WIN_HEIGHT-FONT_SIZE)
	love.graphics.print({{255,255,255,1}, "level 1"},WIN_WIDTH-FONT_SIZE*5,0)
	love.graphics.print({{255,255,255,1}, 'weapon: '..playerLayer.player.weapon},WIN_WIDTH-FONT_SIZE*8,WIN_HEIGHT-FONT_SIZE)
end


require('player')
require('utils')
require('enemy')

bump = require('libs/bump')
sti = require("libs/sti")
anim8 = require("libs/anim8")


function love.load()
	-- load gamepad
	local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
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

function love.update(dt)
	map:update(dt)
end

function love.draw()
	-- love.graphics.scale(SCALE, SCALE)
	local tx, ty = getScaleTransformations(map)
	map:draw(tx, ty, SCALE, SCALE);
	if ENABLE_DEBUG then
		map:bump_draw(world, tx, ty, SCALE, SCALE)
	end
end

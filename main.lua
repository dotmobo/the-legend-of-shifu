require('player')
require('utils')

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
	-- load player layer
	playerLayer = addPlayerLayer(map)
	local spawn = getPlayerSpawn(map)
	createPlayerInLayer(world, playerLayer, spawn)
	addControlsToPlayer(world, playerLayer)
	drawPlayer(playerLayer)
	removeUnneededLayer()
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

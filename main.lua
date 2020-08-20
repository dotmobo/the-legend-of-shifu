require('player')
require('utils')

bump = require('libs/bump')
sti = require("libs/sti")
anim8 = require("libs/anim8")

function love.load()
	world = bump.newWorld()
	map = sti(PATH_LEVEL1, {COLLISION_MODE})
	map:bump_init(world)
	local layer = addPlayerLayer(map)
	local player = getPlayerSpawn(map)
	createPlayerInLayer(world, layer, player)
	addControlsToPlayer(world, layer)
	drawPlayer(layer)
	removeUnneededLayer()
end

function love.update(dt)
	map:update(dt)
end

function love.draw()
	local tx, ty = getScaleTransformations(map)
	map:draw(tx, ty, SCALE, SCALE);
	-- for debugging
	-- map:bump_draw(world, tx, ty, SCALE, SCALE)
end
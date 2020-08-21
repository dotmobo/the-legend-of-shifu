
require('player')
require('enemy')

function Game:enter()
	-- reset score
	Score = 0
	Level = 1
    -- load world
	World = Bump.newWorld()
	Map = Sti(GAME_LEVEL_PATH, {GAME_COLLISION_MODE})
	Map:bump_init(World)
	-- adds custom layers
	PlayerLayer = Map:addCustomLayer("sprites", 5)
	EnemiesLayer = Map:addCustomLayer("enemies", 6)
	-- init player and enemies
	initPlayer()
	initEnemies()
end

function Game:keyreleased(key, code)
	if key == "escape" then
		Gamestate.switch(Menu)
	end
end

function Game:update(dt)
	if Joystick and Joystick:isGamepadDown('start') then
		Gamestate.switch(Menu)
	end
	Map:update(dt)
end

function Game:draw()
	-- love.graphics.scale(GAME_SCALE, GAME_SCALE)
	local tx, ty = getScaleTransformations(Map)
	Map:draw(tx, ty, GAME_SCALE, GAME_SCALE);
	if DEBUG_ENABLE then
		Map:bump_draw(World, tx, ty, GAME_SCALE, GAME_SCALE)
	end
	-- hud
	love.graphics.print({{255,255,255,1}, 'score: '..math.floor(Score)},0,0)
	love.graphics.print({{255,255,255,1}, 'lifes: '..math.floor(PlayerLayer.player.life)},0,WIN_HEIGHT-GAME_FONT_SIZE)
	love.graphics.print({{255,255,255,1}, "level: "..Level},WIN_WIDTH-GAME_FONT_SIZE*5,0)
	love.graphics.print({{255,255,255,1}, 'weapon: '..PlayerLayer.player.weapon},WIN_WIDTH-GAME_FONT_SIZE*8,WIN_HEIGHT-GAME_FONT_SIZE)
end

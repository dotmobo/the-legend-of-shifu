local icon
local timer
local background
local levelName = ''

function Transition:enter()
	if WorldType == 2 then
		background = love.graphics.newImage(GAME_WORLD2_IMG_PATH)
		levelName = Level ~= 5 and 'The Death Valley' or 'Kill The Evil Bane !'
	elseif WorldType == 3 then
		background = love.graphics.newImage(GAME_WORLD3_IMG_PATH)
		levelName = Level ~= 5 and 'The Forest Of Ruin' or 'Kill The Evil Stella !'
	elseif WorldType == 4 then
		background = love.graphics.newImage(GAME_WORLD4_IMG_PATH)
		levelName = Level ~= 5 and 'The Mountains Of Madness' or 'Kill The Evil Cobalt !'
	elseif WorldType == 5 then
		background = love.graphics.newImage(GAME_WORLD5_IMG_PATH)
		levelName = Level ~= 5 and 'The Eyjafjallajökull Volcano' or 'Kill The Evil Choco !'
	else
		background = love.graphics.newImage(GAME_WORLD1_IMG_PATH)
		levelName = Level ~= 5 and 'The Darkest Dungeon' or 'Kill The Evil Crousti !'
	end
	icon = love.graphics.newImage(GAME_ICON_PATH)
	-- Music:stop()
	timer = 0
end

function Transition:draw()
	love.graphics.setColor(255, 255, 255, 0.25)
	love.graphics.draw(background, (WIN_WIDTH-(11*GAME_SPRITE_SIZE*GAME_SCALE))/2, (WIN_HEIGHT-(9*GAME_SPRITE_SIZE*GAME_SCALE))/2, 0, 1, 1)
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'World: '..WorldType..' - Level: '..Level},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, levelName },0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
end


function Transition:update(dt)
	timer = timer + 200 * dt
	if timer > 300 then
		Gamestate.switch(Game)
	end
end
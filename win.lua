local icon

function Win:enter()
	background = love.graphics.newImage(GAME_WORLD1_IMG_PATH)
	icon = love.graphics.newImage(GAME_ICON_PATH)
	Music:stop()
end

function Win:draw()
	love.graphics.setColor(255, 255, 255, 0.25)
	love.graphics.draw(background, (WIN_WIDTH-(11*GAME_SPRITE_SIZE*GAME_SCALE))/2, (WIN_HEIGHT-(9*GAME_SPRITE_SIZE*GAME_SCALE))/2, 0, 1, 1)
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'Victory ! Score: '..Score},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Enter or Start to retry"},0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Escape or Select to quit"},0,WIN_HEIGHT/3+128,WIN_WIDTH,"center")
end

function Win:keyreleased(key, code)
	if key == 'return' then
		WorldType = 1
		Score = 0
        Gamestate.switch(Game)
	end
	if key == "escape" then
	   love.event.quit()
	end
end

function Win:update(dt)
	if Joystick and Joystick:isGamepadDown('start') then
		WorldType = 1
		Score = 0
		Gamestate.switch(Game)
	end
	if Joystick and Joystick:isGamepadDown('back') then
		love.event.quit()
	end
end
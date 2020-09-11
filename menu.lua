local icon

function Menu:enter()
	background = love.graphics.newImage(GAME_WORLD1_IMG_PATH)
	icon = love.graphics.newImage(GAME_ICON_PATH)
	WorldType = 1
	Score = 0
	Level = 1
	Music:stop()
end

function Menu:draw()
	love.graphics.setColor(255, 255, 255, 0.25)
	love.graphics.draw(background, (WIN_WIDTH-(11*GAME_SPRITE_SIZE*GAME_SCALE))/2, (WIN_HEIGHT-(9*GAME_SPRITE_SIZE*GAME_SCALE))/2, 0, 1, 1)
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'The Legend of Shifu'},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Enter or Start to play"},0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Escape or Select to quit"},0,WIN_HEIGHT/3+128,WIN_WIDTH,"center")
end

function Menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(Transition)
	end
	if key == "escape" then
	   love.event.quit()
	end
end

function Menu:update(dt)
	if Joystick and Joystick:isGamepadDown('start') then
		Gamestate.switch(Transition)
	end
	if Joystick and Joystick:isGamepadDown('back') then
		love.event.quit()
	end
end
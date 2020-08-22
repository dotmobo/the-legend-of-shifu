local icon

function Win:enter()
	icon = love.graphics.newImage(GAME_ICON_PATH)
end

function Win:draw()
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'Victory ! Score: '..Score},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Enter or Start to retry"},0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Escape or Select to quit"},0,WIN_HEIGHT/3+128,WIN_WIDTH,"center")
end

function Win:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(Game)
	end
	if key == "escape" then
	   love.event.quit()
	end
end

function Win:update(dt)
	if Joystick and Joystick:isGamepadDown('start') then
		Gamestate.switch(Game)
	end
	if Joystick and Joystick:isGamepadDown('back') then
		love.event.quit()
	end
end
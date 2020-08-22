local icon

function Win:enter()
	icon = love.graphics.newImage(GAME_ICON_PATH)
end

function Win:draw()
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'Victory !'},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Enter or A button to retry"},0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Escape or Y button to quit"},0,WIN_HEIGHT/3+128,WIN_WIDTH,"center")
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
	if Joystick and Joystick:isGamepadDown('a') then
		Gamestate.switch(Game)
	end
	if Joystick and Joystick:isGamepadDown('y') then
		love.event.quit()
	end
end
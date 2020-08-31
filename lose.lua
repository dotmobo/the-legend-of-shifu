local icon

function Lose:enter()
	icon = love.graphics.newImage(GAME_ICON_PATH)
end

function Lose:draw()
	love.graphics.draw(icon, WIN_WIDTH/3, WIN_HEIGHT/3)
	love.graphics.printf({{255,255,255,1}, 'Defeat ! Score: '..Score},0,WIN_HEIGHT/3,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Enter or Start to retry"},0,WIN_HEIGHT/3+64,WIN_WIDTH,"center")
	love.graphics.printf({{255,255,255,1}, "Press Escape or Select to quit"},0,WIN_HEIGHT/3+128,WIN_WIDTH,"center")
end

function Lose:keyreleased(key, code)
	if key == 'return' then
		WorldType = 1
		Score = 0
        Gamestate.switch(Game)
	end
	if key == "escape" then
	   love.event.quit()
	end
end

function Lose:update(dt)
	if Joystick and Joystick:isGamepadDown('start') then
		Gamestate.switch(Game)
	end
	if Joystick and Joystick:isGamepadDown('back') then
		love.event.quit()
	end
end
function initPlayer()
	local spawn = getPlayerSpawn()
	loadPlayer(spawn)
	updatePlayer()
	drawPlayer()
	removeUnneededLayer()
end

-- récupère le spawn
function getPlayerSpawn()
    local player
    for k, object in pairs(Map.objects) do
        if object.name == PLAYER_OBJECT_NAME then
			player = object
			break
		end
    end
    return player
end

-- creer le jouer dans le layer
function loadPlayer(player)
	local sprite = love.graphics.newImage(PLAYER_SPRITE_PATH)
	local g = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, sprite:getWidth(), sprite:getHeight())
	local bulletSprite = love.graphics.newImage(PLAYER_WEAPON_PATH)
	--load sound
	local bulletSound = love.audio.newSource(BULLET_SOUND_PATH, "static")
	local hitSound = love.audio.newSource(PLAYER_HIT_SOUND_PATH, "static")

    PlayerLayer.player = {
		sprite = sprite,
		animations = {
			stop = Anim8.newAnimation(g('1-2','1-2'), 0.25),
			move = Anim8.newAnimation(g('1-2','3-3'), 0.125)
		},
		x      = player.x,
		y      = player.y,
		width = GAME_SPRITE_SIZE,
		height = GAME_SPRITE_SIZE,
		speed = PLAYER_SPEED,
		bullets = {},
		bulletSprite = bulletSprite,
		bulletSound = bulletSound,
		life = PLAYER_LIFE,
		hitSound = hitSound,
		hitted = false,
		hittedTime = 0,
		weapon = "pee",
		moves = {
			stop = "stop",
			up = "up",
			down = "down",
			left = "left",
			right = "right"
		}
		-- ox     = sprite:getWidth() / 2,
		-- oy     = sprite:getHeight() / 1.10
	}
	PlayerLayer.player.animation = PlayerLayer.player.animations.stop
	PlayerLayer.player.move = PlayerLayer.player.moves.stop
	World:add(PlayerLayer.player, PlayerLayer.player.x, PlayerLayer.player.y, PlayerLayer.player.width, PlayerLayer.player.height)
end

function updatePlayer()

	local playerFilter = function(item, other)
		if other.life then
			return "touch"
		else
			return "slide"
		end
	end

	local movePlayer = function(player, goalX, goalY)
		local actualX, actualY, cols, len = World:move(player, goalX, goalY, playerFilter)
		player.x, player.y = actualX, actualY
		-- deal with the collisions
		for i=1,len do
		  print('player collided with ' .. tostring(cols[i].type))
		  --if cols[i].other.life then
		  --	cols[i].item.life = cols[i].item.life - 1
		  -- end
		end
	end

	local bulletFilter = function(item, other)
		return "touch"
	end

	local moveBullet = function(bullets, index, bullet, goalX, goalY)
		local actualX, actualY, cols, len = World:move(bullet, goalX, goalY, bulletFilter)
		bullet.x, bullet.y = actualX, actualY
		-- deal with the collisions
		for i=1,len do
			print('bullet collided with ' .. tostring(cols[i].type))
			if cols[i].type=='touch' then
				if cols[i].other.life then
					print(cols[i].other.life)
					cols[i].other.hitted = true
					cols[i].other.hittedTime = 1
					cols[i].other.life = cols[i].other.life - 1
					cols[i].other.hitSound:play()
				end
			end

			if cols[i].type=='slide' or cols[i].type=='touch' then
				World:remove(bullet)
				table.remove(bullets, index)
				break
			end


		end
	end

	local createBullet = function(bullets, move)
		PlayerLayer.player.bulletSound:play()
		local bullet = {}
		bullet.width = BULLET_WIDTH
		bullet.height = BULLET_HEIGHT
		bullet.moves = {
			stop = "stop",
			up = "up",
			down = "down",
			left = "left",
			right = "right"
		}
		if move == "up" then
			bullet.move = bullet.moves.up
			bullet.x = PlayerLayer.player.x + PlayerLayer.player.width / 2
			bullet.y = PlayerLayer.player.y - bullet.height
		elseif move == "down" then
			bullet.move = bullet.moves.down
			bullet.x = PlayerLayer.player.x + PlayerLayer.player.width / 2
			bullet.y = PlayerLayer.player.y + PlayerLayer.player.height
		elseif move == "left" then
			bullet.move = bullet.moves.left
			bullet.x = PlayerLayer.player.x - bullet.width
			bullet.y = PlayerLayer.player.y + PlayerLayer.player.height / 2
		elseif move == "right" then
			bullet.move = bullet.moves.right
			bullet.x = PlayerLayer.player.x + PlayerLayer.player.width
			bullet.y = PlayerLayer.player.y + PlayerLayer.player.height / 2
		end
		World:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
		table.insert(bullets, bullet)
		return bullet
	end

	currentShootTimer = 0
	PlayerLayer.update = function(self, dt)
		if self.player.life <=0 then
			Gamestate.switch(Menu)
		end
		-- hit
		if self.player.hitted and self.player.hittedTime > 0 then
			self.player.hittedTime = self.player.hittedTime - GAME_HITTED_SPEED*dt
			if self.player.hittedTime <= 0 then
				self.player.hitted = false
			end
		end
		-- default animation
		PlayerLayer.player.move = PlayerLayer.player.moves.stop
		-- Move player up
		if love.keyboard.isDown("up") or (Joystick and Joystick:isGamepadDown('dpup')) then
			PlayerLayer.player.move = PlayerLayer.player.moves.up
			movePlayer(self.player, self.player.x, self.player.y - self.player.speed * dt)
		end
		-- Move player down
		if love.keyboard.isDown("down") or (Joystick and Joystick:isGamepadDown('dpdown')) then
			PlayerLayer.player.move = PlayerLayer.player.moves.down
			movePlayer(self.player, self.player.x, self.player.y + self.player.speed * dt)
		end
		-- Move player left
		if love.keyboard.isDown("left") or (Joystick and Joystick:isGamepadDown('dpleft')) then
			PlayerLayer.player.move = PlayerLayer.player.moves.left
			movePlayer(self.player, self.player.x - self.player.speed * dt, self.player.y)
		end
		-- Move player right
		if love.keyboard.isDown("right") or (Joystick and Joystick:isGamepadDown('dpright')) then
			PlayerLayer.player.move = PlayerLayer.player.moves.right
			movePlayer(self.player, self.player.x + self.player.speed * dt, self.player.y)
		end

		-- animation
		if PlayerLayer.player.move ~= PlayerLayer.player.moves.stop then
			-- move animation
			self.player.animation = self.player.animations.move
		else
			-- static animation by default
			self.player.animation = self.player.animations.stop
		end
		-- On met à jour l'animation du joueur
		self.player.animation:update(dt)

		-- add bullet
		currentShootTimer = currentShootTimer + dt
		if currentShootTimer > BULLET_TIMER then
			if love.keyboard.isDown("z", "w") or (Joystick and Joystick:isGamepadDown('y')) then
				local bullet = createBullet(self.player.bullets, "up")
				currentShootTimer = 0
			elseif love.keyboard.isDown("s") or (Joystick and Joystick:isGamepadDown('a')) then
				local bullet = createBullet(self.player.bullets, "down")
				currentShootTimer = 0
			elseif love.keyboard.isDown("a", "q") or (Joystick and Joystick:isGamepadDown('x')) then
				local bullet = createBullet(self.player.bullets, "left")
				currentShootTimer = 0
			elseif love.keyboard.isDown("d") or (Joystick and Joystick:isGamepadDown('b')) then
				local bullet = createBullet(self.player.bullets, "right")
				currentShootTimer = 0
			end
		end
		-- move bullet
		for index, bullet in ipairs(self.player.bullets) do
			if bullet.move == bullet.moves.down then
				moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y + BULLET_SPEED * dt)
			elseif bullet.move == bullet.moves.left then
				moveBullet(self.player.bullets, index, bullet, bullet.x - BULLET_SPEED * dt, bullet.y)
			elseif bullet.move == bullet.moves.right then
				moveBullet(self.player.bullets, index, bullet, bullet.x + BULLET_SPEED * dt, bullet.y)
			else
				moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y - BULLET_SPEED * dt)
			end
		end
	end
end

-- on dessine le joueur
function drawPlayer()
	PlayerLayer.draw = function(self)
		if self.player.hitted then
			love.graphics.setColor(208, 0, 0, 1)
		else
			love.graphics.setColor(255, 255, 255, 1)
		end
		-- player's animation
		self.player.animation:draw(self.player.sprite, math.floor(self.player.x), math.floor(self.player.y))
		-- player's bullets
		for _,bullet in ipairs(self.player.bullets) do
			if bullet.move == bullet.moves.left or bullet.move == bullet.moves.right then
				love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y, math.rad(90))
			else
				love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y)
			end
		end
		if DEBUG_ENABLE then
			love.graphics.setPointSize(5)
			love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
		end

	end
end

-- on supprime le layer de spawn devenu inutile
function removeUnneededLayer()
    Map:removeLayer("player")
end